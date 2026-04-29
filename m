Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFB27EFE9
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474576; cv=none; b=c0X8mwXgEAWE4/bpWE3xqcnlNJc81NdZ3ORk+YohqucagEhnuun9sVZteKr4FlIQ+g143/aR4N25ysLYOhh971H33tMzJ79NtjQ3P6t5c5IpkKvq+VREOZL13MxxVEqMAj1QMZ6S2c06uWQNUk6reizdsKXCo5Xg2zBH7K+XfsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474576; c=relaxed/simple;
	bh=ADF4gA3ZQ+uPmt15jkjduWyob6LH1raOuvn6jfdveuY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=libCnjxtPbeb3II89cuMcoKBVnKOfeKQKQuIKSnwo4C4doQqQhvHtwJAQB+7BIojGYGAlB6HePObqcuP/k174jZmlHUhd7eLbl7LV304zeyZXsH8YK0mvm3xEsWcN7BRFP2iw17QO1dMEy5JavilSsZ9Y1kU1l7pTGXLByXQ9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFnUbkYT; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFnUbkYT"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2d96243c91fso20760909eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777474574; x=1778079374; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u45tHYAdD1cShEg+n/KYQLO7zyjzznMDKuVCSgFtypM=;
        b=OFnUbkYTbNFklGqPc9QtOBH4SSCJ953mvN4OuzjxSvuRtY/sTheWHYonBVJZ2+tACc
         KQexWOhtct6zx30z0/2KzVvAmmv9FEBqNhW0XyVzpDgjZGLRUXqnDguPCwZZ6d5TtnF0
         zaBiT8IUhNcW9MO1Z9usNm7d/dzd24W91VCjd+M7x9XSSm/+ifQ7/3UG37l+aXzGaeY1
         kWXTy6P3J89wms5YKJHtgnQpZCpdnolRGcpcZIyKFyNCEwzGR/K8xgLqhykiZSE+RDyY
         0XZl6EKhRPif3/QKvUawXwcjl+5zLZaz/hAZoAtTix5NPddlRv4IjSQpDPV5h08zw+f2
         pAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777474574; x=1778079374;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u45tHYAdD1cShEg+n/KYQLO7zyjzznMDKuVCSgFtypM=;
        b=Ee052dx4uey2Q2gglkl2hi0Q3M0spRA4gIB2jtvWrsvt6AzCJXssulelNA+XDK8Ilr
         RGtaNsDNnfv6j8akvundM8H7haH+eEhsEKPYneuuZT2CL2NwLjAM4HstrOvNsDloAkrU
         tSj6spUh91IwAcLR1q4L78xr7auMK40SWqh0VYCrdZk6khgiIlCzzbmawXzRfeDY2YEe
         So31rO+YqTOO6LGXc92oOXendJyRSo3vmngZSD6hGL61hBBGcv9EP9TCv4c3SS+qCJOn
         15pihDqDI6g4nN8nSyZwNK9QNS81Nb1i/04hV4RelGKsuf6Gvzc4oqq+8m04VZrbXtJ9
         Ipig==
X-Gm-Message-State: AOJu0YzKPRIb5mRGQJiCGUnNA2gfsIk/lD7sZafkzOPOgKIdDsiOePHW
	1oEVqLpqTEOcjk/lAUY9g6HUIUC7ELaqX2apoLBR0qijTPrfz9bxSdhbxIlG6A==
X-Gm-Gg: AeBDietwdzSHOnKFhAu0HCHFYiVLoViqJHFwDW/WCVGKBmUX5NhpSw+kCdNqLewzktX
	gMVz85vBsfXTyHlFju+GPWVF3nrwnD9rBy6K4g4ua33Og2gVwbEjgPGrBSG6r9FvZqnHeNFTolT
	IsFuiKHuXX+o/tJA3zMjJqCfkUaUbMOb61+nCCPUkLMUjIlanw4ndVO//QviC9IkZoipnVcuErG
	MEsTRcpimM8WVRqcfgeS2n9NRD/s3ZThYZWru2+8fYiJDVgYeoTwEgzP4ZkoIx5zUwHyW0qVg5S
	j5v1LijPrHWKeG2r6aZ/OAL960bapBsTGC0vI2Wp5HHdDwyL/IxxAcqHKcfoNrKa/qA4NejbU5S
	LnMGovF2Pv+04G8uzUtsNfnevBtNed/whNtv5EGH62Qc+LKKmui0Qy/+tbB7lS7AGxgXCeyc1zc
	JUzBQ9N1fcoCT+W0uyWbvmH4pH/5NnJQ5R98BRrXFh610=
X-Received: by 2002:a05:7301:1e94:b0:2ea:5057:a319 with SMTP id 5a478bee46e88-2ed0a003541mr3856562eec.6.1777474573945;
        Wed, 29 Apr 2026 07:56:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.158.165])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c0d218dsm2379199eec.27.2026.04.29.07.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:56:13 -0700 (PDT)
Message-ID: <69f21c0d.050a0220.7ef7a.dfec@mx.google.com>
Date: Wed, 29 Apr 2026 07:56:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1511043286195440163=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v2] Bluetooth: btusb: Allow firmware re-download when version matches
In-Reply-To: <20260429121207.1306526-1-shuai.zhang@oss.qualcomm.com>
References: <20260429121207.1306526-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1511043286195440163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1087449

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       FAIL      0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.84 seconds
CheckAllWarning               PASS      28.00 seconds
CheckSparse                   PASS      26.10 seconds
BuildKernel32                 PASS      24.71 seconds
TestRunnerSetup               PASS      524.21 seconds
IncrementalBuild              PASS      23.70 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btusb: Allow firmware re-download when version matches

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
31: B1 Line exceeds max length (84>80): "  https://lore.kernel.org/all/20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com/"


https://github.com/bluez/bluetooth-next/pull/130

---
Regards,
Linux Bluetooth


--===============1511043286195440163==--
