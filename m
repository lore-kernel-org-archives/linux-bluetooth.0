Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5528151F
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746548029; cv=none; b=niB1YRPa+gr+sB4todKe+xa3+85c0GKFp9RlUWaEA5oVbgkuDvtubOXCFo5wgM/8xN7YoAVpsXk99l7/3rKUZRz37YYhRvDOHbxBCc6ad9MNff4zaOQywjtHy0sePVezK8nRNL0VMO46In+2S8/gOfsaExKTmYUfiVa/zCqF4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746548029; c=relaxed/simple;
	bh=UncqzR0vPm0UNj6eS/aabtSFJY/q7INcPwA95v+C9qI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RnRP9Y+kmPTPb2Yx11GH6H4A2D1MyHoxp8fydLulRxqxnGxWiTT9c9813xUb1cw8iDAeeG+eLUbNf8hWql9sMxpYL5Q4cwBIaHroyx9RqZ0AFQjxmkjkhLiJV4qsNt7hMoeEQ4eu9Q9QUsllFccOuHG82VtyhsJFGPWrFv4q7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH9rrw7i; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH9rrw7i"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f53d271b7cso5420056d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 May 2025 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746548026; x=1747152826; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=turTTXRbM960YFmW71b1oejoMVKouWVoalotTt1dPYM=;
        b=mH9rrw7i/Alxe+de0yFhQkO9J1+LOGAYzENjQZ98h9nzElvh+F84S2Tm+5zNtcWk+W
         bk96zwUdMviidt05aOjqb2rKoNCcy3B2fU17YaHDRkDkcQ8gyx58vEPGKKcAtAFo7nEX
         QKpBxFtJCSp7tXd9Se3V2BXH+G+cZu3GfGW4ZTifvgPH3NeL6dIRAYrCPwUbn2g6QNsE
         OJkJPhBPmm9lVau0177wTAMHTKVXJvsnHrHmS2CBBcEiORIyXcM7P9Z6hZdeKlLVZ19Y
         DY/AX5ttcVJ2qdohu48lzRVjXij1xbQydrh9szsrPUuQh+1fWMPDfUQeqvmoIM1WVBpl
         CvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746548026; x=1747152826;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=turTTXRbM960YFmW71b1oejoMVKouWVoalotTt1dPYM=;
        b=MCw8xpDtuDlnAYzD+wqwKGlVjz3keU4Se5xnXjcPvNaBJ2kmKyAZ+Z874tDk+F56c8
         uwf2sAdYeV0/WnKcFZqlHX0A6XvBrAB2Ng0f/OzBUnWYIlemug5JTeDf+JOvSQBQf7m2
         E8G/8/P4Zlt5F9QSKz2mTxPJNBXcCoEJCdWGT7q4DISy17XYFaADVGfe3QZ7IHQnMu8B
         9e3jCqE1zASK8SC4lm/NIw0ivq2cucwYCm2LFg2YOfZTMw+S8jweQotpZ1+0J3XOQBYW
         Hj0rEluHRoV6OEjwPcsehjXcE2onmbBL9JTNKWabziHg/Vyy2lbhUVrzSZ5ixZqxCryS
         O3Dg==
X-Gm-Message-State: AOJu0Yy/lyPXSAz+ljKSTSzIKBrx+TDmAs/M3SptMoKrsJ44wJqUnkIF
	afYsdGo/PhaQ5XZ6NaFV+lU5xwX+QIP5YETkHIfjpPEAE08AgMIU3cvGSg==
X-Gm-Gg: ASbGnctv1C5YQi7U4WOtfYMknofUIUDcmLEZZrCO8ABDu43Lz8s9URGiHauVQLI+dHK
	ZP9Vi71iW9XQUHefagbv3/SZQPpcdwKMs+Nt6fnOwO3YiyG6MVDLMhSnwleDbcfpWI0tZCJVX8J
	bszSz81OPHFxQiLQ3+2+RxVsteCebUT1PX08QZBF4khZcne43Zp4v5rdyjRscZ5dssI1zeUOERv
	/y1KJo7fbXSrscxezgXQU3LM+TLrX3EtQYs1sADmRyoBCLOhBN0B67Ly2SD6Mns70Sphn9edDgp
	wSyGCCQUG4EOD5DzTBhaTtoqTni4uSzHog+j+bJZXknNAD4xg4XNFWXtqwrZ
X-Google-Smtp-Source: AGHT+IG5bZHe0CwC+mSiPjSQvCOoadv6/GJ1V4rPalGjzxNYosdCfVBcTJ5SysOsC1iLupcnXiFUWQ==
X-Received: by 2002:a05:6214:1306:b0:6e8:9797:f94e with SMTP id 6a1803df08f44-6f5157f0dfbmr310621616d6.35.1746548026135;
        Tue, 06 May 2025 09:13:46 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.246.192])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f4518c5sm72073296d6.84.2025.05.06.09.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:13:45 -0700 (PDT)
Message-ID: <681a3539.d40a0220.3ad7de.7ec9@mx.google.com>
Date: Tue, 06 May 2025 09:13:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6276858186390200843=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] main.conf: Fix documentation of TemporaryTimeout=0
In-Reply-To: <20250506144814.49996-1-luiz.dentz@gmail.com>
References: <20250506144814.49996-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6276858186390200843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=960073

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.50 seconds
BluezMake                     PASS      2729.60 seconds
MakeCheck                     PASS      20.61 seconds
MakeDistcheck                 PASS      198.30 seconds
CheckValgrind                 PASS      275.60 seconds
CheckSmatch                   PASS      302.50 seconds
bluezmakeextell               PASS      128.53 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      904.35 seconds

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


--===============6276858186390200843==--
