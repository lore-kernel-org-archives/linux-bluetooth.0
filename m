Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4BC1DE89A
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764882443; cv=none; b=Zkv1pw5dsA+7iYxpKH8R5/KJoiJT6orbNjUlCuiat+PAjONNrWHjs7J6ZYeql3B5MMMM5RITB54vA+CSYG7AWljvb5UBzk+fSI8Fm95B5kuEiS8i9sg1hOsZ2o110M1UH6YA5hTme/gorVIIFIKv90Dfcc+BpKY9q1eBM3RusXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764882443; c=relaxed/simple;
	bh=a/WY/7m30HaR3BoQa6kr6V5qo0qJ3vC4oEUdZTH8K2A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kgxNZ5qOQyKN2jHFu5WkTZYZZPAxrn+byB74DYSdKBKgeUmfDYxJNMZl5ICTIe2F7z3pCK67fS5uIeIJIuVL3AHjRbED7OZz0JSHs0yYNFDEYtLrW2pwItkINgyy4NKj4sT/whaTrG+y0dsf+04rzYKgDop2JkwVQkrJWnjV8dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffXAyS2s; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffXAyS2s"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88057f5d041so12918176d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Dec 2025 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764882441; x=1765487241; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w5PENDRbToYLYAZCRn6TIJ6woR5hFvJCCdKWZ1GOXpY=;
        b=ffXAyS2s2kilgnjTeJSIi1RYqRCtZfLJupLv/MqPIktqwPvntQotPNv+fA541hQZCE
         D7RL2sflP/J4Ywh7bTYws+0lRqUdgfjxxgnfNxZosj+OfitUaQgd4OyJyzx8FFi+PAzl
         lOQElNh0DpRMO4/hSEtlN7LSigJYbFA/M10dbMIrrBjpZtGxtETQh45Pn4CZkkdDgXnl
         U3LcHRhAZuzclDnkJLerdQTh+aK6scIYyUTG46BaycUD0AB7vA5B+06mRyCN+OI6ZVWL
         2zZ1cyhAgXJ2BuwLl2UJ6LUNmjp/Z2ha4NjSvz14DYLVXFzSDovL0QLbeR8+oCx7J7Jl
         OPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764882441; x=1765487241;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5PENDRbToYLYAZCRn6TIJ6woR5hFvJCCdKWZ1GOXpY=;
        b=mmC0vGd0uMe4aBJ8io9R4W+t74Z97Nuw8W/ZmJdj5F4cwdeMO4k6WhyeahzjKkgmwe
         zkGTwJ0/ZYF3/9+vMPpn0GqAgRV+3xrLUGEjQb0xyjc7DFKTrWz81ykERIXLdU7dnJjE
         qNaaiYPGM4h56HEHsNFLDJWkJM6G/xmYOhPdFxKBYJg5dLsTDGiCaKebhVP3ISvoqY+V
         9eAzRTFiKCzZ2msmHk55R/NdH/KQA+2gVNNB55BirvMfiBeY2U4erycLBJno0MfwvF0W
         OQMGEFwv/4OGdlLPS92ftp5wNnW7ZW9rBLZbtu/WDTnFHIDcYSdqmZdOr3VUm2SJLvXY
         iDtA==
X-Gm-Message-State: AOJu0Yxe3LsU5tUjO6wc3eXCIHYehFrbflmVJXUul3QhVpEklQVigkq4
	xJ5Hv6xx0i7jv6BoOMdEotU4/m5thPoPxA6THkIFtNU+34952ooB8iQhHmKj0w==
X-Gm-Gg: ASbGncuCMEnP6ST5LkSeRP6C9YqFh12+93WfJNOw+oeZHa04WP9n7cQpFeQ2pSOALgP
	V8kqF/6Wg8W1VQg9Tx3/9iDz3fnCcnkLkCaj8BTFoUC5pbNJDsHZ53L/mCvzjtaVoWU5Wc4GD5/
	RYkzjLRyInf6e47I9ja7X6/9RSdBiqctcYR+2ynMIqYjNpgpiUklzVY1NXDJ88Zofd1Wn72A28q
	ujfDsY1TqPPDZptDQ7JEK71X2pcZT889PfoDS59/FGTj4tP2J+ZphelKPo5zpp4RaDT45EagNAI
	USGYkTVfDLkEFmig7b0TVSmdfJGzgpayrNs/LPAqZ/a0jyGHnR+EkZIGVsM7QBuXgXGDySG6dmp
	28NsjZredvKNocwsB6AGYa82QFbCLqqiRivMSiX9VNMWr7igQMYT+SU9+lpFTt7tteqQ+9Te1C9
	AhhPKxKeyCjYueGNNQ288=
X-Google-Smtp-Source: AGHT+IElPXIPtUG5Jwzr/J0Z9fius1hdi+kLuXkxa02u/zsA3nhlxM1mMK6geNZ6gWTsSLucATA4yA==
X-Received: by 2002:ad4:5dca:0:b0:7d2:e1e6:f79f with SMTP id 6a1803df08f44-888248c77bfmr68218226d6.47.1764882440812;
        Thu, 04 Dec 2025 13:07:20 -0800 (PST)
Received: from [172.17.0.2] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-888287a4a77sm17903716d6.32.2025.12.04.13.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 13:07:20 -0800 (PST)
Message-ID: <6931f808.d40a0220.340ebe.730f@mx.google.com>
Date: Thu, 04 Dec 2025 13:07:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8776635704543401208=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: MGMT: report BIS capability flags in supported settings
In-Reply-To: <9e5172cb82b9d4d130d83d9fc6beac9e496227c1.1764875787.git.pav@iki.fi>
References: <9e5172cb82b9d4d130d83d9fc6beac9e496227c1.1764875787.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8776635704543401208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1030593

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.26 seconds
CheckAllWarning               PASS      27.75 seconds
CheckSparse                   PASS      31.29 seconds
BuildKernel32                 PASS      25.23 seconds
TestRunnerSetup               PASS      554.72 seconds
TestRunner_l2cap-tester       PASS      24.37 seconds
TestRunner_iso-tester         PASS      91.73 seconds
TestRunner_bnep-tester        PASS      6.25 seconds
TestRunner_mgmt-tester        FAIL      128.00 seconds
TestRunner_rfcomm-tester      PASS      9.55 seconds
TestRunner_sco-tester         FAIL      14.40 seconds
TestRunner_ioctl-tester       PASS      10.19 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.73 seconds
IncrementalBuild              PENDING   0.45 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.101 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.837 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8776635704543401208==--
