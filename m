Received: from mail-yx2-f18.google.com (mail-yx2-f18.google.com [74.125.224.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0CC51FCB8
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.146
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171729; cv=pass; b=EIbGJUIoRQRduOaVgr4Jy0F/9OlWgtJ0W9meyJKsQm2TpOkDoUqhpIj3L3cSGxKbHl2+ji7jlx3tounCqShhrEEOcOFycqLb1dkfC/IqeWzQQ0QdTkvnZm+SY2eo9ydmA4qDS7SJJncddyNL2XeQndh2nCo+FfNJpgNMzf+ukcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171729; c=relaxed/simple;
	bh=7+Avl/fKXhPY/bUWzQawFz9yYQWqO66fCVM4Psdlbek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KI7yLl5QVDBYIYXwP4HtjY1urz4irojLDToWc8/SemKUdR5dWQTunihUd+fuDeKGxYpD16GuNB+G40XEppG8BtScnH+iMH5Fp7Z0Hr4eMizpB6ULPHRvAIZhqoAzZ+6CY++ay+kJCVhB3FcMCF+MZ5sk7sU+qXnR1exw8J7r4R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEqomvga; arc=pass smtp.client-ip=74.125.224.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEqomvga"
Received: by mail-yx2-f18.google.com with SMTP id 956f58d0204a3-66e4aac92dbso889006d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 06:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790171727; cv=none;
        d=google.com; s=arc-20260327;
        b=IuDOuaJKa4ywllB5S9vlhF9vK4+/y9RhcrfADsqSeHEJ01hTsI6j6ky+Q7MwhtwkHQ
         eKNC4YoEql2K5klF6TK6aqXeWv+gYTFm//gHFDBhbNePf2nzMP+pTyzXtEtWBEsrGkB2
         OX6tX2aFoZyt3qsp8rFIS0ELHgJamRPbopxEuOCkMIXAGYTnYSrnk0XYGaLHnEhvXaQJ
         EZhlzmzOx6c6mgQHpU1NY4l1Xa6P2JZ815AEBEyELjwOCuz/axLkVBR58obbA97406be
         sOtlJNxl/uZjd1U6uTKPgXsij0guLKzltSeOIOeJZg5+hO3SOcSYE4FwbeeYFF+sL1an
         4Xzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vPp6aOrYg8Ur9w6++HZ9tsXCq4SxnZ3n79cpjzN5naU=;
        fh=ImHaVp9LKIGjD0tRyxgUyPXd5WNSYdKgZ1TGxuDzvzM=;
        b=D08SQKl1fqXu0dUlKpt9SJRiQnONjjue+IAU3gtJxYpiq6Z5qUQ/eg6lWRcSGHc58e
         ujFGnbqUlOUE31BdMYYgfEfy3QTeqT55LY7uo8PQdjhMeNTsmZ1IwDFhPyIt/d+GEiGu
         /PD9m5NRFtSNYIGqLw/fKXRKg2wUNo35KVqkmXaz5uJWPdF9zs3SIdXo8lX0u8yjCwfB
         zol23TeubwykdE2X3gpcYPp+o0sTDtSlK6HfG6GRnc/Fn/NnOOdrUFNjESj3nPKkJF5N
         bd75oK01ug6GT3DVefVhb047py3NxSX3hLOzFq7cuspfDxxRIAcxsv64cDLOAX2ygel/
         EoiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171727; x=1790776527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vPp6aOrYg8Ur9w6++HZ9tsXCq4SxnZ3n79cpjzN5naU=;
        b=jEqomvgaWVITnOzHCGIRmQlTd17BzNeaD052jO4RSInFww6Q5rdHiHVGC22jAriQUp
         v8I552jWa1vFrlbibqR9h6/upVYWy3JcK+SAf2rqR8xg9ojCRC+EqxnylscW9J/G0MGf
         DSPeQaWXl2TYvGnoyD637Mt0arL7Ek2GeJPRFYxcupu+IMLiTik+AyW10qJgNhwgNEXD
         da8NnF/j2AgCCJYczUq4KflILDw1a4Owj/JOpMSZfQDO5Q5y4yZ+HbD9RQmriFG11ooB
         HALOnMhL3oLPyNN/L1qEfpWvcoUypPd92QxkClmO2ha1KkFXHqn4qicfoAOiLwVhr88N
         02EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171727; x=1790776527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vPp6aOrYg8Ur9w6++HZ9tsXCq4SxnZ3n79cpjzN5naU=;
        b=Bz4/tDAFjBTRUpjTRTf9Pp1cjeYeVsei5dTOQeKyAw1GcBHuTvIMlt42WlsxzSBZT1
         MpwI9xTmc40fBbSYKE/JVWRpdUXGbVJwY+hHBtvuWxrg504u5eYkD4QNRv/h9+MNprW0
         8WoAWxtp4+pdnBmh1gzF+h++I6+d13Cu2FucAw2ACLzWIwMIBbGbsUVrJFK1ftuJ5dwh
         c8I/o3iMe1mZ4YnpNwvMY2Ts+AD/9ycx4yZLywHeI+Bje2k4RLz2LeLCohpJ4kuusnVX
         EUOJ37z6igwqGJKilOk97OxwpOx9z/d2WxJ1feolEjkvexz2IJNu956jps4En/0vTGUT
         V4Xg==
X-Gm-Message-State: AFuF++kyTINmv/4fJODMO3LvO+WgHRJFiiILkx2eAwrKdTYSDl2KmHZW
	ldlUjDzgrPl/th6SHYBvAt07OauYRSIhBWE7tNyjlej1bB5cIkBi3DJoFj6Ic4GJpSSmh1GkEQS
	LwUeHNduwl4eqMULbBPnO0qWsitLcZ+PFLL1oq7n6M0lR
X-Gm-Gg: AYBFou241fFgwGAq2eSYvYCHAdxIuMfwyayabqswuwEC97beAI7kN2LkMSegNRWel6s
	IgW5Hxrpx19ibs6eUZVf6yFv8M4e155qIPz9adaU4xXTMkg5lBTPqjBFb9qjGTql8V9Hwo1GlRc
	xuLIWE3fuzSC8ASbY+jXNdxUCSl8pfYj7Jk73DXUbk5kd/gFv0tfqL7hRXT9NahjqEcW4z78xJ9
	FJhBCHAHGX2TKAn8R86vrR75w5dsA7ZSNrlJKSYC7jQgTuW7ZMwq8DG0xRN/UNibzLG21Sk1p/a
	pbBu/APqqJ2Keoo98hla05vqbTWEPcIFdsHZd1HWaMHvnISth2RXucEYjfbvEwvwH+nMgk/rtMB
	KWHq/DaIOzN1Lg8gdyOrl6bR26E3fltvIpdGsEgN9gA==
X-Received: by 2002:a05:690e:43d6:b0:671:3cf6:e1ab with SMTP id
 956f58d0204a3-672d578f736mr1091881d50.32.1790171726876; Wed, 23 Sep 2026
 06:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923080003.317019-1-frederic.danis@collabora.com>
In-Reply-To: <20260923080003.317019-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 23 Sep 2026 09:55:15 -0400
X-Gm-Features: AclHuK-eX89lYm0yOJu_w7E80pRyWp3sINdh8AB6J8C2gvEvw4mXQrPs6tP9rGM
Message-ID: <CABBYNZKN2C_65XH_LOptU_GVoarEa_BQmhvzr+7O68Y+Um9Zzg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/avrcp: Poll GetPlayStatus when position
 changed event unsupported
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Wed, Sep 23, 2026 at 4:02=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Some remote targets do not support the AVRCP_EVENT_PLAYBACK_POS_CHANGED
> notification, meaning bluetoothd never learns about track position
> updates for such devices.
>
> When this event is not present in the capabilities reported by the
> remote, fall back to polling AVRCP_GET_PLAY_STATUS once a second so
> the media player position stays in sync. Polling is only kept running
> while playback is actively progressing (playing/forward-seek/
> reverse-seek) and is stopped otherwise, and is torn down on session
> destruction.

Back in the days AVRCP was introduced we decided not to poll the
status and instead have the upper layer trigger it via
https://github.com/bluez/bluez/blob/master/doc/org.bluez.MediaPlayer.rst#ui=
nt32-position-readonly,
that said I do agree that perhaps it is better to it with directly by
bluetoothd since so many years have passed and some manufactorers
insist in not having AVRCP_EVENT_PLAYBACK_POS_CHANGED implemented.

> Assisted-by: Copilot CLI:claude-sonnet-5
> ---
>  profiles/audio/avrcp.c | 64 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index df5f97eaf..105538cdc 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -247,7 +247,9 @@ struct avrcp {
>         unsigned int control_id;
>         unsigned int browsing_id;
>         unsigned int browsing_timer;
> +       unsigned int position_timer;
>         uint16_t supported_events;
> +       bool pos_changed_supported;
>         uint8_t transaction;
>         struct pending_pdu *pending_pdu;
>  };
> @@ -341,6 +343,7 @@ static const uint32_t company_ids[] =3D {
>
>  static void avrcp_register_notification(struct avrcp *session, uint8_t e=
vent);
>  static GList *player_list_settings(struct avrcp_player *player);
> +static void avrcp_get_play_status(struct avrcp *session);
>
>  static void avrcp_browsing_record(sdp_record_t *record, sdp_data_t *vers=
ion)
>  {
> @@ -2224,6 +2227,56 @@ static const char *status_to_string(uint8_t status=
)
>         }
>  }
>
> +static bool avrcp_poll_play_status(gpointer user_data)
> +{
> +       struct avrcp *session =3D user_data;
> +
> +       avrcp_get_play_status(session);
> +
> +       return TRUE;
> +}
> +
> +static void avrcp_stop_pos_polling(struct avrcp *session)
> +{
> +       if (session->position_timer =3D=3D 0)
> +               return;
> +
> +       timeout_remove(session->position_timer);
> +       session->position_timer =3D 0;
> +}
> +
> +static void avrcp_start_pos_polling(struct avrcp *session)
> +{
> +       if (session->position_timer > 0)
> +               return;
> +
> +       session->position_timer =3D timeout_add_seconds(1,
> +                                               avrcp_poll_play_status,
> +                                               session, NULL);
> +}
> +
> +/*
> + * Poll GetPlayStatus once a second to resync position while playing whe=
n
> + * the remote does not support AVRCP_EVENT_PLAYBACK_POS_CHANGED. Polling=
 is
> + * paused whenever playback is not actively progressing.
> + */
> +static void avrcp_update_pos_polling(struct avrcp *session, uint8_t stat=
us)
> +{
> +       if (session->pos_changed_supported)
> +               return;
> +
> +       switch (status) {
> +       case AVRCP_PLAY_STATUS_PLAYING:
> +       case AVRCP_PLAY_STATUS_FWD_SEEK:
> +       case AVRCP_PLAY_STATUS_REV_SEEK:
> +               avrcp_start_pos_polling(session);

Btw, if I recall correctly, position tracking really breaks when the
user seeks the stream using the player progression bar, which
interrupts the continuous timer. So, if the player does either
AVRCP_PLAY_STATUS_FWD_SEEK or AVRCP_PLAY_STATUS_REV_SEEK then we can
resink the position once, afaik iOS media player doesn't use them
either, thus why the whole polling thing is needed to capture non
continuguos skips that are not advertised.

> +               break;
> +       default:
> +               avrcp_stop_pos_polling(session);
> +               break;
> +       }
> +}
> +
>  static gboolean avrcp_get_play_status_rsp(struct avctp *conn, uint8_t co=
de,
>                                         uint8_t subunit, uint8_t transact=
ion,
>                                         uint8_t *operands, size_t operand=
_count,
> @@ -2252,6 +2305,8 @@ static gboolean avrcp_get_play_status_rsp(struct av=
ctp *conn, uint8_t code,
>         media_player_set_position(mp, position);
>         media_player_set_status(mp, status_to_string(status));
>
> +       avrcp_update_pos_polling(session, status);
> +
>         return FALSE;
>  }
>
> @@ -4128,6 +4183,9 @@ static gboolean avrcp_get_capabilities_resp(struct =
avctp *conn, uint8_t code,
>                 }
>         }
>
> +       session->pos_changed_supported =3D
> +                       !!(events & (1 << AVRCP_EVENT_PLAYBACK_POS_CHANGE=
D));
> +
>         if (!session->controller || !session->controller->player)
>                 return FALSE;
>
> @@ -4140,7 +4198,8 @@ static gboolean avrcp_get_capabilities_resp(struct =
avctp *conn, uint8_t code,
>                         !(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
>                 avrcp_list_player_attributes(session);
>
> -       if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
> +       if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)) ||
> +                       !session->pos_changed_supported)
>                 avrcp_get_play_status(session);
>
>         if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
> @@ -4470,6 +4529,9 @@ static void session_destroy(struct avrcp *session, =
int err)
>         if (session->browsing_timer > 0)
>                 timeout_remove(session->browsing_timer);
>
> +       if (session->position_timer > 0)
> +               timeout_remove(session->position_timer);
> +
>         if (session->controller !=3D NULL)
>                 controller_destroy(session);
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
