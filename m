Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC543A2550
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736752; cv=none; b=kTqO4olqtCyVJe5uuB7lyp/HFSPJqkH5h03tHIVyYgoNm6fZoyxLkZnGNXf1a7xWb9+z79auGJAb0xBqweUzFY4v4ncsTr09dQUnpajrO5yGcpZ2wmonDhc1p9ul+Wr6JmPb43SksKfB4upLZQrOK24wkkVQooiiCImJy31TDG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736752; c=relaxed/simple;
	bh=r9d/mUYeVBXTcnlHC3NLZkRn+EANxBmachVLKGpPpZo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Vgd+VmSO4IolPWxzf65AXMsuGwPC85eWnYXv/1ijzHWsNl59meRVb4Qop9rtlqbCwoCI9jEiDWsyN03186Er+prd+kLsaxkMeEWw3g+sVQSXrl6MUNtN8Kzo61U9Hsn5PbRXIdgn4Hy997NsEWHZPVYzFCSkVeazZuxz8xjTlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oKLu4FNz; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKLu4FNz"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2d52c7f92b1so50353eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 05:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775736750; x=1776341550; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ztaBxn1mWCSAe+QhtrNy1Ix7HAjvKuuoSe45MHzSXb4=;
        b=oKLu4FNzlluj9sjqsy6vfP/wlWrQqj8p58qHKSNK8LqTNcwXiF/jBiKLtkuCSvJbjA
         pw/PQji++jP/uzTMSywwb8X74AOL/p9rO3bEgWOI9j8d3Jg78Xvub53KUIfksK1WfxSr
         VEbggBex26mYH/sqtTL/yXM8S7TuRsQVqBvZ9woW7fCkG+AUiLzFsCdFirVCrcRY2+Hw
         HxQ++XSIjfWSyCZGMXmXuxstF8eYrFSKpapVC5CsEPHBTXgD43HhVfXAEFnjr3f7XJlL
         rGFzINOLWqTZVDMBrVpEWptqpMObzuAPwc8g6N7KMjXTZwLTY8EwnKMM6Vnmn437Or/E
         KtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775736750; x=1776341550;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztaBxn1mWCSAe+QhtrNy1Ix7HAjvKuuoSe45MHzSXb4=;
        b=fB7dddUN3dBEwjPLW50Osb5y0WqzjJNSNlnnuAGNEMeqDN9zhs0nfYBbG6VecatweO
         bH/13xQmRKMgjg+SKHNkinLEkfTinnhVblYoEME7ed2Bgy2TqsETiFgG0oOKjGFW6sFS
         KN9I/SwhQPjAUbQ1gvEggJ3O1FCDC+alKZgcmBbEXWYTDSFD3EsP7+n5FdzHYgCjHiO+
         8Xm9izeUeKzHTzo9bJICP0bwCyLePB4VP+Jgu25U3cxvfLXhTobPkzNBV3wj5HKRWMO0
         cJlnD3PrC+GGSfmg2Ek1fFOWUDXjNIHR1mOcq/1ljRF0Prtq46v8MX41GCz7DmBSiJgS
         PCVg==
X-Gm-Message-State: AOJu0YxjsyzUkJDSjAi0+S5y5jtfdEagPfRwbJI2IJQWdLtuaHj2/EyQ
	8oYhIiEW6cTcwrmKPbp9FmpdJrbr4Gs4AolaA1amit+ruGW2jM8j/496Jxa9yQ==
X-Gm-Gg: AeBDievw70yrnbk/9fqtU0jrDiV1iZH1L1MjaHVey1YAlBVbtQGy3iPEdxAP7XA+HmB
	ykmBzRsf6ClrwSbTbWlPuXuVxr8GJ8J71hmEnvU2kZMO5Yh0VBIgUk+HX9GL4XPLct2aUHUUWEO
	ykusN3JOvcDmPerdRZ31m+1tATynrpXwueUxoFoAn/OcU1oC8PtoXaRE//+VgMipT6ou5twopal
	T0a4/gKsDX5f4YP4tmYPCuCX8QwTsSyx9c8Rk/CCLPUCG4Mln4n/sZrzfYXn9NMx9IFz3qVg0GV
	4YB8p1jd58uR4ZvfHdKvBu0WNUs0kGCWvuP/DYzFBh9Gw/a7vKD444vtnIdJSywVCCrx2oyucsG
	ha7w82QRLCsnNElMB7/3Kysnc+pFenLISuH/QxH/sDCg1QEBNb78dtfvVk/5UDpgfzibbBnFK77
	ydBrOh+bE+X1qbrFWZYXjLpBupLfnvXuDa
X-Received: by 2002:a05:693c:3104:b0:2cb:88b5:a93e with SMTP id 5a478bee46e88-2d40defae0emr1934546eec.17.1775736750050;
        Thu, 09 Apr 2026 05:12:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.219.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cb7ec57f9dsm22574672eec.11.2026.04.09.05.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 05:12:29 -0700 (PDT)
Message-ID: <69d797ad.050a0220.4ce72.e910@mx.google.com>
Date: Thu, 09 Apr 2026 05:12:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7119744858872705832=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v5] Bluetooth: qca: Fix delayed hw_error handling due to missing wakeup during SSR
In-Reply-To: <20260409112233.3326467-1-shuai.zhang@oss.qualcomm.com>
References: <20260409112233.3326467-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7119744858872705832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1079179

---Test result---

Test Summary:
CheckPatch                    PENDING   0.56 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.04 seconds
CheckAllWarning               PASS      27.37 seconds
CheckSparse                   PASS      27.05 seconds
BuildKernel32                 PASS      24.57 seconds
TestRunnerSetup               PASS      530.06 seconds
TestRunner_l2cap-tester       FAIL      28.46 seconds
TestRunner_iso-tester         PASS      37.36 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      111.47 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         FAIL      14.52 seconds
TestRunner_ioctl-tester       PASS      10.17 seconds
TestRunner_mesh-tester        FAIL      12.62 seconds
TestRunner_smp-tester         PASS      8.64 seconds
TestRunner_userchan-tester    PASS      6.76 seconds
IncrementalBuild              PENDING   0.94 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.115 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
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
Mesh - Send cancel - 1                               Timed out    2.748 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7119744858872705832==--
