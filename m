Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF4AECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 21:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiH2Vze (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiH2Vzd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 17:55:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A5D248FB
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 14:55:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bt10so13031846lfb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=9c3R1Cx0DmKJgi/vJJ3jgrHA+xOEF3WX6a5lIt5mVcM=;
        b=iV0XZYLFKsFFHOXe74r52ktTw6tFlCUEVHulMf+uQzdKXGGRd5kYfj9Q2fQL3DQMnG
         VmRiE7NSBmMhN+vQ5mYAjD+3HjoLharxYUjsCuQ7kFBB3res+HT7GqN0e7y5cDhNY3nH
         zdYTFm0+i5gS3zYQIA13AqtXnPOfhFUiCNgVJgEk5jfYs4t7vbZBdUM/22JpuDde1Ls6
         6RqtPv+OqajqedEVxRKI2AkpRwv/NTo3Kvj90qi7OS47YuJVyy/eWe8lAaQulnL666pX
         f+MXrAI3TfCP5BGPpSOUQdC7Diquci9nWeDPZVzbXovfhME8zwdo1/rcDkliWxssl0Qc
         ZdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=9c3R1Cx0DmKJgi/vJJ3jgrHA+xOEF3WX6a5lIt5mVcM=;
        b=xYjKj3tpUvrJYJ7znUIzrmWDKTBfGuQqXkMVcHzmIe3fhUE0krWu/VC+E/IrZVXyiw
         /lfDtMLsAdI7HKsYd7nYtzzXTFYtFB50RsbgYts684IkJU016HiTNi6AW1tbINuEs3Ms
         iZDZJm5KNA29xhRchBAPNKKN5mr78dyErXtvINxmEBmFJAjjcrikxkHkXa59e8dDFsNP
         MadLjEiepN1HPXavnBpJl3s7NDNUjXw8QPIy3XI15O8VyUVWaKudtgGuNNvL7Ei6Jsq0
         6MyOMSkGMBWb9jh1ycbB6Nvo2wAP0wmJUxatl7DMu7VpRpbnIAv4f31/CO+CyMSsvH4i
         aJZQ==
X-Gm-Message-State: ACgBeo1sqfk+Bda8Ih+jU4OCW3ipbda/74n0vwGDcjKzhMVsaDwG1kFK
        d9AgeB2c6jMNlPvkBEM0RUjr8HofU4TVofMeiFCvTheiqWY=
X-Google-Smtp-Source: AA6agR6v2u4zs44xKiEHzusfeMZ6Ux6Tptz+v6qwnZzCE2NWqZwJAwY2SIxpZtL8t3r+jvOb1ofFriY1pMXUuMWXe/0=
X-Received: by 2002:a19:7017:0:b0:494:649d:f1e2 with SMTP id
 h23-20020a197017000000b00494649df1e2mr3175397lfc.251.1661810129698; Mon, 29
 Aug 2022 14:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220829203122.51343-1-frederic.danis@collabora.com> <20220829203122.51343-2-frederic.danis@collabora.com>
In-Reply-To: <20220829203122.51343-2-frederic.danis@collabora.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 29 Aug 2022 14:55:18 -0700
Message-ID: <CABBYNZ+JrmO6T5u+06XjiP9UZ-0Smi436-5jfPQ8fFOOSJMQ4g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] profiles: Add remote endpoint path to SelectProperties
To:     =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Fr=C3=A9d=C3=A9ric,

On Mon, Aug 29, 2022 at 1:36 PM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> ---
>  profiles/audio/bap.c   | 2 +-
>  profiles/audio/media.c | 3 +++
>  src/shared/bap.c       | 2 ++
>  src/shared/bap.h       | 2 ++
>  4 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index d388afe56..cf27ec0ae 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -613,7 +613,7 @@ static bool pac_found(struct bt_bap_pac *lpac, struct=
 bt_bap_pac *rpac,
>
>         /* TODO: Cache LRU? */
>         if (btd_service_is_initiator(service))
> -               bt_bap_select(lpac, rpac, select_cb, ep);
> +               bt_bap_select(lpac, rpac, ep->path, select_cb, ep);
>
>         return true;
>  }
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index ff3fa197b..8d777eedd 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -891,6 +891,7 @@ done:
>
>  static int pac_select(struct bt_bap_pac *pac, struct bt_bap_pac_qos *qos=
,
>                         struct iovec *caps, struct iovec *metadata,
> +                       const char *remote_ep_path,
>                         bt_bap_pac_select_t cb, void *cb_data, void *user=
_data)
>  {
>         struct media_endpoint *endpoint =3D user_data;
> @@ -917,6 +918,8 @@ static int pac_select(struct bt_bap_pac *pac, struct =
bt_bap_pac_qos *qos,
>
>         dbus_message_iter_init_append(msg, &iter);
>
> +       dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &rem=
ote_ep_path);
> +

If the endpoint object is not part of the dictionary then you will
have to fix client/player.c as well since the signature will be
changing, so I think it is better we include it as part of properties
itself.

>         dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", =
&dict);
>
>         g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 8edc7b72e..691fec2fa 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -4058,6 +4058,7 @@ static bool match_pac(struct bt_bap_pac *lpac, stru=
ct bt_bap_pac *rpac,
>  }
>
>  int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> +                       const char *remote_ep_path,
>                         bt_bap_pac_select_t func, void *user_data)
>  {
>         if (!lpac || !rpac || !func)
> @@ -4067,6 +4068,7 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct b=
t_bap_pac *rpac,
>                 return -EOPNOTSUPP;
>
>         lpac->ops->select(lpac, &rpac->qos, rpac->data, rpac->metadata,
> +                                       remote_ep_path,
>                                         func, user_data, lpac->user_data)=
;
>
>         return 0;
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index ff4bac330..da5fe1431 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -122,6 +122,7 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db,=
 const char *name,
>  struct bt_bap_pac_ops {
>         int (*select) (struct bt_bap_pac *pac, struct bt_bap_pac_qos *qos=
,
>                         struct iovec *caps, struct iovec *metadata,
> +                       const char *remote_ep_path,

Hmm, Id avoid passing D-Bus specific path here since this API is
suppose to be generic and at some point we might want to create a unit
tests that don't involve the daemon, so instead I think it is better
that we pass the rpac and addition to the lpac and then perhaps have a
function which can attach custom user_data to the rpac e.g.: void
bt_bap_pac_set_user_data(void *); void *bt_bap_pac_get_user_data();

>                         bt_bap_pac_select_t cb, void *cb_data, void *user=
_data);
>         int (*config) (struct bt_bap_stream *stream, struct iovec *cfg,
>                         struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
> @@ -188,6 +189,7 @@ int bt_bap_pac_get_codec(struct bt_bap_pac *pac, uint=
8_t *id,
>
>  /* Stream related functions */
>  int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> +                       const char *remote_ep_path,
>                         bt_bap_pac_select_t func, void *user_data);
>
>  struct bt_bap_stream *bt_bap_config(struct bt_bap *bap,
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz
