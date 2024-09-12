Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F11BF817
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153925; cv=none; b=F2PvOCUH31AbT5FEt2K2CNkFTLVk1LGF9VtpWTDV4sRoZEDJEECQ6iPLf4Lh817ZjPlieMRtT7skEZEymWFYmyXm0vFmfi8KLS6J8fk4l2mzY4pK+qXeE8ZoxWdEAx+B0d9yNv9/SvGF0UjdWfwBP5Vp0u8H0Vu5+12d7pDgsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153925; c=relaxed/simple;
	bh=aFghCCLvkvP35AC+Q1bAsTqvzVClZi4Z/xnc/IDwZWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHBCeeHzvyoGPscCfgrrisp/spkGAoM61QYPss+4uW3Y3WEpYisIDNI9GJd51LkF2atD2T9KR2Ro5q/LbNw3AWPupjAdtiVBcXMKJ9RYao5QxfnHEQTj75XkJYZcGEV8loR0dpqT3jJiFRvlwGBIkkPMk+wJDstcuo74cJBymZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAlqXKj7; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAlqXKj7"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso13403661fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726153922; x=1726758722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LIoZ8O1rkUWB7sRIp1YiDX1BYLEwPp4xz+Uv3kmBhA=;
        b=kAlqXKj7I2CIvHrB/YQehzkXQlDIUKB3KupY+752kDAu6ndgpo7ad0/TNrQspokA0W
         NF8WFBh4kx/MVbGMxw1bek0qYKgUz7aWf+Gxb7xxLmPRM4NRkUd7ZC+xrnSVlHrCjID7
         x+eZpehdid/E/jXSePv9RaBkb+pRmZeSnKiIzbIcE2T4Pv9nLJhwh9EgCm+p13dYe4Pk
         QNnmksAxiyR2eZpbzcvBkpOJ95A3kBrVdAg+sZlksuKqVDjkM/Rxjtf/7Cu6ygHVhFT5
         OWo03EWdg1J3NRQlZwOZ+ntq95m9d3KIaHpL72S4E3zCuOwjUAwyzKOCOhvSMsuLHnDq
         DlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153922; x=1726758722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LIoZ8O1rkUWB7sRIp1YiDX1BYLEwPp4xz+Uv3kmBhA=;
        b=OBa7vJevtksJwy4HepTvIjweuR3MxF9S6PJZJZPFSeM3RhpF5Ux0Zw0smnjkGyahbp
         3fLr2x+vgBbmQvrSbMfNFqeCQaYw8GyL0xVW2X9yRJyGVq7TRET1U4f+ogHsOfT9dtNH
         AQotpwlESa/Y8M/0EgG9dwNQBnBErNczY2VLo2cKjnh6dvjzTkb5H8FLCZG/GVvhl1Gn
         0xte3vzDfoLZ0babvat0Su58Qi9NCSfKTYZcyDmA12lyAwRcqwuiplE5bPbBGIX2ccAn
         iGAUC78e8Y392rB7G0eOK3ZbKw83o/T/jKV8OdGry72VDQJEQQlMc5ksF0C6R31UWRsl
         UBsw==
X-Gm-Message-State: AOJu0YyfgLxIoERQx5Z+a9CvsL7/zGAwMyfk5HfL7h20OzbxDXWIT3e+
	94DMZU9p6N5/MqzAuNejlbLq1edDmGkJhLI0v//0rU+7TEqIvrVotgQ3dLM8iRyJbyIDy/yB5ra
	64Suqui+2J+8Kv2NlyjbVgsLhCyo/PiBU
X-Google-Smtp-Source: AGHT+IGwMAVK1AXr42/IqwxQK/ltpvQlVxVCjWvyO38rBZZVTRxQghtpNMvM8/CCzv7l0Gu/Ma87YV0h07+4qpRaAJ0=
X-Received: by 2002:a2e:a316:0:b0:2f6:5f7b:e5e0 with SMTP id
 38308e7fff4ca-2f787ed89c2mr15887781fa.21.1726153921891; Thu, 12 Sep 2024
 08:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912092253.119754-1-hadess@hadess.net> <20240912092253.119754-4-hadess@hadess.net>
In-Reply-To: <20240912092253.119754-4-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Sep 2024 11:11:49 -0400
Message-ID: <CABBYNZLNDSsJmb=JpY=ObK-1DeJ2gc3L0pAaDN3sSP8BOzCC0g@mail.gmail.com>
Subject: Re: [BlueZ 3/3] shared/shell: Exit after printing the help
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Thu, Sep 12, 2024 at 5:29=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> Exit after handling --help, so as to avoid the daemon waiting to
> communicate with a D-Bus service that might not be running.
> ---
>  src/shared/shell.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index c31487190d0f..f7e8b3300373 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -1324,9 +1324,7 @@ void bt_shell_init(int argc, char **argv, const str=
uct bt_shell_opt *opt)
>                         return;
>                 case 'h':
>                         usage(argc, argv, opt);
> -                       data.argc =3D 1;
> -                       data.argv =3D &cmplt;
> -                       data.mode =3D 1;
> +                       exit(EXIT_SUCCESS);

This would undo shared/shell: Print commands when --help option is
given, so you might want to add print_cmds call.

>                         goto done;
>                 case 's':
>                         if (optarg && data.init_fd < 0) {
> --
> 2.46.0
>
>


--=20
Luiz Augusto von Dentz
