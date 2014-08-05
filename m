Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1406893754-11650-1-git-send-email-luiz.dentz@gmail.com>
References: <1406893754-11650-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 5 Aug 2014 17:05:53 +0300
Message-ID: <CABBYNZJ+34pF3ryHMMsi14u79vRrpgCAwiGP_taRmmZyZtq57A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/3] audio/media: Remove experimental status from
 Media* interfaces
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 1, 2014 at 2:49 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> These interfaces have been stable for a while so there is no reason to
> keep them as experimental anymore.
> ---
> v2: Fix not moving tools_mpris_proxy_SOURCES and tools_mpris_proxy_LDADD out of
> experimental check.
>
>  doc/media-api.txt       |  6 ++--
>  profiles/audio/media.c  |  4 +--
>  profiles/audio/player.c | 88 ++++++++++++++++++-------------------------------
>  3 files changed, 37 insertions(+), 61 deletions(-)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index 07ea991..ae49dfa 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -121,7 +121,7 @@ MediaPlayer1 hierarchy
>  ======================
>
>  Service                org.bluez (Controller role)
> -Interface      org.bluez.MediaPlayer1 [Experimental]
> +Interface      org.bluez.MediaPlayer1
>  Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
>
>  Methods                void Play()
> @@ -309,7 +309,7 @@ MediaFolder1 hierarchy
>
>  Service                unique name (Target role)
>                 org.bluez (Controller role)
> -Interface      org.bluez.MediaFolder1 [Experimental]
> +Interface      org.bluez.MediaFolder1
>  Object path    freely definable (Target role)
>                 [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
>                 (Controller role)
> @@ -390,7 +390,7 @@ MediaItem1 hierarchy
>
>  Service                unique name (Target role)
>                 org.bluez (Controller role)
> -Interface      org.bluez.MediaItem1 [Experimental]
> +Interface      org.bluez.MediaItem1
>  Object path    freely definable (Target role)
>                 [variable
>                 prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX/itemX
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index fa5c013..ef7b910 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1828,10 +1828,10 @@ static const GDBusMethodTable media_methods[] = {
>                 NULL, register_endpoint) },
>         { GDBUS_METHOD("UnregisterEndpoint",
>                 GDBUS_ARGS({ "endpoint", "o" }), NULL, unregister_endpoint) },
> -       { GDBUS_EXPERIMENTAL_METHOD("RegisterPlayer",
> +       { GDBUS_METHOD("RegisterPlayer",
>                 GDBUS_ARGS({ "player", "o" }, { "properties", "a{sv}" }),
>                 NULL, register_player) },
> -       { GDBUS_EXPERIMENTAL_METHOD("UnregisterPlayer",
> +       { GDBUS_METHOD("UnregisterPlayer",
>                 GDBUS_ARGS({ "player", "o" }), NULL, unregister_player) },
>         { },
>  };
> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
> index de608a3..ac7481a 100644
> --- a/profiles/audio/player.c
> +++ b/profiles/audio/player.c
> @@ -716,16 +716,13 @@ done:
>  }
>
>  static const GDBusMethodTable media_player_methods[] = {
> -       { GDBUS_EXPERIMENTAL_METHOD("Play", NULL, NULL, media_player_play) },
> -       { GDBUS_EXPERIMENTAL_METHOD("Pause", NULL, NULL, media_player_pause) },
> -       { GDBUS_EXPERIMENTAL_METHOD("Stop", NULL, NULL, media_player_stop) },
> -       { GDBUS_EXPERIMENTAL_METHOD("Next", NULL, NULL, media_player_next) },
> -       { GDBUS_EXPERIMENTAL_METHOD("Previous", NULL, NULL,
> -                                               media_player_previous) },
> -       { GDBUS_EXPERIMENTAL_METHOD("FastForward", NULL, NULL,
> -                                               media_player_fast_forward) },
> -       { GDBUS_EXPERIMENTAL_METHOD("Rewind", NULL, NULL,
> -                                               media_player_rewind) },
> +       { GDBUS_METHOD("Play", NULL, NULL, media_player_play) },
> +       { GDBUS_METHOD("Pause", NULL, NULL, media_player_pause) },
> +       { GDBUS_METHOD("Stop", NULL, NULL, media_player_stop) },
> +       { GDBUS_METHOD("Next", NULL, NULL, media_player_next) },
> +       { GDBUS_METHOD("Previous", NULL, NULL, media_player_previous) },
> +       { GDBUS_METHOD("FastForward", NULL, NULL, media_player_fast_forward) },
> +       { GDBUS_METHOD("Rewind", NULL, NULL, media_player_rewind) },
>         { }
>  };
>
> @@ -734,34 +731,20 @@ static const GDBusSignalTable media_player_signals[] = {
>  };
>
>  static const GDBusPropertyTable media_player_properties[] = {
> -       { "Name", "s", get_name, NULL, name_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Type", "s", get_type, NULL, type_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Subtype", "s", get_subtype, NULL, subtype_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Position", "u", get_position, NULL, NULL,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Status", "s", get_status, NULL, status_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Equalizer", "s", get_setting, set_setting, setting_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Repeat", "s", get_setting, set_setting, setting_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Shuffle", "s", get_setting, set_setting, setting_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Scan", "s", get_setting, set_setting, setting_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Track", "a{sv}", get_track, NULL, track_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Device", "o", get_device, NULL, NULL,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Browsable", "b", get_browsable, NULL, browsable_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Searchable", "b", get_searchable, NULL, searchable_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Playlist", "o", get_playlist, NULL, playlist_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> +       { "Name", "s", get_name, NULL, name_exists },
> +       { "Type", "s", get_type, NULL, type_exists },
> +       { "Subtype", "s", get_subtype, NULL, subtype_exists },
> +       { "Position", "u", get_position, NULL, NULL },
> +       { "Status", "s", get_status, NULL, status_exists },
> +       { "Equalizer", "s", get_setting, set_setting, setting_exists },
> +       { "Repeat", "s", get_setting, set_setting, setting_exists },
> +       { "Shuffle", "s", get_setting, set_setting, setting_exists },
> +       { "Scan", "s", get_setting, set_setting, setting_exists },
> +       { "Track", "a{sv}", get_track, NULL, track_exists },
> +       { "Device", "o", get_device, NULL, NULL },
> +       { "Browsable", "b", get_browsable, NULL, browsable_exists },
> +       { "Searchable", "b", get_searchable, NULL, searchable_exists },
> +       { "Playlist", "o", get_playlist, NULL, playlist_exists },
>         { }
>  };
>
> @@ -1088,15 +1071,15 @@ static gboolean get_items(const GDBusPropertyTable *property,
>  }
>
>  static const GDBusMethodTable media_folder_methods[] = {
> -       { GDBUS_EXPERIMENTAL_ASYNC_METHOD("Search",
> +       { GDBUS_ASYNC_METHOD("Search",
>                         GDBUS_ARGS({ "string", "s" }, { "filter", "a{sv}" }),
>                         GDBUS_ARGS({ "folder", "o" }),
>                         media_folder_search) },
> -       { GDBUS_EXPERIMENTAL_ASYNC_METHOD("ListItems",
> +       { GDBUS_ASYNC_METHOD("ListItems",
>                         GDBUS_ARGS({ "filter", "a{sv}" }),
>                         GDBUS_ARGS({ "items", "a{oa{sv}}" }),
>                         media_folder_list_items) },
> -       { GDBUS_EXPERIMENTAL_ASYNC_METHOD("ChangeFolder",
> +       { GDBUS_ASYNC_METHOD("ChangeFolder",
>                         GDBUS_ARGS({ "folder", "o" }), NULL,
>                         media_folder_change_folder) },
>         { }
> @@ -1684,26 +1667,19 @@ static gboolean get_metadata(const GDBusPropertyTable *property,
>  }
>
>  static const GDBusMethodTable media_item_methods[] = {
> -       { GDBUS_EXPERIMENTAL_METHOD("Play", NULL, NULL,
> -                                       media_item_play) },
> -       { GDBUS_EXPERIMENTAL_METHOD("AddtoNowPlaying", NULL, NULL,
> +       { GDBUS_METHOD("Play", NULL, NULL, media_item_play) },
> +       { GDBUS_METHOD("AddtoNowPlaying", NULL, NULL,
>                                         media_item_add_to_nowplaying) },
>         { }
>  };
>
>  static const GDBusPropertyTable media_item_properties[] = {
> -       { "Player", "o", get_player, NULL, NULL,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Name", "s", get_item_name, NULL, item_name_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Type", "s", get_item_type, NULL, NULL,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "FolderType", "s", get_folder_type, NULL, folder_type_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Playable", "b", get_playable, NULL, NULL,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> -       { "Metadata", "a{sv}", get_metadata, NULL, metadata_exists,
> -                                       G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> +       { "Player", "o", get_player, NULL, NULL },
> +       { "Name", "s", get_item_name, NULL, item_name_exists },
> +       { "Type", "s", get_item_type, NULL, NULL },
> +       { "FolderType", "s", get_folder_type, NULL, folder_type_exists },
> +       { "Playable", "b", get_playable, NULL, NULL },
> +       { "Metadata", "a{sv}", get_metadata, NULL, metadata_exists },
>         { }
>  };
>
> --
> 1.9.3

Pushed.


-- 
Luiz Augusto von Dentz
