Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41604CC27F
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448623; cv=pass; b=FK8PBayfCPYdKKbTwEaWGUeXRAGab7nS1UOBbYXzoj93fEfuJ2RiuuCmQd3fNf7i26ySqfkFcxYb+U+wRjvU7mYL13hoO9tp/n/4YnnG5mIVbhsAfvXPDp03gRHy0zNJZ319GYhiu4kiZjsfhj4AEjgfG2LpKGeWHkaHbR238og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448623; c=relaxed/simple;
	bh=3nO+ybbrISHzWCE/RSykvCpqbQJ6kWVwwUOLxAq6PRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDg1DhWqYXtHwdB3H8Lfb5CLe7VsVZD+0vCral0oGkArsevLu75ov7vaNZ2CB/mOdYHFzSlWOovdKFox0YD1G5O1WdmoHaMgONaHv2+0E/N4RjxLqvQMDzqMm6zJOl5P7ePY0Zn7r6Fa7GJCDxABlrHvusZBFk6iDLVe/rLFa1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4CA+vyA; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4CA+vyA"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-86162c086f8so17222167b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 08:17:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788448619; cv=none;
        d=google.com; s=arc-20260327;
        b=IH6NxKFrjl101JWS2CNatRASAuRw9aB0hgcytM0Ijlc9vy1z1JZLWveqsmd+aRAldI
         w9qhJJvg6WVXQLN3KugRBkqVQcq3sEStissNzYpNKNeR1Ib6cG+Ys6rC0IXPiaj20wAT
         yv//hGK5brIQPXZpl0oW6tXR7wd+ITXqI8AE6D98rOBViSkxNWM+CU6qy4wSCPgHThrj
         YBMWNmynwa9evHZMzmX2q9hC8LadPWDN9s/DmfAMofA7sgLvp2InViOT4p8zDj56D5wP
         78fRI31Tu9PMCarrSvA134nNLjzPyDuGSox57PnrfwNOtcnXorWr3+xKskIbI6+G1U+8
         fphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=REvth/bA33eH5i15g/1PkWYeT0j/pthj0cdPzhJU/B0=;
        fh=tw86IrMHBiuPusb5zWJgELyw94ZchURkxy4CWgF5gG4=;
        b=XESpOWsI7ZOYAfpcPlx4SGF96fLrkL2RPQVZ4dV389BDZmBXaVcZCS9vOK4RvWCvTl
         kzNmSUyX/azhA0zzsxIsZw6Oi8dpOGR3eD7T+Ui+YdG/oeZBRC5dAodll9Xw6v/6Jyh7
         r+Wdmv/VBHsasVpyXJKEm79hOxPZ4morneBlIJVCNASxF7ImmLgNGbwiMnsvQIFEHADx
         9fH/GukCSW8dHHRc866EdVbEM6y0YsqZAM22tLANdiuuXMuFyv6Y2ha4uY2B8qUKp3fG
         Q9nAKlQR5tl6IOSjj8z56sMUk1R2TqxyUcn84jm6+13ztnlSocgDLObt+5MdFvaTCub8
         qzIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448619; x=1789053419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=REvth/bA33eH5i15g/1PkWYeT0j/pthj0cdPzhJU/B0=;
        b=a4CA+vyAGGi80T9bVirYJlh2u7aeDOVvD7YpoHGNRaT2zSGRWS6iwtXjNgOG4Q04fr
         9zZ6qD8H2Jnchw40qdgrB/FC3gBMvXRw1pH5cJUZhAWObZU0FMPwVL/Uem44VJNdMr/7
         4V0ZhoaTS2hben68r07SB7NziEuJxRbWp2TyEOwDgs3VwyFduoKce9ivVyB5PF/CE9ta
         D5BDlXgE9PYvgMJFBBgb9abdXs+zVIFJvxmp+JWJbc7irmzl5zsY0+VKpwpz7U61Pzoi
         J13NVjAjY37RhyqX3nSMlNUj7KrrZVBwTG3C7UmfvbpRrIVjZFGD1YpJQcwfSkIDVNjH
         3uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448619; x=1789053419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REvth/bA33eH5i15g/1PkWYeT0j/pthj0cdPzhJU/B0=;
        b=YGMHveuwXZnXzCHl2w63GS4GT76TcdOrQJMu3nfBkpcF/MQNuzGgh+SsxuM5WUieD3
         JmBVhpsw5Paj1x/DyFGEJp6vtuY5KUmF3obZft9B/UVL1Sv6HsLCHFgvsSVFltf2PVXx
         wsfJMaEb8/K+TB0on5DiUqdbvuKHm5LMwSB6cUT+BV7ISiP0e7rMzEkVmyrVuiRB2gzl
         k6uZbkQ384c12Fu0HEB7OJ2eM7AojcHRAUB5bt/UQ77b1H5MYAnurPDViukwZR7JQVRa
         VdSIC54+5h6iP4YEA3G+CidBIEwgCJuQc9HoXpiEzsUQokrVOElp9R9KpNgoJlPqyZMX
         C1/A==
X-Forwarded-Encrypted: i=1; AKwUvBxMYJ0AF771ALem7xFJpDpLAhOzDxnPjHDQgf4gyoDmbXF1cQ0gphduJnjvdZpR+72+/7DR0xCZ7f4Xdvb5eq4=@vger.kernel.org
X-Gm-Message-State: AFuF++lkVSFwo9pFJbei8Si5dMwNmb4ul0FHwyD7TqPg+D49TtXALMpz
	OQDbI7tfNWwh2aHySOBblZ3Fwj+tSE/tapmHdnLxWy//WdHb51gMu6tBnJ5O02QOyrTG45GX7sg
	wCAgB1rxNXm5D1UAuJxLci3fxuj0zYvE=
X-Gm-Gg: AYBFou0I1jVm9ZDYuTyb4QHLjbtRP0xNam3uk0vkhl2Aszz3zV519kN7JHA5gywzkji
	QvHMKUXm8sQYr5R17T5KTsMp/o7kbnVFtVeBveItqRYwbGykXAI/FxfFdGv8gRDPDjaH9+lHRo2
	BUuq/t2qlG+H9qcu5WfDrzQuLoUD/Gd815npdizf20uw/m8/BXnIdD/3Gh1l89m4X6xdaPJo9jm
	brWYXmJOhJrLQBz9+JzefRtVxbVEYWnx8oJpNtnzbYA305DLdqstDTb1D6jJWdSUhGdKM2vwa84
	PlW9KC7XeDX/2Pn8UWYP0Moqfl4xWH8ROoaSFYVpYzvh8axmExe/LN4W2KYjjtQWq+Tg4YSIH9O
	v3clL9Ay13se1D5M1rDGFUDgGPj2sZOg=
X-Received: by 2002:a05:690c:dc9:b0:7ef:9fd9:db07 with SMTP id
 00721157ae682-86e6fc68c34mr35588107b3.12.1788448619242; Thu, 03 Sep 2026
 08:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com> <20260903-vendor_hci-v3-3-015d62a57c91@oss.qualcomm.com>
In-Reply-To: <20260903-vendor_hci-v3-3-015d62a57c91@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Sep 2026 11:16:47 -0400
X-Gm-Features: AcwNN1XsAEB8Wh4URhk1xImIPD5ruvxRdIZQ2leJ_KFm59hMlg7ME_SltA7IF48
Message-ID: <CABBYNZ+1PqFXSqAPNC3krSaTccv4VT7ERNRWkO-pCg3k+qCH9A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 3/4] doc/hci-protocol: Add BT_RECV_VENDOR_PKT
 socket option for HCI_CHANNEL_USER
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Thu, Sep 3, 2026 at 10:47=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> BT_RECV_VENDOR_PKT controls receiving vendor packets over HCI_CHANNEL_USE=
R.
>
> Disabled by default to avoid regressions for existing applications.
> ---
>  doc/hci-protocol.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/doc/hci-protocol.rst b/doc/hci-protocol.rst
> index db10b35df736..53734a0037a9 100644
> --- a/doc/hci-protocol.rst
> +++ b/doc/hci-protocol.rst
> @@ -131,16 +131,34 @@ Example:
>
>      uint16_t mtu;
>      socklen_t len;
>      int err;
>
>      len =3D sizeof(mtu);
>      err =3D getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, &mtu, &len);
>
> +BT_RECV_VENDOR_PKT (since Linux 7.3)
> +------------------------------------
> +
> +Control receiving vendor packets, requires hci_channel to be set to
> +HCI_CHANNEL_USER.
> +
> +Default is disabled.
> +
> +Example:
> +
> +.. code-block::
> +
> +    uint32_t enable =3D 1;
> +    int err;
> +
> +    err =3D setsockopt(fd, SOL_BLUETOOTH, BT_RECV_VENDOR_PKT, &enable,
> +                     sizeof(enable));

I don't think we ever applied this socket option to the kernel,
though. Anyway, I think we are better off adding another channel,
e.g., HCI_CHANNEL_VENDOR which can then allow packet type rather than
just the known ones.

>  RESOURCES
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  http://www.bluez.org
>
>  REPORTING BUGS
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
