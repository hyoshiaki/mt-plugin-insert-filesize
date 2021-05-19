package MT::Plugin::InsertFilesize;

use strict;
use base qw( MT::Plugin );
use MT;

our $VERSION = '0.11';

my $plugin = __PACKAGE__->new({
    id => 'InsertFilesize',
    name => 'InsertFilesize',
    version => $VERSION,
    description => '<MT_TRANS phrase="InsertFilesize.">',
    author_name => 'hyoshiaki',
    author_link => 'https://hyoshiaki.github.io/',
    l10n_class  => 'InsertFilesize::L10N'
});
MT->add_plugin( $plugin );

*MT::Asset::as_html = \&as_html;

sub as_html {
    my $asset = shift;
    my ($param) = @_;
    require MT::Util;
    my $text = sprintf '<a target="_blank" href="%s">%s</a>',
        MT::Util::encode_html( $asset->url ),
        MT::Util::encode_html( $asset->display_name )." (".uc(MT::Util::encode_html( $asset->file_ext )).":".sprintf("%.0f",(-s $asset->file_path) / 1024) . "KB）" ;
    return $param->{enclose} ? $asset->enclose($text) : $text;
}

1;
