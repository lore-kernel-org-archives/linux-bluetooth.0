Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795536960;
	b=RVV0gVzx8u59NgkVwTGutNb2jZHMLhzfyFZluzM/mJvJiTtM7fjkubaxYhAsKUfxvHjF
	 KDzTiOmKvE087WSQTnfIePXwgqeR/HWUB9+87DmDrpwIQM18hcmp+PbRC3ir6KLsdJI0J
	 W3GlXkEsyHgqaySQ5RgVWvi2nb7EOxlA3zf3yOYEHI8Byz6Ib2ZR75S/oDl8EEl//XeOF
	 J+c7dDPuk1ohsAAiDkz0/kI0fgc3tW6ArAZ35dZMO7Q7zvm1PA10/i0fM56oY0n0BvgvX
	 KiTyXssuk0irRfSJ7OrXOUnH2upLrh7zsVkEr/EQHcD8Ja8/tzRN0JKEafSk2rJKsHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=TH5xMsKYDQssC9Oo4SOCAKqT+vr+cXpvI+9eJsZLkqQ=;
	b=IO3Ut5pO/Vh4wYcMHvGJ6wNrAC+HvJLB4vKiLv8h7KXNEjP0eyeuF2GJzuxNigW9T6xf
	 GCsPUWL0gHcn8Choo+3yxTdR0IUHLZGtms++y9/+fT6OwizRsYQpVJZYTABLgeokk1lFR
	 rnL8eIeCP1k+TOLabWD5ercn4ljZQN7FKJXVDAFYVKoxdnLL/cCUU2IJO01L8V2kHLT/0
	 s8YcfRwy2Q/QGwDw6htXAFKyUUeDKtNRSeLP5+QjMVhu3TWIvNbYfIxmSrs8yTXDyjhwI
	 HXy9YHOG9eGuyQb47A48AFTq7Somx/qlw3cE7o6CRK1PHowJllxaXTfub/57MokakHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MaEO6iFO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBA606A323
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 16:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18BBA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MaEO6iFO
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67db35e7953so4855823d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 08:15:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795536959; cv=none;
        d=google.com; s=arc-20260327;
        b=FdR93DM86UeSmw/ANZYVzHSu0DnVViiXK2C+2wsWxLYeGl9sqnVyIFZCwNf2O6aynj
         96CqYRwAVK4a9r+hMg5V+OQxO1k2bDPmvHG1txAHP/3AAjUuHqILJlHFYB7NJaKqdSos
         1/4dGMVcXGfov54Mta5MCt3s1P5jdnEEYhJUXPvez8fedax2iwBBk9WXxOVo6H+1vK7M
         +ccfXzlghLh0gM9kmOh5ijcL9EP6epGb/bILNTe39u4WAH3+LwT+bPj86D/yzsIKKXbd
         WEJcggSXw8RTSTWjJnloUchLTXqK5CrLGvj8Vkk0EYgIX+q9u+dFTyBCSfF4fg+UDQP2
         vvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TH5xMsKYDQssC9Oo4SOCAKqT+vr+cXpvI+9eJsZLkqQ=;
        fh=tyq0gYhA4cMcqn+bWakZSAdnDDyh/si+tlAcgOGyoy0=;
        b=PDoZuFz+2yfDqVygI6fh5aPDBPOUNMOU000Q/Jm/htxsB4VFs9XrY92lpzubygrUzV
         IXmyDe1OvrkntjCnJApveJ6+qFFZK2UYmEDy9PaJVLUlUeC3TSiNl92ec8nEOGAvDkux
         gvi0k/zPC1pixXZoYxivmUDAsgNonxfbg3nc6dXu5+/youS6BVg+5MEYy2zRMyjDTbet
         IirD3192L6S04YVLsQZItjeMrKMM2Q/ZhxhxlR5nJ5FwWlIWCqlDa4jWdgynIJvaO6td
         7lEWA2R9wSMIzBTd793ysWIHvnEIv4tupEiL84FWzlOrf3GHVGP0WIqeDEgDu8UG1yRA
         ym/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795536959; x=1796141759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TH5xMsKYDQssC9Oo4SOCAKqT+vr+cXpvI+9eJsZLkqQ=;
        b=MaEO6iFOPkgEP408RMmqtF8OyEP3MQpWkdp3T9ehP7R/+SOJJOlVSMElN8jUqwrRtq
         wzbu+3x44hgpl0e72ZcqYpLjyZixMxO3OTb322IfhmI3pjpCHoEtOlq02H9BTRNSMHE5
         mfBkAThTiBBv5QeOJ3E3+62ABbZovys7y8ITnht+tU9WEoJ8PoPZrssGTdE+8LfimgL9
         8++zSHBARgfnoZDZ8G4dPoxn4+TUMKxNZnDk6dRFKqEeSVoW4BK8BaqvleJVKXMhmxuR
         CIig1Lx0hvOTPNdPNMHtdIa2bGzk/hnsu31D+kRswVzViaADZMzWv2/smtBrEiVvquXN
         CHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536959; x=1796141759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TH5xMsKYDQssC9Oo4SOCAKqT+vr+cXpvI+9eJsZLkqQ=;
        b=1oPDnSoLYU/d3VjnY1GuCw90Yeh/4ihRK+099rThj9vNmgRp38wjHUvtVdZ8cpfu5O
         H0N252tjHKdrjwwgdxfVdpgPnomnx9DE1RSiz782K8D3FyHq25jnolucw4f0Tcz27o9E
         ILRb6VFRd32PQoRFsM7wXU2mxiTNvNRZqaNvrqD2HPzMTLk6UFEUntY/rB0C32AxoGxm
         G/TqerXHqXt1uklVSMp7dyNNlvNeA4sreR3IiTZy+J+SlvwN4p7h5XSXt85zH7le+RfE
         53tY1bjOGZkPMt7KQVrsBHS8V+qHe+iXZOM8kbpbuTGnsF5MYQeiQtsvMBf3BQbKB7SQ
         tNOw==
X-Gm-Message-State: APuU4Z/DxqWlMHljFsGHVIFKHJz2YNikhy2/D22iTloPTVn57hLZrgLb
	dxfDaMDkutX+S31rraimuT1mss8Kqu7sGCsYJb9HgJNcbgISv30IQcDIxZSHxN3PX9zgtsi09XM
	bHWesCzYwNHBTVA8wwZG68LBopMRMBBOdtg==
X-Gm-Gg: AZFdTZfh4H3ESAqV+okBWupn6pTO2AuUJujlNXbmUqQKhY0/a2mQ61ZKrSO83fKN7SH
	FFqimYo5e6qtwU08k0XygT1bw+xYa0UjNZFukh5o5U/OS1iHqcLt0UUSG+YPdNJ4Ghb89uaTSN0
	xSPbBVgkgOcuZfDOV14UQeQnJ0mm9VQ0fBCxh6Pxyf/tQbrDd32p1su+zhSY19k0iwwCVE6I34k
	WOBMjS9X5Y9UuXs8gP31VsiCF1OLvNtA4uT0e+8Tem+bFV3N2VUq+f9KeP/uSDOihisoeRcnAWn
	RRT7XQXcCwgatIfSjaiI7zwISJR2T3tZp+aGNctbT9abQRfuwRFjmkX9G9IGlsjXm1VddTbPzFc
	eZs7z9gJAOd9QGEejRkZWFHjI+pRKb7Xi0imd0vE2MVGcsdN1pWcbjz80xE3GxfWBWv8kLH6nXJ
	qBPilV08nT3GWKWhOrXEQwHZ67Gj0WLfqeVrhK849tpLRqlPQ39RGwz+Z/
X-Received: by 2002:a05:690e:bca:b0:679:b16a:8dae with SMTP id
 956f58d0204a3-67df4528c2emr5493456d50.103.1795536958893; Tue, 24 Nov 2026
 08:15:58 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124133954.4009535-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261124133954.4009535-1-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Nov 2026 11:15:45 -0500
X-Gm-Features: Aa3M54ourkYDUojCKH8D-f1S8theGRa86zK6fCTY5GWJKuB3Fwb7kHTVhnwedMM
Message-ID: <CABBYNZL7ekOUHtuvw5e-J_b+AESLYJ5E=gABnNfjaELhBoo_Og@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] avrcp: Defer init until service discovery completes
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Tue, Nov 24, 2026 at 8:40=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> When the remote connects AVCTP before SDP has found its AVRCP records,
> as iOS does on the first connection after pairing, neither controller
> nor target is initialized and the session stays without them. Wait for
> the service discovery with device_wait_for_svc_complete() instead.
>
> The remote uses the session meanwhile: iOS asks for the supported
> events and registers for EVENT_VOLUME_CHANGED right away, and would
> not get absolute volume otherwise. Report every supported event from
> the start, the remote registers only those it uses, and create the
> target when the control channel connects so these registrations are
> kept; target_init() completes it from the SDP record. A volume
> registration with no volume set yet starts at max volume, which
> target_init() set only for 1.4 controllers with category 2.
>
> Assisted-by: Claude:claude-opus-5-5
> ---
>  profiles/audio/avrcp.c | 102 ++++++++++++++++++++++-------------------
>  1 file changed, 55 insertions(+), 47 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 2f214e982..f7c988ec0 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -252,6 +252,7 @@ struct avrcp {
>         bool pos_changed_supported;
>         uint8_t transaction;
>         struct pending_pdu *pending_pdu;
> +       unsigned int svc_complete_id;
>  };
>
>  struct passthrough_handler {
> @@ -1614,12 +1615,6 @@ static uint8_t avrcp_handle_register_notification(=
struct avrcp *session,
>         if (!(session->supported_events & (1 << pdu->params[0])))
>                 goto err;
>
> -       if (!session->target) {
> -               pdu->params_len =3D cpu_to_be16(1);
> -               pdu->params[0] =3D AVRCP_STATUS_INVALID_COMMAND;
> -               return AVC_CTYPE_REJECTED;
> -       }
> -
>         switch (pdu->params[0]) {
>         case AVRCP_EVENT_STATUS_CHANGED:
>                 len =3D 2;
> @@ -1648,6 +1643,10 @@ static uint8_t avrcp_handle_register_notification(=
struct avrcp *session,
>                 len =3D 1;
>                 break;
>         case AVRCP_EVENT_VOLUME_CHANGED:
> +               /* Start at max volume if none has been set yet */
> +               if (media_transport_get_a2dp_volume(dev) < 0)
> +                       media_transport_set_a2dp_volume(dev, 127);
> +
>                 volume =3D media_transport_get_a2dp_volume(dev);
>                 if (volume < 0)
>                         goto err;
> @@ -4263,16 +4262,15 @@ static void session_init_browsing(struct avrcp *s=
ession)
>                                                         destroy_browsing)=
;
>  }
>
> -static struct avrcp_data *data_init(struct avrcp *session, const char *u=
uid)
> +static struct avrcp_data *data_init(struct avrcp *session,
> +                                       struct avrcp_data *data,
> +                                       const char *uuid)
>  {
> -       struct avrcp_data *data;
>         const sdp_record_t *rec;
>         sdp_list_t *list, *protos;
>         sdp_profile_desc_t *desc;
>         int port =3D 0;
>
> -       data =3D g_new0(struct avrcp_data, 1);
> -
>         rec =3D btd_device_get_record(session->dev, uuid);
>         if (rec =3D=3D NULL)
>                 return data;
> @@ -4348,14 +4346,9 @@ static void avrcp_connect_browsing(struct avrcp *s=
ession)
>
>  static void target_init(struct avrcp *session)
>  {
> -       struct avrcp_server *server =3D session->server;
>         struct avrcp_data *target;
> -       struct avrcp_player *player;
>         struct btd_service *service;
>
> -       if (session->target !=3D NULL)
> -               return;
> -
>         service =3D btd_device_get_service(session->dev, AVRCP_REMOTE_UUI=
D);
>
>         if (service =3D=3D NULL) {
> @@ -4363,47 +4356,22 @@ static void target_init(struct avrcp *session)
>                 return;
>         }
>
> -       target =3D data_init(session, AVRCP_REMOTE_UUID);
> -       session->target =3D target;
> +       target =3D data_init(session, session->target, AVRCP_REMOTE_UUID)=
;
>
>         DBG("%p version 0x%04x", target, target->version);
>
>         btd_service_connecting_complete(service, 0);
>
> -       player =3D g_slist_nth_data(server->players, 0);
> -       if (player !=3D NULL) {
> +       if (target->player !=3D NULL) {
>                 int8_t init_volume;
> -               target->player =3D player;
> -               player->sessions =3D g_slist_prepend(player->sessions, se=
ssion);
>
>                 init_volume =3D btd_device_get_volume(session->dev);
>                 media_transport_set_a2dp_volume(session->dev, init_volume=
);
>         }
>
> -       session->supported_events |=3D (1 << AVRCP_EVENT_STATUS_CHANGED) =
|
> -                               (1 << AVRCP_EVENT_TRACK_CHANGED) |
> -                               (1 << AVRCP_EVENT_TRACK_REACHED_START) |
> -                               (1 << AVRCP_EVENT_TRACK_REACHED_END) |
> -                               (1 << AVRCP_EVENT_SETTINGS_CHANGED);
> -
>         if (target->version < 0x0104)
>                 return;
>
> -       if (avrcp_volume_supported(target)) {
> -               session->supported_events |=3D
> -                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> -               /* Check if transport volume hasn't been initialized then=
 set it
> -                * to max so it works properly if the controller attempts=
 to
> -                * subscribe to AVRCP_EVENT_VOLUME_CHANGED.
> -                */
> -               if (media_transport_get_a2dp_volume(session->dev) < 0)
> -                       media_transport_set_a2dp_volume(session->dev, 127=
);
> -       }
> -
> -       session->supported_events |=3D
> -                               (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGE=
D) |
> -                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANG=
ED);
> -
>         /* Only check capabilities if controller is not supported */
>         if (session->controller =3D=3D NULL)
>                 avrcp_get_capabilities(session);
> @@ -4430,7 +4398,8 @@ static void controller_init(struct avrcp *session)
>                 return;
>         }
>
> -       controller =3D data_init(session, AVRCP_TARGET_UUID);
> +       controller =3D data_init(session, g_new0(struct avrcp_data, 1),
> +                                                       AVRCP_TARGET_UUID=
);
>         session->controller =3D controller;
>
>         DBG("%p version 0x%04x", controller, controller->version);
> @@ -4460,8 +4429,35 @@ static void controller_init(struct avrcp *session)
>         avrcp_connect_browsing(session);
>  }
>
> +static void session_svc_complete(struct btd_device *dev, int err,
> +                                                       void *user_data)
> +{
> +       struct avrcp *session =3D user_data;
> +
> +       session->svc_complete_id =3D 0;
> +
> +       if (btd_device_get_service(session->dev, AVRCP_TARGET_UUID) !=3D =
NULL)
> +               controller_init(session);
> +
> +       if (btd_device_get_service(session->dev, AVRCP_REMOTE_UUID) !=3D =
NULL)
> +               target_init(session);
> +}
> +
>  static void session_init_control(struct avrcp *session)
>  {
> +       struct avrcp_player *player;
> +
> +       /* The remote may register for events before its records are know=
n,
> +        * target_init() completes the target from them.
> +        */
> +       session->target =3D g_new0(struct avrcp_data, 1);
> +
> +       player =3D g_slist_nth_data(session->server->players, 0);
> +       if (player !=3D NULL) {
> +               session->target->player =3D player;
> +               player->sessions =3D g_slist_prepend(player->sessions, se=
ssion);
> +       }
> +
>         session->passthrough_id =3D avctp_register_passthrough_handler(
>                                                         session->conn,
>                                                         handle_passthroug=
h,
> @@ -4473,11 +4469,19 @@ static void session_init_control(struct avrcp *se=
ssion)
>                                                         session);
>         session->control_handlers =3D control_handlers;
>
> -       if (btd_device_get_service(session->dev, AVRCP_TARGET_UUID) !=3D =
NULL)
> -               controller_init(session);
> +       /* Report every event supported: the remote registers those it us=
es */
> +       session->supported_events |=3D (1 << AVRCP_EVENT_STATUS_CHANGED) =
|
> +                               (1 << AVRCP_EVENT_TRACK_CHANGED) |
> +                               (1 << AVRCP_EVENT_TRACK_REACHED_START) |
> +                               (1 << AVRCP_EVENT_TRACK_REACHED_END) |
> +                               (1 << AVRCP_EVENT_SETTINGS_CHANGED) |
> +                               (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGE=
D) |
> +                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANG=
ED) |
> +                               (1 << AVRCP_EVENT_VOLUME_CHANGED);

So this seems to disregard what version we are operating on so we
don't foresee any problems with sessions getting unknown event bits
being set? I guess we can only do that if we are absolutely sure
PTS/Qualification will never ever be updated to check bits considered
RFU (e.g 1.3).

> -       if (btd_device_get_service(session->dev, AVRCP_REMOTE_UUID) !=3D =
NULL)
> -               target_init(session);
> +       session->svc_complete_id =3D device_wait_for_svc_complete(session=
->dev,
> +                                                       session_svc_compl=
ete,
> +                                                       session);
>  }
>
>  static void controller_destroy(struct avrcp *session)
> @@ -4513,6 +4517,10 @@ static void session_destroy(struct avrcp *session,=
 int err)
>
>         session_abort_pending_pdu(session);
>
> +       if (session->svc_complete_id)
> +               device_remove_svc_complete_callback(session->dev,
> +                                               session->svc_complete_id)=
;
> +
>         service =3D btd_device_get_service(session->dev, AVRCP_TARGET_UUI=
D);
>         if (service !=3D NULL) {
>                 if (session->control_id =3D=3D 0)
>
> base-commit: 1608f836188610aabeff5a3164169ebe0360e443
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
