Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332844093-1818-1-git-send-email-michal.labedzki@tieto.com>
References: <1332844093-1818-1-git-send-email-michal.labedzki@tieto.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 2 Apr 2012 09:28:40 -0300
Message-ID: <CAMOw1v4UseGTxfjLjZ2okiv8=RNSFjXv47VQZ9mkmRAmwM6wiQ@mail.gmail.com>
Subject: Re: [PATCH] AVRCP: Add support for changing active player
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal

On Tue, Mar 27, 2012 at 7:28 AM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> There is possibility to register more then one player, so this patch
> allow to change active player to the freely chosen previously
> registered player.
> ---
>  audio/avrcp.c     |    7 ++++++
>  audio/avrcp.h     |    1 +
>  audio/media.c     |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  doc/media-api.txt |    5 ++++
>  4 files changed, 75 insertions(+), 0 deletions(-)

Aside from some comments below, patch looks good. However it seems we
are missing some infrastructure support first. See section 6.9.2 of
AVRCP 1.4 spec. If we have support for changing the currently
addressed player, we should be able to:

1. notify CT that player has changed
2. cancel pending operations, responding with AVC_CTYPE_REJECTED

We can have this support without being able to remotely change player.
But we shouldn't change the player without notifying CT.

>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index 8eba046..aba453a 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -1327,3 +1327,10 @@ void avrcp_unregister_player(struct avrcp_player *player)
>
>        player_destroy(player);
>  }
> +
> +void avrcp_set_active_player(struct avrcp_player *player)
> +{
> +       struct avrcp_server *server = player->server;
> +
> +       server->active_player = player;
> +}
> diff --git a/audio/avrcp.h b/audio/avrcp.h
> index 8a09546..f2041a7 100644
> --- a/audio/avrcp.h
> +++ b/audio/avrcp.h
> @@ -96,6 +96,7 @@ struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
>                                                void *user_data,
>                                                GDestroyNotify destroy);
>  void avrcp_unregister_player(struct avrcp_player *player);
> +void avrcp_set_active_player(struct avrcp_player *player);
>
>  int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data);
>
> diff --git a/audio/media.c b/audio/media.c
> index c0fd0c3..00b35ef 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -1705,11 +1705,73 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
>        return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>  }
>
> +static DBusMessage *set_active_player(DBusConnection *conn, DBusMessage *msg,
> +                                       void *data)
> +{
> +       struct media_adapter *adapter = data;
> +       struct media_player *player;
> +       const char *sender, *path;
> +       DBusMessage *signal_msg;
> +       GSList *l;
> +
> +       if (!dbus_message_get_args(msg, NULL,
> +                               DBUS_TYPE_OBJECT_PATH, &path,
> +                               DBUS_TYPE_INVALID))
> +               return NULL;
> +
> +       sender = dbus_message_get_sender(msg);
> +
> +       player = media_adapter_find_player(adapter, sender, path);
> +       if (player == NULL)
> +               return btd_error_does_not_exist(msg);
> +
> +       avrcp_set_active_player(player->player);
> +
> +       for (l = adapter->players; l; l = l->next) {
> +               struct media_player *mp = l->data;
> +
> +               if (sender && g_strcmp0(mp->sender, sender) != 0)
> +                       continue;
> +
> +               if (path && g_strcmp0(mp->path, path) == 0) {

I don't think we need to string-compare sender and path again. We
already did that on media_adapter_find_player(). If we indeed need
this loop here, we may just compare the pointers.
Why do you have different behavior if player is part of the same
sender or not? If I understood well this loop, what you are doing is:

1. notifiying other players that current-player changed
2. notifying the new player that it was activated

1 above should be true independently if it was registered on the same bus.


> +                       DBG("activate player <%s>", mp->path);
> +                       signal_msg = dbus_message_new_signal(mp->path,
> +                                       MEDIA_PLAYER_INTERFACE,
> +                                       "Activated");
> +                       if (signal_msg == NULL) {
> +                               DBG("Message Null");
> +                               return NULL;
> +                       }

missing blank line

> +                       if (!dbus_connection_send(conn, signal_msg, NULL)) {
> +                               DBG("Out Of Memory");
> +                               return NULL;
> +                       }

missing blank line

> +                       dbus_message_unref(signal_msg);
> +               } else {
> +                       signal_msg = dbus_message_new_signal(mp->path,
> +                                       MEDIA_PLAYER_INTERFACE,
> +                                       "Deactivated");

missing blank line

> +                       if (signal_msg == NULL) {
> +                               DBG("Message Null");
> +                               return NULL;
> +                       }

missing blank line

> +                       if (!dbus_connection_send(conn, signal_msg, NULL)) {
> +                               DBG("Out Of Memory");
> +                               return NULL;
> +                       }

missing blank line

> +                       dbus_message_unref(signal_msg);
> +               }
> +       }
> +
> +       return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> +}
> +
>  static GDBusMethodTable media_methods[] = {
>        { "RegisterEndpoint",   "oa{sv}",       "",     register_endpoint },
>        { "UnregisterEndpoint", "o",            "",     unregister_endpoint },
>        { "RegisterPlayer",     "oa{sv}a{sv}","",       register_player },
>        { "UnregisterPlayer",   "o",            "",     unregister_player },
> +       { "SetActivePlayer",    "o",            "",     set_active_player },
>        { },
>  };
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index c53ab7b..d2c6f2e 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -123,6 +123,11 @@ Methods            void RegisterEndpoint(object endpoint, dict properties)
>
>                        Unregister sender media player.
>
> +               void SetActivePlayer(object player)
> +
> +                       Set active media player. Only active player may be used

s/Only/Only one/

> +                       by remote controller.
> +
>  MediaPlayer hierarchy
>  =====================
>
> --
> on behalf of ST-Ericsson
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
