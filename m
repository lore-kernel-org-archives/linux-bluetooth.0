Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DF11712
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750348150; cv=none; b=jj8o7+kaq1NjfUKFJcWxFmD+iik07OxDfcRdQcFnHxqBZB8TcozmI/ByVe4wEzhQT/qmN6rfbVR9hNCnuzdvLTcpQCHepRSgtnQrlsF+zM86XHdyETlLAMrgmK67mk3kHBjv7QySc1hEJyWFrqQ1LaJYyNdOCeS++Zj+uff+If4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750348150; c=relaxed/simple;
	bh=ZEhWqIWGxai6v59GfWJRe00FgpC70IEs6KONcSbrMZ4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AOMRmEJ2PdzffBSAJ3etZebHWV367BLm0HFB1+///hfr0HCsxzJvPBo8PtvEXlcNXnCb4CDZP4Eq/9L7PinVnDcMh/qh68dGZ2cU4gSWTeR//JpFNwOwa7/9qK88RTOt/QtfduBcUoBgzSEEMOy82v8rF4sGqxliNO4jF2mcDsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5Rc9Fse; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5Rc9Fse"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747fc7506d4so669273b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750348148; x=1750952948; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=50USjAqtrsqsNK212VJnDycCptwvJhA2gsjUsclFaLI=;
        b=B5Rc9FsezvLE3ss97q/7Jld37UC9pkRwa04l7SAHG8Skh9OK4Ef9CigEy9/ucMGO2U
         2/OaeDlc1T3kXN51uwxrWxwsZnFosUXi5+DGcp7zkmnKR5a2xrIrod+epd131TLOkorN
         6+JxcnAPplEarG1te8B4Ckl5wiSS465yoEo3ra2Bk/XCJ8HpZ6ZeeiEIRySPQZE1nC2k
         H7k1Vly5SxV7QtnA9w0OwPfv5/JsyY4I5BCG2TmJsl6JWOtged35RjxCoBbUGYWG2KIX
         jQGozJfS0w5PJ+WLU96runDRWpqhaRSnraDpqVBHQZsfHKvSzP8VITizUTJ6+8RJDZhs
         CMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750348148; x=1750952948;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50USjAqtrsqsNK212VJnDycCptwvJhA2gsjUsclFaLI=;
        b=mXrTbTM0Z3uybK2fj954ctlKJm0ImbIA+6cVOyj67O6neD8nU2L9IX9LywhLpd+Ghj
         NhuMjKEagy9v/Fy+g3J434VLxy8WMDIBHpxrWB+gsDdxBGnbfWZ3cA44ZVkHuTDBXhCC
         B8DNdg+yOaMkry/tfphvl3egW1ZxOO+7bU9Ga6hmKtTSaBxli3Mm4OefqmWJ7av0+z7y
         rTZCdV696guEIz+M85Iw9jOwVYBzt9bLPlTBrRLRB8oVP6Fs8aVd9A7O3dArT0SFH3KU
         IoJZc8jobYrvpmbJvxbGHXtbM5JZ0u6RBelxG5ppnGBpFeIq+mKXHtrBKlpNUt2noUsn
         Hccw==
X-Gm-Message-State: AOJu0Yw3u0s3uVdX2BwrTlT6Rovw/dh/dMb1cspu48mzVaMRhGKXA46h
	AZ6b+sl6LvIbqek5KZGdfL/BmVrhsyuikY0JHr3n9jvYAMPm6vMKiMERVY1HMA==
X-Gm-Gg: ASbGnct+qBDu1kVPwmu05JBjWMz38zy0r4VARBW5mt2uhvgfetWy/7/xp81X+N7XJiu
	FdFP0PZDpC/+TbCn1Kv3PelWzlFwOWjBxSnF3Q3y0U/i12thlQPINbdoBPCZQf2fFq8o+EHElDW
	u2USSXf2GqF4Fmc3zIhC2wMWFqsnrAx92t0w3tQ36GhcwRINOsX2MzIPz+oyg+XVaxJYOXLytKU
	pNgSKCDSEG3LUTpm+z0sKnvFykufRLJ4w/9S/hDLIHzH6cvbV2+I3yNizVwKj2fHsK1WvB+wIhN
	6MOL6i8H3Q/eFn7Y+/dEBErzoF7opGhQGiOjRW4aNQ1uqqVdWAnb3qyGsq2INRSt+0A=
X-Google-Smtp-Source: AGHT+IFbmunkbKrW1ZIJfeUz8z7wtG3OUly839pjXFIdR/XG5wcXTgGQUX5LOdJFOoFRQqMFTzjY/w==
X-Received: by 2002:a05:6a21:4a4a:b0:21d:375a:ee33 with SMTP id adf61e73a8af0-21fbd559171mr32450741637.9.1750348148357;
        Thu, 19 Jun 2025 08:49:08 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.80.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1639f97sm11213822a12.6.2025.06.19.08.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 08:49:07 -0700 (PDT)
Message-ID: <68543173.050a0220.6f0b6.0b49@mx.google.com>
Date: Thu, 19 Jun 2025 08:49:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6496393599594771693=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, adrian-constantin.dudau@nxp.com
Subject: RE: [v2,1/1] tools: Expose the raw advertising data available on D-bus to PTS tester
In-Reply-To: <20250619142459.7979-4-adrian-constantin.dudau@nxp.com>
References: <20250619142459.7979-4-adrian-constantin.dudau@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6496393599594771693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=973863

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.31 seconds
BluezMake                     PASS      2711.77 seconds
MakeCheck                     PASS      20.01 seconds
MakeDistcheck                 PASS      198.83 seconds
CheckValgrind                 PASS      273.97 seconds
CheckSmatch                   PASS      306.00 seconds
bluezmakeextell               PASS      127.79 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      930.35 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6496393599594771693==--
