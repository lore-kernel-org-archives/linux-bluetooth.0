Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77658211A34
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023724; cv=none; b=hBWdtyAt5sbac71DFKJRnYeylKgfUS0ZeklQgcQ+5WiSanP3S4422pbJbDuKbT2Ce4j5YXch8WrlJfOOTJDEPyw2OYTj4mj0yX5Ir8P5liyRgsbyew/9EUPxcucgSL2+hkW45JIqYcIA6c3knYfARZ+Bu3qd5r9mc871f3Rfnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023724; c=relaxed/simple;
	bh=hYor/BO5qNbKNFlbrx0w2aaq63N0wtQfvkSKF9FzSF4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cisnOnAae+ohTfb0Szqldqm5Tl2vtwMVd3UngkHkt/DVeePtndNurJYKmCBhvoHg/s4hCeLFo3YGiR0nFmoeKhEBhbXbWf8cETBjoGWmUPV8/oPph591908QJl/BJd3fmMLrnV71PPH82nDCWEf8WBsB2CyQ++5tk5gC/XZWTVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRb8f1jV; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRb8f1jV"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6ef047e9bso76094785a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 09:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734023721; x=1734628521; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eobt1/ceXb3fbMMUxERI3jOswUTcwfs3c9npPFcCHJk=;
        b=PRb8f1jVEfLv//njngEXaZmN0exq60tSTWouDsSPc539nPs5mgigVMAY82rka0mjSy
         adyyVHFbFEo8TJ0pcKvnb9ASiTxe89Y+GpCoeen1LqbPabuk6vm17AkgVxKdiK7KHspR
         FkVZy170mc0e0ijXzZaesgB2cUhcybD8CLN1tHGFcPpGSTJDYk43Lv89scnNR47DdHgB
         zeP+XktDHhE8BLF9UfVjFnm/VvfzkxI2+ll6vpT3nst9mXPNXYFkr3aruSdw29Cgy5gf
         XZuGvMbHjTjAxM5pQc8Ui4RmgMM8SUnvutUUo8icpeA+DSJVB+2K1h6km8GRsgXkATk9
         4goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734023721; x=1734628521;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eobt1/ceXb3fbMMUxERI3jOswUTcwfs3c9npPFcCHJk=;
        b=bv8sVyhB332pUSbChZYHKo7Nh3se+mVl9EqviFZF6stvltc+RoXkp1B0j1nBj2NbRq
         i3F3wRlY1Gm1aHSKHDry7DSQEVaCQHmoZ2z/Y0jf1CDjHzfCqafAIHFs9/5suaF1nsTB
         cwy/SldPM6SpQ6YE11X6ICNIhoqt9g4kY+gFpeOC0k5DL7S6mvDWXT7A6hYqEYiVT7JJ
         dc/ueXidy65IRe9HZ9seqJottACsKQ/s1YBWbg5M6GWlEtAJZEOlTdK3rQ9G8loPLaTQ
         dv5fWJFkEVRkcqF5mlXX4VLr1+v2oJKkgfM4lKzClGCmMNVy9nK439+Po/wM03DifP6k
         ehRg==
X-Gm-Message-State: AOJu0YxRhztIalpMx0LL2K7cz4fAq8FCBC8J1ewuew4Ri/i5LYtfCNnJ
	5DIOruckZCrV6nQdX9dxzB8ZqdZBK0+F9CNVqLpvepx0CLDfyEYAY95AHw==
X-Gm-Gg: ASbGncsm63yt9TugZdUl+SFgHwRA1xh88Sb8+RNaLo3hvyh94FOco+L5GriSAM7w+MN
	AOcHhan4dexmOJeX7sSpyeWCyplnKBjQFck7I7VtKF8YXj89HJk9bv6AnLtbBVjQIowvwibXfpY
	kxHsbVEdQ/EJGdTzGI84binHrvg5fKZZtPKzTi6T1hn91p/XCTFYZdYfYTKNyay232OApQSamgD
	+Ktv0U/napmhVukyWcbL8KUzIfqAFijdK8Do1y4RS7jrvlZfPoZ8auwXCwIzaio
X-Google-Smtp-Source: AGHT+IG9ZxyLZO1qAvT4Jh54Vt3jXFRBSWWivBBZMSAP9ax7L+jV55Lj3aL1+djgx8SypcjHk00Szw==
X-Received: by 2002:a05:620a:a515:b0:7b6:d942:c161 with SMTP id af79cd13be357-7b6f8ee0984mr109307885a.8.1734023719428;
        Thu, 12 Dec 2024 09:15:19 -0800 (PST)
Received: from [172.17.0.2] ([172.183.132.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6f16ead8fsm122237485a.39.2024.12.12.09.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 09:15:18 -0800 (PST)
Message-ID: <675b1a26.050a0220.9d17c.6138@mx.google.com>
Date: Thu, 12 Dec 2024 09:15:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3429037837743000274=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] lib: Add constant for 16 bits transparent voice setting
In-Reply-To: <20241212161445.298083-1-frederic.danis@collabora.com>
References: <20241212161445.298083-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3429037837743000274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=917289

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.44 seconds
BluezMake                     PASS      1517.29 seconds
MakeCheck                     PASS      13.29 seconds
MakeDistcheck                 PASS      158.94 seconds
CheckValgrind                 PASS      214.78 seconds
CheckSmatch                   PASS      272.15 seconds
bluezmakeextell               PASS      98.84 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      851.99 seconds

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


--===============3429037837743000274==--
