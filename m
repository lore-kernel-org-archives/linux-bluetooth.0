Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFE15351E
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573293; cv=none; b=gEF3Jh4GSODPs92tqljuAsvorXV+tK0mov9MS2LctYS8odH8IjHzVn5BJEHZDWLqvid/m0mYidHkdAB+F5RhRkhvDnOnjZjNerFWPCVM39Yy4xf19wD+5/WkxNZqRCJyJqxcnLNFx8iI12rqfnnyYkLYQIMfbgIT4zdkbS0axgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573293; c=relaxed/simple;
	bh=ZDFiSNmWaFYv4bc35f+srXHanLDpEpEDr+NGPpELKb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aG3gUjxZxnp9QIkcyyFFC5iMykhEs3qTUB3D4zkGHS4+kh2LR1qtwYYdUcCB4fLZTjtIgHweTbsQ+++WKkoJdyY0ZE4WTLFy6D4k4o+4MrvLCsdmtoHCM509wnR8Exf8u44kDJWMQ7sHxwE/8XqWPdETTxd5gMOLfooczdyH8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOogOzH4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOogOzH4"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d6dda3adb9so2378451fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 14:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711573290; x=1712178090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VdAPqd14du3TLfQ4kC1l/CAKQ4Z23FHSXA40h6eKdY=;
        b=SOogOzH4txfpd3r/YpkmZDMb7NHfbfvf6ADBghbYS54cLgOOTaDuwNCQRZyNJmaB4n
         YbO/B3GcnJJT2P5sjQhrYXA3Jpfbzibamz0UbOLb58IolBfsH2k5SEI6XHB+6/sYiIhN
         IQ/jT1zxjFhzwYpEgywB70D6MRZMWLxuGnF5AdS8STVpSqDErN3W+PbJ/klqno6Sqxmm
         WqbxBHKNU8KcXQNzXkl42astUdCimBxD2TT27TSBDvopKKQuvMUrMYumgmphdPGRsBxj
         k/HftbgJV87YY0WvTrnkdClDzS6uUTOEwgeuJB6/lkwanSGa3MgZJO46utocDr7p1K3I
         WoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711573290; x=1712178090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VdAPqd14du3TLfQ4kC1l/CAKQ4Z23FHSXA40h6eKdY=;
        b=sqQvDOCer6YRIxTo34pj8GlYEQG4kyhq45FnBG1pnRtmJOUxLBUzO5+xEJs+hPN5+7
         mLfSslfsdg0YgJO0K2C63UFKFHxovPATEtGiPcgteiTM7tZVdMvGVhg3L/6hJNdhuQk+
         ZkEJRbP+Odm2tQVVgGiuqRxd/4Hh16lVNsa/uf9aOBLs+LMMg2941EOD/5iw8/7NCkXT
         ux5sjsRXc6DJoOIt7iB1uh+N6PaoE3vLXIOMZCCU4hQ4DIu9I9GuVt1QslsFRph95Ftd
         hpVeOydF7ONuOHBknUww2/1jlmqtcJWTpwoPp+ybnudin4KaeJJbKdU49keqKh1O8aBR
         a9IQ==
X-Gm-Message-State: AOJu0YwOlTiw+l9bMCVEOs//oy+2PISs8IbCuJ5KvA3tOX0KOp8cMmds
	TDgSQ2Ykr9Ja3VYjHI+v2t6l1pzA7CRwBqAvClJNjW5cJvXFW/MWEjOovjuoej09NrynqI4SXFO
	Jgm0VLJ3gYSXHrucyJiVoQFotBkCpKcle
X-Google-Smtp-Source: AGHT+IE4zBfjjlmtxho0E6+Erw0Szw5cJYmJ/CNMUZEtXJhN1xLAU02gg4Fuc3hIOg65989pz5VZhNPlXWTVSpnI8Pk=
X-Received: by 2002:a05:651c:547:b0:2d4:2bc5:38dc with SMTP id
 q7-20020a05651c054700b002d42bc538dcmr580791ljp.30.1711573289441; Wed, 27 Mar
 2024 14:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR14MB53009C64A876F92F7F472CB5E9342@PH7PR14MB5300.namprd14.prod.outlook.com>
In-Reply-To: <PH7PR14MB53009C64A876F92F7F472CB5E9342@PH7PR14MB5300.namprd14.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 27 Mar 2024 17:01:16 -0400
Message-ID: <CABBYNZLj8z1xbB-2Qnwiqvqw1PdLjhVy3GgZLHFirEjLE4QtAw@mail.gmail.com>
Subject: Re: Maximum Bonded Devices
To: Chris Laplante <Chris.Laplante@ezurio.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Wed, Mar 27, 2024 at 2:15=E2=80=AFPM Chris Laplante
<Chris.Laplante@ezurio.com> wrote:
>
> Hi,
>
> I have a customer with an issue where they are unable to get 30 devices p=
aired and bonded when the BL5340PA (nRF5340) SoC as their central device.
>
> Following details might help you out-
> 1.      They are using the hci_usb sample code as the firmware on the SoC=
.
> 2.      The stack on the host Linux system being used is BlueZ (version 5=
.66)
>
> They are able to pair and bond with upto 8 devices pretty quickly and the=
n this process slows down and they aren't able to pair with more than 12-15=
 sensors in a single go.
> After the pairing and bonding process stagnates at around 12-15 sensors i=
f they restart the host system (and in turn the SoC as well) they are able =
to pair with a few more sensors but not 30 sensors.
> So far out of the things that they have tried out to identify the source =
of the problem it has something to do with the BlueZ stack configuration ( =
they are currently using the default stack configuration) and/ or the firmw=
are configuration parameters.
>
> Do you have any idea on what configuration parameters could be causing th=
is behaviour and/ or what configuration changes need to be made so that the=
y can achieve the target of pairing and bonding with 30 sensors. If you hav=
e any more questions please let me know.

Don't think there is such thing about number of paired devices limit,
we just use lists so they be extended dynamically as you pair with
more devices, there might be a limit on how many the controller can
maintain connected simultaneously though, so perhaps you want to
explain a little better how the process of pairing goes, is that
serialized or you attempt to connect/pair everything in parallel?

> I believe the default is set to something like 65K devices per MaxControl=
lers in main.c as well as main.conf
>
> parse_config_u16(config, "General", "MaxControllers",
>                                                 &btd_opts.max_adapters,
>                                                 0, UINT16_MAX);
>
> # Maximum number of controllers allowed to be exposed to the system.
> # Default=3D0 (unlimited)
> #MaxControllers=3D0

These are the number of controllers, not to confuse with paired devices tho=
ugh.

> I am assuming the issue isn't BlueZ specific but if there is any thoughts=
 or guidance you may have it would be appreciated.
>
> Thanks
> Chris
>
> THE INFORMATION CONTAINED IN THIS DOCUMENT IS OF A PROPRIETARY NATURE AND=
 IS INTENDED TO BE KEPT CONFIDENTIAL BETWEEN THE SENDER AND THE INTENDED RE=
CIPIENT. IT MAY NOT BE REPRODUCED OR USED WITHOUT EXPRESS WRITTEN PERMISSIO=
N OF EZURIO



--=20
Luiz Augusto von Dentz
