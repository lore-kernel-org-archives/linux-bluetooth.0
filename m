Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566724;
	b=4MFZrC8YhSwuhTAksQIylXoDyCIOY1HU6teMj9cn+56J/P+waUVBBVYzY2cc3wCK7dlW
	 Cy982vkG+gd4hvcJ5u6PH36dgLZgmf16uDAZwFAAklfg8aA9+veDh2rInpGEFHTNEpqbM
	 6dJtb8JtD+l+0zfaqllv81PDJsAABlQSzt3xxpBMnkvm2Ol3RiGmm/utzJUUMrRznItdy
	 RegQR6k4RGPk3Ly0+S7favgktjIi5kFoTi7ZEyO8hyQY2HyN0PwsDNn+3vkdZ9SbdW2hG
	 FrwbrMk/E42nW+mrdJIPkUAWULYdzl+n/9CJnvEjyyP9XRUv0jmdkWLEDm7gb6/Ek6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pkYp+7Cerae/4hvPBPVJ47A8aQzxR1pyx/G6X3uTZ2Y=;
	b=T5whxwFuM8Yvq3V9J1defX5nwWarneW3wVjlTsaCx/CLaEQd62ue8bUyM3R7Q2ongPro
	 ea0eiGlgQadcUCzF+Nh9HySqMinOAs3G6u+ALscuvGNJLQvaJq03jkZ0CW3dwtF1PurQ6
	 acTFR5BOY+y/w+HoX5svThFjpYf2iXHOmp7a2g7qR35zhvghC1Nkwy5zq+CtPhNEb9Pzh
	 SdSnT+09L6wTREgHjRKWyT8SzKBK82xRLa+Ks3x0CuusQGlvQeSRjaAnZK+ro+HohkD3+
	 3aTCyxqIS8RxX6HjMdchRTj8tJLc79aK++psqoh6qWBGsew1vboL09JXgG6IAdrFzfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k9TOnKRo;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC6606A31A
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 07:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFEC6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k9TOnKRo
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1e266fca2so2054935e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 00:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566722; x=1793171522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pkYp+7Cerae/4hvPBPVJ47A8aQzxR1pyx/G6X3uTZ2Y=;
        b=k9TOnKRotyfftAmySX+0K1yDgnJoy6a4j8JOtnNAIIEDzdcheZm+L4r0XCDEfLspQb
         VdWXHhAnzSONR63hbfoIYP4MafkzgyKp9UfPqymp040SF4q4my6b2XQoMbckMjn05g31
         rlDbR5NTFv6aqqGwtuBXDkdWGGh9XPdHd2J1rlCEzwoHduM0p654CQ+FdMiDngWau1ij
         4WlSI1i/Rd+2rtTE7dmvIEal4v4DgQTUWMAbBXP5+JVQHCCxLcGr+A4hydd+v1uhCoGz
         GNm8M0N/jM7lNz7mvmfo7F8umep5aVVpmt0GNBVnzk1bBeKNZycBL/QTffO7wt4UApsh
         IaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566722; x=1793171522;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pkYp+7Cerae/4hvPBPVJ47A8aQzxR1pyx/G6X3uTZ2Y=;
        b=KvmWC9MeG6WF0X5VJgwYrPYKvK92msJimKfrmlPln4Q7s5kciJ4vQKyuhCnDHw7wzx
         c/KjOcuz3BOcaKGwuTWh1ia7uMyeMPj3fXTNbyiXzopysFI3hlKb69XlBHsSTvIh1jUN
         Oh/QlcQmYDyCSTMp86dZ5sB7X9vMJHOfSPm02AXO/Vk4DTM4SIvqcvthBSUuuXLTEyyr
         ZGR9erDXcCKc4Ur1TQX1buaww3oGzVF0D5qV0eN9lbX0wJBkNdhNhZbDRJ16+5sbQmGl
         +zHrQ+4yEm8zpD+hCcBjQp9o+mjwo7WQwEz71cgzpq1nlUpShrUvOX2XA7338wWTQE0H
         LfGg==
X-Forwarded-Encrypted: i=1; AKwUvBwWcIM1WnkLAMMkDATsgL7dxAjng7OMo3T+BHkf3l5ZSUcaW1C7+iwmpkusrUhAAmF0JsMMZNF3+cqv2+7hNdU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJO0KiiChsB+0utv9e4SqVTL5nUBHyGw8lna4GObEzKQv/kVQkC
	cC79rQ9CIRrOEmbmrykXOlMkLqChLXCdmPqH8UDc95sQdUsbgL9QYw9k
X-Gm-Gg: AYBFou0xKEmiH0zzhuXroQDt//8hsJJVM3UKtYLzinzOtXnpUAmWGNWC+isIyE2vafu
	zeNTTl7ZLdOkLsfsG0jSIE+7OpCv+bsWiRz1ka8fXTXZ/n0YDz4BkfZasC5R7lFS9bDgj74mZY1
	QmC5UgYoTA1a/aEsAysa0x4ipynF3gjnv6ie2ozdQ7Z6zpe10uIQNyKTwI2768aCUW0T6S4J0YC
	1Suvzc/VB8ly+RvvPAs76096bRKfysqZsBcwkKWmt26cHQSBEYNbM53vJFiIqZu9qMwu7dAs0ni
	zFCClnV+l+KQUVWqVJykNXzyUJDwU6dF3Bosj6+d2RSdNTRThH6QVLt7xRS3Vfnt2PoBDKm/P6u
	omma1FNviSk4HjTetFS/6nr185oSV2Z5h6FSSnqYMeRbgXn3scMQrN6iq51b+1D4Ks0kZ+ofXkX
	9wFtgloh6MfCXK88x+aI95CVNypZQHThK/6I6Ju1BenkLeDvV2PlF1XJuhu0fyF6pKef3/RyX1X
	cCulYL0FB5BB/Nocobtx+mA3kY4IgoKVfmPKHiTdhSf5KqUSQt4ylxJ/i6zCAqKAMA=
X-Received: by 2002:a05:600c:6995:b0:4a1:e08e:46b5 with SMTP id 5b1f17b1804b1-4a1fdd245c7mr18888085e9.16.1792566721874;
        Wed, 21 Oct 2026 00:12:01 -0700 (PDT)
Received: from foxbook (bfd231.neoplus.adsl.tpnet.pl. [83.28.41.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f093asm3872395f8f.4.2026.10.21.00.12.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Oct 2026 00:12:01 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:11:55 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Nahuel Clotet <nahuelclotet@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 mathias.nyman@linux.intel.com
Subject: Re: [REGRESSION] v7.2: btusb SCO (HFP mic) broken on AMD Raven xHCI
 + Intel 9260, works on v7.1
Message-ID: <20261021091155.733a122c.michal.pecio@gmail.com>
In-Reply-To: <CAJD1503U2GDcbWma3Y4EGjBztADi-EO2ZGk6Ux0cDpWvYCwLoQ@mail.gmail.com>
References: <CAJD1503U2GDcbWma3Y4EGjBztADi-EO2ZGk6Ux0cDpWvYCwLoQ@mail.gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 02:17:04 -0300, Nahuel Clotet wrote:
> Hi,
> 
> Bluetooth HFP microphone audio stopped working in v7.2. v7.1 is fine.
>
> Hardware:
> 
>    - Lenovo ThinkPad T495, AMD Ryzen 5 3500U
>    - xHCI: AMD Raven USB 3.1 [1022:15e1] (06:00.4), BT on usb4 port 1
>      (full speed)
>    - BT: Intel Wireless-AC 9260 [8087:0025], fw intel/ibt-18-16-1.sfi
>      (201-12.24), linux-firmware 20260916
>    - Headset: Anker soundcore P30i, HFP with mSBC (also tested CVSD)
>    - Userspace: BlueZ 5.87, PipeWire 1.6.9, WirePlumber 0.5.18
>      (identical across all kernels)
> 
> Test: switch the card to headset-head-unit and record 6 s from the
> bluez_input source (pw-record, 16 kHz mono), then check the samples
> and the kernel log.
> 
> 
> *Results*:
> 
>    - 6.18.55 (CachyOS LTS): OK, real audio (rms ~1500), no SCO errors
>    - 7.1.11-arch1: OK, real audio (rms ~200), no SCO errors
>    - 7.2.11-arch1 (vanilla): BROKEN, all-zero samples, nothing in the
>    kernel log
>    - 7.2.9 (CachyOS): BROKEN, dmesg floods with "Bluetooth: hci0: corrupted
>    SCO packet" and "SCO packet for unknown connection handle 257", PipeWire
>    reports "Failure in Bluetooth audio transport"

Hi,

For the record, did you try downgrading to 6.x or 7.1 *after* finding
that 7.2 doesn't work?

Not sure where the difference between 7.2.9 and 7.2.11 comes from,
there are no xhci-hcd changes and only one btusb quirk. But there
are changes to net/bluetooth, so maybe there.

> btusb's isoc path (btusb_recv_isoc, btusb_isoc_complete,
> btusb_submit_isoc_urb, __fill_isoc_descriptor, __set_isoc_interface) is
> unchanged between v7.1 and v7.2, and btusb submits SCO URBs with
> URB_ISO_ASAP. The isoc-related xHCI changes in v7.1..v7.2 are:
> 
> d20405dcdf usb: xhci: Remove skip_isoc_td() 298ff13271 usb: xhci: Remove
> isochronous URB_SHORT_NOT_OK handling e765ab012f usb: xhci: Improve Soft
> Retries after short transfers
> 
> I have not bisected yet, so these are suspects, not a confirmed culprit.
> I'm happy to test patches or reverts on this machine.

You could start with testing this commit, which includes all those you
listed above and other USB changes that went into 7.2-rc1. If it fails,
bisection will be trivial. If it works, the bug may not be in USB.

1c2b66a7d725 ("usb: ucsi: huawei_gaokun: support mode switching")

Regards,
Michal
