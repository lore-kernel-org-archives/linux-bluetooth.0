Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125325E822
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623386; cv=none; b=niK7/HNVtrpmCeVaPe8DYmvruIKRJrWnyHMZsu6GSTA9xhQlK6FoCFQF//C1ojJPqjJzZi5P4zGsqjANcKCEMQGPogZgFHyQyaTyCYG1mQ3GSLdjjVO8gTcHG/M2ljRV2+NY4onopL7VnZ9zlL9wQOoZ1hs2I35mCoF6HceTg9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623386; c=relaxed/simple;
	bh=7ztTkr7cSYhWLElt9KkNS6XM5xi+ALddWDgtbi/+2JM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L0qfc8qiYMHoUOuejUjngBYDQ+RfTLsJM8qHkxmVO1GbyQECtOPNi7nJKpMmWaacYA4vgCIHiGQ7FJwu9DB5LJokIu34mXmnvNjeNm5y2Hqho8jRRqiRC4AK+Zfni3GuVTrptlY9RmyTP47tJW7wuvtxokMXGdpssu33gxO44gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3etAHsX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3etAHsX"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so3171588a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744623384; x=1745228184; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NE+pduSDEE6LG/BgSAhDFuJ3dHqkNd+uBzs4un34Yv8=;
        b=X3etAHsXcttZMFWUDlaR2fXjR28cFqocndRYCv0sQqtQP3ZBlNT3yXp7CwfgtT2X7p
         t0r8nHnEvsfd5w8XiAOclm3epsEuZCUmiTSU5FK3lA3g2+5ZPwnmVn4PRZm3BuqHri0H
         LxobrJ4aF3antw1rigoNAMLHG/OH+2xYynS+mKVazLuOTh9efXjBvGNyx2tLCggwiLDk
         KC+wSDLNnrISu6tCylylLur7Q5XGmcmvUwa/qw4sdldg7hlW/hJUnPBrJo56JYnzqehx
         c9t4tm42EL8QL5F61fLygS4dOTFA3ouB2VPwZLTg6vWu8VAbnCTKazutHCURCA3vg5s9
         +kTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744623384; x=1745228184;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NE+pduSDEE6LG/BgSAhDFuJ3dHqkNd+uBzs4un34Yv8=;
        b=deQJUp8nkjh2824c/Ozu2uy9qbygbE3EtiaP+2ZI+InUomWSmQ15DauOVUwpohrXdJ
         wQIMli8lX7HOfSmuwxxSVDgGjlajqRtvZkdyIgGijn1tRGMd8HpTbRmhWfFUpuU4Q9cQ
         7/RJTfbv+YKTbArUQqEqE27YY5zxkpYzqUXM/57EWEFxRbSMa/rwBa9BcA7M0GfKWr8M
         gG3at0kIshSf1vQSl7ME9lGLf/OHUl8HGS2tvg+ALw86+mBZfyHJcgNl3sm/lAmQY+C0
         mil09t6wtuojmpUugmMCdgPu07ueAKOp1NTS1iZR9BfAYCdHESn+8zImx9DeqZprif/C
         uGlQ==
X-Gm-Message-State: AOJu0YzxHUkx5VIf9f+lCkksciyHN7GHSdYzUNUEPJP1T1qY0MosTLdb
	pUB4hR9aXrovZj/DsUnO1WB7N7vvASAkwaYscyU3UFCzm3SGh7bOFS8rVg==
X-Gm-Gg: ASbGncvL8q48GbulDBnX0mFM3Kw7KXsu6W5ZaWMvWiSQYNGQVEgmtOK+rWPJpoXXEX7
	Iypw1y57JP9j+FDyrEz1otnCN6poeNZqE8aU8IJ3qPf13anT6n+E+Cok3RmKOBWa3SumzvGrdVH
	DIbrd8gLwfVqzvK2Vl5sATHOBTnYm30Y+XKQxjs7nzDa+lFdYtrLcJJ8dq5mKnSEG13MRl7QUB/
	G8bL9gl1U68+/DjPUWfQJmGA4CsDIvafVHYaoERZN/G+27FSj9cO5PQsBZTgf1wqU7ufMed78xN
	Tv3vMQ8Tzs3pHWSFlpwkQTMZF9E4sQjRkuYMziR230Cfj+SH
X-Google-Smtp-Source: AGHT+IE0x/kLbbYz85JxgFtWJ1FPUaOcItHpSbDtJcgdAk9RGOWYcN6p9rdclRbmRpGNfSEfsqsbqQ==
X-Received: by 2002:a17:90b:5242:b0:2fe:e9c6:689e with SMTP id 98e67ed59e1d1-30823670094mr16587188a91.8.1744623383757;
        Mon, 14 Apr 2025 02:36:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.160.165.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3082a58c27csm5853791a91.20.2025.04.14.02.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 02:36:23 -0700 (PDT)
Message-ID: <67fcd717.170a0220.34b224.0162@mx.google.com>
Date: Mon, 14 Apr 2025 02:36:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3556788400945103231=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v2] Bluetooth: l2cap: Process valid commands in too long frame
In-Reply-To: <20250414090815.32366-1-frederic.danis@collabora.com>
References: <20250414090815.32366-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3556788400945103231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=952988

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.39 seconds
SubjectPrefix                 PASS      2.24 seconds
BuildKernel                   PASS      24.51 seconds
CheckAllWarning               PASS      26.93 seconds
CheckSparse                   PASS      30.37 seconds
BuildKernel32                 PASS      23.99 seconds
TestRunnerSetup               PASS      463.53 seconds
TestRunner_l2cap-tester       PASS      21.33 seconds
TestRunner_iso-tester         PASS      35.28 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      124.02 seconds
TestRunner_rfcomm-tester      PENDING   46.46 seconds
TestRunner_sco-tester         PASS      16.09 seconds
TestRunner_ioctl-tester       PASS      8.27 seconds
TestRunner_mesh-tester        PASS      5.95 seconds
TestRunner_smp-tester         PASS      20.67 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PENDING   0.52 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.171 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.206 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.150 seconds
##############################
Test: TestRunner_rfcomm-tester - PENDING
Desc: Run rfcomm-tester with test-runner
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3556788400945103231==--
