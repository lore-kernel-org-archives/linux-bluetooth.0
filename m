Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1440745212-30777-1-git-send-email-bharat.panda@samsung.com>
References: <1440745212-30777-1-git-send-email-bharat.panda@samsung.com>
Date: Fri, 28 Aug 2015 11:06:06 +0300
Message-ID: <CABBYNZKkHQM_2-2S+EoN__t8xs3en=DMxmu0GoDONPs9FTiL=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] audio/avrcp: Set player properties
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Fri, Aug 28, 2015 at 10:00 AM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Populates player properties like player name, type, subtype
> and feature bit mask in player registration.
> ---
>  profiles/audio/media.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  test/simple-player     |  1 +
>  2 files changed, 44 insertions(+)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index ed441d0..df364c0 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -112,10 +112,17 @@ struct media_player {
>         bool                    next;
>         bool                    previous;
>         bool                    control;
> +       char                    *name;
> +       char                    *type;
> +       char                    *subtype;
> +       unsigned int    features[16];
>  };
>
>  static GSList *adapters = NULL;
>
> +/* Define default feature value */
> +char *features = "0000000000b701ef0200000000000000";

Please add a description what this value means, btw we should probably
use static const uint8_t so we define the value already in binary
format.

>  static void endpoint_request_free(struct endpoint_request *request)
>  {
>         if (request->call)
> @@ -1607,6 +1614,23 @@ static gboolean set_flag(struct media_player *mp, DBusMessageIter *iter,
>         return TRUE;
>  }
>
> +static gboolean set_name(struct media_player *mp, DBusMessageIter *iter)
> +{
> +       const char *value;
> +
> +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
> +               return FALSE;
> +
> +       dbus_message_iter_get_basic(iter, &value);
> +
> +       if (g_strcmp0(mp->name, value) == 0)
> +               return TRUE;
> +
> +       mp->name = g_strdup(value);

You are leaking the previous value stored in mp->name if this function
is called a second time, so please add g_free before assigning a new
value.

> +       return TRUE;
> +}
> +
>  static gboolean set_player_property(struct media_player *mp, const char *key,
>                                                         DBusMessageIter *entry)
>  {
> @@ -1647,6 +1671,9 @@ static gboolean set_player_property(struct media_player *mp, const char *key,
>         if (strcasecmp(key, "CanControl") == 0)
>                 return set_flag(mp, &var, &mp->control);
>
> +       if (strcasecmp(key, "Identity") == 0)
> +               return set_name(mp, &var);
> +
>         DBG("%s not supported, ignoring", key);
>
>         return TRUE;
> @@ -1775,6 +1802,7 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
>         DBusMessageIter args;
>         const char *sender, *path;
>         int err;
> +       uint8_t i = 0;
>
>         sender = dbus_message_get_sender(msg);
>
> @@ -1799,6 +1827,21 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
>                 return btd_error_invalid_args(msg);
>         }
>
> +       /* Currently assigning these default values for
> +        * player properties, which are not parsed in mpris
> +        * player.
> +        */
> +
> +       mp->type = "Audio";
> +       mp->subtype = "Audio Book";
> +
> +       memset(&mp->features, 0x00, 16);

Use a binary format as I suggested, that way we avoid setting it to 0
only to reset it to something else.

> +       while ((i < (strlen(features)/2))) {
> +               sscanf(features+(2*i), "%02x", &mp->features[i]);
> +               i++;
> +       }
> +
>         return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>  }
>
> diff --git a/test/simple-player b/test/simple-player
> index a8ae0b1..02754c2 100755
> --- a/test/simple-player
> +++ b/test/simple-player
> @@ -43,6 +43,7 @@ class Player(dbus.service.Object):
>
>                         self.properties = dbus.Dictionary({
>                                         "PlaybackStatus" : "playing",
> +                                       "Identity" : "SimplePlayer",
>                                         "LoopStatus" : "None",
>                                         "Rate" : dbus.Double(1.0),
>                                         "Shuffle" : dbus.Boolean(False),
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
