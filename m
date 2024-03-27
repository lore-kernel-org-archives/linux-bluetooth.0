Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290121514D9
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573825; cv=none; b=Zmus5UERKpjyIwxWMqWr5OjR8jzJqT8GPkwNYMvdXGUgLAsNYf4prc5xPvVQbFlRapVySKjrQdiALr1+75MA7/MrL6DXE6bIxqRnohIF2Xtux8TE8xPRaM+xiBHGFhwqDgEnSz7UED+wjZZD3ZdZT1r8WcnstNP5LSfupPRKhJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573825; c=relaxed/simple;
	bh=eetfl0ugcwiDU1PfSfANamMdWQ0+Q4sRTlS+5oMzWVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPP3rDJiKWCjBFflJQv5PEat7ct+GxeJ/dNd/CI2XSXrZs7BDqk5p4i1ZcLE5R19a9OLOdCvl97r1MM1p9TtLZ+v/uUmjy8gc+ZU6iS/FPHK43jhKXZ7Ep80KDbEcGkOSqqjZzxy2eUS9CfsyM8jnByVTSyLGd/9ZwxSYa+spTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6gsJzwA; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6gsJzwA"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d700beb60bso3952261fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711573822; x=1712178622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Okbd7w40lb4gNC64Z95JoLSQftq3wWi5ZeNfgbZh7q0=;
        b=E6gsJzwA53Z+jCQY3Xii6MIwZRF9ktP8mfaE/M31LGr0i7EUNtfkL9wFN81wm6QbM4
         AER8dHUT2EP8SLIkBCwUIspwd+bz2FtcQ0RPeU/f9R3+1Id93aqct0Owp42xOx7FeAWQ
         6jfV0/sDwi9FzqdmuzVwfoJTocFTOmhTpzZHqlQVuFBjQWFMr8JBnIgOofbkrIAyzwLQ
         kgqRGtphKpAs5tEvZqIMJSRjc5bbO3fBUNr0EPlsch+cnYl5jVNcepa+zgw9T1GUGdAf
         paTbVOgOPNM2wCrwN13wXV/PiR9BR4buscY6msABnvchXidLrzaSV/tCuN9C+VqRE9qg
         l/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711573822; x=1712178622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Okbd7w40lb4gNC64Z95JoLSQftq3wWi5ZeNfgbZh7q0=;
        b=W0GvCFgTDNXHrTcaoV80Odccb9IipbS0pAKEn7YURtdAcnC66ffpK6hjkiaDp3D3ff
         zm/TA2Vc6YODr2SsTpfCIF/oY4uhcmjb4Mt64rgB8dkxV/RI3O5INRUVFlhtyDK8DKAc
         h/rSUWJjP06LeeGR+WWsjazYJViLUoevvQiAIasU8VCc7dPpN39Ckcej/1EFgCT+26L5
         czdaTtqbmiKoXTr2+JtYKJiQSjhwojwGY3Ji4aYd1YrZVanDHd41TjPZbQZS0m2VR07A
         +CEpD0E0mKpSZMzdUX1+t25fBIxAPItvcIm9gki0xbdGRlGdjKq5va/60+qmg4kR/3Lo
         /wbA==
X-Gm-Message-State: AOJu0YztJbypErnZvhpc+3jkhQUwjTtUQLoaTJVladehqUHziF/6Un7I
	ncT8h9Tukh/UmerHcvQvRUnD73TSeIBEiL8JXV2p2r3MWHGezZ5bj/cZBRD/RGfgNwTiFYoF0OC
	34lM09yM596aJy8KSw2s9sEy/PcQ=
X-Google-Smtp-Source: AGHT+IH8qPtl7EOT0Huz0Kw0aHKYQ7aadaCkac+DZjiOZeEAuKYQH0fqBtLAiCmybq7ixvCS9YkAH6U84a4bv+UjgQQ=
X-Received: by 2002:a2e:9999:0:b0:2d6:84a4:99b4 with SMTP id
 w25-20020a2e9999000000b002d684a499b4mr1143949lji.20.1711573822184; Wed, 27
 Mar 2024 14:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR14MB53009C64A876F92F7F472CB5E9342@PH7PR14MB5300.namprd14.prod.outlook.com>
 <CABBYNZLj8z1xbB-2Qnwiqvqw1PdLjhVy3GgZLHFirEjLE4QtAw@mail.gmail.com> <PH7PR14MB5300B754841B71CAC197BA84E9342@PH7PR14MB5300.namprd14.prod.outlook.com>
In-Reply-To: <PH7PR14MB5300B754841B71CAC197BA84E9342@PH7PR14MB5300.namprd14.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 27 Mar 2024 17:10:09 -0400
Message-ID: <CABBYNZJ-D=y4DtAXdyb3Py-Qf68aSYwLvL1W2_mzh4RtFS1cFw@mail.gmail.com>
Subject: Re: Maximum Bonded Devices
To: Chris Laplante <Chris.Laplante@ezurio.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Wed, Mar 27, 2024 at 5:04=E2=80=AFPM Chris Laplante
<Chris.Laplante@ezurio.com> wrote:
>
> Thanks Luiz
>
> They are not trying to maintain 30 simultaneous connections if that is wh=
at you question was. They will only connect with say one at a time but they=
 want to maintain up to 30 bonded devices in their database.

I have something like that in my device database, in fact in a crowded
environment you may see hundreds, perhaps they are marked with
auto-connect flag and then at some point you can't really pair more
because they are always connecting/disconnecting?

> Thanks
> Chris
>
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Wednesday, March 27, 2024 5:01 PM
> To: Chris Laplante <Chris.Laplante@ezurio.com>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: Maximum Bonded Devices
>
> EXTERNAL EMAIL: Be careful with attachments and links.
>
> Hi Chris,
>
> On Wed, Mar 27, 2024 at 2:15=E2=80=AFPM Chris Laplante <Chris.Laplante@ez=
urio.com> wrote:
> >
> > Hi,
> >
> > I have a customer with an issue where they are unable to get 30 devices=
 paired and bonded when the BL5340PA (nRF5340) SoC as their central device.
> >
> > Following details might help you out-
> > 1.      They are using the hci_usb sample code as the firmware on the S=
oC.
> > 2.      The stack on the host Linux system being used is BlueZ (version=
 5.66)
> >
> > They are able to pair and bond with upto 8 devices pretty quickly and t=
hen this process slows down and they aren't able to pair with more than 12-=
15 sensors in a single go.
> > After the pairing and bonding process stagnates at around 12-15 sensors=
 if they restart the host system (and in turn the SoC as well) they are abl=
e to pair with a few more sensors but not 30 sensors.
> > So far out of the things that they have tried out to identify the sourc=
e of the problem it has something to do with the BlueZ stack configuration =
( they are currently using the default stack configuration) and/ or the fir=
mware configuration parameters.
> >
> > Do you have any idea on what configuration parameters could be causing =
this behaviour and/ or what configuration changes need to be made so that t=
hey can achieve the target of pairing and bonding with 30 sensors. If you h=
ave any more questions please let me know.
>
> Don't think there is such thing about number of paired devices limit, we =
just use lists so they be extended dynamically as you pair with more device=
s, there might be a limit on how many the controller can maintain connected=
 simultaneously though, so perhaps you want to explain a little better how =
the process of pairing goes, is that serialized or you attempt to connect/p=
air everything in parallel?
>
> > I believe the default is set to something like 65K devices per
> > MaxControllers in main.c as well as main.conf
> >
> > parse_config_u16(config, "General", "MaxControllers",
> >                                                 &btd_opts.max_adapters,
> >                                                 0, UINT16_MAX);
> >
> > # Maximum number of controllers allowed to be exposed to the system.
> > # Default=3D0 (unlimited)
> > #MaxControllers=3D0
>
> These are the number of controllers, not to confuse with paired devices t=
hough.
>
> > I am assuming the issue isn't BlueZ specific but if there is any though=
ts or guidance you may have it would be appreciated.
> >
> > Thanks
> > Chris
> >
> > THE INFORMATION CONTAINED IN THIS DOCUMENT IS OF A PROPRIETARY NATURE
> > AND IS INTENDED TO BE KEPT CONFIDENTIAL BETWEEN THE SENDER AND THE
> > INTENDED RECIPIENT. IT MAY NOT BE REPRODUCED OR USED WITHOUT EXPRESS
> > WRITTEN PERMISSION OF EZURIO
>
>
>
> --
> Luiz Augusto von Dentz
> THE INFORMATION CONTAINED IN THIS DOCUMENT IS OF A PROPRIETARY NATURE AND=
 IS INTENDED TO BE KEPT CONFIDENTIAL BETWEEN THE SENDER AND THE INTENDED RE=
CIPIENT. IT MAY NOT BE REPRODUCED OR USED WITHOUT EXPRESS WRITTEN PERMISSIO=
N OF EZURIO



--=20
Luiz Augusto von Dentz
