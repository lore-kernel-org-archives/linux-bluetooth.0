Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CDEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Oct 2021 04:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C3A61039
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Oct 2021 04:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhJKE2p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Oct 2021 00:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhJKE2p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Oct 2021 00:28:45 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A90C061570
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Oct 2021 21:26:45 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id h196so5477814iof.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Oct 2021 21:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ye4mMpcq7ZL34zS0ab98oVagHCnSb65BU9VjVM+JDoA=;
        b=qfC2RaKJixxJT3b+t5sOejG+KMfXTNpx/ioByK6beqSjOelewah2pXQZhhfmufO6cY
         hI+Oy+oqHFfnRjKXRq71UoVpEpuK6mU+OMyYx9lrl2Zz7g0hsu2w8s3/pv/a45i9DsD8
         QVCSkIU166AieRYR5MKqE9/k/t7l8aqbqaqQy+xrLX1hCW8BQuSljxpCVplWNjcozwkk
         zavc8BblyN/pO7TkyKJYNtuBCmXxSXmlDfCKkDAjASF9mZ1GQcBmxs8+nSQs2mnG/O8/
         tGSfYNvGpGTWEW5O0T6CvYlnt9kVJdfM2+wNyclFac6/ZtxNZHn4N8JsVTcwHin87S8A
         aThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ye4mMpcq7ZL34zS0ab98oVagHCnSb65BU9VjVM+JDoA=;
        b=uKe8p9abOLkUwWHdSaf7lEAoZ3oGr2GuqYlsAGZusxkqnJwb8EGfYDVKOMqGjSiN4l
         0DLWoVSVwR6+Ju0goe/5fM/NCLw81+qojOIWNovQaNl2O7oTMEXj/FgmH0k+23svAeFz
         3gswVRretCHDiUL0VHG+u9KaOBCYALJFe5gZ+4l7Wt6eSONu5LuNMGWH3YkRolMzMvdw
         LfaeiLEfu/w88O4zcX48mbdxPeA9rWkeaRkJUhuqqPd8lKv4zlPlN2GnI2pnuzBlOhQn
         vifjiP6TlD2W7I6NdhfAfMoyj4rDYsIzmu6E4Y085o5ZUWWg8gJY75kesSziE3L8EYl9
         2CXw==
X-Gm-Message-State: AOAM532EEuF+md9OPS0oVXhdJrV69QkVOFcm2Ibl8qX5P+r6uIqFBvZo
        xuhndHxkSK1x8hgctt2RELiRltSlhyX/SUrXJqs=
X-Google-Smtp-Source: ABdhPJx2Nvsq6EPSH8sh5F2lJ/+/QarKch12ckZ5DYUZgIqEKzI32/JWIrG9LpbpVRaED4597YojMb4HqdW1j8gu/Ws=
X-Received: by 2002:a05:6602:160b:: with SMTP id x11mr17737696iow.108.1633926405218;
 Sun, 10 Oct 2021 21:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211010171447.35355-1-pav@iki.fi>
In-Reply-To: <20211010171447.35355-1-pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 10 Oct 2021 21:26:34 -0700
Message-ID: <CABBYNZKgXNA1jqdhXV3t44bhRjXiKboTb7nOPMtidmi4dHAQpA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] avrcp: keep track of last volume, and use as
 transport init_volume
To:     Pauli Virtanen <pav@iki.fi>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sun, Oct 10, 2021 at 10:20 AM Pauli Virtanen <pav@iki.fi> wrote:
>
> Some devices may send AVRCP VolumeChanged notification before AVDTP
> SetConfiguration occurs, and not send another until a hardware button on
> the device is pressed. If a media_player is registered to BlueZ, the
> volume from the event is stored on the player, and used as init_volume
> for new transports.  However, if no media_player is registered,
> transports are created with volume missing.
>
> If that occurs, the DBus "Volume" attribute on transports will be
> missing until a hardware button is pressed.  Consequently, applications
> cannot get or set volume, even though it is actually possible.
>
> Address this by keeping track of the last device volume set in AVRCP
> session. If no media_player is registered, use that as the init_volume
> for new transports.  This has a similar effect as if a dummy media
> player was registered.
>
> This fixes AVRCP absolute volume not being available on some headphones
> on Pipewire & Pulseaudio until HW button press.
> ---
>  profiles/audio/avrcp.c | 23 +++++++++++++++++++++++
>  profiles/audio/avrcp.h |  1 +
>  profiles/audio/media.c |  3 +++
>  3 files changed, 27 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 7c280203c..0df416d2c 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -276,6 +276,8 @@ struct avrcp {
>         uint8_t transaction;
>         uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
>         struct pending_pdu *pending_pdu;
> +
> +       int8_t last_device_volume;

We can probably keep this short and just call it volume.

>  };
>
>  struct passthrough_handler {
> @@ -1759,6 +1761,7 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
>         volume = pdu->params[0] & 0x7F;
>
>         media_transport_update_device_volume(session->dev, volume);
> +       session->last_device_volume = volume;
>
>         return AVC_CTYPE_ACCEPTED;
>
> @@ -3731,6 +3734,7 @@ static void avrcp_volume_changed(struct avrcp *session,
>
>         /* Always attempt to update the transport volume */
>         media_transport_update_device_volume(session->dev, volume);
> +       session->last_device_volume = volume;
>
>         if (player)
>                 player->cb->set_volume(volume, session->dev, player->user_data);
> @@ -4145,6 +4149,7 @@ static void target_init(struct avrcp *session)
>
>                 init_volume = media_player_get_device_volume(session->dev);
>                 media_transport_update_device_volume(session->dev, init_volume);
> +               session->last_device_volume = init_volume;
>         }
>
>         session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
> @@ -4308,6 +4313,7 @@ static struct avrcp *session_create(struct avrcp_server *server,
>         session->server = server;
>         session->conn = avctp_connect(device);
>         session->dev = device;
> +       session->last_device_volume = -1;
>
>         server->sessions = g_slist_append(server->sessions, session);
>
> @@ -4497,6 +4503,7 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t code,
>
>         /* Always attempt to update the transport volume */
>         media_transport_update_device_volume(session->dev, volume);
> +       session->last_device_volume = volume;

So if I understand this right we are going to cache the volume here
since media_transport_update_device_volume may not have a transport
yet? If that is the case we probably need to be checking if there is a
transport or not beforehand instead of doing this blindly.

>
>         if (player != NULL)
>                 player->cb->set_volume(volume, session->dev, player->user_data);
> @@ -4598,6 +4605,22 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
>                                         avrcp_handle_set_volume, session);
>  }
>
> +int8_t avrcp_get_last_volume(struct btd_device *dev)
> +{
> +       struct avrcp_server *server;
> +       struct avrcp *session;
> +
> +       server = find_server(servers, device_get_adapter(dev));
> +       if (server == NULL)
> +               return -1;
> +
> +       session = find_session(server->sessions, dev);
> +       if (session == NULL)
> +               return -1;
> +
> +       return session->last_device_volume;
> +}
> +
>  struct avrcp_player *avrcp_get_target_player_by_device(struct btd_device *dev)
>  {
>         struct avrcp_server *server;
> diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
> index dcc580e37..952f0eea9 100644
> --- a/profiles/audio/avrcp.h
> +++ b/profiles/audio/avrcp.h
> @@ -91,6 +91,7 @@ struct avrcp_player_cb {
>  };
>
>  int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify);
> +int8_t avrcp_get_last_volume(struct btd_device *dev);

Let's have it as avrcp_get_volume so it is symmetric to avrcp_set_volume.

>  struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
>                                                 struct avrcp_player_cb *cb,
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 521902ed8..a37378393 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -494,6 +494,9 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
>                 return FALSE;
>
>         init_volume = media_player_get_device_volume(device);
> +       if (init_volume < 0)
> +               init_volume = avrcp_get_last_volume(device);

I wonder if we shouldn't be better to move the call to
avrcp_get_volume inside media_player_get_device_volume so it does the
fallback automatically if there is no volume set.

>         media_transport_update_volume(transport, init_volume);
>
>         msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
> --
> 2.31.1
>


-- 
Luiz Augusto von Dentz
