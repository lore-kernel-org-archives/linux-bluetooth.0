Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C40A5F
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743299; cv=none; b=hX5C7VKqjyzGN30ge96jHAT00s5RXAg/4IkZuutNtpwFJzi90m2xUdPsv0BrKdaeoZavAifcRCFo5Q+4zT4JS3RExgjbymi2wXn1B6QMQwcqePIP+cIDYjD5IZBxNl01Ys/dMCDHGhAAYlr4yT2QZKN1VArKWD/UIkeowk8KCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743299; c=relaxed/simple;
	bh=xrYzbrbZjOFX9FiIU30gslJgSw2jdOB7UmnCVEdpcqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzsXhMyD+onOvmXyd5OwqOXsUz8okFgb4LN+gX+yBiTAIb4b8uoByl2Fz+rRfUX7vmR4SIBqkHp7yzQvolxyCrfFAvnI4WVA/ZTaoTMXvuzFZjQYBI8VrUi17bXbNg58YXiLun2rLzKaf6/FFBCayjdbxIePElC+z1grFF6frkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwUm0JSi; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwUm0JSi"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso13539611fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 10:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723743295; x=1724348095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9xkvZINv70r7S1n1cWsjzAWoiIyl0YZI9l4/eYEdIo=;
        b=KwUm0JSiyqL4RSUhgsjA6Kaf2YLm4nSMiFAUrQVJTE7tb+F6MGqX4m6x1JWDKMTTRg
         g+UJC7IayPf626SeasriC3hTthK9m3TXkPmGiLs7iKIPsdZH4Lj8oXTnLKZ9mNpHlxbB
         7BToOPqOvGF+Nn0z+0/602qNfzbuahQGx4CzYWb7R0dYJyKYfuYh0ewyU4q7yxT1aANO
         PPKAJCnHq3eyipFrK4Zmo8LAPWmk8TqQG8rXRjfGWNAOrls0d6R90Aui9b+SZnZtlyPJ
         M1vj93xlw3nid0ulzG0Pt+AsCI91vHmtg62c3yH9M/RPZARo1QKmwyJXQi+LdfU8wJEH
         NM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743295; x=1724348095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9xkvZINv70r7S1n1cWsjzAWoiIyl0YZI9l4/eYEdIo=;
        b=EV8QDOunZItdkhDEzw4Ik55bpsJZOn0iAXRTQsUN0FPH4M1Dvn2zwjym43A5Nhn7FE
         auORPnQvT/AsKEeIKbjzIn2+84j4HG3/aV6D31r5J+/OG0sTyk4pbEv6eqdAYTD1eaHH
         jkLe0wf6f0mts3yzN72Do9uxuqOk+w8REIC2nQByDleYwWjitK4bc9x9MaYUr6TxdOPo
         dWCBkfqo+WN/T6WTUP6RBsYXRPm1L3GK1xVF7D//3Gbb3wXNmDXtecuX9ZOGjLoBBF/N
         BrZXGUJhxtAJ886PKlVESVbFiHQrmYyqmOjmcmowIdL1zhe2CwdZVKMIsMwf27KrApog
         3C8A==
X-Gm-Message-State: AOJu0YyU9k4+qRFxnpmmUeSAPB6P8Z/3/IN03I9OR8yqAMljISPP8dD5
	lljeY2HKNrvnn6mS7BuiZp/EKAFL3TzKSp4jZhXxGP5gfTFIkJ2Fg6+/DW198uYSRflblOpVXk7
	nn5J8nRNwmWrW07646BDIfq0WsuM=
X-Google-Smtp-Source: AGHT+IFU6CmX12wiJqRvaccQMRlbxaTss5kJ07n7uVyv0+zWBE61s7MilnZ8om11ntT27JQCfYHdAA+EpSiLKdFB/HI=
X-Received: by 2002:a05:651c:1549:b0:2ef:1db2:c02a with SMTP id
 38308e7fff4ca-2f3be577e0cmr3010821fa.6.1723743294849; Thu, 15 Aug 2024
 10:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172362641171.1463.1558884635182654862@lain.khirnov.net>
 <CABBYNZJ0OK=yfrzFneNXBD+ye8UF7w_5pLJah+Fyfr+XHefLsQ@mail.gmail.com> <172374276216.7554.15339600683100081438@lain.khirnov.net>
In-Reply-To: <172374276216.7554.15339600683100081438@lain.khirnov.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 15 Aug 2024 13:34:41 -0400
Message-ID: <CABBYNZLXvvM2knc6khd+iFnx0NkDFiuF-d5UjcFpFj-xD85Drg@mail.gmail.com>
Subject: Re: monitoring advertisements from specific device(s)
To: Anton Khirnov <anton@khirnov.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Thu, Aug 15, 2024 at 1:26=E2=80=AFPM Anton Khirnov <anton@khirnov.net> w=
rote:
>
> Hi Luiz,
> Quoting Luiz Augusto von Dentz (2024-08-14 16:47:27)
> > Hi Anton,
> >
> > On Wed, Aug 14, 2024 at 5:14=E2=80=AFAM Anton Khirnov <anton@khirnov.ne=
t> wrote:
> > >
> > > Hi,
> > > I'm developing a program that needs to monitor advertisements from
> > > a known LE device (or several) and take action based on their content=
s.
> > > From looking at the kernel code, there seem to be two relevant ways t=
o
> > > initiate passive scanning:
> > > 1) performing MGMT_OP_ADD_DEVICE with HCI_AUTO_CONN_REPORT;
> > > 2) using an advertisement monitor.
> > >
> > > However, it seems that 1) always enables the duplicates filter, so on=
ly
> > > one advertisement for a given device is ever reported; meanwhile 2) c=
an
> > > (after my recent patch) report all the advertisements, but disables
> > > device filtering - so userspace receives reports from all devices, no=
t
> > > just those I care about, which seems inefficient.
> > >
> > > My question then is this - should my use case be implemented by
> > > a) extending HCI_AUTO_CONN_REPORT processing code to allow disabling =
the
> > >    duplicates filter on request;
> > > b) extending the advertisement monitor interface to allow monitoring
> > >    only specific devices;
> > > c) something else?
> >
> > Have a look at scan.pattern, it sets a filter which can be either the
> > name or address using active scanning, passive scanning is only meant
> > for auto-connect and depending on things like LL privacy being enable
> > the host may not even see the advertisement reports since it would be
> > done using acceptlist/whitelist filtering which is done directly in
> > the controller.
>
> I would very much prefer to avoid active scanning. Perhaps it was not
> clear from my email, but my program is intended to be a daemon that
> spends most of its time waiting for advertisements to come in. In my
> understanding it's very undesirable to spend extended periods of time
> actively scanning.

Then you are after something else, advertising monitor perhaps.

> Also, the advertisement monitor interface already does almost exactly
> what I want, except for the fact it forces me to receive advertisements
> from devices I'm not interested in.

Yeah, I was gonna say that, but this is a vendor extension, not really
following about forcing you to do anything, or you are saying you want
to connect rather than parse something on the advertisement? It is a
little bit hard to give you any advice if you are not really
explaining what is the use case, also if you are involving a daemon
then perhaps you are not really using bluetoothd?

> Thanks,
> --
> Anton Khirnov



--=20
Luiz Augusto von Dentz
