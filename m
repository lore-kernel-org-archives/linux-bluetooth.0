Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75A346773
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750392; cv=pass; b=uiHkEEBUzNVgkaGk4QLlrOn4iAwRL7aDJb97MP9vrvsgfpuUn9jSZ2tP8aSmoaFXKJssPE/QqWvnBbjauvttVugrV48lANqQK2Pdmgfs9W7tGSXs565bkeT7KwsOffwt+FVoaCn+BKSKRgkCziKEnfDDCe/w5QNquw7mppGNv6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750392; c=relaxed/simple;
	bh=LF64hiw8nvzetfkmvDjLaiOYdDbWIJxidOFpAcXxUzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKm4Y1OJpyVMAjgE8ufez4wqz5Xj05EGc1I/lWSBamMZEVHTa3+xxcLZb3GtjMQgzOjJyM80z4eLJhOyPF1aBI3Gf6bWBq8bUItEQwDkkMW+ym38b1cg1DLuoPHi5H1UComq2xhb+15p/LsDvszZeZkGeMf+cGlckE2OKlC72Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLPtxlz7; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLPtxlz7"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64cb577e79cso9115536d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2026 14:39:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772750390; cv=none;
        d=google.com; s=arc-20240605;
        b=FaxQMyx/Zkmwu2hSlIqj1uMn0ZScWHc8jBkEXjzNPIkVuNhu0NKmej3WG1eGgyY7v2
         IzFC0m4Rzff0aonOoSHqYj+nzb+UxeYhrfbPQplBK/E9OMNRzw3vvAoprHMcC2YuHePy
         RbJYN16dZe15Rzlye1kVJT1ZHLQmatM2Qmi5MeuxVK1Tk5H8m3BdtGiggu5Wdkj3ojCh
         kwefnvSBnzW/p14wrxj7S6uRuI+okTjsOW9HhzYVa+7yOXYPm4UVu2CL4PXzQoE2TI4b
         3le5eQuCkUToaq/pdJ09btDKfxKY/KXMBJRwzlOZqUtfn7fjgf4Mg8MAPLLLJI1i45mD
         iXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cmr4GnR1fHF3eO0tyZFqgDANvXNSuiRs+dGq3h1gFsA=;
        fh=rm4UsBpQoFRUVxuhLKOQAdsxvo9NL1j3b7EyLouuwgY=;
        b=K1MvE4+UtKeC5yKTrXLRKroQWn5yRbrXICJe4fEzAj+56kq5g2oksftYTHP4QcVrOJ
         Yqqp+Np1tlYa1eeKE/7Vr6cUYYV6VUZYCMZEmAEXrhXtq9FL/pbywO2LE9CzbftSPtNJ
         kpv8+pn/6j6Xyg9K4APJfSPsbYRHPnu5PQhluFnpdVo5H+RTPuZ/XThifOmMdeudD0oZ
         Rr6dY46U4a5soBI083mCc5ZCjNRlTZaK+fN4KtX04jM3a5aDSX/8l0emykpcA1gkNH0K
         +tagiW7WTnUM1h4luGQOesLuENDsTqo0/UAd/h1OOtFmoxJHS82EhUzpwvVc7Fs6VFuk
         ELuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772750390; x=1773355190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cmr4GnR1fHF3eO0tyZFqgDANvXNSuiRs+dGq3h1gFsA=;
        b=FLPtxlz7ADBf8TpOfPHMsiPU9gnkCEqgkjpB6VdKxixMyXBy2P0tXciwSO3sTrk5xn
         LT9RM5r1CNl/yI4apOhPf9NsdGnmqXWYV0tzVsjCtaIIEJPW4LVcHG3n7buVkzye8wFB
         1knKWX1wC0pqqtWEG3tNVFtsB2Numqlw1fl8rokX603gHVnIBbZsyM504D4jFh+dhcK5
         FbzYOYOTAnw0NVhoPsaUUr+6l1swJ/rgR3iNy89KfeM4hsB8y8aI1VXNsAwVCBV82e1Y
         qZKh52cqrdM2BFgUVWNdzcslH5x3fpIeObKlU4zprMrEjifN60wmQwaajKp6qiRFoP4h
         LZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772750390; x=1773355190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cmr4GnR1fHF3eO0tyZFqgDANvXNSuiRs+dGq3h1gFsA=;
        b=X4pYMftoGGOulFmf3lOq8PzVxHD9V70bH4hmgwPDsC6GaZMpU3x7kDIVa7DKhX0Gfq
         ZNfATGaD4uPGrXknSek0Sa0zJM9yL4YGX5q3xvBZSAxNougZfRtQkfhmmDt3DX2CAb8M
         TNtFM+sko7g1d6iPnHNJ5ll87gRV/i5kL0CFFlI6+e+dS1QkVZKUmdO+yVwuzPwhVNhr
         /IDsNTIP37LsPPum8mX4JfO27q6fMT7WmKZi/qwQ+sIrQcv2ELNXZdv/C0o+72zh5XXI
         rEg7tvm/he70H4Nhf1hvjMzVd/LjHZHSElji53xG5XHROxeH/EUNbuulE7bHRUvIGTEr
         KIEg==
X-Gm-Message-State: AOJu0YxnLjcDxMmn23sA2Ka6UdJnWAL/Es9wAmfQNRFp08ujUvsk7Gaz
	zhkEocZITcNctmw5Scmy4G9RYKYHhMUu177kKOs1hxZh3te9hIIyQX883FOK4GSltOHsKjebTr0
	01wnzIC4/jlQK4oeV32rp8bxZiI6EdpQbNA==
X-Gm-Gg: ATEYQzyiBaepkgv/rPdDb7239c4YNWPxzcQ9m1OkDGNo8oUTr0ENbzjAK3OzgzR4GZe
	fiPKAJ6+gN6zKfH43x5SSWeV1RKGxgebwxk7dINXzZaIFOLwacpf1jYZmWxzDMJXeL6kx6XlcF3
	dqyCM4Qlp4TbMzdqpa8UxV3codMccwFWAF0mbQv0HnwB/eBf5Nf1I5ivOslz5/3b1EMa2fSfTtd
	0PGwdHxATYX+BHLNvwgYVzfTcpYQLUKZIcalOe8dTHl9u8vd/YW1OmlMLOqV4UWn+zyM5Z6R/H4
	jwYZ0ZPIDMQRkSckX4afT8AWirLGhrA6oGKH8PbCfMVb7l7e6h676DRHrB64ygOBuGTSzg==
X-Received: by 2002:a05:690c:74c1:b0:796:4235:ea1c with SMTP id
 00721157ae682-798c6cc7f3bmr62850177b3.40.1772750389877; Thu, 05 Mar 2026
 14:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305172813.12F6E1EA006C@mailuser.phl.internal>
In-Reply-To: <20260305172813.12F6E1EA006C@mailuser.phl.internal>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 5 Mar 2026 17:39:38 -0500
X-Gm-Features: AaiRm50E3bB9KSUlluw_y3XtWeAPvZDVrkrQdTbfo1l2RytBn-CIaOoOLd50MQc
Message-ID: <CABBYNZ+PTk5+Dq5p+kHQdmqQshsC1kOzuqqmJtZyF5XAJzLzmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: btusb: Add USB device IDs for MediaTek
 MT7927 (MT6639)
To: Javier Tia <floss@jetm.me>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Thu, Mar 5, 2026 at 12:28=E2=80=AFPM Javier Tia <floss@jetm.me> wrote:
>
> Hi Luiz,
>
> On Thu, Mar 5, 2026 Luiz Augusto von Dentz wrote:
> > Is the lsusb information for these devices present in the links? We
> > normally require that to confirm these ID's are real/valid.
>
> Yes. Here is lsusb -v from my ASUS ROG Crosshair X870E Hero
> (0489:e13a):
>
>   Bus 001 Device 005: ID 0489:e13a Foxconn / Hon Hai Wireless_Device
>   Device Descriptor:
>     idVendor           0x0489 Foxconn / Hon Hai
>     idProduct          0xe13a Wireless_Device
>     iManufacturer           5 MediaTek Inc.
>     iProduct                6 Wireless_Device
>     Interface Association:
>       bFunctionClass        224 Wireless
>       bFunctionSubClass       1 Radio Frequency
>       bFunctionProtocol       1 Bluetooth
>
> The other four USB IDs have been confirmed by users on their hardware
> with lsusb output in the tracking issue and bugzilla:
>
>   0489:e0fa - Lenovo Legion Pro 7 (kerberos272)
>   0489:e10f - Gigabyte Z790 AORUS MASTER X (Thex-Thex)
>   0489:e116 - TP-Link Archer TBE550E (marcin-fm)
>   13d3:3588 - ASUS ProArt X870E-Creator (samutoljamo)

Let's gather their emails and list them as Tested-by, or perhaps we it
should really be multiple changes to make easier to trace back how it
was tested.

> Each is documented in the GitHub tracking issue [1] and the upstream
> bugzilla [2] with lsusb and dmesg output.
>
> > Ok, this is especially valid if AI assisted, otherwise we would
> > probably need to ensure the agent has access to every board to list
> > its IDs, etc.
> >
> > Regarding the use of AI, there doesn't seem to be a global policy.
> > However, for Bluetooth Im not inclined to accept any patches that
> > hasn't been properly reviewed by the author
>
> Understood. To be clear: I wrote and reviewed these patches myself.
> Claude Code was used as a coding assistant (editor-level help, similar
> to copilot), not as an autonomous agent. The Assisted-by trailer
> follows the kernel coding-assistants policy from Documentation/
> process/coding-assistants.rst.
>
> I tested the patches on my own hardware (ASUS ROG Crosshair X870E
> Hero, BT 0489:e13a, Arch Linux kernel 6.19.6). The USB IDs come from
> real hardware reports by real users, not generated by AI. The patches
> have been running as a DKMS out-of-tree module [1] since January 2026
> across Arch, Ubuntu, Fedora, NixOS, and openSUSE.

Ok, so Id probably require 'Tested-by' to be a human, and in this
case, I want the lsusb and dmesg | grep bluetooth either directly in
the commit message or as a Link so it can be verified.

> Your feedback is being read and responded to by me personally.
>
> [1] https://github.com/jetm/mediatek-mt7927-dkms
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D221096
>
> Javier



--=20
Luiz Augusto von Dentz
