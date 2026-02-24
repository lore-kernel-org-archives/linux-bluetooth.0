Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE433806DD
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771934376; cv=none; b=Cltg5A8JT65Gr2hQQOgYw/05jUTTl5gpSgbyfVQ6L1VzS51APSJshjExtv7ikBDkXWUS6S1vJBKTvW/H39syQt3crB+fdmp2KixTuMPiOQDGTxf3tiwdA4BM/gsPnEGad7KPMySy0vbRnpdjW4Q0xJeMe+YgZPBpG6JOka9NqZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771934376; c=relaxed/simple;
	bh=wwX5zKMYmEF2Zumwf+u90nk0NFBMRurpxJn+p3kJ4D0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NLv/+Pr/3mykogj/zTNGcaTGtL7EaWEFpPENwGU8tB75VkRhjtuZjvPW0som9lOP6WFC/A5LKNYXj8IICVEovjOyvDQEuqz2OSVXuRy5PDMBzMfQbTIibHviKO2C9ZzyVsD33pz80BhJBJbV0gWW1dbBC47t8jmoLZOddx8EZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N208dfc7; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N208dfc7"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1275910b930so3993907c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 03:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771934372; x=1772539172; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lCzuK/vunJzQRzJRtwF7lhatCAteXOwsglChQ0H932Y=;
        b=N208dfc7OI6ULKMP3mYv/MjHK4E07j2swNG055dF6h6gk0o+X7A86JA6+a/9zlAKjd
         KnvSVm1vQeYwS0i1rwpgrC2c3v2C0mXBBgW4vX0xIHm7kcPwKQN+RlDGSQT2sYfQ3uu/
         N/+IHG9WfUYeF8LK3puZpwwIEQnsU9OAy92tkI+P1UgjkkBdTtuZB0QXLSbO1pZWnfAH
         y3XPjn/XbW8k9r6kJUvmneggwnHsBrJRI5quiwkBEJbn+R3Fm3XRoAtu44ADzOd+PX3a
         cBw16qS6gbsSCj+njVdXDjcCt3Nb9Jp6Rx280RlXk6tZDdpQ6Yj8yaK5D1jDQoTkLm3T
         iasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771934372; x=1772539172;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCzuK/vunJzQRzJRtwF7lhatCAteXOwsglChQ0H932Y=;
        b=qhr9MBRQ2zRilEfeSYyqQ6oSNy11ezIMhiXrNuukRp4LXXu4Dh0z2ainQAPBKg7pF/
         1PXsuZsfkX0pqnnn2c9uMExWtPMTXtdflPVkQ83UmRK+FCjdbpcnfvOaun0vne0FtZJB
         sZ118WSIlGH+/CAA0rF8zm6kSPOcU2PB8WKbD4UxMAgXgnWFwhBX6R0nSVja0MRTXBGI
         LrtRAk+Z41WsnOogZ1PJktNZH3Ovw4Tpk3T2i+xqsn/9DgWKUF+TwRwIU4xNsq1iEKGm
         p3K/7TH9Td7fZ/5/9IZf+wFjVDmhhFv0Ik0BozaBT1Ue+Z24nt09xEpUxkt5gPrnq/u+
         7Czg==
X-Gm-Message-State: AOJu0YzuBtb7AdXgOIE3vCG/AskTXQhkKiIGBXlNtvW1hwoQ+PaMtRcW
	evDcb/Ii74qiypXMhZD3XbksJSHbg49fXgwf6KVAvWrgeZvO6JEZtzPAoiI8JTUK
X-Gm-Gg: AZuq6aJGAsi3w9qMT0dRCXhxG2TMSH9Bo/x87VIvudA9XkcrJ9UyZKwGA2Yxqe3te6D
	Yd/FCcRFuvli3V/nma8sTvi5EuKoL0R8hg8YaFDNkPxQMRj6bjsHzQ8torQRxFkHVv2zINIu1Pf
	MqqGs2u65Swm53l48HXZ6hbjwfrMhHNC1E9L85mcdfOBQog+DGXYJ2jQhM+WN4hmrMRX/pxrMvA
	5CZMEYxve728bgHQXv98m5RDznvA5wrKBkMNc3ZpY1TZLqLJg99KhNoGXP1AaxcFEuJ9HT41dJr
	sYt3oQSbJ8Qs1zT+smPIHMznf18+twCliP93RkTZMj90vSiw/JtV01z57x6y7t0NLkUjNuJG5yI
	3Yu1YX8gZvFy07BMXXCbYMBBFeBfxYG74PtlOzxr+yycu2lDNAa6Mw/AIMjxpcrhxXdSO06pIm1
	HEBzMlgwtGbwscXZNlj8/aPk5flRmhCbw=
X-Received: by 2002:a05:7022:60a0:b0:119:e569:f86d with SMTP id a92af1059eb24-1276ab6bbb0mr4571877c88.10.1771934371906;
        Tue, 24 Feb 2026 03:59:31 -0800 (PST)
Received: from [172.17.0.2] ([172.184.210.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af7ad65sm9061108c88.11.2026.02.24.03.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:59:31 -0800 (PST)
Message-ID: <699d92a3.050a0220.375ca.6d47@mx.google.com>
Date: Tue, 24 Feb 2026 03:59:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7623466374580266321=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, stefano.radaelli21@gmail.com
Subject: RE: Bluetooth: hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x
In-Reply-To: <36a2c4c75e557527d101897b649f9de8d2180fb6.1771930508.git.stefano.r@variscite.com>
References: <36a2c4c75e557527d101897b649f9de8d2180fb6.1771930508.git.stefano.r@variscite.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7623466374580266321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1057165

---Test result---

Test Summary:
CheckPatch                    PENDING   0.52 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.00 seconds
CheckAllWarning               PASS      28.95 seconds
CheckSparse                   PASS      32.94 seconds
BuildKernel32                 PASS      25.47 seconds
TestRunnerSetup               PASS      558.94 seconds
TestRunner_l2cap-tester       PASS      28.47 seconds
TestRunner_iso-tester         PASS      73.06 seconds
TestRunner_bnep-tester        PASS      6.25 seconds
TestRunner_mgmt-tester        FAIL      113.22 seconds
TestRunner_rfcomm-tester      PASS      9.60 seconds
TestRunner_sco-tester         FAIL      14.34 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      12.51 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.61 seconds
IncrementalBuild              PENDING   1.03 seconds

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
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    2.731 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7623466374580266321==--
