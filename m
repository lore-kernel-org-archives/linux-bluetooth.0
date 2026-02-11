Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633E61A0B15
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770843343; cv=none; b=KG91FFb6HAi2r6fWXrAsh9ujVAio9MBoQTaWRUqTFdrStaYF9EW421vORbpBjI8SHOjOlGqZVdkaIf65K+Bp0a4XFNRnHJTAx0gF18UofoxiZSQOfQ1094w1AbB4IukjyhD1km6onwMA1Il9bp5KNq9EWZoba+tksURUa81ICKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770843343; c=relaxed/simple;
	bh=ste1+tqL/fML7DO+/4MhioqLx6WT72HNSf9vUpYrNfw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=s1j5vQ8KvuRnOIrj+ad1QvPm4TzIO1eORsFgouQnocahC1u+TfWPcLKKsisWfJyQyn+Bj52oqf7N4e/zPAq+oKzGJKJttGTDKM1m8h/Lew19MYq/Et2RNuP+bDUYHnAHYl+K1zAEM2PLpjqdp9eX0eMO/xABvmlgdlF1eNkyr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8JxfXjS; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8JxfXjS"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c6d76b9145so254849885a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 12:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770843341; x=1771448141; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=plCN+uQW9bPFIAF/M1jEfOU45NDB5ze0x6F7GRGsrH8=;
        b=X8JxfXjSeeTS9E7C2MIN14FdS0N45gCajfMfJuRxRe40nSvYxaecXLSe8VR7DNIFA1
         pU4xtqrFFVA0X1wlyniyyKTj2IX0Pg0YzLZghek/Ejiqt9RAsGOWwbjRNCi+W3i2JDJ1
         ODKk6FbplqCuxQRP0T1ftP7xBp2gxXsZTz+v0nQQ4x5RDe2dwKfCttGGgwSa/QqypoGI
         VlTvG4YrgEM6/lQEP33dL07oGD4HMyqvviBU5CkuCl0bosZBsy/A1BkgR08rilLZBjJc
         E3g27b199KRwRLGrM1U3hs4U2NWsUfrzKqGSv/zetjWF03/xQ1P7jllh2CLtvOvyHpQl
         JeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770843341; x=1771448141;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plCN+uQW9bPFIAF/M1jEfOU45NDB5ze0x6F7GRGsrH8=;
        b=Jymg53XRLGWLJVH9BE+7p2KAKkuqxikxxnfSRgZwYDT/k+5Oe/FjpNiVrtVAhJT52b
         goe8pS+1RdjQaICwVGRgVUJvR8+zNLymOKhPsk2Q4laTzcUlwIHZtcvAS2YC18Ezi1D8
         aF/2b43tROES4ffN5VOZqPr5/UXUbEt4o9Owf3TOYFGjOGb96+0uQ5ULeiVCSEK4nggz
         +FmN3Z3nZSTxs0TaG668fYOGnZ4d7TqYly4ZGLnMqvz91VzNeIdEsTLMXXtAJ1MQFtyC
         EyjgVHV4Kg3BOw32GLtVyQXwO89Xjykrn6wmIfVrXuylrujvoDf0hZy64Nadz4muhm/4
         U49w==
X-Gm-Message-State: AOJu0Ywq6g1MaPHKErsVWy6aFQZ/lbsNOr766XmMI+l+Vqh9+QjOBbkq
	Ne9W8pAVrVC2XjFkE/f6mch6Cs1KPBHJAxNgVz9u/YyNS1XM3Y+0kGgIBOMiZTW1
X-Gm-Gg: AZuq6aIoyzzIkOAam2fulbhLNdwSC8GqgkloBK+eG1dequO7blhGOp22HWsycGzrTta
	l9R6mvFG8Q+xl9QKqmC+NPWFVex1MkiZKIy0LfoxhSqMN1yDTm3eZdGwwPew13HN3JYiZh57UNP
	MFUsTS+kuf0ycFGz2IAkNRVEo7jFVGiWs4X1WMDelZ638akTrOE9AzqE4iI0Z1h7j/M1rIBVoD8
	d/OV064hEH2kQJgOy3CvsEjnq/o9uFypqOaBwl0pOoxHTLReMBMqMIeI9IvGYslS8dyWzMCU7T/
	dNB9+6ayp0uzOpRlEjT4QTTUTDYDbacam89hntTBWY8pTfLrYTuCmwJRfVMwAkqaPn5wNNfr1SQ
	XP4sqZ1vvyOm8gFnzGz0POdznaLucF5WNJ49JczKBEiRGcj1ia4fZst5korofvUkyAkGvJ5yAmk
	1Q5pUnjuUZu2R+bTC8jtzfAfTbPz+IoA==
X-Received: by 2002:a05:620a:4489:b0:8b2:dd0a:8809 with SMTP id af79cd13be357-8cb331a712cmr75610285a.89.1770843341043;
        Wed, 11 Feb 2026 12:55:41 -0800 (PST)
Received: from [172.17.0.2] ([64.236.192.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b004eecsm196893185a.0.2026.02.11.12.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 12:55:40 -0800 (PST)
Message-ID: <698ceccc.050a0220.1b4cfc.56a5@mx.google.com>
Date: Wed, 11 Feb 2026 12:55:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3060231331375931940=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix response to L2CAP_ECRED_CONN_REQ
In-Reply-To: <20260211202815.1464211-1-luiz.dentz@gmail.com>
References: <20260211202815.1464211-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3060231331375931940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1053246

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.86 seconds
CheckAllWarning               PASS      28.39 seconds
CheckSparse                   WARNING   31.89 seconds
BuildKernel32                 PASS      25.36 seconds
TestRunnerSetup               PASS      577.67 seconds
TestRunner_l2cap-tester       PASS      29.96 seconds
TestRunner_iso-tester         FAIL      62.16 seconds
TestRunner_bnep-tester        PASS      6.68 seconds
TestRunner_mgmt-tester        FAIL      126.49 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.79 seconds
TestRunner_ioctl-tester       PASS      10.65 seconds
TestRunner_mesh-tester        FAIL      12.48 seconds
TestRunner_smp-tester         PASS      9.00 seconds
TestRunner_userchan-tester    PASS      9.54 seconds
IncrementalBuild              PENDING   0.89 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/l2cap_core.c:7765:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7766:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7768:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7769:1: error: bad constant expression
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.114 seconds
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
Mesh - Send cancel - 1                               Timed out    2.608 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3060231331375931940==--
