Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697ED12E75
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105702; cv=none; b=ny/tcI5wkQKZuyw9Wlm2SGZh5m9u4j1lDyFNv3lc5Eru9R6GdW3ktKITZ0D3mnzF1wjvrcdNOQofHp4atiimEWLnSII9hv+Lg4H5YuBszKziq1WwrhigUX2t8JDf9shzeHIcSS7geM/l3fJKEFd4AdnZ832r54Dg5WOg3SFoxKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105702; c=relaxed/simple;
	bh=5tyXPyBlpp5UbB6oJKNJiHuQqVn1Nr+wNHLUzSCNN8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqWjtsGKY3jXjBla3kmOVGG9jhL9qaFvOndyJ3BGLC3rQzAv9yfJdIjHuRF1TCLSyrASJHcYzQV8Fe8unW1KdyXSBTc9ThNUMRBrch9RY6unQXSRFiVYE2kW55mTcsbN0ErTp1cqU3UF3XYdrMY4Hs3JYjbxc1uSyFj3lSOT/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJh2ZxOY; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJh2ZxOY"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso2671421fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 12:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729105698; x=1729710498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfoPyOsmNKBpbW4UUVilRw1fzgl5ccqhl9fH1mrp5ew=;
        b=NJh2ZxOYrenmAbV8dEQO1ux9egc4Qu3enzGTHCpvUjn8IaJfdP6hxEzXhbvPOomXPA
         yRblR4AxgXqE/FfggjM2vcduWa/NmxtwJLS6BfOM2I6ZAQu8C3I2enNEvcoER+TK58kV
         tLVUvOnip2z6W37LYzZFxYbvIWGAy/j4FcljYE81nPUuEBfjtMlaQuOTNiEjMtTVjNpq
         1F0Z/GEmGCmHVhwDLddFYnd9JgCgk7dzDYV63QN+lz/j7gZWbIzMAhNhNsIKuEcQz5lr
         4Jqr4HgWa5iP+Sc5tEcA8v5nTdVv/aXcq/JRsp2LvpAmCSIiR0x/vLRE/pKT/wjsiaaK
         BS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729105698; x=1729710498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfoPyOsmNKBpbW4UUVilRw1fzgl5ccqhl9fH1mrp5ew=;
        b=na8Z0WYiPBQSmrwI+55qgJ3YXuV1041ar4ViNZhxZoPDvQUscTyarSNoA9M896c9ks
         eTHoagat3oQJ8d7D7IN/2FWsylrimDiDKhdmdJVJTRMuVj7ucpbf9xd6K71lrB1cpgVB
         BYH/C1ulWH0/jVHvsivHOkB+0C3Bt7UWuwey67qbSK2RUYiEQhfkpMXE/SPdvan+jDv2
         AJ6rZHHQrY5Wyh7YEhvdf+LcyZWnvCXAYTTMwd5fwecynpxPTEbtVA5AmZleOG6l68Px
         XlSRZTe0373S22HDv+k4K7/rsqQtXew0t0XKm+rK2fHRWiaiNMEp3oe/Pl+WsooOKxzJ
         Q+0Q==
X-Gm-Message-State: AOJu0Yy41Os97nGZBZdGxNe40iW9LNiXrfH06Cok/yrKM7k/KaraloTc
	2sLF98otrD8y7yGUv7hxCgscFgCb+7DZT/ZodxxMEtgxWKgt3e+C0tHG2jvh0uAhKw8+xatn9NE
	ltoRv41qyR+bRYnoy6Ne2ftaHcYw=
X-Google-Smtp-Source: AGHT+IFpMThFFX120dLLOYTQhI9ofrhgYrUm3CaUjbVmWJRaHSuAFYnolyq+nLH/xIMlkYVB0yPbfcJXrZtV1Hw3l5g=
X-Received: by 2002:a2e:6101:0:b0:2fb:51a:d2a with SMTP id 38308e7fff4ca-2fb3f197c65mr92963161fa.12.1729105698221;
 Wed, 16 Oct 2024 12:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhaqxrW=0g9E2qWdEXTGkjv5cxZLAu-6UGDO5tGLxZDdQXvJg@mail.gmail.com>
 <CABBYNZKu465GRDOCGepyckgrk4CZF4tOwbzUN6HQyG8ZKfg=8w@mail.gmail.com>
In-Reply-To: <CABBYNZKu465GRDOCGepyckgrk4CZF4tOwbzUN6HQyG8ZKfg=8w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Oct 2024 15:08:05 -0400
Message-ID: <CABBYNZ+pYGDBUWg1=+X8JiHVeTHe4rZM20ckTixpGW6bLsnaBw@mail.gmail.com>
Subject: Re: Bluetooth not working on 13d3:3585 IMC Networks Wireless_Device
To: Grimoire April <aprilgrimoire@gmail.com>, Chris Lu <chris.lu@mediatek.com>
Cc: linux-bluetooth@vger.kernel.org, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Wed, Oct 16, 2024 at 2:51=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Grimoire,
>
> On Wed, Oct 16, 2024 at 3:28=E2=80=AFAM Grimoire April <aprilgrimoire@gma=
il.com> wrote:
> >
> > Hi. I have a laptop with an integrated bluetooth adaptor recognized as
> > a usb device. However, it fails to initialize properly. Searching for
> > other instances on bugzilla, it seems others had success with
> > 13d3:3585 adaptors.
> >
> > (base) =E2=9E=9C  ~ sudo dmesg | grep Bluetooth
> > [    0.422244] Bluetooth: Core ver 2.22
> > [    0.422254] Bluetooth: HCI device and connection manager initialized
> > [    0.422257] Bluetooth: HCI socket layer initialized
> > [    0.422261] Bluetooth: L2CAP socket layer initialized
> > [    0.422265] Bluetooth: SCO socket layer initialized
> > [    0.530052] Bluetooth: HCI UART driver ver 2.3
> > [    0.535346] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> > [    0.535355] Bluetooth: HIDP socket layer initialized
> > [    3.556068] Bluetooth: hci0: Opcode 0x0c03 failed: -110
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D218472
> >
> > I updated to 6.11.1 and the issue persists.
>
> Well it looks like the reset command is timing out, but the issue was
> originally the PID:VID was not supported in btusb so perhaps something
> else is happening, perhaps another manufacturer that don't support
> short-transfer which was introduced by 7b05933340f4 ("Bluetooth:
> btusb: Fix not handling ZPL/short-transfer") so try reverting that to
> see if it helps.

Seems this appears to be a Mediatek chip are you guys able to verify
the above change doesn't break with your controllers?

>
> > Thank you.
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
