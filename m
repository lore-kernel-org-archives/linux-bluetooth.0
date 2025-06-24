Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060002571A1
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770551; cv=none; b=St0Qyv/Gq9ZhP3wtIzIzNG4j+oHYBHrhtKfmMlDN3k6w6KC1IQnL7c1CRsn0HPf3l9N+503Ua06P6XRHb1bZjIhhwiZkctrEQFasDmi/UkIi0I45aLQ+teecvTYE+DDx64OA/5SxQm92bBnbKqqhooCRSg0d+rOUQCFKuhzjRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770551; c=relaxed/simple;
	bh=j2uL5RWtH+Rhjkte0Lb0vfd6v+NfY8sC24yKGcpe1YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpNP9RrOES9TrjAThz6Lhr9/gz9Upshi4xJirlagy2nH0wHa/1GArZVlYV4nLQcTbkXHIIM2qJw+8HUeLxpTJhrw58zfvDfYHSbAMkmxvYVzyyPWwKogrdKne8HEfSREb7qlcKXlzXBnoixkRIUq/aXdmVR/LnYU2AO+GUDeI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jh0y17UE; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh0y17UE"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32ade3723adso63423961fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 06:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750770548; x=1751375348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZPoV9lytSwIwK8Htp8CXXPJd928f4GE6nenI6Ghu1E=;
        b=Jh0y17UEyXJ/9CGeXLlhNSL7Z9xK7Uox76vbiKHmi9Pdfk2UU/o9SUJeWWGsQdc+rE
         JCT3o/sutqJEYc0riCU045RCg090s9wTg5aFfNsviKf6etIb+2QsKk1ppFdS1/dYU+o/
         kOp8GVeGXB4WiMZZ61VJ8aksccWUisQNnb6l6OsY8xIW5vUq68J8Bni0JN8iCxbIbWPd
         aBvTE9E1Em+vNZe7qAbuC0gOevOivAd4XuF8HSNsKmK5E+DlQAwEryBOrjYoGv+1u/39
         En32Np+7o7WD3OZWdcTGVjHMgFqqZANR3PWXNhDmt8A657Eo6MnElXMX3cq6sj73QarU
         9c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750770548; x=1751375348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZPoV9lytSwIwK8Htp8CXXPJd928f4GE6nenI6Ghu1E=;
        b=XiYIC4ze6m/rVjwvUGohHP0j2WkLFRatDuvvNOg8JJsVkuNtJ03lTGso4Hu1RuVmTD
         OzftGGEKpx/HX3uGId80kqnawUul8yOKu0mJsmdmCP/qUBny8+Q17Td/y2HkUCsywFqL
         Bgxmt5qQ8oNi5PgpLFmWpT1DRWfzVkwdJJjS5/wYxB4llqD/oOEsBvpPzyWFW0GJ/v/b
         88AKxmiYftMOE0846sR+1OI9cIVY1se+fStOhpbniDx7/7DXlhYg1NaROoLYlCjyWDUc
         yGei6bLey5ZxDovG6k6TphkvWSLd7knKB3BXD+0sl7OtyDKt3M2rJXDSPFLzK48ra/dW
         sPew==
X-Gm-Message-State: AOJu0YxK7AEYD7ugHpP9yRj7X/DHo2NXlLROWPLz00l3gCcSbllJ9Sp6
	3iCSyWHeB32Z+9gyjIhRCXmDolA9NnTWrPKxv6ivR55ptT2HmX3s7ChS8Gl4AfhCQav8eExdkPM
	H3FdNBnUDC3Hd4ydd7BshXQnfXLKb9pc=
X-Gm-Gg: ASbGnct2NvY/wHJC+p0r29dzKaDP47emfodLX9kY7dV+hq6lKRGMvlwBY+nAr0ZENZ8
	eAvS9dGzm1HLnMH6eYx/FPtnomf8BV9duDNRCtszOIpgth8TgF2iLVhN6QY5WH+jSj40d98QQSS
	UDOab25B/vig+5TgSj6e/zUSy71dIA2AE7XOFRpKOttQ==
X-Google-Smtp-Source: AGHT+IEVCR1WMvM3afUQQdpkgEwNT/layEphYEP4BpPlVVAX1ILwyLzxTzaVNyYpYWWqkJpv4bOXdUlTAxh5HDuneEg=
X-Received: by 2002:a05:651c:4102:b0:32b:3879:ce7f with SMTP id
 38308e7fff4ca-32b98c930f3mr27887431fa.0.1750770547410; Tue, 24 Jun 2025
 06:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com>
In-Reply-To: <20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Jun 2025 09:08:55 -0400
X-Gm-Features: AX0GCFsnEVzK3jLMKk38EhmCn--TL0twQ8GF9ha-rPvBzbFkVy0rni9uTgaCe84
Message-ID: <CABBYNZK=5-N8wcHhSp5ii8FmM5CzPFqKheKHOcCs8brNhVp_ww@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez] shared/bap: Set stream to idle when I/O is disconnected
To: yang.li@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 24, 2025 at 2:04=E2=80=AFAM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> When the CIS link is disconnected, the ASE status transitions from Releas=
ing to
> Idle.
>
>   > HCI Event: Disconnect Complete (0x05) plen 4           #1484 [hci0] 6=
7.947425
>                 Status: Success (0x00)
>                 Handle: 512 Address: 5C:B1:E1:2F:01:B9 (Resolvable)
>                 Identity type: Random (0x01)
>                 Identity: E8:D5:2B:59:57:A6 (Static)
>                 Reason: Remote User Terminated Connection (0x13)
>   =3D bluetoothd: src/shared/bap.c:stream_io_disconnected() stream 0x..  =
 67.948018
>   =3D bluetoothd: src/shared/bap.c:bap_ucast_set_state() stream 0xdff..  =
 67.948145
>   =3D bluetoothd: src/shared/bap.c:stream_notify() stream 0xdffda8 st..  =
 67.948275
>   =3D bluetoothd: src/gatt-database.c:send_notification_to_device() G..  =
 67.948525
>   =3D bluetoothd: profiles/audio/bap.c:bap_state() stream 0xdffda8: r..  =
 67.948679
>   =3D bluetoothd: profiles/audio/transport.c:bap_state_changed() stre..  =
 67.948967
>   =3D bluetoothd: profiles/audio/transport.c:transport_update_playing..  =
 67.949061
>   =3D bluetoothd: profiles/audio/transport.c:media_transport_remove_o..  =
 67.949106
>   =3D bluetoothd: profiles/audio/transport.c:media_owner_free() Owner..  =
 67.949149
>   =3D bluetoothd: profiles/audio/transport.c:media_transport_suspend(..  =
 67.949375
>   =3D bluetoothd: profiles/audio/transport.c:transport_set_state() St..  =
 67.949423
>   =3D bluetoothd: src/shared/bap.c:bap_ucast_detach() stream 0xdffda8..  =
 67.949574
>   =3D bluetoothd: profiles/audio/media.c:pac_clear() endpoint 0xdd2d2..  =
 67.949710
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
>  src/shared/bap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index bccbc73ff..d51f3106e 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -6584,10 +6584,8 @@ static bool stream_io_disconnected(struct io *io, =
void *user_data)
>
>         DBG(stream->bap, "stream %p io disconnected", stream);
>
> -       if (stream->ep->state =3D=3D BT_ASCS_ASE_STATE_RELEASING)
> -               stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);

This is actually on purpose for unicast since that supports caching
the configuration, now perhaps this is not the case for broadcast
since the BIG may have been terminated so we probably need to check if
this is a broadcast stream or a unicast stream, or add a dedicated
callback for each type.

> +       stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
>
> -       bt_bap_stream_set_io(stream, -1);
>         return false;
>  }
>
>
> ---
> base-commit: ae1b7f6ba805f82742bbc32ff275e268248ef9f8
> change-id: 20250624-bap_for_big_sync_lost-63476c679dbb
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz
