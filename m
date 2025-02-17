Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B055F21C9F4
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798951; cv=none; b=OTCU4ZWkQWA+qZN8biDYX+FaBqtIFaVMOF2ORKSAAiS1LS60cgMnhtx65gAaD2S68grao/WtwSpmjTuWjLlUYe2mmEPjSEDNkBnmEzoHBj39XKbDpz9WQik4ZF+Z3wAMZMyDCwiNVspW1tlJZ/I/xv8oifOo6elP8Ir0QAmEUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798951; c=relaxed/simple;
	bh=jK6hkxvtE+IJJoXi6+gZeW50rBWLW9Qee2XpYEBanp8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pJc+7R9PtysuSPKt9FOomKo5iGS6HqI9jZ1Cb2QmjlNn+sY8CwTalG2TMrTowpsgu4fgcdLLfesKL4wRx9UxvxMAszsjp3v4tKeapI3BVoUd8e2OeOg3yrGGo94hNAOkN1onlQQnyvFLKw8pl5qBaYANVnqvZznrV4GrCXNLLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1IQC2Tw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1IQC2Tw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220e6028214so69225595ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 05:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739798949; x=1740403749; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ydfQ8T7ftwsJGJ2L94EqWfIz6Vl2aYRy9J1OnI09BTc=;
        b=c1IQC2TwqrabQg7PooqojxgODhbLUnK39HewfmZXcsqNOENcDoE6RxHIHBZMXZJDa1
         /0yIP1jiGE3sZfpbT2V89Gjs4585yJCI+Tf9P7XY3EAyT1nH2LS3u2mq6C514k4shAJ+
         QTHPc3/77s5L0ICMXtItrUGQKoxLnrX7PAir40VfjVXqSFQkMOS5O/hHwpcwpa8TJ26z
         skkVfmJxejWwLGP8MMgvTVZHI19g78fPIEj4K9TnMORPIfVehU+0qhH84v2Gnixq8JoZ
         L6+U6rmsoyvnioCiBL7sIpcPPdi9gsEFKlgD4czmv/A0UzxF1YKK2UhOBuaHBIOP81Ep
         Xkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739798949; x=1740403749;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydfQ8T7ftwsJGJ2L94EqWfIz6Vl2aYRy9J1OnI09BTc=;
        b=B7FFsRDJFBTNtYKW9S0bWYXg1EvHwgm2f5SoC2EAijDqrgBw1fMBpjxmUhWzYiTzja
         0kAAKQh/ftckTnrRegY4eE9t6lAUeSv4StAhobd+s9YeGl0xdsPOz4l19UMbkHFIPFbh
         UUqbM0khGGRReVplWA2gs7oUxnwemdxJRe5yls4MWLXxFU3tPaABGlGoaHj22wVULpvL
         knCvFeqqaNClAoFa4nIn0L2L8DtE2MqXds6g7wv3dYLDI4DTGBRJv2Dg/O57idEgtES/
         RlKX2QJilr4EBHjHtFUcZVVfN3ZjhmCq/HokKMJzEzzenUpL8YC60l3DxLgV+na/hhHL
         OLzA==
X-Gm-Message-State: AOJu0Yw19rnlNS32oDDOvGzF0du8AvUGFPJ6FKuVt3Wdt99ELlKSRYBc
	rP/ghB77cFN04rrXo/XbejpJAVgcf4FOQmGgEhYQJ+MzXpJarI3dlwRyjg==
X-Gm-Gg: ASbGncvIGnNNU0Ap/9Qd9R6UKr/xpkrymuawedpK4k7EgPFbcK4cr+8xYMrI227z57l
	2PwVxBbLaXNH3+v9tOWV8CVYKHy7fycJvelMHfkMaPcaZgwbTHRJqJXVaAKqgZhFZrZ3gPKzhh9
	EFUSTu950+FrDGuzpUVDLo+NJGw79r93Eo9v02I+IesCCQ4XUaiG+Zz6yAlo7aTB3LtTx3sfS3S
	Xmf7Xp+JZkxYo5kGkqrfD13CNQ7Ng7S3ZIvhCJNZTPhIwP3QULLpEawF4sne8e5FylzS4+2LHX1
	UAtguRxW3SUYKJyr6IcyOA==
X-Google-Smtp-Source: AGHT+IENVuX0zD8Car/V9gmKt7QOaB0YD57cIpiy/PxyF6p71FN6U/9D9YVJwhm/5LULuMalIZabZQ==
X-Received: by 2002:a17:902:e892:b0:216:282d:c67a with SMTP id d9443c01a7336-221040a8e7cmr168390305ad.39.1739798947136;
        Mon, 17 Feb 2025 05:29:07 -0800 (PST)
Received: from [172.17.0.2] ([52.234.33.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5590770sm70962925ad.231.2025.02.17.05.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:29:06 -0800 (PST)
Message-ID: <67b339a2.170a0220.5a27d.40a5@mx.google.com>
Date: Mon, 17 Feb 2025 05:29:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4573617886781791971=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] a2dp: Remove Endpoints cache entries on device removal
In-Reply-To: <20250217114802.52247-1-frederic.danis@collabora.com>
References: <20250217114802.52247-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4573617886781791971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=934674

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.67 seconds
BluezMake                     PASS      1595.63 seconds
MakeCheck                     PASS      39.34 seconds
MakeDistcheck                 PASS      161.52 seconds
CheckValgrind                 PASS      215.86 seconds
CheckSmatch                   PASS      286.32 seconds
bluezmakeextell               PASS      102.52 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      897.58 seconds

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


--===============4573617886781791971==--
