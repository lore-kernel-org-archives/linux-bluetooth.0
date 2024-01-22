Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5495F4D100
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948084; cv=none; b=a9g68pEzdALcZwnFioHOEMHo1ibFN4jDowFn1RICTUbGB6ddbSdRUF9SCl4PMQBIkOD8+twYRyVpLT0US0+onrpi4p6/3eJrkjR9//kP75gIayzJ96w2FjwiwFlCxNlTprBIbhnRIpSGRkB3mNOExiybaL3odt5vCUvh1Fukn+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948084; c=relaxed/simple;
	bh=dQiMwhl+idwmMWmIqdzjqVhMNczlI1duAUZ6+6zL6pQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avPPIA5gVqanLh4aaRINIbPQPJSuQ4n0W26hOT63TGUR53kacRJ+AGbXrnX8KiEg3KmyPIqrD+FC8lVTCOICj7vAheiH74qpYWdbK6zx1LaybxvDeE/JoASTDu2FshDY1pterVwjTi0dv2zdM24k8meO9vkeKjN1kIwagcBYJys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rm/egwQX; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm/egwQX"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cddf596321so36573911fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 10:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705948080; x=1706552880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsmdGPbk5hVPNZGgiNPviYhBh/lVBr6yp4EloryPXQM=;
        b=Rm/egwQXxkLmppZIU9nCfAp/YTf1x7fDbThFq6V2QVXx8vxXOMxkv81j/R8+s38UGj
         WDorfT6MAPtMrkp6bFCm6vdEVPTsNdfhmcjLzVvMmHg7p7mZQnjI5yFN2Bx8Tku5ZZuO
         VcISE/hTxNQ5/ILFcMImUUnIhQscRwslOBseSR3Y21ow2e4WZWPBl+SvKXMv/8+p5Zv0
         lh72xyXLXqwEhI7/pRB7+QnoGPEw39y80QAdBIpLYIREaX/ZQmgFbhOyICXaHgTj87BV
         i99STfkOD8Gc5YDwWmhf88sG4UnUFYUYe4sPaooQOMoOSmhCb8xAGAAlJJ8g51OTXRBt
         U3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705948080; x=1706552880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsmdGPbk5hVPNZGgiNPviYhBh/lVBr6yp4EloryPXQM=;
        b=o/RDNGc4zZ9xYQ4h78U1CTYKIhKRon/5O2f7kR3DEXEnYbf+ON3bZk56w9/LVaksXQ
         6eBwX+HwdShEPNxvAzgIqYr2PsXPKdKFueZ5BbSVmz/tdXyhBeCVw8Q5X3zDCk4B/8Mi
         DsbTgX+6RFOgwbqx876grrsFusj4TClkSORX5ICTHL80F+GCYs5HqnN7bGVbXlxh0D4L
         ngNRQn0M+QaF3MCUuKXKWd83wzU6n9n82lWlgbuKz4ovapNNqG9xJYCKhZttTRsSuIS7
         lvEQa/lSAOSRp6Wyhw13EAwBZHfLFoCeu8TLhdrw2Wosr0nwiYZ0ziuQOLW6fVdkJGdX
         cZNA==
X-Gm-Message-State: AOJu0Yz/gIncF82S/4qsDHQPEnQuanEES0EoHScIJrXdhM6cfKmD2a+7
	arCGqJx817R1+Y89xBCT9cZF3PAUgAXgnxYOQa/YcaM8DCW04XuV5MKkkBFllVvvWhXg535NyhA
	akz4+9myMeroETFMaMHkdpawZOJ+e1CAx6X0=
X-Google-Smtp-Source: AGHT+IFk1QT2BO8Dp/2tKr+pK9hbJDjDvi9xn0UxH0W9UdQndTaTGB0Pin4VWZPSpF7uNMMxqS7L/4R8rKdJbXFPJIo=
X-Received: by 2002:a2e:7a05:0:b0:2cd:8e9f:9b91 with SMTP id
 v5-20020a2e7a05000000b002cd8e9f9b91mr1929098ljc.83.1705948080087; Mon, 22 Jan
 2024 10:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121100328.1200839-1-mk@lab.zgora.pl>
In-Reply-To: <20240121100328.1200839-1-mk@lab.zgora.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jan 2024 13:27:46 -0500
Message-ID: <CABBYNZKW8odyLb_BQcXXpjAKjPzHRhXVCbxvcg54VkoeULeHnw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] btmon-logger: Fix stack corruption
To: =?UTF-8?Q?Mariusz_Koz=C5=82owski?= <mk@lab.zgora.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mariusz,

On Sun, Jan 21, 2024 at 5:04=E2=80=AFAM Mariusz Koz=C5=82owski <mk@lab.zgor=
a.pl> wrote:
>
> Version 3 capability masks are 64 bits in size.
> ---
>  tools/btmon-logger.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c
> index a770ad575..1f6db3751 100644
> --- a/tools/btmon-logger.c
> +++ b/tools/btmon-logger.c
> @@ -161,14 +161,14 @@ extern int capset(struct __user_cap_header_struct *=
header,
>  static void drop_capabilities(void)
>  {
>         struct __user_cap_header_struct header;
> -       struct __user_cap_data_struct cap;
> +       struct __user_cap_data_struct cap[_LINUX_CAPABILITY_U32S_3];

Ok, but this doesn't change the field, it makes it an array, or are
you talking about the following note:

Note that 64-bit capabilities use datap[0] and datap[1], whereas
32-bit capabilities use only datap[0].

In that case Ive just pointed out to this note to explain why this is neede=
d.

>         unsigned int mask;
>         int err;
>
>         header.version =3D _LINUX_CAPABILITY_VERSION_3;
>         header.pid =3D 0;
>
> -       err =3D capget(&header, &cap);
> +       err =3D capget(&header, cap);
>         if (err) {
>                 perror("Unable to get current capabilities");
>                 return;
> @@ -177,11 +177,11 @@ static void drop_capabilities(void)
>         /* not needed anymore since monitor socket is already open */
>         mask =3D ~CAP_TO_MASK(CAP_NET_RAW);
>
> -       cap.effective &=3D mask;
> -       cap.permitted &=3D mask;
> -       cap.inheritable &=3D mask;
> +       cap[0].effective &=3D mask;
> +       cap[0].permitted &=3D mask;
> +       cap[0].inheritable &=3D mask;
>
> -       err =3D capset(&header, &cap);
> +       err =3D capset(&header, cap);
>         if (err)
>                 perror("Failed to set capabilities");
>  }
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
