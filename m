Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC2146A71
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737738068; cv=none; b=PwrYD5q8+lySix5bJf4Dc6WQ7ic7g0YKpetbdM2KGHLCNuySoMLnozsF67nSX5wyMQMJoRS+KNB46EDxrBDzKGlZqh/DTvlbvd1fzMqm7D1bie/YuNtb9WKlkvGhkUFcaf9qvDDALMkzxMbzj4EqoyUIFJgH1N/B8zt9RcGSH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737738068; c=relaxed/simple;
	bh=0J2gcKvlozR2bB+PLJut0XwWcbn/gkWv8LfdYXJSOrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPRgj+yJDcN0zFnUAwbRqjCEu9XnQV3832BKHKtqsNSO8EnkHfFHbWHpoiz9xjc7PXxFSOmb/47iBHzf1HP82wSYUjDRZDnmEvXvFT7vAytXzYQkZtnJz/HwAKMinARFqkmD+4Z8T3uvmRd0UeTNM4QJoDAml8xuSuOu7j2s6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXkOKwBV; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXkOKwBV"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e3a227b82so2071053e87.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 09:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737738063; x=1738342863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQfIcB6Hl7Iet3q6Ll877uWNkyJh3qjWW8I/PEYhDEw=;
        b=EXkOKwBV9YB+Ox8IWARkULkzl4zoK6nQ4B7ogUTN+ENqX7yK7p40q6J34WRNcPeJYC
         puvAjMtpaWQumiOsKDOk5IrQ66dWd96E96IGVE0YXQyN+ikt4RDmcjntnjtiOlKh85X9
         5RRCmOUA9xMlJ66dsjs5PaYVI9kOcVsSPVFe5UCHJ8i/o6NKnR28ANTDYnpDNFwpOu9i
         mIlETTYyaRSXD+uxUMHy1AHq5SKyUBzUq0CQmQ3ChXTIdENLm0lmYVkhRtMan9tKvhzR
         DetwxfFvlBb3bi0P+zyStkEDFtkzafgEY/SwCaQUaclaXt30kMQiWkWLk6ViCv6Av96G
         /Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737738063; x=1738342863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQfIcB6Hl7Iet3q6Ll877uWNkyJh3qjWW8I/PEYhDEw=;
        b=vKDHi7jF41yjMHhaY0ZZykJAWhyY8qMg7darXwR0eKM6MrbgbPgJ/yH3UJim9IQGdy
         S1sfjW3O2Vpg/cm0VTtcugFeq2aNjoRmywF55wvP0C9C5UQ6ZKW5/o0G8RUTf7ArGaY3
         S527rrvesBXvjg8HOiPaGaSq9QbMtdHtIlaqUuZS9zowB1OtN/Kr5rvSHGWqXN9peVN9
         BdwcA0yQ2QrfF4A8BG4xbUcft+aXsW4x8fG4s8vBqKLWn2ZKdYeDZWKlZSNP59sK0Pjn
         L4kY7IWpKz0LwgShw9ULpKRhluvbzkAldZesRPj8nYoEyVvOMo59mQvDsLHH9NWZrJvj
         FzeQ==
X-Gm-Message-State: AOJu0YwtpuM75sB9D0RmnHwmJ8UNpDHp0miqixK+4fWwmlFAZN9lcQpO
	y0Slkt6ZF9U+26ONX18yoA/U+WKHtOYSVPrxNKQkVzfpwjixVFphld7+0gysevQuIhPCdlPJ+6Y
	fjABFWiq4YSaK+nUroYLlN/7yOC8=
X-Gm-Gg: ASbGncu5fKgDDB7LOOdPkoQ3s3CdUYrcujkNRKUasyZe4Opr/9W5MFkdMXZP0jjP8zZ
	YhDJNn5e631kpzXzKvItwFvIhA3UU7p/JnYMGR6HDfoEVrgTQ/+EGc4mg7ilQ
X-Google-Smtp-Source: AGHT+IG/DoFKpbLy3QVSdWLkOAIcn37E+a92PMFdLq7E2UZTLM+jifoCjyTlH5o1O7dMEtAhQVt8xPtIqRl3SHTcu9Q=
X-Received: by 2002:ac2:4294:0:b0:540:1f7d:8bc4 with SMTP id
 2adb3069b0e04-5439c281105mr10470065e87.48.1737738063081; Fri, 24 Jan 2025
 09:01:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124164611.1175429-1-frederic.danis@collabora.com>
In-Reply-To: <20250124164611.1175429-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Jan 2025 12:00:50 -0500
X-Gm-Features: AWEUYZn2Bg8wRpmdmFVrPKJ6pWaYVreRWVRJp6dlPOE5DXrCngW2gB6w_XBVXZk
Message-ID: <CABBYNZJt36EFuhUbmgVfpq8gyOK46R-hKB=hQn_LuJdipLXgig@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] mpris-proxy: Add mpris:artUrl support
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Fri, Jan 24, 2025 at 11:48=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> This commit connects to the bip-avrcp Obex service if the
> org.bluez.MediaPlayer ObexPort property exists.
> Once connected, the Track properties update may contain an
> ImgHandle which is automatically downloaded, then a Metadata
> property updated signal is sent on org.mpris.MediaPlayer2.Player
> interface.
>
> Some devices share the Obex session between multiple players. So
> the Obex session is created by device.

Can you add a sample output? Also our long term plan is to integrate
mpris-player functionality into bluetoothctl.

> ---
>  tools/mpris-proxy.c | 435 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 425 insertions(+), 10 deletions(-)
>
> diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
> index e5fc91fdb..1f6c86777 100644
> --- a/tools/mpris-proxy.c
> +++ b/tools/mpris-proxy.c
> @@ -30,11 +30,18 @@
>  #define BLUEZ_BUS_NAME "org.bluez"
>  #define BLUEZ_PATH "/org/bluez"
>  #define BLUEZ_ADAPTER_INTERFACE "org.bluez.Adapter1"
> +#define BLUEZ_DEVICE_INTERFACE "org.bluez.Device1"
>  #define BLUEZ_MEDIA_INTERFACE "org.bluez.Media1"
>  #define BLUEZ_MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
>  #define BLUEZ_MEDIA_FOLDER_INTERFACE "org.bluez.MediaFolder1"
>  #define BLUEZ_MEDIA_ITEM_INTERFACE "org.bluez.MediaItem1"
>  #define BLUEZ_MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
> +#define BLUEZ_OBEX_BUS_NAME "org.bluez.obex"
> +#define BLUEZ_OBEX_PATH "/org/bluez/obex"
> +#define BLUEZ_OBEX_CLIENT_PATH BLUEZ_OBEX_PATH "/client"
> +#define BLUEZ_OBEX_CLIENT_INTERFACE "org.bluez.obex.Client1"
> +#define BLUEZ_OBEX_IMAGE_INTERFACE "org.bluez.obex.Image1"
> +#define BLUEZ_OBEX_TRANSFER_INTERFACE "org.bluez.obex.Transfer1"
>  #define MPRIS_BUS_NAME "org.mpris.MediaPlayer2."
>  #define MPRIS_INTERFACE "org.mpris.MediaPlayer2"
>  #define MPRIS_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
> @@ -48,8 +55,10 @@ static GDBusProxy *adapter =3D NULL;
>  static DBusConnection *sys =3D NULL;
>  static DBusConnection *session =3D NULL;
>  static GDBusClient *client =3D NULL;
> +static GDBusClient *obex_client;
>  static GSList *players =3D NULL;
>  static GSList *transports =3D NULL;
> +static GSList *obex_sessions;
>
>  static gboolean option_version =3D FALSE;
>  static gboolean option_export =3D FALSE;
> @@ -59,6 +68,12 @@ struct tracklist {
>         GSList *items;
>  };
>
> +struct obex_session {
> +       GDBusProxy *device;
> +       GDBusProxy *obex;
> +       uint16_t port;
> +};
> +
>  struct player {
>         char *bus_name;
>         DBusConnection *conn;
> @@ -67,11 +82,14 @@ struct player {
>         GDBusProxy *device;
>         GDBusProxy *transport;
>         GDBusProxy *playlist;
> +       struct obex_session *obex;
>         struct tracklist *tracklist;
> +       char *filename;
>  };
>
>  typedef int (* parse_metadata_func) (DBusMessageIter *iter, const char *=
key,
> -                                               DBusMessageIter *metadata=
);
> +                                               DBusMessageIter *metadata=
,
> +                                               void *userdata);
>
>  static void dict_append_entry(DBusMessageIter *dict, const char *key, in=
t type,
>                                                                 void *val=
);
> @@ -240,7 +258,8 @@ static void dict_append_iter(DBusMessageIter *dict, c=
onst char *key,
>  }
>
>  static int parse_metadata_entry(DBusMessageIter *entry, const char *key,
> -                                               DBusMessageIter *metadata=
)
> +                                               DBusMessageIter *metadata=
,
> +                                               void *userdata)
>  {
>         if (dbus_message_iter_get_arg_type(entry) !=3D DBUS_TYPE_VARIANT)
>                 return -EINVAL;
> @@ -251,7 +270,8 @@ static int parse_metadata_entry(DBusMessageIter *entr=
y, const char *key,
>  }
>
>  static int parse_metadata(DBusMessageIter *args, DBusMessageIter *metada=
ta,
> -                                               parse_metadata_func func)
> +                                               parse_metadata_func func,
> +                                               void *userdata)
>  {
>         DBusMessageIter dict;
>         int ctype;
> @@ -277,7 +297,7 @@ static int parse_metadata(DBusMessageIter *args, DBus=
MessageIter *metadata,
>                 dbus_message_iter_get_basic(&entry, &key);
>                 dbus_message_iter_next(&entry);
>
> -               if (func(&entry, key, metadata) < 0)
> +               if (func(&entry, key, metadata, userdata) < 0)
>                         return -EINVAL;
>
>                 dbus_message_iter_next(&dict);
> @@ -299,7 +319,7 @@ static void append_metadata(DBusMessageIter *iter, DB=
usMessageIter *dict,
>                         DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_S=
TRING
>                         DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
>
> -       parse_metadata(dict, &metadata, func);
> +       parse_metadata(dict, &metadata, func, NULL);
>
>         dbus_message_iter_close_container(&value, &metadata);
>         dbus_message_iter_close_container(iter, &value);
> @@ -1223,7 +1243,8 @@ static gboolean parse_path_metadata(DBusMessageIter=
 *iter, const char *key,
>  }
>
>  static int parse_track_entry(DBusMessageIter *entry, const char *key,
> -                                               DBusMessageIter *metadata=
)
> +                                               DBusMessageIter *metadata=
,
> +                                               void *userdata)
>  {
>         DBusMessageIter var;
>
> @@ -1253,6 +1274,30 @@ static int parse_track_entry(DBusMessageIter *entr=
y, const char *key,
>         } else if (strcasecmp(key, "Item") =3D=3D 0) {
>                 if (!parse_path_metadata(&var, "mpris:trackid", metadata)=
)
>                         return -EINVAL;
> +       } else if (strcasecmp(key, "ImgHandle") =3D=3D 0) {
> +               struct player *player =3D userdata;
> +               const char *handle, *path;
> +               char *filename, *uri;
> +
> +               if (!player || !player->obex)
> +                       return -EINVAL;
> +
> +               path =3D g_dbus_proxy_get_path(player->obex->obex);
> +
> +               if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_S=
TRING)
> +                       return -EINVAL;
> +               dbus_message_iter_get_basic(&var, &handle);
> +
> +               filename =3D g_strconcat(g_get_tmp_dir(), "/",
> +                               path + strlen(BLUEZ_OBEX_CLIENT_PATH "/")=
,
> +                               "-", handle, NULL);
> +               if (access(filename, F_OK) =3D=3D 0) {
> +                       uri =3D g_strconcat("file://", filename, NULL);
> +                       dict_append_entry(metadata, "mpris:artUrl",
> +                                               DBUS_TYPE_STRING, &uri);
> +                       g_free(uri);
> +               }
> +               g_free(filename);
>         }
>
>         return 0;
> @@ -1272,7 +1317,7 @@ static gboolean get_track(const GDBusPropertyTable =
*property,
>                         DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_S=
TRING
>                         DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
>
> -       parse_metadata(&var, &metadata, parse_track_entry);
> +       parse_metadata(&var, &metadata, parse_track_entry, player);
>
>         dbus_message_iter_close_container(iter, &metadata);
>
> @@ -1443,7 +1488,7 @@ static void append_item_metadata(void *data, void *=
user_data)
>                                                                         &=
path);
>
>         if (g_dbus_proxy_get_property(item, "Metadata", &var))
> -               parse_metadata(&var, &metadata, parse_track_entry);
> +               parse_metadata(&var, &metadata, parse_track_entry, NULL);
>
>         dbus_message_iter_close_container(iter, &metadata);
>
> @@ -1938,11 +1983,72 @@ static void register_tracklist(GDBusProxy *proxy)
>                                 player, NULL);
>  }
>
> +static GDBusProxy *connect_obex_session(const char *address, uint16_t po=
rt)
> +{
> +       static const char *target_str =3D "bip-avrcp";
> +       DBusMessage *msg, *reply;
> +       DBusMessageIter iter, array;
> +       const char *path;
> +       DBusError err;
> +
> +       msg =3D dbus_message_new_method_call(BLUEZ_OBEX_BUS_NAME,
> +                                       BLUEZ_OBEX_PATH,
> +                                       BLUEZ_OBEX_CLIENT_INTERFACE,
> +                                       "CreateSession");
> +       dbus_message_iter_init_append(msg, &iter);
> +       dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &address)=
;
> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +                                       DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING
> +                                       DBUS_TYPE_STRING_AS_STRING
> +                                       DBUS_TYPE_VARIANT_AS_STRING
> +                                       DBUS_DICT_ENTRY_END_CHAR_AS_STRIN=
G,
> +                                       &array);
> +       dict_append_entry(&array, "Target", DBUS_TYPE_STRING, &target_str=
);
> +       dict_append_entry(&array, "PSM", DBUS_TYPE_UINT16, &port);
> +       dbus_message_iter_close_container(&iter, &array);
> +
> +       dbus_error_init(&err);
> +       reply =3D dbus_connection_send_with_reply_and_block(session, msg,=
 -1,
> +                                                               &err);
> +       dbus_message_unref(msg);
> +       if (!reply) {
> +               if (dbus_error_is_set(&err)) {
> +                       fprintf(stderr, "%s\n", err.message);
> +                       dbus_error_free(&err);
> +               }
> +               return NULL;
> +       }
> +
> +       if (!dbus_message_get_args(reply, NULL,
> +                                       DBUS_TYPE_OBJECT_PATH, &path,
> +                                       DBUS_TYPE_INVALID)) {
> +               dbus_message_unref(reply);
> +               return NULL;
> +       }
> +
> +       return g_dbus_proxy_new(obex_client, path, BLUEZ_OBEX_IMAGE_INTER=
FACE);
> +}
> +
> +static struct obex_session *find_obex_session_by_device(const char *devi=
ce)
> +{
> +       GSList *l;
> +
> +       for (l =3D obex_sessions; l; l =3D l->next) {
> +               struct obex_session *session =3D l->data;
> +               const char *path =3D g_dbus_proxy_get_path(session->devic=
e);
> +
> +               if (g_strcmp0(device, path) =3D=3D 0)
> +                       return session;
> +       }
> +
> +       return NULL;
> +}
> +
>  static void register_player(GDBusProxy *proxy)
>  {
>         struct player *player;
>         DBusMessageIter iter;
> -       const char *path, *alias, *name;
> +       const char *path, *alias, *name, *address;
>         char *busname;
>         GDBusProxy *device, *transport;
>
> @@ -1960,6 +2066,11 @@ static void register_player(GDBusProxy *proxy)
>
>         dbus_message_iter_get_basic(&iter, &alias);
>
> +       if (!g_dbus_proxy_get_property(device, "Address", &iter))
> +               return;
> +
> +       dbus_message_iter_get_basic(&iter, &address);
> +
>         if (g_dbus_proxy_get_property(proxy, "Name", &iter)) {
>                 dbus_message_iter_get_basic(&iter, &name);
>                 busname =3D g_strconcat(alias, " ", name, NULL);
> @@ -1971,6 +2082,27 @@ static void register_player(GDBusProxy *proxy)
>         player->proxy =3D g_dbus_proxy_ref(proxy);
>         player->device =3D device;
>
> +       if (g_dbus_proxy_get_property(proxy, "ObexPort", &iter)) {
> +               uint16_t port;
> +               struct obex_session *session;
> +
> +               dbus_message_iter_get_basic(&iter, &port);
> +
> +               session =3D find_obex_session_by_device(path);
> +               if (session =3D=3D NULL || session->port !=3D port) {
> +                       printf("Create new session\n");
> +                       session =3D g_new0(struct obex_session, 1);
> +                       session->obex =3D connect_obex_session(address, p=
ort);
> +                       session->device =3D g_dbus_proxy_ref(device);
> +                       session->port =3D port;
> +
> +                       obex_sessions =3D g_slist_prepend(obex_sessions, =
session);
> +               }
> +               player->obex =3D session;
> +       } else {
> +               player->obex =3D NULL;
> +       }
> +
>         g_free(busname);
>
>         players =3D g_slist_prepend(players, player);
> @@ -2177,7 +2309,7 @@ static void register_item(struct player *player, GD=
BusProxy *proxy)
>                         DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_S=
TRING
>                         DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
>
> -       parse_metadata(&iter, &metadata, parse_track_entry);
> +       parse_metadata(&iter, &metadata, parse_track_entry, player);
>
>         dbus_message_iter_close_container(&args, &metadata);
>
> @@ -2377,6 +2509,121 @@ static const char *property_to_mpris(const char *=
property)
>         return NULL;
>  }
>
> +static const char *obex_get_image_handle(DBusMessageIter *args)
> +{
> +       DBusMessageIter dict, var;
> +       int ctype;
> +
> +       ctype =3D dbus_message_iter_get_arg_type(args);
> +       if (ctype !=3D DBUS_TYPE_ARRAY)
> +               return NULL;
> +
> +       dbus_message_iter_recurse(args, &dict);
> +
> +       while ((ctype =3D dbus_message_iter_get_arg_type(&dict)) !=3D
> +                                                       DBUS_TYPE_INVALID=
) {
> +               DBusMessageIter entry;
> +               const char *key;
> +
> +               if (ctype !=3D DBUS_TYPE_DICT_ENTRY)
> +                       return NULL;
> +
> +               dbus_message_iter_recurse(&dict, &entry);
> +               if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE=
_STRING)
> +                       return NULL;
> +
> +               dbus_message_iter_get_basic(&entry, &key);
> +               dbus_message_iter_next(&entry);
> +
> +               if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE=
_VARIANT)
> +                       return NULL;
> +
> +               dbus_message_iter_recurse(&entry, &var);
> +
> +               if (strcasecmp(key, "ImgHandle") =3D=3D 0) {
> +                       const char *handle;
> +
> +                       dbus_message_iter_get_basic(&var, &handle);
> +                       return handle;
> +               }
> +
> +               dbus_message_iter_next(&dict);
> +       }
> +
> +       return NULL;
> +}
> +
> +static void obex_get_image(struct player *player, const char *handle)
> +{
> +       DBusMessage *msg;
> +       DBusMessageIter iter, array;
> +       struct obex_session *obex_session =3D player->obex;
> +       const char *path =3D g_dbus_proxy_get_path(obex_session->obex);
> +       char *filename;
> +
> +       player->filename =3D g_strconcat(g_get_tmp_dir(), "/",
> +                               path + strlen(BLUEZ_OBEX_CLIENT_PATH "/")=
,
> +                               "-", handle, NULL);
> +       filename =3D g_strconcat(player->filename, ".tmp", NULL);
> +
> +       msg =3D dbus_message_new_method_call(BLUEZ_OBEX_BUS_NAME,
> +                                       path,
> +                                       BLUEZ_OBEX_IMAGE_INTERFACE,
> +                                       "Get");
> +       dbus_message_iter_init_append(msg, &iter);
> +       dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &filename=
);
> +       dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &handle);
> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +                                       DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING
> +                                       DBUS_TYPE_STRING_AS_STRING
> +                                       DBUS_TYPE_VARIANT_AS_STRING
> +                                       DBUS_DICT_ENTRY_END_CHAR_AS_STRIN=
G,
> +                                       &array);
> +       dbus_message_iter_close_container(&iter, &array);
> +
> +       if (!g_dbus_send_message(session, msg)) {
> +               g_free(player->filename);
> +               player->filename =3D NULL;
> +       }
> +       g_free(filename);
> +}
> +
> +static void device_property_changed(GDBusProxy *proxy, const char *name,
> +                                       DBusMessageIter *iter, void *user=
_data)
> +{
> +       const char *path;
> +       struct obex_session *session;
> +       gboolean connected;
> +       GSList *l;
> +
> +       path =3D g_dbus_proxy_get_path(proxy);
> +
> +       if (strcasecmp(name, "Connected") !=3D 0)
> +               return;
> +
> +       dbus_message_iter_get_basic(iter, &connected);
> +
> +       if (connected)
> +               return;
> +
> +       printf("Bluetooth Device %s disconnected\n", path);
> +       session =3D find_obex_session_by_device(path);
> +       if (session =3D=3D NULL)
> +               return;
> +
> +       for (l =3D players; l; l =3D l->next) {
> +               struct player *player =3D l->data;
> +
> +               if (player->obex =3D=3D session)
> +                       player->obex =3D NULL;
> +       }
> +
> +       g_dbus_proxy_unref(session->obex);
> +       g_dbus_proxy_unref(session->device);
> +       obex_sessions =3D g_slist_remove(obex_sessions, session);
> +       g_free(session);
> +}
> +
>  static void player_property_changed(GDBusProxy *proxy, const char *name,
>                                         DBusMessageIter *iter, void *user=
_data)
>  {
> @@ -2397,6 +2644,13 @@ static void player_property_changed(GDBusProxy *pr=
oxy, const char *name,
>                                                 MPRIS_PLAYER_INTERFACE,
>                                                 property);
>
> +       if (strcasecmp(name, "Track") =3D=3D 0 && player->obex) {
> +               const char *handle =3D obex_get_image_handle(iter);
> +
> +               if (handle)
> +                       obex_get_image(player, handle);
> +       }
> +
>         if (strcasecmp(name, "Position") !=3D 0)
>                 return;
>
> @@ -2485,6 +2739,9 @@ static void property_changed(GDBusProxy *proxy, con=
st char *name,
>
>         interface =3D g_dbus_proxy_get_interface(proxy);
>
> +       if (strcmp(interface, BLUEZ_DEVICE_INTERFACE) =3D=3D 0)
> +               return device_property_changed(proxy, name, iter, user_da=
ta);
> +
>         if (strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE) =3D=3D 0)
>                 return player_property_changed(proxy, name, iter, user_da=
ta);
>
> @@ -2496,6 +2753,151 @@ static void property_changed(GDBusProxy *proxy, c=
onst char *name,
>                 return item_property_changed(proxy, name, iter, user_data=
);
>  }
>
> +static struct player *find_player_by_obex(const char *path)
> +{
> +       GSList *l;
> +
> +       for (l =3D players; l; l =3D l->next) {
> +               struct player *player =3D l->data;
> +               struct obex_session *session =3D player->obex;
> +               const char *obex_path =3D g_dbus_proxy_get_path(session->=
obex);
> +
> +               if (g_str_has_prefix(path, obex_path))
> +                       return player;
> +       }
> +
> +       return NULL;
> +}
> +
> +static void obex_connect_handler(DBusConnection *connection, void *user_=
data)
> +{
> +       printf("org.bluez.obex appeared\n");
> +}
> +
> +static void obex_disconnect_handler(DBusConnection *connection,
> +                                       void *user_data)
> +{
> +       printf("org.bluez.obex disappeared\n");
> +}
> +
> +static void obex_proxy_added(GDBusProxy *proxy, void *user_data)
> +{
> +       const char *interface;
> +       const char *path;
> +
> +       interface =3D g_dbus_proxy_get_interface(proxy);
> +       path =3D g_dbus_proxy_get_path(proxy);
> +
> +       if (!strcmp(interface, BLUEZ_OBEX_CLIENT_INTERFACE)) {
> +               GSList *l;
> +
> +               printf("Bluetooth Obex Client %s found\n", path);
> +
> +               for (l =3D players; l; l =3D l->next) {
> +                       struct player *player =3D l->data;
> +                       DBusMessageIter iter;
> +                       const char *address;
> +                       uint16_t port;
> +                       struct obex_session *session;
> +
> +                       if (!g_dbus_proxy_get_property(player->proxy,
> +                                       "ObexPort", &iter) ||
> +                                       player->obex)
> +                               continue;
> +
> +                       dbus_message_iter_get_basic(&iter, &port);
> +
> +                       if (!g_dbus_proxy_get_property(player->device,
> +                                       "Address", &iter))
> +                               continue;
> +
> +                       dbus_message_iter_get_basic(&iter, &address);
> +
> +                       session =3D find_obex_session_by_device(path);
> +                       if (session =3D=3D NULL || session->port !=3D por=
t) {
> +                               printf("Bluetooth Obex Create new session=
\n");
> +                               session =3D g_new0(struct obex_session, 1=
);
> +                               session->obex =3D connect_obex_session(ad=
dress,
> +                                                                       p=
ort);
> +                               session->device =3D g_dbus_proxy_ref(
> +                                                       player->device);
> +                               session->port =3D port;
> +
> +                               obex_sessions =3D g_slist_prepend(obex_se=
ssions,
> +                                                               session);
> +                       }
> +                       player->obex =3D session;
> +               }
> +       }
> +}
> +
> +static void obex_proxy_removed(GDBusProxy *proxy, void *user_data)
> +{
> +       const char *interface;
> +       const char *path;
> +
> +       if (adapter =3D=3D NULL)
> +               return;
> +
> +       interface =3D g_dbus_proxy_get_interface(proxy);
> +       path =3D g_dbus_proxy_get_path(proxy);
> +
> +       if (strcmp(interface, BLUEZ_OBEX_CLIENT_INTERFACE) =3D=3D 0) {
> +               GSList *l;
> +
> +               printf("Bluetooth Obex Client %s removed\n", path);
> +
> +               for (l =3D players; l; l =3D l->next) {
> +                       struct player *player =3D l->data;
> +
> +                       player->obex =3D NULL;
> +               }
> +
> +               while (obex_sessions) {
> +                       struct obex_session *session =3D obex_sessions->d=
ata;
> +
> +                       g_dbus_proxy_unref(session->device);
> +                       g_dbus_proxy_unref(session->obex);
> +                       obex_sessions =3D g_slist_remove(obex_sessions, s=
ession);
> +               }
> +       }
> +}
> +
> +static void obex_property_changed(GDBusProxy *proxy, const char *name,
> +                                       DBusMessageIter *iter, void *user=
_data)
> +{
> +       const char *interface;
> +       const char *path;
> +
> +       interface =3D g_dbus_proxy_get_interface(proxy);
> +       path =3D g_dbus_proxy_get_path(proxy);
> +
> +       if (strcmp(interface, BLUEZ_OBEX_TRANSFER_INTERFACE) =3D=3D 0) {
> +               struct player *player;
> +               const char *status;
> +
> +               if (strcasecmp(name, "Status") !=3D 0)
> +                       return;
> +
> +               dbus_message_iter_get_basic(iter, &status);
> +
> +               player =3D find_player_by_obex(path);
> +               if (player && strcasecmp(status, "complete") =3D=3D 0) {
> +                       char *filename;
> +
> +                       filename =3D g_strconcat(player->filename, ".tmp"=
, NULL);
> +                       rename(filename, player->filename);
> +                       g_free(player->filename);
> +                       player->filename =3D NULL;
> +
> +                       g_dbus_emit_property_changed(player->conn,
> +                                                       MPRIS_PLAYER_PATH=
,
> +                                                       MPRIS_PLAYER_INTE=
RFACE,
> +                                                       "Metadata");
> +               }
> +       }
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         GOptionContext *context;
> @@ -2566,6 +2968,19 @@ int main(int argc, char *argv[])
>         g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_remov=
ed,
>                                                 property_changed, NULL);
>
> +       obex_client =3D g_dbus_client_new(session, BLUEZ_OBEX_BUS_NAME,
> +                                       BLUEZ_OBEX_PATH);
> +
> +       g_dbus_client_set_connect_watch(obex_client, obex_connect_handler=
,
> +                                       NULL);
> +       g_dbus_client_set_disconnect_watch(obex_client,
> +                                               obex_disconnect_handler,
> +                                               NULL);
> +
> +       g_dbus_client_set_proxy_handlers(obex_client, obex_proxy_added,
> +                                               obex_proxy_removed,
> +                                               obex_property_changed, NU=
LL);
> +
>         g_main_loop_run(main_loop);
>
>         g_dbus_remove_watch(session, owner_watch);
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
