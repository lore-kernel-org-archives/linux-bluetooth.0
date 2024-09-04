Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2691DA61A
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462880; cv=none; b=HIIZ2+YH6wwmnR16wnNeoHRtn/XAX8kfmzNzTE2XZz1hQAsryP45OKvbW5F2vMJC/d5qSu9f+YAjsbAuV6hpOCCIOzPhrlVDnZJvViusv7srpkPz3vwf7p8UtbPPAm/6z82moCr4ngRcxTAQKPyc18XkAaNIMdVbC+UrPF4SJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462880; c=relaxed/simple;
	bh=Y9MlyzdHBN/eFBezApL63VZ/Ye6Q3+sLU3ngho0d9G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfHbfUw1kI0xVkjcVq85BeV3NPBNEo6Xwv1F43tyLBQhXU6FHgNpayT2bz5+qaRAOuXWvWIBPKsje20uXSltX1ZOp+e0xxTM1pWAAFToIbtiIUeHq9tMFK282bk/p0zTfgaHyvh0K859kWHM3y/ZgV2DDqEOyL0KPoi93pmqHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv8gQtPT; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv8gQtPT"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-533521cd1c3so7943397e87.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Sep 2024 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462876; x=1726067676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sVqbD3VnCTz9vCvyZwylDe+C5nWb+e7CJpG/rViEbU=;
        b=Hv8gQtPTSWnSmREUQySZhYe3lBla6stLmNxhWMWvc94Qtshdgx4kSHBpX+tvUomKks
         lwRv0U8QfQiSIET0pjOJbHL5DxRqh/0eO4gT1NXJx2OmyH18R9ffXwiBuwR8gJIhxigp
         T9Ei8BoFPKENhskz5KgOxtn1ov5E4aYzHtpmwGBrIkwVNyoCbC8A108LIWPQXpz+wenv
         iJEi0OXEMfDhCnsh4jyuW3RFm6BV5m6SdN514IxuWvTjEcJxG8ING2l/gr+zDieHiohU
         z/3wmk7kavyw2w9nZHKR03RRcLFji5n42kKtEaUTCZuRO+m10g5YKDXwAwog4YPIGS3Y
         pGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462876; x=1726067676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sVqbD3VnCTz9vCvyZwylDe+C5nWb+e7CJpG/rViEbU=;
        b=jvdikpcRNfjktmjd7WgeGh8jeOIBttF15QNgs3rmqCGLFXJVSue/Ps3Lj5HmLZvV+D
         +xV7PnuHdNmaQtTVYkwytoTNytYghwoXDKVCM9OhZDWnMR+ZS485xOg2vID9hEyk19Ne
         ZVU74hLHP0MR+df4pjS39zo7Nqo8FIRyK1eNPIaq1eHTxrETadEW02fo8ymhaG/kp/25
         WPOSdnLzpsEU3yTzJuFtkR7N3rEAgQ+r4EFmLPDw7VlSe5BwyOukLWGVxI05bwAuJWDd
         2ir0wsQWbOzvAYsp3dp0Ej2VgPJLqgmenxsndeTA796CRlaAWtGym1rkJGSrenyTyu+M
         7PhA==
X-Gm-Message-State: AOJu0YzMo2Dx5w4mHDTCaiaTFw0xluB2t0bzn0jCrytoPIexf69HR1jW
	srzd2/lTW/ph8Jr0lp2ZQwb0oEZ9N1BKY90O4sGM2fTzz5tKiKn+0N+vJtychTzLuYxZBmRDRqp
	eLK/Jx3VIHDwDGVXJWDEMZWbfFoL3ew==
X-Google-Smtp-Source: AGHT+IGegqLymae1CXar6ex8RZCSE5tiXog8MerqI6rnCQIs5PjWmk+0uV9Yo7edDw7aXVmVzmlpFihB8VIbLQoqNv0=
X-Received: by 2002:a2e:be2c:0:b0:2ee:52f4:266 with SMTP id
 38308e7fff4ca-2f6105c47e0mr205381521fa.3.1725462875336; Wed, 04 Sep 2024
 08:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904140421.283166-1-frederic.danis@collabora.com> <20240904140421.283166-3-frederic.danis@collabora.com>
In-Reply-To: <20240904140421.283166-3-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Sep 2024 11:14:23 -0400
Message-ID: <CABBYNZ+C6R7TSDtUj0kOwPPioBDx9u92TRSx1Je-UB4iS2jZqQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/7] player: Add OBEX PSM port for cover art support
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Wed, Sep 4, 2024 at 10:33=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> This parse the AVRCP Target SDP record for the L2CAP PSM to use with
> the OBEX session to get the cover art.
> ---
>  doc/org.bluez.MediaPlayer.rst |  6 +++++
>  profiles/audio/avrcp.c        | 51 +++++++++++++++++++++++++++++++----
>  profiles/audio/player.c       | 29 ++++++++++++++++++++
>  profiles/audio/player.h       |  1 +
>  4 files changed, 82 insertions(+), 5 deletions(-)
>
> diff --git a/doc/org.bluez.MediaPlayer.rst b/doc/org.bluez.MediaPlayer.rs=
t
> index 60bd679bb..f1e999bdf 100644
> --- a/doc/org.bluez.MediaPlayer.rst
> +++ b/doc/org.bluez.MediaPlayer.rst
> @@ -313,3 +313,9 @@ object Playlist
>  ```````````````
>
>         Playlist object path.
> +
> +uint16 ObexPort [readonly]
> +`````````````````````````````
> +
> +       If present indicates the player can get cover art using BIP over =
OBEX
> +       on this PSM port.

Id pass this via as part of URL e.g. obex://<address>/handle:[port]

That said, like I mentioned in the other change, we could perhaps
attempt to load it directly from bluetoothd since obexd registered its
profile with it the daemon will know that BIP has been registered and
we could allow bluetoothd to create sessions/transfer via that
connection rather than using the session D-Bus, it is a little more
work compared to doing bluetoothctl but then we don't have to
reimplement as part of upper layers or force the system to run
bluetoothctl which is more like a testing tool to validate our API's,
etc.

> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 752e55be3..61558e492 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -118,8 +118,14 @@
>  #define AVRCP_FEATURE_CATEGORY_2       0x0002
>  #define AVRCP_FEATURE_CATEGORY_3       0x0004
>  #define AVRCP_FEATURE_CATEGORY_4       0x0008
> -#define AVRCP_FEATURE_PLAYER_SETTINGS  0x0010
> -#define AVRCP_FEATURE_BROWSING                 0x0040
> +#define AVRCP_FEATURE_TG_PLAYER_SETTINGS       0x0010
> +#define AVRCP_FEATURE_TG_GROUP_NAVIGATION      0x0020
> +#define AVRCP_FEATURE_BROWSING                         0x0040
> +#define AVRCP_FEATURE_TG_MULTIPLE_PLAYER       0x0080
> +#define AVRCP_FEATURE_TG_COVERT_ART                    0x0100
> +#define AVRCP_FEATURE_CT_GET_IMAGE_PROP                0x0080
> +#define AVRCP_FEATURE_CT_GET_IMAGE                     0x0100
> +#define AVRCP_FEATURE_CT_GET_THUMBNAIL         0x0200
>
>  #define AVRCP_BATTERY_STATUS_NORMAL            0
>  #define AVRCP_BATTERY_STATUS_WARNING           1
> @@ -254,6 +260,7 @@ struct avrcp_data {
>         struct avrcp_player *player;
>         uint16_t version;
>         int features;
> +       uint16_t obex_port;
>         GSList *players;
>  };
>
> @@ -487,7 +494,7 @@ static sdp_record_t *avrcp_tg_record(bool browsing)
>                                         AVRCP_FEATURE_CATEGORY_2 |
>                                         AVRCP_FEATURE_CATEGORY_3 |
>                                         AVRCP_FEATURE_CATEGORY_4 |
> -                                       AVRCP_FEATURE_PLAYER_SETTINGS );
> +                                       AVRCP_FEATURE_TG_PLAYER_SETTINGS)=
;
>
>         record =3D sdp_record_alloc();
>         if (!record)
> @@ -3522,6 +3529,7 @@ static struct avrcp_player *create_ct_player(struct=
 avrcp *session,
>                 return NULL;
>         }
>
> +       media_player_set_obex_port(mp, session->controller->obex_port);
>         media_player_set_callbacks(mp, &ct_cbs, player);
>         player->user_data =3D mp;
>         player->destroy =3D (GDestroyNotify) media_player_destroy;
> @@ -4006,7 +4014,8 @@ static gboolean avrcp_get_capabilities_resp(struct =
avctp *conn, uint8_t code,
>         if (events =3D=3D (1 << AVRCP_EVENT_VOLUME_CHANGED))
>                 return FALSE;
>
> -       if ((session->controller->features & AVRCP_FEATURE_PLAYER_SETTING=
S) &&
> +       if ((session->controller->features &
> +                       AVRCP_FEATURE_TG_PLAYER_SETTINGS) &&
>                         !(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
>                 avrcp_list_player_attributes(session);
>
> @@ -4075,8 +4084,9 @@ static struct avrcp_data *data_init(struct avrcp *s=
ession, const char *uuid)
>  {
>         struct avrcp_data *data;
>         const sdp_record_t *rec;
> -       sdp_list_t *list;
> +       sdp_list_t *list, *protos;
>         sdp_profile_desc_t *desc;
> +       int port =3D 0;
>
>         data =3D g_new0(struct avrcp_data, 1);
>
> @@ -4092,6 +4102,35 @@ static struct avrcp_data *data_init(struct avrcp *=
session, const char *uuid)
>         sdp_get_int_attr(rec, SDP_ATTR_SUPPORTED_FEATURES, &data->feature=
s);
>         sdp_list_free(list, free);
>
> +       if ((g_strcmp0(uuid, AVRCP_TARGET_UUID) !=3D 0) ||
> +                       !(data->features & AVRCP_FEATURE_TG_COVERT_ART) |=
|
> +                       (sdp_get_add_access_protos(rec, &protos) !=3D 0))
> +               return data;
> +
> +       /* Get the PSM port from the Additional Protocol Descriptor list
> +        * entry containing OBEX UUID
> +        */
> +       for (list =3D protos; list; list =3D list->next) {
> +               sdp_list_t *p;
> +
> +               for (p =3D list->data; p; p =3D p->next) {
> +                       sdp_data_t *seq =3D p->data;
> +
> +                       if ((sdp_uuid_to_proto(&seq->val.uuid) =3D=3D OBE=
X_UUID) &&
> +                                       SDP_IS_UUID(seq->dtd)) {
> +                               port =3D sdp_get_proto_port(list, L2CAP_U=
UID);
> +                               goto done;
> +                       }
> +               }
> +       }
> +
> +done:
> +       if (port > 0)
> +               data->obex_port =3D port;
> +
> +       sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
> +       sdp_list_free(protos, NULL);
> +
>         return data;
>  }
>
> @@ -4189,6 +4228,8 @@ static void controller_init(struct avrcp *session)
>         session->controller =3D controller;
>
>         DBG("%p version 0x%04x", controller, controller->version);
> +       if (controller->obex_port)
> +               DBG("%p OBEX PSM 0x%04x", controller, controller->obex_po=
rt);
>
>         service =3D btd_device_get_service(session->dev, AVRCP_TARGET_UUI=
D);
>         btd_service_connecting_complete(service, 0);
> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
> index c995697fe..4e3de8047 100644
> --- a/profiles/audio/player.c
> +++ b/profiles/audio/player.c
> @@ -88,6 +88,7 @@ struct media_player {
>         struct player_callback  *cb;
>         GSList                  *pending;
>         GSList                  *folders;
> +       uint16_t                obex_port;
>  };
>
>  static void append_track(void *key, void *value, void *user_data)
> @@ -437,6 +438,28 @@ static gboolean get_playlist(const GDBusPropertyTabl=
e *property,
>         return TRUE;
>  }
>
> +static gboolean obexport_exists(const GDBusPropertyTable *property,
> +                                                               void *dat=
a)
> +{
> +       struct media_player *mp =3D data;
> +
> +       return mp->obex_port !=3D 0;
> +}
> +
> +static gboolean get_obexport(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct media_player *mp =3D data;
> +
> +       if (mp->obex_port =3D=3D 0)
> +               return FALSE;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
> +                                                       &mp->obex_port);
> +
> +       return TRUE;
> +}
> +
>  static DBusMessage *media_player_play(DBusConnection *conn, DBusMessage =
*msg,
>                                                                 void *dat=
a)
>  {
> @@ -778,6 +801,7 @@ static const GDBusPropertyTable media_player_properti=
es[] =3D {
>         { "Browsable", "b", get_browsable, NULL, browsable_exists },
>         { "Searchable", "b", get_searchable, NULL, searchable_exists },
>         { "Playlist", "o", get_playlist, NULL, playlist_exists },
> +       { "ObexPort", "q", get_obexport, NULL, obexport_exists },
>         { }
>  };
>
> @@ -1997,3 +2021,8 @@ struct media_item *media_player_set_playlist_item(s=
truct media_player *mp,
>
>         return item;
>  }
> +
> +void media_player_set_obex_port(struct media_player *mp, uint16_t port)
> +{
> +       mp->obex_port =3D port;
> +}
> diff --git a/profiles/audio/player.h b/profiles/audio/player.h
> index 74fb7d771..0076c4641 100644
> --- a/profiles/audio/player.h
> +++ b/profiles/audio/player.h
> @@ -86,6 +86,7 @@ void media_player_set_folder(struct media_player *mp, c=
onst char *path,
>  void media_player_set_playlist(struct media_player *mp, const char *name=
);
>  struct media_item *media_player_set_playlist_item(struct media_player *m=
p,
>                                                                 uint64_t =
uid);
> +void media_player_set_obex_port(struct media_player *mp, uint16_t port);
>
>  struct media_item *media_player_create_folder(struct media_player *mp,
>                                                 const char *name,
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
