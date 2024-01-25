Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B055C12
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190001; cv=none; b=dOIFbiaYH9cKw11yl745BiyuyCoCZOhzZYuA+tLvk8kH8doJ2nOC4Y1CuzdiyGsQOu/A1+FnQ0AEM8OMIgOEKAcskwYX4JiPcfB/pWu8XUPYL4vUoodSNO8mLXZVv/mV/eFOjtat60lho3edDqlo6sQiklp+YaTCvkO+z4iIbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190001; c=relaxed/simple;
	bh=WjocFrwW9NDLGstkXFRh15G8gZP/XvkcAu85wAyXrs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjftpcAG0JjuYnVfp+MBIsCMkQqwCFRvGwl0xrEljk4J3XWhn6mLa2sLFMFosnoEBhr5opcAHMocn1KVwHW6MjCObs1IMhu93FNm+xnxPZGcdpxwYr9+IoBOOmhrLP6e+BQ2jFOkzNTGttOaHguX8IebL0LvxJ/XmEPkeLJQdo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKarW5Jw; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKarW5Jw"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5edfcba97e3so68130217b3.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 05:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706189999; x=1706794799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5lfDeObWyvenc38qfma1JeNasaT76DJPrJnz2DZsA9c=;
        b=WKarW5Jw0k3wpI1Lact4VRdBlmyAyYU6I30ihOM/og6Yc3jTT1x+ttrd5HYpuTeTdC
         3PKRc5B/ozGf2HwAjBBuHqUpmRRasQUqI5AXFqZtj5qAr4euR8yGI8AssBhXwn0AKWzX
         u5I1LAPk7t/0Tw55r0h+k4U0q/oGEdsL0S8sC96eFYPm6viNgm7Y6Ihvw8mTejo60dBn
         0/evWgL3kgz5wMC9u0VutEsP0I+JqdEL5Qz20OviK+HikVoNSC/3bu+hcdLYmTWgh4tM
         Ph1Un5vCEtImJ8SXJWkCMhxHBuvSgBvAvS6XoB+0/8F2IDN6ID4bUiMSAuLiVI0Wd8vJ
         tZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706189999; x=1706794799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lfDeObWyvenc38qfma1JeNasaT76DJPrJnz2DZsA9c=;
        b=dTOLyEE/peItMvmIAYRXjIV4Q2mHBdhQodTr9/FD3Z7DUlEs/3t9hyOLodU3SpL/3c
         5QL0flDfzA3+03+85G/9zVhHgZB1reAizpgj/mOJw4IeK/DmNIBJj5yYclqzkRSd3f/k
         +X5pCN/kPOVsmZPl8TnZY+JdBqFv6nIaPRsSbsJ8H7hyqnY6WxQIWiR8e/aTSr2XOgit
         Ky2X3wTZh3nMrfLeR3EXPb9wfxPTe0tlZMXBlGEKsM1MvjvS7AxN3WbA4Wh+XHr6B/8Z
         fY6g2rFvTd1J4hx2IQCF2UzrnpA1JS/hn5vxBxiUtAZQ6hrKRojU6+xB1MaQVbNypAvU
         WCcw==
X-Gm-Message-State: AOJu0YwFJUdMQZlty+a3y9b6HbYGOiv3NnqJSb61Wyaht3X6dN83ciAB
	YrGpp293pcNCZp2KHc3fLuZTPZDPtDFrYqkz1b7i+PwDKCzHVD+ZTBt7rUKseFBALzF4Jfvi3/X
	gD4EQqzOrR2cd3WieF048F8ttnto=
X-Google-Smtp-Source: AGHT+IHeeELf+vecAFm716c6dcVOkqqm4+sIN85FLS8jmWjp75Pv/jbuh5GgoKkQfl3KkvVg3iuYN10gHUUCg/Eo0pY=
X-Received: by 2002:a0d:d707:0:b0:5ed:8cf7:8233 with SMTP id
 z7-20020a0dd707000000b005ed8cf78233mr653376ywd.87.1706189999290; Thu, 25 Jan
 2024 05:39:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com>
 <20240124-disto-patches-v1-1-97e0eb5625a3@gmail.com> <CABBYNZLibBw-_SJ4wpzF-r5cDPSds99kShO9C3v2FVNJ2Um9vg@mail.gmail.com>
In-Reply-To: <CABBYNZLibBw-_SJ4wpzF-r5cDPSds99kShO9C3v2FVNJ2Um9vg@mail.gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 25 Jan 2024 13:39:47 +0000
Message-ID: <CACvgo51BHdhdzhPifJjuz66Dc2vJ1QEvCrkxQwQnC8dNWC8nZA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/9] Enable alternate Bluetooth connection modes
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Vicki Pfau <vi@endrift.com>, 
	Rachel Blackman <rachel.blackman@synapse.com>
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

On Thu, 25 Jan 2024 at 03:54, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Emil,
>

>
> I'm sort of surprised by this, we do only use the PHYs listed as
> supported by the controller, so is there a bug or is this really a way
> to disable PHYs that the controllers report as supported but in
> reality don't really work properly? In case of the latter I think we
> would be better off having a quirk added in the kernel so it can be
> marked to the controllers we know misbehaves rather than limiting all
> controllers to 1M PHY by default.
>

Using pristine bluez, bluetoothctl/mgmt/phy lists (omitting the slot phys):

Supported phys:     LE1MTX LE1MRX LE2MTX LE2MRX LECODEDTX LECODEDRX
Configurable phys:                LE2MTX LE2MRX LECODEDTX LECODEDRX
Selected phys:      LE1MTX LE1MRX

With this patch + the LE/SupportedPHY config set to "LE1MTX LE1MRX
LE2MTX LE2MRX LECODEDTX LECODEDRX", as per the original patch we get.
Note: I've intentionally dropped the override for submission, happy to
bring it back if you prefer.

Supported phys:     LE1MTX LE1MRX LE2MTX LE2MRX LECODEDTX LECODEDRX
Configurable phys:                LE2MTX LE2MRX LECODEDTX LECODEDRX
Selected phys:      LE1MTX LE1MRX LE2MTX LE2MRX LECODEDTX LECODEDRX

Note: I've intentionally dropped the override for upstreaming, happy
to bring it back if you prefer.

So from what I can tell, the controller reports that all (as far as
we're concerned) PHYs are supported. Yet the selected and configurable
PHYs are mutually exclusive, which doesn't quite compute here.
Mind you, my bluetooth knowledge is a bit limited - I'm just going by the code.

What would you say is the best way to move forward with this? It
doesn't seem like a kernel quirk is needed IMHO.
Generally, if you feel that a different name and/or semantics for the
toggle would help, I'm all ears.

Thanks in advance,
Emil
