Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359092773DD
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308068; cv=none; b=RGqR0wl0ROR25NdmYsMm+Z4KQRGVFx9ncfRYNQo47awlUqztgdE/5GtpBH+4pAY6gyQrFTnU7JDWvWo/xcoSV3A+TiCcNfnF58irq4s6AX8LmRtbfigJmeERev46nH2pEweQ8VpdrI/DEXjwIOXMe5gYD5jBqYvbOUBvQOpf09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308068; c=relaxed/simple;
	bh=cWonKTDQrBKqJ19ODZDMPbA9DsEimZ1S/nLXhRmk66k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKqdyBePBau31lK5tRzTQBuDoeOZaTWDd7EskFMSbUojDK8XWsmUvM3f+AOgzf+X5JK/zDGysZPTLZRvJbPmvzNNh0w2lYGOMTCZBAWoxn/hG6tpurq6F9zlOdyQEE6HyRKThJr/Akz7sDXfwkCNOIAbOcu5jsFJSkXaEHZhlMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYCDf3LZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYCDf3LZ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47175d02dcso17771a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308066; x=1756912866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDsAVYvBQ/uugRRwPSG7GOyoAuMwi5jqFzobqbedMeI=;
        b=cYCDf3LZ92Z8VBD6sqTMMPaiE7tPXhXPeLLoOtboTbeyM7NGnbZO8Z6czxgv7F9shq
         wrwjswXI6QtCajjqugWsppb7FKSv11ptK9KNDkWphvKBWSdANCv61oOUUpRPlO3JP3GY
         s4GU4J0l5+5fonKkbJQ3h6BrgFMEsE/pD2t8M1vQQS5mwDN44xyTRA07vPpqoDnX7SSX
         0fmAqJAb0UZWMCODUtYfBkMDrdsk7zpih5lez1GyHuSP/F2qczgJa3u/KLkCDLNbgabM
         RW803QIMZMykHbZCG7tVnMLP9inqNvB0bV0ZUsGImyoORT7O+nb8ygIwyCyrU+zkCX6B
         lEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308066; x=1756912866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDsAVYvBQ/uugRRwPSG7GOyoAuMwi5jqFzobqbedMeI=;
        b=JgY/0OaTDC3wPH0o5h5RrNS3uzO+vShahwnTmBbmPQc8VcoAnuQvcpp6WqR9NPMo7g
         AnRmQ/2noqgTv+jEG0cHTyYO36szXx+sP8vXcAgQAasovvmKGlmgSoPT7QvAc76pXMqn
         Ik5G1d4udQPX6Aa+tIcWkxDJg4m8QcObeAJDojZAQqkAnLd8P64g8W5BQQQ7zDa28UZH
         rjJiBxOasDwQq6zJCWsLCgHQYT2zzAp4cwuPsi/WBfkah0CXgt873xjqwQiiJj8g1XXI
         LaDoBg99y02Ui+tlYYfw9/0zaiZTFr/Nlqk2h9tHwsJZv6OUaIiqXsKyd2HVOlnlLGte
         lwBA==
X-Gm-Message-State: AOJu0YzmCtJlKbOydt9Zs63DmHW3dCPByBEgYG2LL+fvhygt/xIztNnA
	Wa7rnV34Wt1wQ0GxtZDMPTe8fTfZ0KRLLWtytK///pC7F0z/6YSq98asYKjtfbvqMsW6NN5fAh3
	F+grQRIa588o3i6wBhMkFQzlh/tQvRE+chY4e
X-Gm-Gg: ASbGnctTZdQ08MC8nPJ5BfcfxM/s+LBHd7DUO8IabxVYZXTf0Dv5Wr3pt2d5oKthR9q
	BXiIryqujCBT0+tIWJtt3Ism8wnzoGlD/nSEpwoDZvkkHfuK6a0R8oEGyRXjMzrshy7IORdY6q5
	w3aRFUgj7IOS+Ce4nRHQPEhVxmsx10tIhInHZ2/bQjK5prGXubP113hxKNiok9kuB2I6u6yG5qT
	EBukOXpwxK6Sa5J9pdNUVNdDgPNpNs0uzmvoph6Ocm6oEZlB/cEw/UY
X-Google-Smtp-Source: AGHT+IH2trhl8EfgLZzPezTlqHDTVUHPhuVGMU3j/hc2+2ZxAZskwbRK2n8E3rVwxs1GfEU5zbcYb3RNv2SU7lJbteE=
X-Received: by 2002:a17:902:ef06:b0:242:9be2:f67a with SMTP id
 d9443c01a7336-2462ee0bec3mr266281675ad.11.1756308066047; Wed, 27 Aug 2025
 08:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLmTCh_mn7w6U31B82cBZsmLaj92dxwfK9PVWZeMqk54Q@mail.gmail.com>
 <20250826170314.352122-1-arkadiusz.bokowy@gmail.com> <CABBYNZJ7kbHJ665-rsKQTfP_U=pfBwAPrGki7JSBpF7+wiXung@mail.gmail.com>
 <CABBYNZKorYK7MKUr1DsipZOUbkNuecW4WpbVKtjyb5ha5EnrSQ@mail.gmail.com> <CAGFh026z9qhAzLOnBUPGojtuO5dH497DppLxiA++-9=odBohbg@mail.gmail.com>
In-Reply-To: <CAGFh026z9qhAzLOnBUPGojtuO5dH497DppLxiA++-9=odBohbg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 27 Aug 2025 11:20:50 -0400
X-Gm-Features: Ac12FXzE2L3MrmgkSJvQXAZ0P7443oxlE01dpqUo0qNRrdxSYNOHbu9b7XKj04E
Message-ID: <CABBYNZ+6OJRi2LTdk7huQ+i3ysFenY0==umR0YFLz=1_WdmAqA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Check for unexpected bytes when
 defragmenting HCI frames
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Wed, Aug 27, 2025 at 11:02=E2=80=AFAM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> > Looks like we are missing:
> >
> > +       /* Barrot Technology Bluetooth devices */
> > +       { USB_DEVICE(0x33fa, 0x0010), .driver_info =3D BTUSB_BARROT },
> > +       { USB_DEVICE(0x33fa, 0x0012), .driver_info =3D BTUSB_BARROT },
> >
> > We can probably add it together in the same patch, so we don't have to
> > rely on Fixes to inform the changes below needs to go together, but
> > then we should include the contents of /sys/kernel/debug/usb/devices
> > before the information why we need the changes to detect extra bytes
> > in order for it to work.
>
> OK, so, should I restore the quirk (so this check is only for Barrot
> devices)? Or add driver_info =3D BARROT without actually using it
> anywhere?

I don't think we need to quirk to acting on the extra bytes, but
perhaps we should leave the driver_info =3D BARROT in case we need some
special handling for it since I suspect it may be needed for setting
up things like firmware download, which in the event the driver is
ever fixed to not sent the extra bytes a new firmware will probably
going to be required.

--=20
Luiz Augusto von Dentz
