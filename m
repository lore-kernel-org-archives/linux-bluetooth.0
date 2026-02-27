Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9935FF57
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211710; cv=pass; b=XA5fVmNsIqkrSm8a4kW8ubPT0xJvQsz/WOKFn23+J9qSe9NtgtdRtjcZMwlhCLYDvJAGeGaPyo3Chj51s00Bwe6olli86Cva9NhMmnZjS00bKgAjmnHJG6Fl7Ncai8dHeNwDLCXdSFWKfVgQQCTZ5igSnQUoP9fACUFe1rXy1E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211710; c=relaxed/simple;
	bh=D1l9X+Lpgj6zztYShtJvADX7qO/ogqx+sCEkGSAUAOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ymrb3T6Ej1MdNCKzf1Yx5lDlpRr2anWuXzOnu7662+w3xfHrzgHy525CA7JVdLEHZ1qO+oH76PZdp0hkVHP6w3/pDpln0l4/XzkOw1I2ZqDkZ42K06AR4hA/pLxWf2tWD5nD3USuXcFMn8F9NWhnfOuUmC7yG8NvPCWICvzeXZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoZDmbs1; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoZDmbs1"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad79df972so2532306d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 09:01:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772211708; cv=none;
        d=google.com; s=arc-20240605;
        b=AFDJ7W0+LMzypLlqqPLs+NhZaDVdZ0F26MMDEv9W+ek/orXEBokTisOfo5yStvzKIB
         XrHZ4hb91CG37aurCbufb4GBLtpcjhk16mbG73rDmqm20CmMgKk9KeWj+fHVVhqQiZuw
         NFf87dv1dkROUaAco9VIaU8ReDQ5ZJ7SnE4Uq+TyJmKClOv+s2bJQykCzMEgcU/iiasu
         mum2qo8WxyajtS4rOy8RPxkvAiCTSsSs1z9jzbmEqLF7EjJdRYBo3V6QErXGiBkMzvF0
         ipKmlgQa0hXJrdhociwEpRCdqkPBFhlJ98wYQxywe1S8+MvYARxNqlvQoQobK3CiEfeL
         Oc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v1DSsC5IjfkU9F0z4xNf/8YgKBHCGBAltNkSYwjJOcE=;
        fh=1fz9LSvKI35CJE+hUnH4yaORc8MHueMppyFMJ5ZRfM8=;
        b=JUjaJ+CE+XPm0OnfDaFM3VrQOdtBuCudwe00tpI/3ZC4t3EFOXpZD/+cUw+f2Cavi6
         khpwp3YJhTeT6VEkZC40rY1PMY51l5aoBRUTF2Wn1tlvOlFmLLDyVokUBaHcLLoWQEzc
         4LgsEX7zLbdk1g3jxeJ9Org5hgPMlfnRIaL48LZwNCtvDi+gYLrzKjZLotGwnM2D5bR+
         hj9lwZ+E+vS9hsfkTPAbCKYhP0FlvgKb1bim/aBShrXbS3+sF3MNayZwqOApndq9AtO2
         GrqPDEpwECiszfvvgO8VR8yfSZgK5aJCra6sFqmdRPH550Rxzs9OtwLcCZjhFlZGkfCM
         vR4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772211708; x=1772816508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1DSsC5IjfkU9F0z4xNf/8YgKBHCGBAltNkSYwjJOcE=;
        b=YoZDmbs1goJhI91+nE3qrJLRPo8+WJZ8vdf3RWBxgBImU7QAfi0P7pz3n+ylAkqMV9
         VrZwPP0Ghgy/YsvH6Scxkm/x93ibNsX+9NVT4lvuCNvt6h/0dZ9cET9ZEuByCHwYtM9/
         qNwFk59o3QfXa2VlU66vtGy0MZXBNL6Ujt3h/SmXDIqA0hh7fN5/W6yhY1/ejTNDFf55
         vxr09E9QI8+FNfdMarpuuzQZliG+CF+Ssxoexdm3sv0+G1JyfomUsrKGGtKFZyQYAjrT
         D+L1LJlv7PMC5MOtipFBMGPH9dDaMtrf5NjWuBhWtq06U5dwsUpoGNWXv/4zYhGsQmxJ
         Ovag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772211708; x=1772816508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v1DSsC5IjfkU9F0z4xNf/8YgKBHCGBAltNkSYwjJOcE=;
        b=aF3dnk5UAd4Dz91Sf1NmPiKqnsZXB8/tGsc80kLxmaNl46b24R11R2kM6vglG15Mva
         uk9BOa2BpuOAi30q8LLBweZIbT0G/4bjl5FoskvT+ZOeeKvuudYYe6z77B0y+aclqyOr
         AmApYn9LU5HHL2NR3p6vnw4HqjVGJAcIkZbST7LxORonQPMXjd1rBtZalunvYJ0am33f
         lshpIW5yXfth0X9hA/w2uZ3uYx0yHn7hA7zfJ91bxPUYW55LR/pxKr/+RZ2Qp2Sfgdjv
         SnNEB3ukI2iSFE4ZgNg4rq+7+Nu22hdxKQLYez4zMaXdPKm0ixBAl2lWbfp13vg4Ge6l
         DO0Q==
X-Gm-Message-State: AOJu0YyRjRv6tqowSWJW/qk5mVqPfOvBQ9s9aT2hRaiGmvNOev468Bq8
	nF9uCWmjPM1OyNWiC3apYFvsap3oNXivkHTEgISrsueZeOaZKHH5wVF6VIiv+k0XMGHzrrKp637
	U6vvDPMLXYK2jwO5gyXXNwKeNQnA1na4=
X-Gm-Gg: ATEYQzwyQmFAoQuH3SyH3iIwhTzu717MLlU1kpRpIYepPso6On3ZM4AtcxTSiSIpswU
	oLMEjGFa6ZyJvYcmVQuG51y1Iml0pmDCkNFcha3XkTqOhw7wHMMeb8hOLbw+JUEaVim6mrQjRcR
	Fgi+YZO4foltPXhmBNSOeB2yAkH2+bfFhH383D2z4N6w21c+KrYXlEM5t+gIJJPuMSlg7XaiZk4
	wYqgifXlcWU/aIW3zYQfphgMmGpyScs6AXAyBdEBs6RM07y2rA0RDihU9QEo6hsmFX7pFA934ys
	T3dHifBf5hzvbbwq+/HPeZLa1nQEG/eEn7izFvCewP/G/1QSCr6vvnK54oDBuTISuwtQcg==
X-Received: by 2002:a53:a001:0:b0:649:ba41:18f0 with SMTP id
 956f58d0204a3-64cc204a0a8mr2142561d50.9.1772211708314; Fri, 27 Feb 2026
 09:01:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227160022.21462-1-ceggers@arri.de> <20260227160022.21462-2-ceggers@arri.de>
 <CABBYNZJJZRav3wRfmkQNg-kyARXwf6A+yDRu94jt8Fb6C0OULQ@mail.gmail.com> <5022130.OV4Wx5bFTl@n9w6sw14>
In-Reply-To: <5022130.OV4Wx5bFTl@n9w6sw14>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Feb 2026 12:01:36 -0500
X-Gm-Features: AaiRm50-e_Afay-sIIBx0QVOxs0CsRaMtIlZylVRPykH489TTEjh0gk-l7PvGOE
Message-ID: <CABBYNZJuCeUF-1nb_mMwsYOvrg2D_NB=Kix6D0OfDKV5oCtAyA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/15] doc/qualification: gap-pics: add footnote for
 TSPC_GAP_21_9 feature
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Fri, Feb 27, 2026 at 11:42=E2=80=AFAM Christian Eggers <ceggers@arri.de>=
 wrote:
>
> Hi Luiz,
>
> On Friday, 27 February 2026, 17:32:55 CET, Luiz Augusto von Dentz wrote:
> > Hi Christian,
> >
> > On Fri, Feb 27, 2026 at 11:08=E2=80=AFAM Christian Eggers <ceggers@arri=
.de> wrote:
> > >
> > > This feature is not supported by some host controllers (e.g. RTL8761B=
U)
> > > and must be disabled with such hardware.
> > > ---
> > >  doc/qualification/gap-pics.rst | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/doc/qualification/gap-pics.rst b/doc/qualification/gap-p=
ics.rst
> > > index f5b63a00ac98..d7673e5da088 100644
> > > --- a/doc/qualification/gap-pics.rst
> > > +++ b/doc/qualification/gap-pics.rst
> > > @@ -832,7 +832,7 @@ Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38=
/3 "Peripheral (BR/EDR/LE)"
> > >  | TSPC_GAP_21_8    | x        | Peripheral-initiated Feature Exchang=
e        |
> > >  |                  |          | procedure (C.1)                     =
         |
> > >  +------------------+----------+-------------------------------------=
---------+
> > > -| TSPC_GAP_21_9    | x        | Connection Parameter Request procedu=
re (O)   |
> > > +| TSPC_GAP_21_9    | x(1)     | Connection Parameter Request procedu=
re (O)   |
> > >  +------------------+----------+-------------------------------------=
---------+
> > >  | TSPC_GAP_21_10   |          | Data Length Update procedure (O)    =
         |
> > >  +------------------+----------+-------------------------------------=
---------+
> > > @@ -848,6 +848,15 @@ Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 3=
8/3 "Peripheral (BR/EDR/LE)"
> > >    otherwise Optional.
> > >  - C.2: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core =
v4.2+HS",
> > >    otherwise Optional.
> > > +- (1) Only set of Bluetooth controller supports the HCI_LE_CONN_PARA=
M_REQ_PROC
> Ok, I could also write "Connection Parameters Request procedure" here
>
> > > +  LE feature, otherwise, GAP/CONN/CPUP/BV-08-C will fail.
> > > +  # cat /sys/kernel/debug/bluetooth/hci0/features
> > > +   0: ff ff ff fe db fd 7b 87
> > > +   1: 02 00 00 00 00 00 00 00
> > > +   2: 5f 02 00 00 00 00 00 00
> > > +  LE: bd 5f 66 00 00 00 00 00
> > > +      ^^
> > > +      ++- This byte must have the 2nd bit (0x02) set.
> >
> > I think we might want to say exactly what feature it is rather than
> > just the hexdump and point to the expected value, perhaps this
> > requires Connection Parameters Request procedure?
> > https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/C=
ore-62/out/en/low-energy-controller/link-layer-specification.html#UUID-56ad=
a5ed-4ae3-acee-198f-27ead57d86f1
> Yes, this is the feature which is required.
>
> Requiring debugfs for this is also not optimal. Is there any (not already
> obsoleted) command line tool where querying of the LE features could be a=
dded?

Don't think we have anything dedicated for LE Features, but you can
use bluetoothctl> hci.open then hci.cmd <LE Read Local Feature Opcode>
and check via btmon since this is a qualification-specific QoL. I
think this will suffice, as you apparently used btmon for a few other
tests.

> regards,
> Christian
>
> >
> > >
> > >  LE Capability Statement
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > --
> > > 2.51.0
> > >
> > >
> >
> >
> >
>
>
>
>


--=20
Luiz Augusto von Dentz
