Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4462285C9C
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292402; cv=none; b=opSBPA+TfSBkGL2L7+SC/34bfoSlFQMRdOOoqDcCLQg+49kydoI1SZxslSznTxuqB/wXNFLloqqXaERAU2OlNXPwSEgORo2RfdUbx1+zg0NDe5FFFPXbMogjQ8ky4n6SH7glctIHAbxByPN6DhkooK4KW5KoPkE5z1WzOT9TFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292402; c=relaxed/simple;
	bh=UuI3bxi0vThpYAD7bb6+hlZ6tbyNKwtUp8j6NnOAdhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6k+TaptMTKPESsMV5eFn8K8TlLHD/h8bCew8NmeqGhJ3pf+CK0SbBhQnHrjkjrXVirsSXPyHHfSWhXvmGSegAu0SLEJtDPztQAFXjR5NHXX7gK4OFSDRhQB7Mng2pDBPFpWz/uUyMxNc81b1gBCJxGqEwE5Bb+727vlSzusDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnuPOygy; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnuPOygy"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32add56e9ddso20102071fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751292399; x=1751897199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhcT0MYjsE/cIfp7Yn00bhWgFm3zafFsEuKTQT/Y7pI=;
        b=mnuPOygykrTRj8yAJ+R5chDFsYer94n4pkTwWsNEXNM3B3BSaluLc2YZGydip6DxZe
         atc5OoXObCi6WsBVHzYlwIlMtzbYhfgO1JKdMCXof9aoZpswVnZp8rkSAKQgzVwyHuP6
         S4xAtTzsv44PfvGX07YTkhY71qD7eORqg9mQx3i99r1EdrgN/UTepFykh3xOSkWkRQiF
         +LYUUCJ0CX/xoIN0NN1E9bwGvIfOoMr4LbGwgH481HkbzyEQN3cQhi8Ef4qEmIGsVNMB
         /yq9C3rbA7ygJVvLl5In3Sb7G/3Rv4uCT/QczCYlqraaFE1JqB/qIg4fuaB90LJasP/1
         wtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751292399; x=1751897199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhcT0MYjsE/cIfp7Yn00bhWgFm3zafFsEuKTQT/Y7pI=;
        b=etwuXQFoOSC9Evf9cbsuBrW/dbJ+wquB+okmEDjq3zFXmci+lCxy/n6Chk26c2psuJ
         4I5S+Yoog9i52Duk6at531owadH+0xfkTq58H6tjQ7asYUSf/wQWgKiTG12YIS0pQPIm
         MsYfe1ZUdan7QpEHy+Hzt96fopwPgZ6QMxVWpmIYN7Vy3MzaHzvF58/KRA8v6iCXIU9i
         8qkvbXDwE95cHDy4cS48aFnHLJ3hgOf6j9DsuSxuTe3pJj7YeLhAdQvADYWNH3iLfbMV
         gUkEuYKVTgkOHrtasGWkEfsvdCmFrcJbkAa06kbEveLlIEbYU/L/4WyvHaMl+GvQo82H
         kLMA==
X-Gm-Message-State: AOJu0Yywe1vU7WFgOSZ52OMUlrEpgyFF8QIZDvbFiOLQIkn31R7WZ95d
	kGh7f2f35KGO8aVHvpucHk+WPSZh/QtF4X5Mrt+JBC4pLfbWgM7WoanjxdD7R5RK86wzZMrIk0D
	or0bhutfWi1vbSUtemuAq6/YXbr6Mc5EcEAMUP3DxMw==
X-Gm-Gg: ASbGncvwkBcBRc3XJl9Q/ugtdfmsWGnAtFZFz+jCE6tr9AtHDX/fzi5xoamBqVhPrP+
	j2y08cXHVBGXV4KJvTgPyWK1zrqENLCKxFlXkeM6pkdRbJ24+F8riSRYfgNxAUQzVM09vM404z0
	Eo29Vf7fMC6hhhp9ggTeaQpgakvDYo2aLQg4sl/MV4CQ==
X-Google-Smtp-Source: AGHT+IECOY92GV5SIFTYl3y4S7o4apdNev5GQYOuwC3zU6cur4mb5g0poQY85WImpgFBmmW9WSUKbRuBC+kF53jrhCQ=
X-Received: by 2002:a05:651c:41c5:20b0:31e:261a:f3e2 with SMTP id
 38308e7fff4ca-32cdc438357mr28977101fa.1.1751292398333; Mon, 30 Jun 2025
 07:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-bap_for_big_sync_lost-v2-0-1491b608cda5@amlogic.com> <20250630-bap_for_big_sync_lost-v2-1-1491b608cda5@amlogic.com>
In-Reply-To: <20250630-bap_for_big_sync_lost-v2-1-1491b608cda5@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Jun 2025 10:06:25 -0400
X-Gm-Features: Ac12FXy2AofbNxO-HE-TglHxq6q2C1kyRrPQyHLKJseMLz0LBtS1_454exyN4UY
Message-ID: <CABBYNZ+WTDrh5GM+98_d62UqHdNaC7-18b1tUHhN+FLdZABYfg@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez v2 1/2] shared/bap: Set stream to idle when
 I/O is disconnected
To: yang.li@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 30, 2025 at 4:06=E2=80=AFAM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> When BIG sync is lost, the stream status transitions from Streaming to Id=
le.
>
>   > HCI Event: LE Meta Event (0x3e) plen 3                #3189 [hci0] 11=
8.870863
>         LE Broadcast Isochronous Group Sync Lost (0x1e)
>                 BIG Handle: 0x00
>                 Reason: Remote User Terminated Connection (0x13)
>   =3D bluetoothd: src/shared/bap.c:stream_io_disconnected() stream 0..   =
118.871183
>   =3D bluetoothd: src/shared/bap.c:bap_bcast_set_state() stream 0xdf..   =
118.871227
>   =3D bluetoothd: profiles/audio/bap.c:bap_state_bcast_sink() stream..   =
118.871258
>   =3D bluetoothd: profiles/audio/bass.c:bap_state_changed() stream 0..   =
118.871307
>   =3D bluetoothd: src/gatt-database.c:send_notification_to_device()...   =
118.871384
>   =3D bluetoothd: profiles/audio/transport.c:bap_state_changed() str..   =
118.871452
>   =3D bluetoothd: profiles/audio/transport.c:transport_bap_update_li..   =
118.871509
>   =3D bluetoothd: profiles/audio/transport.c:transport_update_playin..   =
118.871555
>   =3D bluetoothd: profiles/audio/transport.c:transport_set_state() S..   =
118.871610
>   =3D bluetoothd: src/shared/bap.c:bap_bcast_sink_detach() stream 0x..   =
118.871660
>   =3D bluetoothd: profiles/audio/media.c:pac_clear() endpoint 0xdd25..   =
118.871689
>
> Fixes: https://github.com/bluez/bluez/issues/1343
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  src/shared/bap.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index bccbc73ff..984ae782d 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -6584,6 +6584,11 @@ static bool stream_io_disconnected(struct io *io, =
void *user_data)
>
>         DBG(stream->bap, "stream %p io disconnected", stream);
>
> +       if (stream->lpac->type =3D=3D BT_BAP_BCAST_SINK) {
> +               stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> +               return false;
> +       }

The likes of bap_bcast_disable, which is what I assume such event
should result, does set it to BT_BAP_STREAM_STATE_CONFIG which I think
is the correct state since this is a about the BIG Sync not the PA
Sync, or perhaps we always assume the later as well since the socket
is disconnected the PA sync will be cleanup? In that case I'd add a
comment about it.

>         if (stream->ep->state =3D=3D BT_ASCS_ASE_STATE_RELEASING)
>                 stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
>
>
> --
> 2.42.0
>
>
>


--=20
Luiz Augusto von Dentz
