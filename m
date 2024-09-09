Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065334963A
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897888; cv=none; b=TqfC9Tqdoq3+urmIUDx5pkbw/pjiwNHYnCfK2pop84vOzOFHe8VPDWaIE2cTPBetLgYOF0JPwikXdG9pPXjy673CBGWBE9hmENvqIG4jggswjCgDKTXyyH+tFTUe0mehtC1QLhYsmPKNtlFUR8EmUpZgkSAH8L7u32XX0ql58g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897888; c=relaxed/simple;
	bh=JqL1/7Td72Srd7LxcZJiL3JCDuD9txPZqOvSjenrlDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqOhLu23yxJiI4UXFUcQtDZjOTv2KRhbPF3Ru2MLpCD669A0BNEb2lWN3dI4D3K6sC/ydD4SHNnGxyyHY7nwo8bph7Ytc44H4rDL5OHEoPJL/DrqM3iZRj6Ww49n1S1PpnUqR0YpCyhLXLKObJhtSO0EI7Sf7YKjDPPdBul6Pow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mq6VOHZI; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq6VOHZI"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c3552ce7faso41557646d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Sep 2024 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725897886; x=1726502686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btKJk13jXBWyWhKQ531pvWuMpWIaX7KQzB3/Z93VCPQ=;
        b=mq6VOHZIAXdkdAO36maMhlGNcHroahyPcevnD0tJVE75PdLxMRQ0PVmMKx0mr2xyix
         E2jTbTtSb/y7XtlZc5nReJkqtQSoHV0S9HRJWrijk/ixL1bdIdyL3WAhHBKAkXKWaHd+
         /P6uuK5SrCWlJ6w3xRTE4ChCpOTqgHF7ADxc49lLr29oV8FVtGg7Ehc9cFU44pUPbjr7
         Rj/aOzWxsR7nSxdkJDgTCQQqbvSEtpwZv63N+6UunPCZK7YUmwp63YJ7KJhyT6E/0elk
         INGsISRYdCoz/1LaObYs3/6hUwPFHBdP/68K//hq/pmbuTXoLBrtpDdSk+x4yogxozem
         Dung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725897886; x=1726502686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btKJk13jXBWyWhKQ531pvWuMpWIaX7KQzB3/Z93VCPQ=;
        b=eRupI3o0KIX1G9aNodlD9No2m7jYC4DrjXQG1I5HEHsrSWV9IPB4QacWfDFHBg9j7q
         eMp6Z9wKdslfxMHV4xxTJbimisYw2qSuEGDRzcAd7KLmROtY9Wc/z3L8VAGBoxX4lqxh
         qCDAZS+FYJif0csXUZTRwxX6raXoD6567nYTqb1ernNV37193Nqo7cgrwryg1pydfCRp
         amQxQoh4VoFHITpxpIFM9sEmKw1Wt57Z/LER+5DYOXlLOfPIq3gn9VVVS28rgfzrvk4w
         mTB8wrIrw1Pv2G08XA+yzQ6klB/eedpxpYDjHKGIguazoMXCJQX0hb4U8+NTMw8aHTjl
         5l7g==
X-Gm-Message-State: AOJu0YzN0UpmgtPSWF0BPGRZNltao1iq4udsJ/+Yw+RX6SuPkF+xQiK4
	jY1/HmlmPPLijFi789F2lujrKjPhBPOxIO7GTrJHbkAiIuGwfD2iHAv/en46PCy5I2GUtwPLlK2
	QXmY0QfuihrGDzg+HP6mn9/Jvr5rc0OIE
X-Google-Smtp-Source: AGHT+IGgKsHlOSb739/S3mY+Sq/r9S+1+4Q99eEc0CCNrOqFLHer4567OdjiWxE7KjxJWFLbzQHA863RSAlyORbPlew=
X-Received: by 2002:a05:6214:5d0f:b0:6c5:50c1:befc with SMTP id
 6a1803df08f44-6c554d69bd8mr1178686d6.20.1725897885761; Mon, 09 Sep 2024
 09:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907213301.14000-1-vibhavp@gmail.com> <20240907213301.14000-2-vibhavp@gmail.com>
 <CABBYNZ+sskbvtEb2CMyGU3_yYJAe4e4Cmh+vrvKj4U9+7872mA@mail.gmail.com>
In-Reply-To: <CABBYNZ+sskbvtEb2CMyGU3_yYJAe4e4Cmh+vrvKj4U9+7872mA@mail.gmail.com>
From: Vibhav Pant <vibhavp@gmail.com>
Date: Mon, 9 Sep 2024 21:34:34 +0530
Message-ID: <CA+T2Sh0DG_qpWMNpNmwcr+6v-0qZcaOnY+7s8Kk4n0O8QVyp7Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] device: Add method GetServiceRecords
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, Sep 9, 2024 at 8:47=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Is this the best format though? I'm afraid this would require an upper
> level to implement SDP record parsing as well or is that what Windows
> exposes as well?

Yes, the service discovery related interfaces on Windows return a raw
SDP byte stream, which the user is expected to further parse with
methods like BluetoothSdpEnumAttributes[1]. That being said, my
primary motivation for returning the raw SDP data was to also
discourage other applications from using this instead of the Profile
API.
Essentially, the Windows kernel and usermode Bluetooth APIs let you
make SDP queries to Bluetooth devices (including service and service +
attribute queries). From my understanding, exposing raw SDP is an
antipattern in BlueZ that was discarded with BlueZ 5, so I did not
want to re-introduce the entire concept again over DBus. Instead, the
current design of the Wine bluetooth driver is to rely on the cached
records stored by BlueZ, and perform any and all queries by searching
through them.
The other option was to rely on sdp_lib.h, but having two SDP local
servers (is it a local server if it's only being used for device
queries?) for every machine sounds like a recipe for eventual
breakage, and letting BlueZ be the authoritative source of truth for
device-related information is a common pattern in Wine.

[1]: https://learn.microsoft.com/en-us/windows/win32/api/bluetoothapis/nf-b=
luetoothapis-bluetoothsdpenumattributes

--=20
Vibhav Pant
vibhavp@gmail.com
GPG: 7ED1 D48C 513C A024 BE3A  785F E3FB 28CB 6AB5 9598
