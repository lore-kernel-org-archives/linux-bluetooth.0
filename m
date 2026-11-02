Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793640324;
	b=pD6THmvYboPuypM3sNDEcMiYRp+Ndcxi5i7QcRUP351j7OzhrNy65gFDKAXLmokaOSak
	 shrlzC1no1VAko//EzvBPHriJ1p7dr3bXN9fquONABe0U8BB873Y4AUnR7hFDqr/zkYWT
	 F7ZUQtmPGIDr0sIUcFr9+FcHMFbLcbNy91Eee9VRCSXf7uLmBXVCvcc3V4ltAH7Ylkl5p
	 DzwXJgjghuKA7qrEE4mvM4iqYCKmNvuhkd2JVJkKrWgcm8QRvro+OgZmX9fhhKsFzLdJW
	 CpyMgChr6Wcd2YCCLhfZzrkMhLtHacQQpm63RtYW/aNBpviuFNGIYXDLK7wzyeOaoZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fgYIVopVoDWfARhrYsF8sqmL6eDPeBwFthOsJmxG8Xc=;
	b=aLkV8sKlADvQn++Ik/Ffg82tVTFPrcwIa8hxWzbU7G62y5s5qP7L66CAw/6XrRpby+fT
	 HSPJ6TuKHVzPWqLIiG4kowGRPLzw9n0gYcycaNmdtIHJj9ELB9hJR7lA3iZ9uy51wlXmq
	 Ss/Uiox/mwFvgFoYP3FcuTD+8aIWzpaPgKXKOVJxMNOZNEzRLzH1VjFbbuTJcRa53LLFh
	 htQPuRqjveJJhIBGgPveRaQSeI/pphT+WsLUkrG/me808HqqL/RoaVW1J/FzVirmUX5+o
	 S997Z1y9TnLn0HzkI6rO/swcfAg/bHy4IfIpiZzF8p5HRUw5BSuLIWuN3K2Xb1Jsktw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hz0dSh0Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ACF606A324
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 17:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3ACF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hz0dSh0Y
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8ac8a2ac52bso37123207b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 09:25:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793640323; cv=none;
        d=google.com; s=arc-20260327;
        b=itE6RstgStwSpOxwzQ0IqyFlvHEGg1uxMIO+Wh5sSi8kDG1zB2S5Py+zNdyL2hvL7M
         h7Z2moqSiu3hWieRN8E/1zBSwC4jBHKFgqWvgCbGa4nboB9BMBeomL49+XYkqLTxMrr8
         TvduFHbYoQzcsN+DUOltlfQhYaO44XsB3fTvKENK8EqtHupAQRwaRgyrOWVRKvY4M92R
         zmGmUF708GfT4oqZZWO0oj3cAoquUfsyWEtlenAL7lwDUokfEgENqV0EL9n4t1oiff1h
         k14EuYFQbqbdilYHwd5mjJ3QQ+14Lwh6nMU/zC7RZUWhtFhukwcAK+ovBcIV3FHd2gmZ
         7Oxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fgYIVopVoDWfARhrYsF8sqmL6eDPeBwFthOsJmxG8Xc=;
        fh=TFaWlzGSUVOsNON7fqumDaBo1sfr95PNGk3P+8peO38=;
        b=RRtSHDh6pT62nYQ15qjcJa5X8cL32quPwa8zZvnlkDeR393eDMc3N8zryuErFEApQ9
         f4WHSelIhkmGiyhITGWzjqod16xU7AyZGJ3wCItcgF8/GR311reepNc7r1LtArbKrfBF
         xXO3aOuRQdsG945YWJsyV/MDayzLSNfCg5T64QGUYkNtUp1S9Lkud8TCGc3OrD2xMWoU
         CtNhOyP3SLp4DPhl0KFOPyLhmiTij5cquLnAz+aq6Af3SJg8L0+t4QcpC8SqRPIJCgSa
         1QcXjU7vWxEviBt+UicmS5o5oZQU2SmSkmEdiF1VJBLNe2rlVS93LCOFNMbrILAToFEl
         aUCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793640323; x=1794245123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fgYIVopVoDWfARhrYsF8sqmL6eDPeBwFthOsJmxG8Xc=;
        b=hz0dSh0YXS29gz3fjNnfzrv6ocoO54lPhzCyj4NEZbZ4IYQrWmk5PBXOtUvHrhHZGe
         SiTYHyCh6E5LUPDnO56nOMlj3RWbeac9Xdo9altwNo3+WJf+n++Wx7m8P0EY/4noorsR
         Qk7KWypgh8tNzWvMx3FBRJReSNs9lSq5OESJ01zwzwiTAQgIWfk0IfJsrL4kp/IHCb6M
         4QDh5JEBI5MgQ6Wm5SBSHBm2ZYVZewvxBS4A2DYqj7lovsJK6f4fHAFMC7gfLsYXY4B2
         TWIBjtV701u6dZgDzGio1+XTCm5DryhveSy1ULRQKnLgxYl6N/BhxLrqWhFdMUc4/Uqs
         lgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640323; x=1794245123;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgYIVopVoDWfARhrYsF8sqmL6eDPeBwFthOsJmxG8Xc=;
        b=CmCQ2Wt4utJdnbpwWKpfjLPP1m4NXzNzchZGTOGlN/pDxRSHRvCXBOSmQoEVc8oiYl
         V1RMO6pGG8B0dDTESIBed1hu2fkGVRO8m/9+IutZyFAKKLxRDfLQ2HERV6VYzhO3eILc
         I1rCTXu/IcXVCh8gHVLu1pQZjQR5Lc/KLapyImxP7QCNeb/jwHtJh811nsC3XqjzR8Ya
         14hmIlmUt2ekzUUgP/NQsMbt2+B/9gYRKqj5LhJ11468rJhNAem9jfsOq8zGNda+cCkI
         mTKqu/nWmc1ocS1yrQ6JiQknxjgcwRhxTH66J4x2LskMKiwG/CPUMhk7NXGhUvU8oqt3
         8qWg==
X-Forwarded-Encrypted: i=1; AKwUvBxCQMxUquAIV3/XOtxBA9dl1SrmhA03EwXcECl5em4CutOYF8XvAEXfwcfFIfy+00wDAxaLeJ3Az8HBD8j7TKo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Aa8rtnn6pzGI3wzYK+qccq/cQmXUluir/Cw3ih0Ka8JOOpcgd
	Np/oaPbp0iCHZUgNXWINkDeLRzSUt8tXmZKA2xKasRDi3f23XL1JBntDoxgvniBX3MQ3rhTqc0g
	rX4d3aPOF37r1vhKjggM0MpMdXlO4MHs=
X-Gm-Gg: AYBFou3tsydZfS5JiJewo4hWADCBTvvc0fmLDnjlli5y45gOT7OdIgdwPXVnSSQlgze
	wDIGkOhnZUwbLTnPiOtm6foi30nPXMGWmfzg0/2jtG94uPB9qDxJ7eE3r3u4PM0LKMQoIJshmIy
	gY4DKcK5OZFkYC9327IvP0dkxt9lYJNzUmbHvuo8vJz4c3pYavC189stey95mmeqSJ9lSk3dgVB
	dQGshQ4YPZPNwrmmlL5oPpmMLsRGO+s3V524pkWoEoCQ/1kqitMTETYu1xpr4JuFMjvDoOuxHtB
	QUPhiIf153u9MhQUbME0zxR3r8jL5SSr3w1h2tG5YpYyy5rw+kHRTStbZ3xa6cIHUxDud24WPYK
	2KZa4rHeRj71FZD55VwXiKN8GycPyz9K38uBW8AjNlRa2i+ul1W8eUpF8qOz7HhX7hRZfkQsxVC
	N5cfIEYaOsM9DqOT8R4l9rBpMM4LiO4MUvuUspQUf4IqloQc1rhw45uJLd
X-Received: by 2002:a05:690c:92:b0:8a9:8744:c07d with SMTP id
 00721157ae682-8b1c67060e0mr106029887b3.18.1793640322970; Mon, 02 Nov 2026
 09:25:22 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031-barrot-le-fixes-v1-v1-0-30e2089882bf@tambosi.tn.it>
In-Reply-To: <20261031-barrot-le-fixes-v1-v1-0-30e2089882bf@tambosi.tn.it>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Nov 2026 12:25:11 -0500
X-Gm-Features: AclHuK8nE9B_f9SaJxGhyAkwZuEIJ22S6BgPT7xi2WKDP1ZDobosJHyTsAeFWWM
Message-ID: <CABBYNZJ+BP3u-gb7GzBud67CEsJr-ShPSjf=L0Rmg5qFnREVEg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Bluetooth: Fix LE on Barrot 33fa:0010 controllers
To: ernesto.salvetti@tambosi.tn.it
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ernesto,

On Sat, Oct 31, 2026 at 8:16=E2=80=AFAM Ernesto Salvetti via B4 Relay
<devnull+ernesto.salvetti.tambosi.tn.it@kernel.org> wrote:
>
> The UGREEN Bluetooth 5.4 USB dongle (33fa:0010, Barrot chip, bound to
> btusb via BTUSB_BARROT) works for BR/EDR, but LE is unusable: as soon as
> a scan is started the controller hangs on LE Set Extended Scan
> Parameters and btusb resets it in a loop. Once that is avoided, two more
> problems show up before an LE device can be used. This series fixes
> them one at a time:
>
> 1/3 Setting HCI_QUIRK_BROKEN_EXT_SCAN alone is not enough on a
>     controller that enforces the spec rule that legacy and extended
>     LE commands must not be mixed: the stack still uses extended
>     advertising (LE Read Number of Supported Advertising Sets is sent
>     during init), after which the legacy scan commands are rejected
>     with Command Disallowed. Don't use extended advertising when
>     extended scanning is marked broken. This also affects the other
>     users of the quirk (hci_bcm4377, Actions ATS2851 and Realtek
>     0bda:a728 in btusb), which will fall back to legacy advertising;
>     I could not test those.
>
> 2/3 The controller answers LE Read Remote Used Features with
>     Controller Busy right after connecting, and the stack drops the
>     link. Continue without the remote features instead.
>
> 3/3 Set HCI_QUIRK_BROKEN_EXT_SCAN and HCI_QUIRK_BROKEN_EXT_CREATE_CONN
>     for BTUSB_BARROT devices.
>
> Testing: on bluetooth-next each patch builds (clang, W=3D1) without new
> warnings. The runtime tests were done on v7.2.11 (PikaOS kernel) with
> the series backported; patch 2 needed a context adjustment there, since
> hci_cs_le_read_remote_features() in v7.2.11 lacks the
> HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE handling. With a 33fa:0010
> (bcdDevice 88.91) and an Xbox Wireless Controller, checked with btmon:
>
>  - without patch 1: Command Disallowed on every LE Set Scan Parameters
>  - with the full series: scanning works, LE Secure Connections pairing
>    from scratch succeeds, reconnecting with the stored LTK works, and
>    the controller shows up as HID gamepad (hid-microsoft).
>
> Before that I used an earlier btusb-only workaround with the same
> effect for an afternoon of gaming without problems.
>
> 33fa:0012 shares the BTUSB_BARROT flag but I don't have one to test.
>
> Tool use: the investigation and the patches were done with the help of
> an AI coding assistant (Claude, Anthropic) in an interactive session.
> It analysed the btmon/dmesg logs, read the relevant core code, proposed
> and wrote the changes and the changelogs, and ran checkpatch. I ran all
> hardware tests, reviewed the changes and take responsibility for them.
> The patches carry an Assisted-by tag accordingly.
>
> ---
> Ernesto Salvetti (3):
>       Bluetooth: hci_core: Don't use extended advertising with broken ext=
 scan
>       Bluetooth: hci_event: Don't drop LE link on busy remote features re=
ad
>       Bluetooth: btusb: Disable broken LE extended scan on Barrot control=
lers
>
>  drivers/bluetooth/btusb_main.c   |  6 ++++++
>  include/net/bluetooth/hci.h      |  5 ++++-
>  include/net/bluetooth/hci_core.h | 11 +++++++++--
>  net/bluetooth/hci_event.c        | 11 +++++++++++
>  4 files changed, 30 insertions(+), 3 deletions(-)
> ---
> base-commit: 42b8c2d729268a65a2d98064e8dc59ff53646b14
> change-id: 20261031-barrot-le-fixes-v1-95624ffd0a43
>
> Best regards,
> --
> Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>

netdev sashiko found a couple of problems:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261031-barrot-le-fixe=
s-v1-v1-0-30e2089882bf%40tambosi.tn.it


--=20
Luiz Augusto von Dentz
