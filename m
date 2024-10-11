Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA601C2DB7
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673544; cv=none; b=Eyk3V+kL8dDuSA0/f2Jm49+tp0tpfiGXShvVdRgU3CyA7KMaHHS7HYsyy+8R/hz1PNJdfzyHXfmdADGvyNsksXVYawjkzVKOQ1k1D1JW7K2+9Ry4GmXZb7JlFZwSwzuBlg4O52vhsAfH2HEe7O7wrI/CzkL3wZitdEyTZxxvxPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673544; c=relaxed/simple;
	bh=8YWCVsnSI24UIinoTOk/Sm4LobEh8F7cfDFpZ6xLk24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHXzqpClD9QxLWsj2q3TJoVM/44IJNBqQ9mDh+sYkjI77beVwEfGCKIxjW1PM+ZXZT9bJypDw+c3GPdlVek4M5r1qTFAcfLkfXoW8vZP7AARvQ8X7pse0cNwa2rV2ZP2AuR88LwuwhNFxdwktXcplLz2XpVPT0DDlrassBvXXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqXTjZko; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqXTjZko"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fac275471dso22520071fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728673541; x=1729278341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWlfC4QFS4UdshXEJpxn5DcdyFHehwU8B2wE7Qd96AA=;
        b=NqXTjZkoM7BHBJIORZxkKaTaGkkS2YMYCOWfLjS7JI4pag4uaUyt0DcroxUDQVfrBS
         61FRVMQNnA3ZbK8E9/1k7gRcTQc1B/KS8/f4TUUQEHVn1/TSMigF6tAfw3e0+BGcftOC
         Huw2aPOw29vGPfdgqp3ANE5CTXRVPSTxd85Wc976NX4YMLnxkFpbJDAeB0o94PnTdOes
         UshZvLNPM5C+jdFkwSZsoLw+fJsS8NjknJbsGOiK2lFeuaJ5yUBVo/8tUcxgM1n/1RC7
         cxK99T3GpyrE4QFOO5gnxIEXWpR+13Y8dCGV71cq6utqHy7wnOjRojVURwFQkWkBPHnO
         wNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728673541; x=1729278341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWlfC4QFS4UdshXEJpxn5DcdyFHehwU8B2wE7Qd96AA=;
        b=JomwzMlYE/4zJMiZ/ym/XDY8E3OUVXC5pjTGaGydcAtDUlQjq5ftzOsRPT9VwwVHMr
         cGbqOrlif42gJaU/YSi1ZMHDU8wgdSIGnK7OT68n852PzewxjC2kmUAT+rn8WEE/jlAg
         S8zhlaDV/X+vEVbwg1Nll/ANn8Q47KTwqa2XAJG7UvgnustPuCsIFBrM+uJwtSUeEb0P
         nBWz0n1is1iFzGoKjA8+EkYyblZGx+Gy4z9bKaqS1BHrYN/tS8U08+za9uOYuOVFMsCS
         /bzBfTFoiw7s72fK7L+nh/Wu1iLe8p4P1zhNqdvBUb7uYMkvihhiyYsESAyz5NfynZEo
         KfKA==
X-Forwarded-Encrypted: i=1; AJvYcCW+5Go+Wj0jjoH1GG2tvpwL5PUuKn7pN4PfSy2CqRYnTFZ4+ZR3uzzKxp0agZXTwf7LDVlyK5J2ZdidgLOdxEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA+D/oAIq7tGhrT1vYTTmA1YIiaxCft1DKILEOLkG/o01XNp03
	nDRDuwivnAkFbeLOamhxqBwOJlMslEooU0NvVMgtUK2Jl8+I4XKdFg2G0MB9R5EvIf6wrLxFOKr
	4N5fQIkIuqE63bl9GA7pT/c4FdKI=
X-Google-Smtp-Source: AGHT+IFrwoH4bfl+FpvVQAQmTkH73XXzuwowkTfzPHIeeCgrs1UyNIHEkECt/+19SdV1EK0J5CIs1Tk6kRkxpTCbEj4=
X-Received: by 2002:a2e:a548:0:b0:2ef:2c40:dd67 with SMTP id
 38308e7fff4ca-2fb30da01a0mr14857691fa.3.1728673540331; Fri, 11 Oct 2024
 12:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <595efd8b-e0fe-4a87-90b1-4b579f3cc876@gmail.com>
 <CABBYNZJMWni33VQ2sX9EDcNbsFbX7pjAFj4QLri9N7jyLY0HvQ@mail.gmail.com> <c8b5c842-463e-4c30-b7e0-f41bf1d59305@gmail.com>
In-Reply-To: <c8b5c842-463e-4c30-b7e0-f41bf1d59305@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Oct 2024 15:05:27 -0400
Message-ID: <CABBYNZ+kcwgPvCNFZHZZok_a6ZNXEPNABNefb4iaSNDNm4wPVA@mail.gmail.com>
Subject: Re: Connection issue since 81b3e33bb054 ("Bluetooth: btusb: Don't
 fail external suspend requests")
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	BlueZ development <linux-bluetooth@vger.kernel.org>, Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiner,

On Fri, Oct 11, 2024 at 2:52=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> On 11.10.2024 18:36, Luiz Augusto von Dentz wrote:
> > Hi Heiner,
> >
> > On Fri, Oct 11, 2024 at 6:49=E2=80=AFAM Heiner Kallweit <hkallweit1@gma=
il.com> wrote:
> >>
> >> Since linux-next from Oct 4th my bt speaker fails to connect if I swit=
ch it on.
> >> It just hangs trying. Manually connecting it via bluetoothctl works th=
ough.
> >> With this patch reverted it auto-connects again.
> >> If you need additional details, please let me know.
> >
> > I suspect something is trying to suspend the controller then, it
> > shouldn't be USB auto-suspend since that should behave as it
> > previously but if there is something externally (aka. userspace)
> > trying to suspend then it will force it to suspend.
> >
> On the host side it's a combined WiFi/BT PCIe adapter (RTL8822CE).
> Runtime PM is enabled, so this may kick in. I'm not aware of any
> userspace tool which may try to suspend the WiFi/BT adapter.
> Disabling Runtime PM may be a workaround, but I don't think that's
> the actual solution.
>

Well I assume it still using USB as transport, not PCIe, otherwise it
wouldn't be using btusb. Regarding runtime PM, I assume it still means
PMSG_IS_AUTO Documentation/driver-api/usb/power-management.rst:

     'External suspend calls should never be allowed to fail in this way,
     only autosuspend calls.  The driver can tell them apart by applying
     the :c:func:`PMSG_IS_AUTO` macro to the message argument to the
     ``suspend`` method; it will return True for internal PM events'

--=20
Luiz Augusto von Dentz
