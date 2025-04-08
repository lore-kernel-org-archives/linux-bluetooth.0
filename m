Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27387263C6D
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110808; cv=none; b=V2h4FutN3Ati2X9pAO9dv/VTpI+/YdFER362fEBKu/Kr/eYGxxWHofhKtmUo958vakvwTdkv22HzezI8HqSMnjJrb8o2PjTyWqoKzH/UlrLCqOebms/eWMZGM5Tu4V+eYV09mdNMO7a5lgh9UVyA4Zac1FukD83Yy86vMgguG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110808; c=relaxed/simple;
	bh=673hLPfkdrttT0eXHyd5kPdSh7zLG1qtgyrti1Jp2Ig=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Hi4h2SJdxMLV+2tG3NAjCz2k6yUpQJa3haL6qNt11VuCndgtrUX+IMjpZEFlcBOblJANEhy3p/nAR+T+1W2S9CQ4U/s1nQMi3uwN79UnPt8eAMB2ds6WzdYoH3yt+0dxQQ8GNabTOJx+xDmT6wq8oOePqInjmQN+/iok8j20jCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWTiHDtf; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWTiHDtf"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5e1b40f68so597215785a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Apr 2025 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744110806; x=1744715606; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zcUdIpT5byKnsEk5Hdy+pSrJ5ITueSnX5/mIdS6efPs=;
        b=DWTiHDtfG90pUxruyIiMjKJQViI5ID9TJxJxUQceYGdiou2l3JQB+1dajuOLgATT6Z
         zo1DBZFQOGuiDBwe1C4pT6VYP76xCjOrOogABRKLbIUdXE6ymAC8isnL5f12jgS9lp6m
         gxX8t6+IHiVQNA9GRyG5c+NhkVszno0FrI1p1irpkYnukcpaEH1Za4frEIekBE6Ke1mJ
         alQbmg/CIGZ8JD3ur/iMm8XG+gQvQWTQKUWc9hCl9qynLak7N1e58PibfFnlmSebR255
         zhqdjtZQVbTnVpF1SIVqx/dyEKBL6czPZ7V9a7Y5bJja7t34JnJ9uZ1NSTaXiVmcY/E1
         Yf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744110806; x=1744715606;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcUdIpT5byKnsEk5Hdy+pSrJ5ITueSnX5/mIdS6efPs=;
        b=eMeE4Gb/GiPl+N/WZfl7sf8ajBFS0HRWeKiHXK9ot0WhaThr49axL49PI/IdLVB+rZ
         KMlRVoXI0oNLVOULJ2inp8LRAZdKTHCWWZ2mWMs4w/SL45gNLmbfFpk5wNGqKXABntBx
         rB1uKw/gS1eHKwLJORAuh32T0v8WcCea+dVVoyIoD4eOwVkQcPQaD1p70IR6UxEOBBiv
         PAmzS/vI2MmFFgRTTnxaFbaLnsAL4cD76P8jF16p31HN1JKSO7CRPWI0mT4KQY2HfT0F
         vmL94qAiH4Bb0VlGNtQfeeYbnYnwNuB9mShQgrGau/IrgvZPbdhbtZVmrsNrYz910y4C
         pKeg==
X-Gm-Message-State: AOJu0YxmYhDD4yKxI5toUzy1f3t1JXfaPJ2d3+l3LYRwAMPaYGnvg2Zj
	OP7Qs3kWOqZtEqM186svtFmwnXGqAgy4M18B6nI5gfZXQ+75mtfcwswkiA==
X-Gm-Gg: ASbGncuvdYv8RRxAawwfZZxBynauqdm1QiI86QFwbsSO4+8EUZxbbwCwJsuN4lNfPCm
	Luia/dES3K3s2ifzOMz1Y2lWBue4RQZhEeppiFYEyx8a/DEcSeUoNDVqp3kEbk2ir5xJ+D3sBvA
	ECl3TO7cBSYLEQGVER/ZeYSUFTlMsdMQIDwdCZaB0qQJYZ+mP8Sc/zzzQO70Au5ccG/fi0L/DDZ
	HKKmS03cu0Swxb/4nNTBfkcAusU9IpCpMKuNHX1bpy4XHT+SRHwSohKz/F+a1tBRUfj8voUMGSX
	io8QDkG5NotYie/vyWuJqUnpy8bOKbVrC9/Dcabz9Ob5votARQ==
X-Google-Smtp-Source: AGHT+IEDoR/OWVv7LHTPzOH9x7zQkFROyBMz6jNTVNKzpPbYnD6dRVmj6fkFCh+0l2/aa5eiFSBVMg==
X-Received: by 2002:a05:620a:424c:b0:7c5:4eee:5405 with SMTP id af79cd13be357-7c775ade724mr2154187285a.35.1744110805716;
        Tue, 08 Apr 2025 04:13:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.47.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0bc60664asm44474676d6.56.2025.04.08.04.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 04:13:25 -0700 (PDT)
Message-ID: <67f504d5.0c0a0220.1b4a.ad24@mx.google.com>
Date: Tue, 08 Apr 2025 04:13:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6781994228455595920=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: doc: Fix various typos in D-Bus interface documentation
In-Reply-To: <20250408101243.6010-1-arkadiusz.bokowy@gmail.com>
References: <20250408101243.6010-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6781994228455595920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=951032

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.65 seconds
BluezMake                     PASS      1522.88 seconds
MakeCheck                     PASS      13.65 seconds
MakeDistcheck                 PASS      159.12 seconds
CheckValgrind                 PASS      215.80 seconds
CheckSmatch                   PASS      285.45 seconds
bluezmakeextell               PASS      98.95 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      881.84 seconds

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


--===============6781994228455595920==--
