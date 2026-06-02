Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8F1624C0
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410095; cv=pass; b=LQzOghbOFPbsbQHcj1ATh0/kZH162qbAjFWR3UJxxyNYSsUxEcA9UWCGkewcio+GZy55WmOiJzzST6SWVPkWSauSuPEfRBNOrrtfkVcbqQ1g3+0ja+bCdQuZt2k0pAqieQ49hs3aJblVTXPLkCSBdE431WwgUD2tiNFwYyK34LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410095; c=relaxed/simple;
	bh=HW/00tBUd6qs14BeZ315DIXYCZBRNZJHW9mRTj1YyIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSbmYNVMhUkagEnfVY08J9Q5j3d+rsGzjYJfSamcIMcza18ijlRDGJDgwICHIv2QMQw7Fa6ZlQXY0wkum29oQX6yZLM9T+D8Uj9UFE2ath1WFwkOGlVHsi29Hj1gYjdb7TE4kSC2r1x4gqIYX7FB7ino1+YVZq3ldpOuskXpNBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxSlEc2l; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxSlEc2l"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66043ecf6b3so5196669d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 07:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780410093; cv=none;
        d=google.com; s=arc-20240605;
        b=eSoU9Y39j7F1CG10aSi0PkiThFKW4hCuyYExr/rRw0GZ7iO1vXLVfIaZIT4gbBONf9
         VMQq+BjxOBrjYyUxHEDZvbIzyL6t7CN3IoKDfTPzi7YMK6/0XBYZp98icmAHzBZsvhrb
         FVPXO6FZp6fUNpJ2ziSasoH78LcW71RtVMD1Nv+TnsQvziCP7DII9855o4ZvVW+cztq0
         FG9B1e7qVSLyjLGclsZyCaIxUsgdYgh6do4Yj2nUMNvjsf2NjK1Mwt0giVGX/ctS42M9
         25h+Sd4x2iNPqp3QCh0LxrZ7jXYkOJA3YEyEwb9MR6Lj/22dmX5CcuC/jH4DIPTfUR/L
         +g8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DcoqbAD0uVLNISY5xAIedMKSLtK3D83wKiOGey0HFqI=;
        fh=2DqQXOfvJHXMo1igz8u9erxgiACEuYxcA4BdaZ6Gcbc=;
        b=EGu+C+gKM1DvMzv/A4TGQp9nVaijRElVo1L/gEGAluijWEarKq5RxnQ9oQ+zsJU9Mn
         jL06hK9WK6SoKscQ6Bv9kQhTZo4B6ReP1a31v2nqHIvl4GDcTTVZh0Re7aE/t3juJX37
         mxCyr0WClFwUZHIithS4EsRlGdesM1/WQ/JnYP4WxZJg3hPpoqwxXBZc8swsKXgc8HkL
         eA7NWXmmSC7xEitOoOfUN9ShK9a7zySY7tK26MgpO/Rv1taiwOLzUipfAMkCLHDWsNYC
         0mRSEoWyVTxJtIvSFlIF8HWwWWDZRBFJpVZmw6OV0zVXt5TYj/taW4+KZfYPnxBy2aHY
         NdYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780410093; x=1781014893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcoqbAD0uVLNISY5xAIedMKSLtK3D83wKiOGey0HFqI=;
        b=YxSlEc2lnowZQ0SsON+y7r+1ta5vZ6gTqCAG1IGtDvTR7UgaidNjeJnJvp4zaCYTeT
         y3UFSJLoa4KKx13gTMg2A4VjIBVe6mJTB3nXsqn3pZXJeZknHWkFFPhsnjK8R87rxgtL
         Kf8JtA+6PvZh6TVcQ8rsE11XBcZCHrquUAsbV1GalwUrWgiw5GsO3NgaHhZKFTY2f6OX
         bdceoU3yBBItN6PlA0S3jUx/KqcKLmUvzJuadV92ftTsvk049jYALPGkJPjZ5+x4V/XB
         yfzlZAaaRnlzCZwI1tuqYaQuZV1qODk5TY5Nhotxrw+XhI8QpIIRPLQ2kI815eIBNXJI
         dQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410093; x=1781014893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DcoqbAD0uVLNISY5xAIedMKSLtK3D83wKiOGey0HFqI=;
        b=Qoo5QrG7hP+5RXdbpJgsSf8kfr6SHgKeeoLNuFk/Pcy5cXQhhfPyavwzV/37CcGiOa
         MuLrAlIlWExAePa2bexNwhIx9N35POhgKCL4LuioQIoN+yi/7KsQl9G3uio3YAJ8kNpf
         hHm6qUUMyXXb3Zhi82VjDuiiheFsJyg+9/NXawvXX6xOpTlJIf10hFHbg+N5vCNux5DX
         pBNRvaAIa07M5SBhCUOMUVpf+CqZb4htlz9C3/4dTDQLsF5g0sNIx9UnsKzChfY6xXxa
         luBPMn3Q3xoyCV75GkIl3YejbIOpmIrCRfJRsNFmVT11Ww/U82oAWqE0kKSD1s3E9Umh
         +KPg==
X-Gm-Message-State: AOJu0YzxhU9vM2B4As1F34Ow2SJOG25cDc8Gs8Pt1MsFvJ+gc4eXauJw
	KwE+rhXZoFQfxi6MfhrRPI3f/sBSoF3TJrSEoDjiuRXetqYba0UhLG7tIUVjvKXchRaQrAnZhZp
	d6GoChiuQ2jWZO74VRA2uA/Q3gkWp0POmWEe9Pgw=
X-Gm-Gg: Acq92OGhWdKZFamMhBZNA1mQmKzHpAoLLLcvjDAqVIngynyxoSaQPMRVOHqL+5+8Eq1
	UjZGAxx3+l607hFmdm6HKbiybofHacAdBSlQN6VQE+wQfE1P8LWuIAgoRhcKY47cWuqs5rotWXI
	KFb7AQswTjwBE98PScD2BcjK6UyHcCDe2swAs8ad5Zu9pweZgC+A3s9gvQqHHbfjjsR//CunHeB
	OXs41Bx3m1O7o+WlFhG9+DMtaLszTuCS1/6XrhQF35Q93rzk7xkAiMI1xHwfzddfw/RWbuBbsjk
	gRnKydxbb8ury5vcGlk5yqQFfYzSh7FUxTWTJoprCkggi4mLBnnKP0zwKFlJKXMTLjhsCFOnKSW
	Teg==
X-Received: by 2002:a53:d14b:0:b0:654:5120:60aa with SMTP id
 956f58d0204a3-6605ffcfbfdmr10541096d50.45.1780410092989; Tue, 02 Jun 2026
 07:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522054015.431152-1-wei.deng@oss.qualcomm.com> <20260602031719.679979-1-wei.deng@oss.qualcomm.com>
In-Reply-To: <20260602031719.679979-1-wei.deng@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jun 2026 10:21:21 -0400
X-Gm-Features: AVHnY4IJAAw001GOuCJBU95FipRUIbpMOyryEqd6F1OS-wohHk9PK4BKeutvO2A
Message-ID: <CABBYNZ+vSQWjJyajPxoBs3endFOkU2JGOFoBKvePu8YvZSMEXQ@mail.gmail.com>
Subject: Re: [PATCH v2] profile: Set L2CAP IMTU for external profile listeners
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 1, 2026 at 11:18=E2=80=AFPM Wei Deng <wei.deng@oss.qualcomm.com=
> wrote:
>
> bt_io_listen() in ext_start_servers() creates the L2CAP listening
> socket for external profiles without an explicit IMTU. This causes
> the socket to use the L2CAP minimum of 672 bytes, which is advertised
> to the peer in L2CAP_CONFIGURATION_RSP.
>
> As a result, when acting as a server (receiver), the peer limits its
> outgoing PDU size to our advertised 672 bytes. This leads to small
> OBEX body chunks (~669 bytes) and severely degraded Rx throughput,
> while Tx throughput is unaffected since the peer's IMTU is not
> constrained by our setting.
>
> The obexd client side (obexd/client/bluetooth.c) already sets IMTU to
> BT_RX_MTU (32767) for outgoing connections. Mirror that on the server
> side by setting BT_IO_OPT_IMTU to BT_RX_MTU in ext_start_servers(),
> so incoming connections advertise the same maximum receive capability.
>
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
>  src/profile.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/profile.c b/src/profile.c
> index dfc5f7161..297959f3c 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -55,6 +55,8 @@
>  #define MAS_DEFAULT_CHANNEL    16
>  #define MNS_DEFAULT_CHANNEL    17
>
> +#define BT_RX_MTU              32767
> +
>  #define BTD_PROFILE_PSM_AUTO   -1
>  #define BTD_PROFILE_CHAN_AUTO  -1
>
> @@ -1411,6 +1413,7 @@ static uint32_t ext_start_servers(struct ext_profil=
e *ext,
>                                         BT_IO_OPT_MODE, ext->mode,
>                                         BT_IO_OPT_PSM, psm,
>                                         BT_IO_OPT_SEC_LEVEL, ext->sec_lev=
el,
> +                                       BT_IO_OPT_IMTU, BT_RX_MTU,

This is doing it for all service registered via ProfileManager which
is not going to fly, instead we probably need to add a MTU option so
the profile entity can pass it instead of getting the default.

>                                         BT_IO_OPT_INVALID);
>                 if (err !=3D NULL) {
>                         error("L2CAP server failed for %s: %s",
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
