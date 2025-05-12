Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A51A8F98
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058710; cv=none; b=E299UXUC0xgHETfal/w/iLiEMwIji+j+lDXYuk5OVqeZQbIVCxIBPe8SpORKdLZrWEEisqGgSYcVDcFRy9MqWVo3DurqiJh52WWsD2M6Uy8MoGWw+fMLBw0tReju1m8zvc8Hr37FXDFBiarYKC6uHWYuytJ/ugF5neErio3oLsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058710; c=relaxed/simple;
	bh=rCFeDgrP8bUZ4UiBReglZvvXzu7rP6vx8AHxnLwnrR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osViUPlOdU2P2E8ld02kbpQS2sNdFa51LKNDEcn6Ww023npM2+zrEEfNs3MlwVWl03GZ5LiRzkmFCptOyQtAjKmkjzgu0a6YVY+R5slPEVhmdXclfjoL2fJ7NusDrb5JUXH7lcEWzXURi85FTMQDnlSB6Ay6O2P4sFbiU+3Eimk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBRWEFC8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBRWEFC8"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54fcb8b889cso2968709e87.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747058707; x=1747663507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y45/zdz8fnyetdwuqMLVOtflHrNfsI9sva+iR7QPHHw=;
        b=GBRWEFC8aJQcxmARcN2ktCcN6FAhZebqj4TYgofbhS9dt1Wg+DDMPcWYINZPTmPEVm
         B6LUH7eTwYSv3z9vZ8BqxwS3QLHMa0rZRcYDD38TpIvSzUBGPj/D7uGtkZbK1oQ7Q3um
         pSwM3QlCv3n9Cq7iTQX7OfCWc66kOgNPOZ+5NL+jtlHciHbzZfLDOI21NV5KtGsNDJ5d
         /OXZqDw0fsnct1SraiIQJVwagZtJImGjNQjOECcEPGO0tQKhFPENBxA3ug4cCVvE0vH+
         ttppq+aaRlWp1H4yFDc5/lUooRrN4eqxrkmWAh4kOuapsjI2w5duqfj/M3wkS+E1GXh0
         51OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747058707; x=1747663507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y45/zdz8fnyetdwuqMLVOtflHrNfsI9sva+iR7QPHHw=;
        b=kHsngX0W9tj9lY3ucDy/4dq5puSLiMZibARYVxlaauW5/pIs+z/u0rMWL2FYzO8pvg
         hrorvYWGnDsEb42f/t9wmX/ByPZZGwP8XKPG2HJsNPXyFE13LfAoi/k6udpHwtPYb9F/
         F+XiYQOjExIkr2IELtfVcmFAtJCPT9bmq0dAnehxtK8n5KMj+qMG4Nl8rYck8UEILN2r
         fYexs8p1KKmeI69WVYIP5U80/Zx5Z1bN/zNv5gbJWS71APgFdXn2FXWmhn/hhvzHmm8Q
         X6zQ5QulBToVVwNWLulYLELuz3lL2LYION+gIvoQlsuppLey4oK9mfgX0oBqku74xF/K
         YRmQ==
X-Gm-Message-State: AOJu0Yy6rXYV3Gr02eZhKtljzDOo77Rj/sDu1SwHiqzIEmWqLdMq1qZX
	HnyyTg3HNSjxa6jrVsgsar4xYkq9UkkmQu3uTxy9gZ7RdJLxXKpTxGYBgIeeeMxyCcGZNag4jJW
	hRscjWdB0oKibONdMqMyaU6bgMNpwLhC2
X-Gm-Gg: ASbGncvxpfSqG2/DKDX52KZByD+A2C0cvJVTRW/Zcf1g54ZcbTxNzpjnduM+ha2r6QW
	OkOJW/a8Ip/yM5MaBtnhYAet0+2nW5INY5/r0HpPuha00hYYRLijzRuSCQXJJsrnzIt31yNccv2
	ZanE0+LvlfAUTfIflDha7FLid/FW15S4C5JnpHMzE82g==
X-Google-Smtp-Source: AGHT+IHQLdsjyf24vivuVYzHWb9nqnUhbg7Ymia1Z2HTfZEdpnH2T9LocDot2lopzofAfJ81KuGXndvNFRPenriFAIY=
X-Received: by 2002:a05:6512:2283:b0:54b:1055:f4b2 with SMTP id
 2adb3069b0e04-54fc6763856mr3990011e87.0.1747058706396; Mon, 12 May 2025
 07:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5681377.rdbgypaU67@n9w6sw14>
In-Reply-To: <5681377.rdbgypaU67@n9w6sw14>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 May 2025 10:04:54 -0400
X-Gm-Features: AX0GCFskSt8ZqcHqBGlidj9__kJloBRJECuagZqUcu0QFaa_cHTSL6znqdY7f04
Message-ID: <CABBYNZLruNnKJKCzYdF6803JsCxidQCu4OH9T-1wezP8NhS0Kg@mail.gmail.com>
Subject: Re: main.conf: GATT.ExchangeMTU
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Mon, May 12, 2025 at 6:04=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> Hi,
>
> for testing purposes, I tried to lower GATT's ExchangeMTU in main.conf:
>
> > # Exchange MTU size.
> > # Possible values: 23-517
> > # Defaults to 517
> > ExchangeMTU =3D 23
>
> Unfortunately, bluetoothd doesn't show my adapter anymore after this chan=
ge:
>
> > daemon.err bluetoothd[450]: /usr/src/debug/bluez5/5.82/src/gatt-databas=
e.c:btd_gatt_database_new() Failed to start listening: setsockopt(L2CAP_OPT=
IONS): Invalid argument (22)
> > daemon.err bluetoothd[450]: Failed to create GATT database for adapter
> > daemon.err bluetoothd[450]: Unable to register new adapter
>
> The first error message seems to come from btd_gatt_database_new() [1].
>
> ...
> bredr:
>         /* BR/EDR socket */
>         database->bredr_io =3D bt_io_listen(connect_cb, NULL, NULL, NULL,=
 &gerr,
>                                         BT_IO_OPT_SOURCE_BDADDR, addr,
>                                         BT_IO_OPT_PSM, BT_ATT_PSM,
>                                         BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_ME=
DIUM,
>                                         BT_IO_OPT_MTU, btd_opts.gatt_mtu,
>                                         BT_IO_OPT_INVALID);
>         if (database->bredr_io =3D=3D NULL) {
>                 error("Failed to start listening: %s", gerr->message);
>                 g_error_free(gerr);
>                 goto fail;
>         }
> ...
>
> Interestingly, the ExchangeMTU value from main.conf seems not to be used =
when
> creating the 'le_io' socket (isn't this the most important one?), so I gu=
ess
> that the error message is raised when creating the 'bredr_io' socket. The
> kernel has different allowed ranges for the MTU, depending on the L2CAP C=
ID
> value:
>
> static bool l2cap_valid_mtu(struct l2cap_chan *chan, u16 mtu)
> {
>         switch (chan->scid) {
>         case L2CAP_CID_ATT:
>                 if (mtu && mtu < L2CAP_LE_MIN_MTU)
>                         return false;
>                 break;
>
>         default:
>                 if (mtu && mtu < L2CAP_DEFAULT_MIN_MTU)
>                         return false;
>         }
>
>         return true;
> }
>
> As the 'bredr_io' (and the 'eatt_io') sockets are not created with the
> L2CAP_CID_ATT cid, the default branch is taken here which imposes a minim=
um
> MTU value of 48.

Yeah, you can't go with 23 for classic, perhaps we could split the
setting for setting it or something like it.

> Questions:
> 1. Is it correct that the value of ExchangeMTU isn't used for the LE sock=
et?

It is used, it is not used in the socket though since it is a fixed
CID the MTU is not configurable, thus you need to use ATT to exchange
the MTU.

> 2. Should the kernel allow MTU values such as 23 for all (GATT) sockets?

Don't think that is an option for BR/EDR.

> 3. Where/how should this be fixed (kernel / bluetoothd / main.conf)?

Well if you think you can do 23 for all sockets, you don't, but if you
want just LE perhaps you should disable classic then? Otherwise we
will need a different setting for ATT over Classic.

>
> regards,
> Christian
>
> [1] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-data=
base.c#n4103
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/net/bluetooth/l2cap_sock.c#n709
>
>
>
>


--=20
Luiz Augusto von Dentz
