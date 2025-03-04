Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289F1D88B4
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072530; cv=none; b=Cg5MelARRtOAeUUgaLC4oW9xlsiYkj9cTZoMPUG/n4KJfn5gSFV4cJ1c1tAvUBKkPPukXv2UMoCMk2ZhYznKjCbsRVplMoypimVzeLAKkKygeN8EVPBPdjnNunlstof0V4qMnC8t8JvQ507OEcdesdX/mUjH3SOLzmH/D3N+NoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072530; c=relaxed/simple;
	bh=/TgbE0JrIwC6u81pmnMqk5Y/6k0rnMxZlEqUHVOVgj4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pnFSdD3zxd4vjmVDW1moHzwf5i1/fAuye4VrAAYsca0rQf+iwGGxRUTmT4LW/wL1q9o4AAtZGRz4BRpuKQ+KnRCe9eDr2JHs/Wd7IGBKg7ocubF5CCyVmK/nnwYoRt84m63vDSOglRYFCMNo07V4qdQz0ap15LbKF/n4xjXA/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlZ9en3z; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlZ9en3z"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c3d3147b81so5070085a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 23:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741072527; x=1741677327; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hLmSb6/lP3Y4NeTCBGV9SCWeUeKIswiNzYXpHhu0Qno=;
        b=RlZ9en3zRlzIg4HjoXjzmsfodBkiW/BBGd9aaJx9Larckv7S1MSfHpWnpPlpLrPP94
         QzHDD3qmgxWlfDwEo2/MYu79RqHPYtnHSinev7UhIalEVyZLdCaozL21ksmWhVAPm9bx
         2HKjNSWoT9rBqtkJ9sAYj4xQfX8W/4c1hdpZry+1PbBTFwZuGw9iTrAx2Dr+puyb1neX
         XpQmnN9HGEamRvcW8L9drlLvbWcIuYitZ7cPvUlPKnAV+CwYWkuN3cOWmZ3W3UfA06I4
         TGS7RRONgZ+djCmGnFmGLD7CVVLz+9F9JCV24XywNS7zbjl18FWEMnBedkE8N9IOhEVG
         +ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741072527; x=1741677327;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLmSb6/lP3Y4NeTCBGV9SCWeUeKIswiNzYXpHhu0Qno=;
        b=At47Fqw6YrKB2opdT5RMvMlq04B/21aEL9Cpsd+UTMWCeBdv7HnxbNPsJa0f49ctdj
         WmX5hjk11+W3kHML5n+3AYu0h4N+VEukNgIrDVA2y9ctjhaeE4smC8XNviWaHo4pwQsO
         bIFu8RCEUECSQD5sskeQ1PUou2KL3Pgzo0sTC2iO2OT3osK/pEJAzQutaejCMsxXyn+p
         B43guBWpLV628MeTcNm+U+McIjshTlT1qBSa0b5dnt8+rSud9ElSji7o19rBk3WlOWfM
         TVzUflHDrJR/JZJi+tPBO1HVOUiTBgb6KgALtwL366O1JGtYHPMJ5Des7fByDu4nLa7R
         IxAw==
X-Gm-Message-State: AOJu0YwfPNR1latlQP0pR0Kc8Wm0urRs9YweW9xD2HHiwSiRWlXT/Ugr
	cIuCM5C+ysEJWl5hLtxBWqxEdxxqslxz0K6gLd7ov469f9jxlHOuUHZsVA==
X-Gm-Gg: ASbGnctJNt7TLTdAw7/zsQ7bZUAJHhbpjoaAgROhkwxiWPzQ7G8ornCYrKwVWqR78hq
	J2a0GKsgGPRVIghINGahFvetY6+0/sE7xsIiuM3B3j8eAcwcWOvO3ojTqncUTMbhkSLlWUjBL+O
	aO+KvzcmD//F8KF/EK/a5HJ1MIELtd7f5pwRnPxTseIWWtlO/ZQ5zced9b1C6WA9sd3c5OSJzeh
	rdllcpl2Sf0gNTzpGQfdNrT4n4JUNVPpP7V2WQHAl8//E8XVXi1A29PqBqhZes+nQ8SSbN6Bi+n
	PIZtB8dOTrkvWSTs2mQFnar8eDAkUQyinbOaQk6Vs4o++Lo0RQ==
X-Google-Smtp-Source: AGHT+IEkweU3vmtj/e/mtnyI7miPAGDmOKkb/6aj1Pk5L28FtK1tba7/GYdhxFsI6yzes9mN4VKxCw==
X-Received: by 2002:a05:620a:27c7:b0:7c3:bcb2:f44f with SMTP id af79cd13be357-7c3bcb3000emr983705585a.17.1741072527672;
        Mon, 03 Mar 2025 23:15:27 -0800 (PST)
Received: from [172.17.0.2] ([20.57.71.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3bc2c38ccsm239789385a.66.2025.03.03.23.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:15:26 -0800 (PST)
Message-ID: <67c6a88e.050a0220.2235a7.6f22@mx.google.com>
Date: Mon, 03 Mar 2025 23:15:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8985485877797167080=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ,v3,1/3] uuid-helper: Add A2DP to the list of known profiles
In-Reply-To: <20250304061959.34839-1-arkadiusz.bokowy@gmail.com>
References: <20250304061959.34839-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8985485877797167080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939880

---Test result---

Test Summary:
CheckPatch                    PENDING   0.18 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.42 seconds
BluezMake                     PASS      1436.81 seconds
MakeCheck                     PASS      13.83 seconds
MakeDistcheck                 PASS      157.70 seconds
CheckValgrind                 PASS      213.77 seconds
CheckSmatch                   PASS      283.34 seconds
bluezmakeextell               PASS      97.93 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      865.64 seconds

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


--===============8985485877797167080==--
