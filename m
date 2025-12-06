Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CBA2D9792
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765022565; cv=none; b=b+rWaskHb9t2Wn6VW7FvCOOZaKefl5xZjr4uvD4uM+0k4Ggj8YnG20vF2OxdfCwi78YzZ+HprwsO0Vr6igdx0yTr+zHgY3fHzYVn3D1+HvjfjmqpXUaCfNJYCAREfmMNZuMgzPSieMETfdfxxinVA1usotiW2H0Nte9x9rzpTos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765022565; c=relaxed/simple;
	bh=yi6znFtYt1n0ZyuXW9ZoXUsyVec8X50QgsKqvahxeoA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NHy3AU9/hUqwWPlsKB+bejoXmmwmSGvtmJeBlwoGBu4kPxQD0W3+evqNSP5LCDCLPe0lxD6A/Lo/1m67B//E4fAEbTMmElAtUwkUhzzcUMCKhsmEPIxojFQ1S68G8kxh0w6Aur2lzxDTApKvQUWDyTtgiv9mpQ0JnSJaM7knpkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qt3LXleQ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt3LXleQ"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c6d1ebb0c4so2507812a34.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Dec 2025 04:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765022562; x=1765627362; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JwyLl3lxDM7AdSx2YgL2vL/r+lP3snF38fprBKJa358=;
        b=Qt3LXleQzL3C2w7yxkU9IRI5c8dukC0rJRRgzF1XlMvBSxR9K/vRgOSbFv6tx7dvez
         ok/wQgRjr6KNdn4IV8addsQbl625hhiUKfQANQaoO+I1VjS8EYZo6yebZFi5d9HjLpcV
         EbiZocfkxoJd0LRooL2HdWtqKDuA+SsHICyfBHtT9SFQOl8mCiNjkz0QCpNY4SkH03u8
         sYb7MrQpDUb803icznDz0CJJw6TyksPbNGlnukLwee34AvDb7R6leUEmPxpmFj0Cmtwk
         StD7dyP1kd56y3RQSnLAOYW519O7jxeUu4in902pTAvDQY09uZhxT6vmwImHeZsQwnu4
         VcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765022562; x=1765627362;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwyLl3lxDM7AdSx2YgL2vL/r+lP3snF38fprBKJa358=;
        b=JmIUMTm9AcBWfzBNrhDDKp1L7B6KKE++IXdzW5ds7xqKXwul3vbWwUBxi6ozgWHaKr
         0OJ+62uOcUkTur0KRrBPGco17Y7WxH44/A4FXGMhvmzaWhNsFausNXCmNbmKlAXo+dCg
         dmlu2Hd/BtHBdSWLfjV8JR8dPK7FzFU4e7X8fAlysGVQdMRSWV89J4ztsFTNFJRmvDg1
         jH7boiZoG02ZEELXUP6NjpzhNfI4JpwQN49R5JUF5xIrWP481ikqLCm0WktLsLawrsAg
         etPQsYBtYJ42UsCrqYx8djsahQFztbym3IqADXDmExJfHOGPItobHpT5w4v3rM7pN6xy
         TPEw==
X-Gm-Message-State: AOJu0YyR08WR1Sg+7IFXw353anK21TWpLFDDhNeiM0wq13JtRPimPuTD
	SPNT9aBe6UZs6BwhNO/kuwpHYGvo2EtxtclqzoA4up6sMzW8hxytSKsuw4c3qA==
X-Gm-Gg: ASbGnctdpxyxrhbCsRrpUunE0Msr9WmbGiyfIToiLHbV7Bs8qgPlVzhIwFHa9MepekQ
	vE3US4g2iUDOvkPT6/O0VNXl940wPH3Q7zKiFA5k+n5DC2b4guSauvD+h1pDNGnIg3+7LHC9aeK
	VcfnE6KZleogN7e2hCagiyMDLgmaTor5A8YwVqaW/SjHHaVhXvETcEWJIb1ezJS+dEB3ZpVaxEf
	5ptB3tc0XonBE4/AwqE21keagES9Y7bJC4BKoCHiEF5iGyNf6vzPY+Rk84DZk6u4XMzhljtjtLO
	gLlXpo0sGcnIou2J4JNJjLd8HcQAbhmZQ+cvg1eupDMivL6YZWEOn1S5GPRTnkjxoC4rX3mzJb/
	3zulXK6o9RjqYTC0aPjjAy17QwRmGb1fuEzbfVWFzb7rjB/Lt2aEmZquhmw6+QgpvnSxnS+ZzTj
	mYGTZP+GGbADPI0CQ=
X-Google-Smtp-Source: AGHT+IFvL6FbENT3IeFlJFEISwhQ3qIWXO0eGhyFqmD1V35tmc91iuulJBtQLY1AOOWE6IJX++mpCw==
X-Received: by 2002:a05:6830:2701:b0:7c9:5bef:eb1 with SMTP id 46e09a7af769-7c9707fb066mr1470051a34.28.1765022561590;
        Sat, 06 Dec 2025 04:02:41 -0800 (PST)
Received: from [172.17.0.2] ([52.154.21.48])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95acff1bfsm5992828a34.31.2025.12.06.04.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 04:02:40 -0800 (PST)
Message-ID: <69341b60.050a0220.316dd6.28a0@mx.google.com>
Date: Sat, 06 Dec 2025 04:02:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6547004592842891841=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Add local TMAS & GMAS servers
In-Reply-To: <c65bf870d8bc9813523302d28eb99b101673285d.1765018766.git.pav@iki.fi>
References: <c65bf870d8bc9813523302d28eb99b101673285d.1765018766.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6547004592842891841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1031057

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.43 seconds
BluezMake                     PASS      650.07 seconds
MakeCheck                     PASS      22.24 seconds
MakeDistcheck                 PASS      242.90 seconds
CheckValgrind                 PASS      303.08 seconds
CheckSmatch                   PASS      354.72 seconds
bluezmakeextell               PASS      185.31 seconds
IncrementalBuild              PENDING   0.55 seconds
ScanBuild                     PASS      1029.81 seconds

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


--===============6547004592842891841==--
