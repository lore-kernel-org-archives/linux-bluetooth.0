Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592644;
	b=csSEpSzElUwty00qqbLVImNTFyvav6/NLb3HEp5j9WxkUBGlCeQ2a6Nuoq5yVeQPnHWv
	 NBRVE/LRWMcFJL13aamRFpamFD+otUwM8MMcnQtnRqiQNJX62ksYdbRQFC5DrU21hPhRJ
	 BEEhPONN7IzqSXRXdaWf7LtlYbualsnVEpJlclJjddgXMjwgMcMW/pBf6loF7vi+6Cais
	 8TI5JhhQu1Qum5CvuMaUqlGBQfWKUpWMxZyzvW88tb0G5CScWQMQaNoX0fhFw3qDsr+lN
	 rRr92y8Ohiaf3+BhV+y4axWXzPbX6QRifWOEwvjcvXtrBu5FaRXQ2t5VQE97Sf4Xm6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CH6oHG3/Qp34ti4yckIWOW65CjO9OEZZdj56Vscx/3g=;
	b=dhFy22SsioFMv7E7snTrAzJV66UnLz3kcz1hLyftqZCRN6JS1Om2APO76VaNQCC8QFEh
	 70EZhDkiXFteUTWYuiDjhzMpuwgyrCI0RLItYhMr7b2eaJfLB6V0H49KDRpW3BGRdoacF
	 iNCpEp32apTX1ODmUjaEy2wRsnkUoM1c6JWpuu9U75j9sKNy0I6AWq9Tn2Y8QDUL8/+OK
	 xrOPBwpW83jwSGlLoZw68eJhvu3SkkmKEo3qFFKhjutuwDGPI9sxbVcTy0xNqZ2Pf/WUP
	 5v/qJdv/t/pypYxrwky3D+rKOmqK8WNgtba37Gh5v1eUhuxRncG99wzIK3TDpOpMBoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mVeuAnoF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751D4606A322
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 14:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 751D4606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mVeuAnoF
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b06c0794cfso8797467b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 07:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792592643; cv=none;
        d=google.com; s=arc-20260327;
        b=sT2jU5JCoEHw2ShlWsTaPMNOjtbB9Y3Jdziky1GXaQvrXU/AkA7EJ23YFFf6V3t8X/
         n4RrQcwSmY9xcZHsb2Rjrnit5qGG2Yhkt+V6FT/A1wmnsLUVQg2RLJiOPSdykEjGkIMK
         ZMTw/APanZMDEJ+OvK4g/aQx0/p0kMmDR0X/o9tm5cIezKiKz7dpqjDwBinkC6wJV4wL
         wPtw1jSWpzbsH3MfZxLwkR/i4e4ammPUz+np+nTcQ9rDtR0kPRH2gfoHUPg403KCiboP
         DEVQcLk3xZhgtVA4zaps/yItVthPtGsmHI8F34qqUhYRxoPcAQeDdoetiN4uDBRsUFp5
         YNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CH6oHG3/Qp34ti4yckIWOW65CjO9OEZZdj56Vscx/3g=;
        fh=nME6GmyW47RgWuYz61WS7XJ39VQi0sX210I1L4RCMlM=;
        b=TyWy7AqBFFnGLiwq1/HpIXAou8viVz8K+eZIr4COoEGnwMH1jTOBSMeQc3NbcfntPm
         8RKt7ab7Hn9MPff0rBm2GkPqIqrskax2aTbScg6ItEk/SDlHO6251UWYB8n1Ds33gN+r
         zseuH9LHHcMGT1DnYkGVNRLdN2Fp0Hf0gl0GWKp7uuA4gxyaD/tHwYgkgOjwYwJadbPn
         NvYdAfcNQnLqlJET/daKaiVtp/JoeSPicOkWcUKMfiRue6GlExS3XaKyJvmCBE3V6KdL
         tPNslPfILAqFlro+d2EXUFpHEIDXh4lij0d0bEGhiHz+r04XfRZ8/2Rg1okMir/NDOUY
         +AoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592643; x=1793197443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CH6oHG3/Qp34ti4yckIWOW65CjO9OEZZdj56Vscx/3g=;
        b=mVeuAnoFaOFhfQvLiTtQZZmds+N4yQc3zn1YhqdWZun1Ga2c060+QgCj5oa3Vpievy
         W8h5lVHAmxwkk0w0uAndhgGUG1iTbAaNoHea7bm3PH3xe7Ck0crjFjM5EHNcYHzVn/x+
         oqrKnkuYtOGcMXYMJLW5DRotaFfiSySwwMm1eSgHxzMLXGzQmIYEk3lXuYl6YuuK2b4G
         /FESwOM1mLoiV0BgPtBDNktm8XVaDhb8GSNrJpnUWpVymDUzus5YThDdL7k+Fez3bDkA
         LuCVCtCXN09raHfO8/VVqyW9wSGP0iWa+kxocdr265hovuU+Dwa0MVEXTu160uYy6Euf
         XrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592643; x=1793197443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CH6oHG3/Qp34ti4yckIWOW65CjO9OEZZdj56Vscx/3g=;
        b=nn34DQG6YKNHseUm4idRZzuNTt9c+Nv96p7f2zEP6hythqoRZeSsc5zAzeWCP8Jj7S
         vcSw+6YS5oAYHMljzxFarX6RhPZvcrd5pDFvsg4eB2QzkIJGNkz/S97lwHERj4WL5Pcp
         z/MfbWVLV9dGewIRwbmJolsz2l2ewkcLLCqlomo+Jh3WDs9xIeemE6xv/w5Zh2VB6HvP
         iRHy6dW1vs4FtcVxZS800+JDhnMgHC/NHYJgsUqF5slgFmSK9ZbslPVBa5yMLznqe4en
         0UnJNM2Zygso7n7z5rinO04bDeoYjNl2A4dj/OyGKMXfXrLR3zLx+qZfRi/GL7fHsPAC
         hg3g==
X-Forwarded-Encrypted: i=1; AKwUvBylCCsZkAzkCbDvWWegux+Cl6ZK28cWnycT527Tz+kOCB7qWOXcus6RZCqCB7vSc8+guYWwCbYFAupjDjLcTY8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVU+nMUJnLG6p65pTMXGPKbn0SZCtC08ZlNNklPVqJBIbEjZXl
	QRm+PWGqKaRdIOsgh2nKDuIq8H7qeIREiCylYmkVRW9O00OEF3P8B6wqRUym5GEOUjr1DdcNPFz
	O+d3WHEqmN2IyBUHZy2Bqrl544f39DHk=
X-Gm-Gg: AYBFou1G8iZ5Xvblzgg3vrybzipUVqQiQHcujMEcG0+kWDM4qkh68DxstUGTe5WL8su
	XvMS9IYCPo86hapo1ozzJdaKrjNbm9Czzpu15uyZ8BlwCDFoCfnu0qEm42pQe+AoSJShsbK3IIX
	4e/o540xWgUz0w8csctf3K1ffL9Y90ewHpyPrv8gVVpOCInu+EMTXDWrTFKaGiUd7/4JTJ+20ak
	Ue0llhC8KzDsNxRZq94Xxpue35W2JuCh8rV7t18Qd2O5RyTW3+4YvFGc26C8cBpfjFKvQnSYrZO
	scvsgKcHTMme/3Ki1gLaBQpwdq7YO1HMqnhC9bxCm/tP3WMQm4/+t55IlNalzqgjDkB47w401U5
	AujVEqwjanLbJ8s/1/FMS98eAn13rwt9AyyBWrqOqKnBWlKREhCbpAp5GMijW4KAFF4fh0AFBEF
	h8OTJ9TSjWS9EQYygHey2i
X-Received: by 2002:a05:690c:e146:b0:8b0:aba3:a3e2 with SMTP id
 00721157ae682-8b133d39371mr7017367b3.37.1792592643275; Wed, 21 Oct 2026
 07:24:03 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021084337.1515468-1-chris.lu@mediatek.com>
In-Reply-To: <20261021084337.1515468-1-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 Oct 2026 10:23:51 -0400
X-Gm-Features: AclHuK8FmV1TdL0_oevKDcXRfpa4yUifRgu3gHeeFUqDijVRdFDfONErTdM1fR0
Message-ID: <CABBYNZKqAa+3V1k3U-NBodfAhYRV3ZqX4V7bp5NFrXY0ndgL7Q@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 0/3] Bluetooth: btmtk: fix ISO data reception
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Hao Qin <hao.qin@mediatek.com>, Wenlong Tian <ot_wenlong.tian@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>, 
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Wed, Oct 21, 2026 at 4:43=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wr=
ote:
>
> Resend due to rebase: the base this series was previously posted against
> no longer exists in bluetooth-next's history, which is why it failed to
> apply. Rebased onto current bluetooth-next; no content changes from v3.
>
> Two fixes for btmtk_recv_isopkt(), found while debugging LE Audio on
> MT7925, plus an update to the ISO data transmission setting. The function
> is shared by every MediaTek USB controller that supports ISO data, so non=
e
> of this is specific to that part.
>
> Patch 1 drops the zero padding that the ISO interrupt IN endpoint appends
> to each transfer instead of parsing it as ISO packets.
>
> Patch 2 bounds Data_Total_Length by hdev->iso_mtu.
>
> Patch 3 updates the mt79xx ISO data transmission setting.
>
> The three hunks do not overlap, so any prefix of the series applies on it=
s
> own.
>
> Changes in v3 RESEND:
> - Resend due to rebase. No content changes.
>
> Changes in v3:
> - Patch 1: instead of dropping a packet solely because Data_Total_Length
>   is zero, also confirm that the rest of the transfer is zero-filled
>   before treating it as padding.
> - Patch 2, 3: unchanged.
>
> Changes in v2:
> - Patch 2 reworked and retitled.
> - Patch 3 added.
>
> Based on bluetooth-next.
>
> Chris Lu (3):
>   Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
>   Bluetooth: btmtk: bound the ISO payload length by the controller's MTU
>   Bluetooth: btmtk: derive the firmware ISO setting from
>     MTK_ISO_THRESHOLD
>
>  drivers/bluetooth/btmtk.c | 44 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 5 deletions(-)
>
> --
> 2.45.2
>

Sashiko is still flagging a problem:

https://sashiko.dev/#/patchset/20261021084337.1515468-1-chris.lu%40mediatek=
.com

--=20
Luiz Augusto von Dentz
