Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025B168BE;
	Fri, 10 May 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715352055; cv=none; b=PCSGgwFICHTsZ+NblF0u3M19ZUpLAirUHJXjYKJLu9TQ09JxsqUxaUS/cpMbEqMmQLzCLbTZ3A+8RKs0IXz/rlVLU8AZWVvhZlMPw7vpR4NzoBmowVS2OcqI6Xd7Fj6+w05uScBAe1/qz2MTJCO63KKwkidZe7j3oOL5RVpU0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715352055; c=relaxed/simple;
	bh=UiLqVKMp4B8/fDygWBWNunb+Cr9pCD0DJLf3F6ksB1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKoCW4UourjIdawWiZQTXlz6vjBTfFnvSKeJordD2dptgTnR58ijQaGbhcTJZCw8IZrES6PtOPJH3PYVRJJrpD0YS31AZqSf6ociEGEvfDsAR9UrU1RfKSRhN9YgMhk/+d+ZUVJLofPgrcEc2k+ZLvh22XnBwkfPey7JuGPNJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPld1Ti7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPld1Ti7"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e4b90b03a9so23052391fa.1;
        Fri, 10 May 2024 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715352051; x=1715956851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiLqVKMp4B8/fDygWBWNunb+Cr9pCD0DJLf3F6ksB1M=;
        b=LPld1Ti7b2m8BsGfBs8lK69s3/yIz2jJ/WfzRXfkyLZKbkUxcWuj2vplzeMoOxsrws
         YE8Roe7r1QMkue+gSL74I49wASEKVhesMHznHX7WXd9jfVisuY5DT0sduc2SAccb1sLC
         QVTG9aQLCbwGZfhWH8wfsThwsTozoRxKBzekPcVbKy68fWOoMC3JNw9TxLHxfUhy8iCq
         D0NYrjj7YdwRYszhyBG9ZG0kIlgFV6Iv3zDV3+0SxWsK7gRuUmosgbrhILibrt/BgBq2
         fivmLW9HEySvc5gsR5JBIuGP2hjZ6mS/eg2MXNQepz2MnJQVcubrMMFGJFDN90HiBIgF
         wMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715352051; x=1715956851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiLqVKMp4B8/fDygWBWNunb+Cr9pCD0DJLf3F6ksB1M=;
        b=RVEnYQCOMpYkUJvItHmiIdpSKnHZjQFtH480zzFV9VtNS3iFncBtc+ZXRKeqSXfRW3
         Hmm1pxCwTGRhY3+xyaGWuoms46ZIJ0VQIGsNbHV45MHjJvYCDfgQx9lX5DPvMHCq7kFU
         ax5a0j5F1x42kCkuH9U80Y0tygH6kMyWTVSGJhW4tPkDrMwmUOOKHYzjF39Fz1FhUvjU
         ImpCLjeqh+hBGMflzs6RgSOMiagHNc4ycOP1KTgtq9d/bZ8EbWO8dV78M4mnWgID8cSC
         he82yVfMA+v9SuRRG7ayqDuIoRA22/de92irKyZewhEwiYBGgMISxquz+FZTrb4bEVQm
         /g7g==
X-Forwarded-Encrypted: i=1; AJvYcCXx9sX111h174WA8QmcrJR5m5wMM0iBQrI4l7CbCk1JftPx+lrXg9rR0PlOi3xdaVRSPijqOaNgfylFdWXTBm2uDSvRcKBVUeMoL1bbS/dZ9SlsnD8xJcaIDRxkoWaAMj2WfuIMwsd6nRUIMkaq
X-Gm-Message-State: AOJu0YyngvTh9MUItVJ9nCnhq556vCpikch6nDhhTDKtNw9e4L1rFFLm
	dFxYLsg6u9QOxwiwbZ0MqASMwwK0gn2gGJLSPX1wesGLA6E1Kou2yjum0ci8uFczGMWcb5RfjKM
	uRcu2r4a3RSHXJ+SHmS73D8uUoTR0TA==
X-Google-Smtp-Source: AGHT+IEY29aCMtw+UI02/vVCzGTZH4fw7uraJPLpl0jojfokPwvL+fue2VxxmE/B7AfPRwKrbpvxFZEY3AFj/cLnG3Y=
X-Received: by 2002:a2e:8e93:0:b0:2e1:18d:7497 with SMTP id
 38308e7fff4ca-2e51fd3fdc7mr16562281fa.7.1715352051305; Fri, 10 May 2024
 07:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304170753.500074-1-neeraj.sanjaykale@nxp.com>
 <20240304192952.GA17410@francesco-nb> <PA4PR04MB96874E4B23D6C225AE1367F4E7282@PA4PR04MB9687.eurprd04.prod.outlook.com>
 <ZfRsYf8qhqmrGbkK@gaggiata.pivistrello.it> <AS4PR04MB96925F0F893BB57A32253077E7E72@AS4PR04MB9692.eurprd04.prod.outlook.com>
In-Reply-To: <AS4PR04MB96925F0F893BB57A32253077E7E72@AS4PR04MB9692.eurprd04.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 May 2024 10:40:38 -0400
Message-ID: <CABBYNZKrbsNtSfTpz=mZDHD_-X8HimSMLqfx3UFWpJ7yMDGiHA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Enable Power Save feature on startup
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>, 
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
	Rohit Fule <rohit.fule@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Geetu Naagar <geetu.kumari@nxp.com>, 
	Francesco Dolcini <francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 10, 2024 at 6:18=E2=80=AFAM Neeraj Sanjay Kale
<neeraj.sanjaykale@nxp.com> wrote:
>
> Hi Luiz,
>
> There are a couple of patches like this one pending review. Can you pleas=
e have a look at it?
> Let me know if you want me to send all the patches pending review once ag=
ain.
> Thank you for your time.

It is no longer available at pw, please resend.

> Regards,
> Neeraj
>
> > > > > This sets the default power save mode setting to enabled.
> > > > >
> > > > > The power save feature is now stable and stress test issues, such
> > > > > as the TX timeout error, have been resolved.
> > > >
> > > > I assume that the stability issue has been fixed in firmware, corre=
ct?
> > > > What's going to happen if running the updated driver with old firmw=
are?
> > > > What about combo Wi-Fi/BT firmware files, were those updated? I'm
> > > > currently using this driver with this firmware [1]
> > >
> > > There were some stability issues in the driver, that are fixed in pre=
vious
> > patches.
> > >
> > > As for FW, I have checked internally and there were no power save
> > > related issues reported for any combo FWs.
> >
> > Thanks for the information,
> >
> > Francesco
>


--=20
Luiz Augusto von Dentz
