Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3C5680
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031298; cv=none; b=Y+9rBFTFX1siLGpKFKAG4Zhiw5QuB1ZYJ2hfus6j7dFmMZegswaabxBhHOsp9hlNwCjIwuaCb4RKyoh5R/RkDHsjrakuDUsAPm0tFNAcXYTEGBmkbQihOinUlE/paN2arICzxgpFWfxlx+yUTsTnk17EAFCGrsGcdN7NQXqkW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031298; c=relaxed/simple;
	bh=1tp3pARZ5qNFDuKf947k17A1igg9tJ0UxdhC7qvkJ2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aI0GUOMU71Au31hssOTZHrx2EUaYeaoBAIXoMhY4W0s93PZRT0t0ghKRKEHB7XsSflh8/5St2stMmPPuyZmIQgDFAh9/MbCMBCUkI+YzxDzcIogMfCvYnF3O061eK780M2UZE8iD5HuVKg+QnrqL+w/cygyzgg0sFeFMR45v3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmWdtPWT; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmWdtPWT"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-549967c72bcso5160873e87.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744031294; x=1744636094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vubFuGu5LF8TMxZJOhYWbSvBm0DDW1KLGq35BKvCM5k=;
        b=lmWdtPWTqCzTs1zfceXdJbKoaLdzSLmEQ299Ja8pYYIfCAxX+gs5txO/zz+dhFxkM3
         y1R3XCY3/vCYX8x2vZBuGCfgRWh0x1lOBx4YpxLpbYMyjJGNODFjdVd0N55lBbwkKHeu
         DujPuZKiYNKtlCnA3QW3NMLo5dCmFMcAdOolQxRRimhUsqYnb0MxcJ+VXTsbXBnROV7f
         YeJ1lKhXZ/FIqShLO13n6K2JSUkBvgrR7chYzE27yH4ZbPwO9mvjVTrtHj9mx9XINIt8
         EM5rl1hsZeTWZUK1fOUKYYbDPWjOqVOD4rVtPeXjsTtJpsLzIHp4YY2cRRTiIS15H+W/
         2r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744031294; x=1744636094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vubFuGu5LF8TMxZJOhYWbSvBm0DDW1KLGq35BKvCM5k=;
        b=k617v76wGnUcU702Y2WWv26W0OV1jqT5ddbfDHOf8hN+g4zymarz46KoIrUYJXGkaS
         Tv4+9WsQxZmxA6kGDqDZMl69v+gKoXd7tFCFK8nwaGWdC6oa8bjkL3YdjkCJFxFEDdrX
         lu3IDbU4UOrofr8GqLSuj2GsNewWY9BHxkGq6jAZ7VmDN3R9ueGh+6it6XDfWepKzIW/
         i2hS96PckW3OROnHu4DjxQHqzn7KZEVEsyuPTweGK7+XGRE39Vf3Msd25NH220zWFS7V
         T2kvRrosFCgbcUtXH7IIqxumgUqXaBcofU6rw9hbqxxNYjNRqLVQzrKfvam7B1lbAbU6
         X9OQ==
X-Gm-Message-State: AOJu0Yx2j9xJ1UPDEerSOorMJf/VQyWDdShON3GW2XgAWmsC4U59j6h5
	AF/cxQDXMvxO6dusWHBkNLHhLEhieKrKq9wP7MEwJfwa/VwQlr3yd/zm7vXBGVWBVnflC0SGLws
	AoNmZUnbRAsXjMwMJixWKjgQ347+HiAVt
X-Gm-Gg: ASbGncsut9ZdaHlIQKgl6xKEhqOsdT5rr6aph7he28G7LAEE1weiQdOrLLhaGk1KEmQ
	cK6cwmYGQXreS6qgZu+Vfrx9hgiDZxaAlrrIzlJjjnr3sa6RBuTBKb49CyZWQzgZiRvSdumkZTM
	W+fE83Jw2E0BlQJ4cbDF5/r52w
X-Google-Smtp-Source: AGHT+IF++PHRM5dCIE4b9LQwnSD5QQxzeWVBRMJAEoYjy9u4mvpm+ROgIed90zmUwUYIvO5y9PEX9jtqT5FQNn2cvAY=
X-Received: by 2002:a05:651c:154e:b0:30b:badf:75f0 with SMTP id
 38308e7fff4ca-30f0be061b3mr37166671fa.2.1744031293425; Mon, 07 Apr 2025
 06:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407-bap_aes_state-v1-1-dfc090c49cea@amlogic.com>
In-Reply-To: <20250407-bap_aes_state-v1-1-dfc090c49cea@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 7 Apr 2025 09:08:00 -0400
X-Gm-Features: ATxdqUE4yLh1Uq4ivHxA3Ljtw7-D1DUcsZ-Co-ZVQlIwyiXCCqB-1QWjQ_0_CZY
Message-ID: <CABBYNZJsJAbGz=VUZuabixnTJcj1gZHM5m1P_cU06aMn3YZo3Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez] bap: Add idle notification for ASE State
To: yang.li@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Mon, Apr 7, 2025 at 6:34=E2=80=AFAM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> When the ASE state changes from releasing(6) -> idle(0),
> the idle state needs to be notified to the Client.
>
> ---
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  src/shared/bap.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 650bea2f4..c40d6e051 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -1123,17 +1123,12 @@ static void stream_notify_metadata(struct bt_bap_=
stream *stream)
>         free(status);
>  }
>
> -static void stream_notify_release(struct bt_bap_stream *stream)
> +static void stream_notify_ase_state(struct bt_bap_stream *stream)
>  {
>         struct bt_bap_endpoint *ep =3D stream->ep;
>         struct bt_ascs_ase_status status;
>
> -       DBG(stream->bap, "stream %p", stream);
> -
> -
> -       memset(&status, 0, sizeof(status));
>         status.id =3D ep->id;
> -       ep->state =3D BT_BAP_STREAM_STATE_RELEASING;

Not really sure why you are taking away releasing state, we actually
depend on it for the new tests:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D950067

>         status.state =3D ep->state;
>
>         gatt_db_attribute_notify(ep->attr, (void *)&status, sizeof(status=
),
> @@ -1713,6 +1708,7 @@ static void stream_notify(struct bt_bap_stream *str=
eam, uint8_t state)
>
>         switch (state) {
>         case BT_ASCS_ASE_STATE_IDLE:
> +               stream_notify_ase_state(stream);

We need something like stream_notify_idle.

>                 break;
>         case BT_ASCS_ASE_STATE_CONFIG:
>                 stream_notify_config(stream);
> @@ -1726,7 +1722,7 @@ static void stream_notify(struct bt_bap_stream *str=
eam, uint8_t state)
>                 stream_notify_metadata(stream);
>                 break;
>         case BT_ASCS_ASE_STATE_RELEASING:
> -               stream_notify_release(stream);
> +               stream_notify_ase_state(stream);

This is actually wrong, we need to notify the releasing state.

>                 break;
>         }
>  }
> @@ -6397,9 +6393,8 @@ static bool stream_io_disconnected(struct io *io, v=
oid *user_data)
>         DBG(stream->bap, "stream %p io disconnected", stream);
>
>         if (stream->ep->state =3D=3D BT_ASCS_ASE_STATE_RELEASING)
> -               stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> +               stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);

Ok, so this is sort of reverting from  bap: Fix not generating
releasing state? I was wondering how much testing you guys did to
confirm this is the right behavior, I don't think it is and Im trying
to figure out if there are any tests for the testing spec that do
properly verify this behavior.

> -       bt_bap_stream_set_io(stream, -1);
>         return false;
>  }
>
>
> ---
> base-commit: 0efa20cbf3fb5693c7c2f14ba8cf67053ca029e5
> change-id: 20250407-bap_aes_state-9306798ff95a
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz
