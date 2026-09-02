Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1967E4A441D
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363088; cv=pass; b=YCxIPFJKRr81FhuWhCa+RnPz5bnKalt45Tw9nssPsj/r07jv0VD/exewq9tcYWwVB7MwEtBwfMtGLGZH2m0mCzV9NWqFVEhbNom820M44mfWZr7lJatoJkvhAtyOspG1CMhvIFLlJitubMdD0Q0r85WG+fp38OpVY0MD/KeIf70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363088; c=relaxed/simple;
	bh=V1zoxzMr40aJ0JifNDone3xzXr4/JLC5xage46s6uc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vpep8un4v5SYpWuaYGAJa3hXxJdnxSg8QDWkepcnXvdfW4YoKUWBQhipNTiThOTna7RCO+IXXW/8EReU6YCwzbe1i97JCjSR0gHIhop9yv3RbR4QGWLqBOcdjpoAat/IjqnDTFs7aviQy3OL/xa3uELBOB8PGlTXwLrGDLzE1S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QU9nsD+/; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU9nsD+/"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-86c0e4dd49cso12555807b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 08:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788363086; cv=none;
        d=google.com; s=arc-20260327;
        b=ZB0KVaY6LO/lQzMPFBsCh9Gf3VLP4Ye95TK9xGFD6nY+Q7e7IoCw8iIasReN+SD7zb
         YSDzFYQCrHJTdQGy7ChQN1TkqPiUhUnTkUQhsVIAsU90wKEtgfWTRUccjVQ2Y1BjjElC
         8TRYpksKGSBKSxJxnhP/LGSzyJ1wHScmCufW9Co9erPUTF2rc62mHGSfDbCzwZFMzWRe
         9pdl2B9cxQiEhsze1PXfhpsAe5Nyg3mJAL69y0yAeKrgK83fwiLANeQLsKdrq3d/IZKs
         UlV46MAZNqNIeRLXEOBKKXDLNDrpCK1UnKbk1Cp6YPAvoR5xvFZwHOn65A+yPDfKyu9x
         0GqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8jlUQS4KLS5Vv1uPa9lTGI6SqgHo4zN7CkVrrTyMB3Q=;
        fh=ZFlyP5+YKgJkmoBW5+QP1miOu0vNYasz89rr0yCZ/+4=;
        b=KofnxMcOG5eyjmSAkvwTWNG0Cfn+WM7yyTrC6zcdMs5+LwiUCz4c6ATVUQ0QiJ93SP
         pxXcubUGo7eRcqg0pqME06X4AGnArCd9vy4zVlVDtTJR8Zaf3CbC35Xz66JGJY7zghgH
         HGZgq9DhsRwP66BhYKMXv8EXqpKjKYNkkqyHaFUpN8U9a7vnjFeDafjaNKll4OFMF17v
         CrY/o8kIIuajzSicLBnygisj+zxwmvAeb4oAPNa6V+Hxz7U6a4AJOtvOLeczY3Tfo/Zj
         Enye0xTQZZPMD0ozJCrNwpqtd0SFvZ2VedGQ6cm+C001D248C8X8BfiFQ5yCxVJH6d2L
         nBJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788363086; x=1788967886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8jlUQS4KLS5Vv1uPa9lTGI6SqgHo4zN7CkVrrTyMB3Q=;
        b=QU9nsD+/KSOUOeCI1xMvG78S95L5RdnxfTwlRxyQZ7sxoqlq7zr25llyoN0OYsoZMV
         jVDWbOlvoLcZrkjC9BJXkr6rgVhv981F+W9p2NpjbBBILy+ywGyq9fLpcFQ/slcNewFb
         j1yXzXWqgvzYB2PY9I5nmqNkfeda3zl9Y7e2er38hFS808uEhndBTB4Owr8wbiBvY+Va
         jejZJyb1UDGVP3afBWOscLsRwD6xcVO5BtvtyVMX9d9dT/6VbA9SvCH5Hfvf9UUboFaR
         2RmnxfH6IXXKvO5NIfuiD1VnJogM8ilM6GmDGu0IwAa0+8p8PeRHuKusOnYMyqne2qSg
         Y3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363086; x=1788967886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8jlUQS4KLS5Vv1uPa9lTGI6SqgHo4zN7CkVrrTyMB3Q=;
        b=arLN8kpSqmw/TYXeUDvJsgQMNMV03pDHwwUy2uxQMCFsCjxckuxuqr4NOlDvtl+Bm0
         CZlaNQA0jDkOe9/zUaaFoTqk0GFDMkJ2zCU6NynDq7QYdC51RIVYQXu1xtBm6UI//wIn
         edHKkvCM7RwKOSn/nBLep/tSz6Q3F25vLIc3aAbBpU79ImODSQ/a3Jrc+a6KVqewXVsL
         HNSZL6nmHLGWFgNucfM2Ddz+1VazLzFw4Wwr4rOLxTefu6QIa0GsQRweaPg4QlxINfrk
         +mKDZrCb4uILIrlblrLayR/M2A6m5Vxs+drRObiqhJ64oAlH6YIV4903Kj8hD5S9/WVH
         0LiQ==
X-Gm-Message-State: AFuF++kyrb2t2nMl6ThvAt2JwMC9ZBmQ313mD2NG3jEfI8NmyuTjwwKs
	Nb1nwtsDrXh5LVGQjh2Ap4iazq0g2Rx8T12X9Bv6t5wXnWEaw+500YvxtMk2TyvguZm1QtQWsVn
	WKLgtU0DlSOLx8K/S9MOFpccTTr/zCDJFM90qEgNiwg==
X-Gm-Gg: AYBFou0f3hHsgo3yaRDGAhcA0HkSwyRWj5VK/FNZud4cjlf5yb1mzTn3vnkYVeXArJi
	CMZtxJloIzZzbo+XGco0PFX+vElRLYbu85lke9WLvMKAXX/rGNLyB9MrkRNKBEBHmUZAcP4XQrQ
	Z8oyD6HeckxcrzIrlwtq3gV1Gu5YFqtAIioFDRQrY4rapT9nCS9ZJ/56QYFTD/s8wf7tanI6PUY
	7swtAVrOKEHbb0ZKX2ef88FPfYABOj2vL7ydBENeEix0bioxNRXQbVxSp91tqBNSk6P3vI7ofOW
	+TzqBO/doU6WicIwtRKE1Z8zZwBSQjeMGWWrPHtkxJAmNqdvIMpSTRna6/0d9mga3VU5RCloH9p
	J8+8CP3qn7o8mazl0KNP3vTmNp2Ul5w6iGpcIFVl0nA==
X-Received: by 2002:a05:690c:93:b0:80c:5ce9:8f29 with SMTP id
 00721157ae682-86c5221a98emr31871037b3.22.1788363085777; Wed, 02 Sep 2026
 08:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831061144.7767-1-raghavendra.rao@collabora.com> <20260831061144.7767-2-raghavendra.rao@collabora.com>
In-Reply-To: <20260831061144.7767-2-raghavendra.rao@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Sep 2026 11:31:14 -0400
X-Gm-Features: AcwNN1UGxUDgr4rKFCtL4e01EzZPg5D0TelEvEEeQJE6l2IYCVd1zIy1ZFfD02U
Message-ID: <CABBYNZ+Y2=+MhptF_tdd2DhDP308LA+F4UJjCzeEnZdc5LKTKw@mail.gmail.com>
Subject: Re: [BlueZ PATCH 1/3] profiles/audio: Support MCS fast seeking
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Raghu,

On Mon, Aug 31, 2026 at 2:12=E2=80=AFAM raghu447 <raghavendra.rao@collabora=
.com> wrote:
>
> From: raghavendra <raghavendra.rao@collabora.com>
>
> ---
>  profiles/audio/mcp.c   | 43 ++++++++++++++++++++++++++++++++++++++++++
>  profiles/audio/media.c | 27 ++++++++++++++++++++++++++
>  profiles/audio/media.h |  1 +
>  3 files changed, 71 insertions(+)
>
> diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
> index 8adf814e8..4df388a22 100644
> --- a/profiles/audio/mcp.c
> +++ b/profiles/audio/mcp.c
> @@ -60,6 +60,7 @@
>
>  #define MCS_UUID_STR   "00001848-0000-1000-8000-00805f9b34fb"
>  #define GMCS_UUID_STR  "00001849-0000-1000-8000-00805f9b34fb"
> +#define MCS_SEEK_OFFSET        (10 * 1000 * 1000)

Okay, what is this for? Why it is not the final number and where it comes f=
rom?

>
>
>  /*
> @@ -440,6 +441,7 @@ struct mcs_instance {
>         struct bt_mcs *mcs;
>         struct queue *player_links;
>         bool at_start;
> +       int8_t seeking_speed;
>
>         /* GMCS-specific */
>         struct bt_uinput *uinput;
> @@ -494,6 +496,11 @@ static void mcs_update_media_state(struct mcs_instan=
ce *mcs)
>                 state =3D BT_MCS_STATE_INACTIVE;
>         }
>
> +       if (state !=3D BT_MCS_STATE_SEEKING && mcs->seeking_speed) {
> +               mcs->seeking_speed =3D 0;
> +               bt_mcs_changed(mcs->mcs, MCS_SEEKING_SPEED_CHRC_UUID);
> +       }
> +
>         bt_mcs_set_media_state(mcs->mcs, state);
>         bt_mcs_changed(mcs->mcs, MCS_TRACK_POSITION_CHRC_UUID);
>  }
> @@ -656,6 +663,32 @@ static bool mcs_pause(void *data)
>         return mcs_command(mcs, BT_MCS_CMD_PAUSE);
>  }
>
> +static bool mcs_fast_rewind(void *data)
> +{
> +       struct mcs_instance *mcs =3D data;
> +       struct player_link *p =3D mcs_get_active(mcs);
> +
> +       if (!p || !local_player_seek(p->lp, -MCS_SEEK_OFFSET))
> +               return false;

Should we seek back to 0? I don't get why you need to seek negatively like =
this.

> +
> +       mcs->seeking_speed =3D -1;
> +       bt_mcs_changed(mcs->mcs, MCS_SEEKING_SPEED_CHRC_UUID);
> +       return true;
> +}
> +
> +static bool mcs_fast_forward(void *data)
> +{
> +       struct mcs_instance *mcs =3D data;
> +       struct player_link *p =3D mcs_get_active(mcs);
> +
> +       if (!p || !local_player_seek(p->lp, MCS_SEEK_OFFSET))
> +               return false;
> +
> +       mcs->seeking_speed =3D 1;
> +       bt_mcs_changed(mcs->mcs, MCS_SEEKING_SPEED_CHRC_UUID);
> +       return true;
> +}
> +
>  static bool mcs_stop(void *data)
>  {
>         struct mcs_instance *mcs =3D data;
> @@ -752,6 +785,13 @@ static int32_t mcs_track_position(void *data)
>         return local_player_get_position(p->lp) / 10;
>  }
>
> +static int8_t mcs_seeking_speed(void *data)
> +{
> +       struct mcs_instance *mcs =3D data;
> +
> +       return mcs->seeking_speed;
> +}
> +
>  static uint8_t mcs_playing_order(void *data)
>  {
>         struct mcs_instance *mcs =3D data;
> @@ -858,12 +898,15 @@ static const struct bt_mcs_callback gmcs_cb =3D {
>         .track_title =3D mcs_track_title,
>         .track_duration =3D mcs_track_duration,
>         .track_position =3D mcs_track_position,
> +       .seeking_speed =3D mcs_seeking_speed,
>         .playing_order =3D mcs_playing_order,
>         .playing_order_supported =3D mcs_playing_order_supported,
>         .set_track_position =3D mcs_set_track_position,
>         .set_playing_order =3D mcs_set_playing_order,
>         .play =3D mcs_play,
>         .pause =3D mcs_pause,
> +       .fast_rewind =3D mcs_fast_rewind,
> +       .fast_forward =3D mcs_fast_forward,
>         .stop =3D mcs_stop,
>         .next_track =3D mcs_next_track,
>         .previous_track =3D mcs_previous_track,
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 95f9580b0..aeb6226da 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -157,6 +157,7 @@ struct local_player {
>         GTimer                  *timer;
>         bool                    play;
>         bool                    pause;
> +       bool                    seek;
>         bool                    next;
>         bool                    previous;
>         bool                    control;
> @@ -2296,6 +2297,29 @@ bool local_player_pause(struct local_player *mp)
>         return local_player_send(mp, "Pause");
>  }
>
> +bool local_player_seek(struct local_player *mp, int64_t offset)
> +{
> +       DBusMessage *msg;
> +
> +       DBG("");
> +
> +       if (!mp->seek || !mp->control)
> +               return false;
> +
> +       msg =3D dbus_message_new_method_call(mp->sender, mp->path,
> +                                       MEDIA_PLAYER_INTERFACE, "Seek");
> +       if (msg =3D=3D NULL) {
> +               error("Couldn't allocate D-Bus message");
> +               return false;
> +       }
> +
> +       dbus_message_append_args(msg, DBUS_TYPE_INT64, &offset,
> +                                       DBUS_TYPE_INVALID);
> +       g_dbus_send_message(btd_get_dbus_connection(), msg);
> +
> +       return true;
> +}
> +
>  bool local_player_next(struct local_player *mp)
>  {
>         DBG("");
> @@ -2673,6 +2697,9 @@ static gboolean set_player_property(struct local_pl=
ayer *mp, const char *key,
>         if (strcasecmp(key, "CanPause") =3D=3D 0)
>                 return set_flag(mp, &var, &mp->pause);
>
> +       if (strcasecmp(key, "CanSeek") =3D=3D 0)
> +               return set_flag(mp, &var, &mp->seek);
> +
>         if (strcasecmp(key, "CanGoNext") =3D=3D 0)
>                 return set_flag(mp, &var, &mp->next);
>
> diff --git a/profiles/audio/media.h b/profiles/audio/media.h
> index 1c43075ba..a89466657 100644
> --- a/profiles/audio/media.h
> +++ b/profiles/audio/media.h
> @@ -73,6 +73,7 @@ bool local_player_have_track(struct local_player *lp);
>  bool local_player_play(struct local_player *lp);
>  bool local_player_stop(struct local_player *lp);
>  bool local_player_pause(struct local_player *lp);
> +bool local_player_seek(struct local_player *lp, int64_t offset);
>  bool local_player_next(struct local_player *lp);
>  bool local_player_previous(struct local_player *lp);
>
>


--=20
Luiz Augusto von Dentz
