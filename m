Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B637721256C
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144871; cv=pass; b=X+8jksRSfDM7vHQ+lKaCRYfY82H7cnaBgvnl9pgeHd2/aPrGFPJJb5Vo7aKKdLtpcAq91EnwsoZALnMaqPrYTqTDrpY+x8CaRIRiPC0b1cEHJ2+4Kqs5z1/ve1K/SuSN1kpHkUOokUFX0RcW4G2kr80EGkG8JGfWmgc8cFT1UJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144871; c=relaxed/simple;
	bh=yrRL2UHayrnPRIMIYAmYlSqghY+Wr5w6FGLp16zkbU0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KlqdRdt+wV9dMsAfrYJi/w8kWehmnX7T9xzdmcV5pIfiYqbXyz0CvEn7/k76Jvl1XT90xsaHWgOPkWuso625yFmszqIL+7knCa650sWpteIl+abtV66UEL63betbLEWjNCx3RFlETRGfgwEDO9yu3M7yt7KOau4nXIuaccDLDpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJAHeZhT; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJAHeZhT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so821316f8f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 06:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787144868; cv=none;
        d=google.com; s=arc-20260327;
        b=n9oswoG38bJxNW3XOFMPb2oro0hgpYd1D3DU8YgFICUjfGTLz+EQmYlbJe1k/nX48U
         mDe1ziraiTQCeAor07df+GS2rU5ph0RqCivpalu/CIMWyNztdDCJUcAGuyv6NReLJeWC
         00Vt2w1Iwej1pqybiUYSzyOB7YJ6FChZEU71JQYthOiE0fjh8RtGscFScggDc9aKTOTC
         H1sMxjmiT1aHvI71Hab8xxt1Y4wg4t9hWwDpIxp2eyfap3HnzDHXgpL3FsHidPaKrm+5
         pxC46XyObVh0G2K7ki1YlQHvCKrDBptgWRtFELKuq+7ftCp25IZR4gKArrZDkuN8DzjS
         voZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HI1U40hbynKBbof+rOaONlG/R3s/eWpg5bJ4GpEZzYA=;
        fh=T25WepgC057fh+HVfM8Pu5opYl2DUIUufO+dgki4HBg=;
        b=a9Sx7z3F5OXb2v+b4AvrLiZLxdMTOcxP/3ZafoFhZxc1simXP2zHZq14x5NuqVPM+j
         WEDcJ5FTYoUW3VDk1F+rQGTvpbZXLGneh2F7fUYb2ZcKqkWkUTCuPwPTsVP53N9LE0hT
         WTIlTLWB06yJYdT5UjySux3TfIkjR8Lc59310hBmCm4uGcgZSyClS4XgT4L/NyVi4ZTc
         a8pCX0nIvDIT+iWV5qz8bUey/KtnBMzBxjp/iiMl6+/m6IdyYPXoHHLSi/i8Th/34EPh
         2/SKJCWaIO8UwZ5/KoO3610j4pGTkx3YoQrhaPtPxSFxSxK81/+pmjtbdhcMB2uD/nNY
         e0Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787144868; x=1787749668; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HI1U40hbynKBbof+rOaONlG/R3s/eWpg5bJ4GpEZzYA=;
        b=FJAHeZhTRZNQP3X3mTD0naCckYznt2ShKhl0JFP7aiepZZZ2Z09NABuKlLEJPe7Rtu
         u2VY4zMDm2Ahvm6tkkAwcCTJVzTm7wtqtI1zqfJD7UgMziqA3ZxiTUQG/S9rv17Y/0MS
         i8wcVyj4wsx0uDjdgaHWM/vq/gcdpWK/gdzIdt3210XIaaxDJE9fXXN2F0LvvI2j9IIP
         OHqaI34Tt92Brwh/59/b/3yHwLbr2/LHw6dEHxGlpE1gW90UyGkfTqpV+V7kG63HOe41
         jyy16bh9uwidxMtolAlGrAOpY5IHzpF8fG9XL0I67R2M/o9aF+jlAU42f29GzHyv9k1U
         hIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144868; x=1787749668;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HI1U40hbynKBbof+rOaONlG/R3s/eWpg5bJ4GpEZzYA=;
        b=G/MtlRm0lZWx1lUG5X9yI0OzrA1UGHP8NOW/sxS5LukVaZR+o3fsXSL16iUEcLADPi
         Es2+LKDqQDi0xy+jhYD5esiP3kzsqGLIUzwbgm2ONjQuMxET8Sxw6JzbotFQmw19r5pe
         pVWunC0z3x5UYpN1NXFTJi/AEnvqGxP/PEH3grjnm/CGqLHPi3F1zBXLcVePlQZfc7Y+
         kv1GwXq7xP89sgfsqgZIMafmrtGYBDOvj7UZWc/BNJrolA2L5543GMMsGGEkvY3a+0Sn
         n5PMI/ueFruQzfWy7xGJWitC4XB7ymxm1i1OpWi8ENS2nYVsrTz9xZPk/JzCbQdfeJlr
         /Fng==
X-Gm-Message-State: AFuF++kgcXs2k4m6TdAi39GDhSaD+zqBwSJ4Eu/QvRSQO24bTLe/Wyl2
	9Ekw/OFZzgzG/DwIBIfSDpSdsrFxhVOfCGV2l2LlfmbFegbNxtrJvuCAH2sPWtds1Jh16Y4XSue
	T08Fc2hUZ2BgkjrmVJotkkx1ZtC4JlV4=
X-Gm-Gg: AR+sD13/kOOL9TTOOC2BzY2hztMmd++YBvs6nBIZszrhrJlU+8YYJ4sV1S2D2+R4cOB
	8wUtbN+xNZ+F7Za63Jupfkif/LntE7hxpyTGEZYWjigshwW2r1/+GrYi401rKLQ0/roa3W8OW+K
	ue8dX1bMSyhArB63uhuOPmcAAAL0VuxHPW3lJYv83nxkqBW8/Bs0zpwE3XUU1Hv7o9VmmacsDi3
	ug3/VNflNI5GsnIbfEf2iAjinRLsLfSk94P4op2WazzzSWdeSt/b616CVQ84JW+5DId5a2b+iC6
	NijPUoUma3b+RAl9pxlCg0kSVU14E5oAtzZZD3YeSsHKN8M=
X-Received: by 2002:a05:6000:2408:b0:47f:c648:e280 with SMTP id
 ffacd0b85a97d-482b1feb2bcmr7454618f8f.18.1787144867569; Wed, 19 Aug 2026
 06:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Blc Dragon <fenix78563@gmail.com>
Date: Wed, 19 Aug 2026 18:07:36 +0500
X-Gm-Features: AcwNN1WKpi82lUqWHO1PaLeI-jk-1yWRBBT0UMt3fzu_OkU1ueK17Z4x7Xoi2uQ
Message-ID: <CAP9emj0q4_GmZZ0-CL6fg=Mxd8FcXkj4LSwEfBhRn6jAgdeJ1Q@mail.gmail.com>
Subject: Re: rtl_bt: RTL8852BU rom_version 3 has no matching in rtl8852bu_fw.bin
To: hildawu@realtek.com
Cc: linux-bluetooth@vger.kernel.org, denizgu@protonmail.ch, pkshih@realtek.com, 
	timlee@realtek.com, kevin_yang@realtek.com, max.chou@realtek.com, 
	alex_lu@realsil.com.cn
Content-Type: text/plain; charset="UTF-8"

Hi Hilda,

I can confirm the exact same issue on my hardware, and I'd be glad to
take you up on the offer to test a pre-release firmware binary.

  Machine        : Lenovo IdeaPad
  BT controller  : 0bda:b853 (Realtek, USB), rom_version = 3
  Wi-Fi (same M.2): RTL8852BE, rtw89_8852be - works fine
  Driver         : btusb + btrtl
  linux-firmware : 20260622 (Fedora)
  Kernel         : 7.1.x

Same symptom as Deniz's report: rtl8852bu_fw.bin only carries eco 1/2,
the controller needs eco 4, so no patch is applied, BD_ADDR stays
00:00:00:00:00:00 and no controller is registered.

If you can share a candidate rtl8852bu_fw.bin with the eco 4 patch, I'll
install it and report back with dmesg / btmon and confirmation that the
controller enumerates and pairs. Happy to test as many revisions as
needed.

Thanks a lot for the quick turnaround and the fix!

Best regards,
Pavel
