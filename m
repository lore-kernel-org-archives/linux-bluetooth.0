Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24352629D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770906629; cv=none; b=fFGDzxI6cK01Y2lDefpkfY14F8AXEjJsdtGvuohJnCUHxaT6HfcAxK3ocPd14q5UflTzTeUR08lmycyRyDMlX2dTrIRz8YTazCA5ivF2wsfTf4cG2IjRkp0cg9Ad6TrIFabzS9G+/LsYXFOgYM48Ulhk/obMUqDuPJaCrYnIhcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770906629; c=relaxed/simple;
	bh=mOIXnb6txCmSPtlc9qnVY3r9lxjnDKvUVuQZnOJoHHQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WrxuIBCxka0TKLbPUQYhr6FSjZvf3PedwjDWeF3/lgUIDDNtP8ul3ah8I8p+WHC86BF8cgjihx9eGyow6x5XwkYmW5fmZl8XtfICeM1Zj0VUltCYAHe/Bpv0lbY2twJmTUfJuv5N7oelxdiA5TRq3CUto/E2daSZ61ECpq87MiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaKf4WWc; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaKf4WWc"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c710439535so231305585a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 06:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770906626; x=1771511426; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o8W9gXS9Ui685atT98JJxSe7uSHnEN6Sq2sK4XBRW4I=;
        b=CaKf4WWcE66DDWCtMU9e2fLGxdbvDQGO8O0rJOEthaFmO6INIcw+ts0Swc0P/f20Tw
         FC6wlyDypC3wO5u5i9v0ipeNrfSmFNr4KWThwce7HDDnBRIYlgwEtJSgS8sYJxROROP1
         yqHXXXL1iPHnpbO6XzHIEY+YkGFb9Tv47UOnW0mqdVpTOu5SGgBMcE+WbN9GOKWoWmoL
         CA87ARCcrXqTrKIL0HR51k+5Xqu3m/HithHyVw7cwlnUnaudpJw/NBOhVP+7oZLcN94R
         +c+L1WP7o0OiE6ZEl7uOoly+1/Yi5xgj0DPpAAI2XqTNgCrh4GdF/iUsPrlnhmdKsTrP
         PkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770906626; x=1771511426;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8W9gXS9Ui685atT98JJxSe7uSHnEN6Sq2sK4XBRW4I=;
        b=RxqEhq80cwJ/mQk0f5RT8/eXfg4FjZNUyAen6MTrjotx5D+yoyflSb83cRhJoUgzaD
         SMsSjHYn6r3GWREcmtcB3OqtAtIxusLoba5ogPAZizfCUjnSO2ACMJBcX/FybPOuesST
         v3xOGmp6We2F89CEIRaPpCyxRUkZysjqKH1Hc6wM1ckG4BQoK8runNUNehBJJVRUpwaX
         8h6fysrXqcEtZJulgPbp8EQ/BJcX8wbgg7LCfStTblPVN4xpCwhJhMs/feIsFfuysX4Q
         4vidfvRmNMmWYIeEfu6DD5Ysbcd27s3HSNYKuL/pIxMepGmH9nt3Htw3Kbrxqp0JqqNV
         R4Lg==
X-Gm-Message-State: AOJu0YzTuUgoj1BRh+XQG2mqyR6UQw7tPvTmhjfJJJN4rFToeIMYsALD
	ZvKkGBbzBcM5uIN6RtzdJ66WyEoXb7VYOwGGO6sH+IyWA4I4Od8rCmDeYQL68MZk
X-Gm-Gg: AZuq6aJtFv8Hf47Ky5smgKKBVSzTQX+45i2ZQALa6tu0ok3z+hHeLmNSaY71GVNK0d9
	HkxjTwRDv+VGQPiSq21yCEkASvwVwBItYyxyY3HZhcNYvWXoChkS6PdFE8Ga42+5Obx5GIDbmRW
	TZItuxRTyuvb19tvkuTNew95Al4hvTAB3Xt729ipzcbYkJGm5TptZYBSuji11cdKhYO8S5CE5wb
	W5KaeOLGtdFRzJ0pHyJ5eK0LDIFzlDJM+aZ1IwPiKucqMIUzyU0lzdc27fqma1Z05TfCnmtL7eI
	G7QYsCWo5wWosluGc0ZAMh85HFJOJwAAC2RwcLwKBFU5y8hxqQh5twp9/vQ2X+XXFnKL9LXPOKk
	Nz2fDSKTNd179dLFb2PultylL2k4YL4K+R1lGAsz3l7GZa3gtx5pE/EIAbZXMJ8oKa9n0Tu8L+T
	XaHo1dFjoqLcNenfKw5CpA6eHTnW0a
X-Received: by 2002:a05:620a:6cc1:b0:8c6:a51e:eee3 with SMTP id af79cd13be357-8cb3506204amr220939985a.14.1770906625352;
        Thu, 12 Feb 2026 06:30:25 -0800 (PST)
Received: from [172.17.0.2] ([68.154.117.38])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0e16dfsm357295485a.16.2026.02.12.06.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:30:24 -0800 (PST)
Message-ID: <698de400.050a0220.3be14.eed4@mx.google.com>
Date: Thu, 12 Feb 2026 06:30:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0772322444128724604=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mariusz.skamra@codecoup.pl
Subject: RE: [v2] Bluetooth: Fix CIS host feature condition
In-Reply-To: <20260212134646.430396-1-mariusz.skamra@codecoup.pl>
References: <20260212134646.430396-1-mariusz.skamra@codecoup.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0772322444128724604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1053568

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.70 seconds
CheckAllWarning               PASS      28.31 seconds
CheckSparse                   PASS      31.65 seconds
BuildKernel32                 PASS      25.24 seconds
TestRunnerSetup               PASS      558.50 seconds
TestRunner_l2cap-tester       PASS      28.51 seconds
TestRunner_iso-tester         PASS      93.87 seconds
TestRunner_bnep-tester        PASS      6.40 seconds
TestRunner_mgmt-tester        FAIL      128.21 seconds
TestRunner_rfcomm-tester      PASS      9.48 seconds
TestRunner_sco-tester         FAIL      14.47 seconds
TestRunner_ioctl-tester       PASS      10.40 seconds
TestRunner_mesh-tester        FAIL      11.53 seconds
TestRunner_smp-tester         PASS      8.82 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
IncrementalBuild              PENDING   0.81 seconds

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
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    1.829 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0772322444128724604==--
