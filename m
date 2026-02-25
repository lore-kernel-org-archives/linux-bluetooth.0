Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52129350287
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020813; cv=none; b=NalHEKyiZQsSz/ceGJVWjptBro1D2eEkMR6RBETCW4xjZjTYHkdLAxkBmWdo3RRYGlsNE5i9ILM9H4r4skKdx9sj2ic8oeNJzQ/xsrab9HjtWG0gnsQ9c6eyaCblKQUHPHkXVuUV6wiB2Z2rY60rvycrypajFy33h8kKJVKg538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020813; c=relaxed/simple;
	bh=vo6a0/xlNk/fvA/8WrlQomGOPTuDBsh2Lcxt7zkldGM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VjnejGPobaCiwOBpY7JsAjbYhG4ES8sljtwurJvKPuEwVnCbe25RC2f5tNbXBsY7h9qYI/yR3BcaY8Ker115OGc7cRPKXUq8BoDDU22FHS1HHcZxDMqHGWmhrenzhqhirhhf8lPEwurpqWIswIcXBiudbKlioVXGTnN2/EGW6Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFfsejov; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFfsejov"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2bdca815fdfso372022eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 04:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772020811; x=1772625611; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qTk7zQml9lxp+ZyuhcfS9TWrOQs8Zheq0CkHM9lcBYk=;
        b=SFfsejovyaVUt4A4rlLIcRB9efnVpHU/jScl2OvSU+NBpT2r/XQWaMLx4oT43iTGG8
         +u7ehv0Q32i95BAxMMv7VbBSU/2Ikuid/QISg0O+KYvtMbKFVMNC/9hx79MI456U1NIb
         hQUlclhgGYKG7/XjVCnFq3dPeniUJUPkHrjCEYElZC9Tn4ARrWK8eSAu9FNS1vKh27cJ
         Ow7WiDMsaYsEPKOuV+ZN9s5LYYj/pzlh27l3Fkjt8GuJom1eYnl9HmtJQJLK99leyIPG
         mT83Sb8V5GuiI7KgHrpZpdldBFI5l5qB6Vcx38olJuXZ57vdEO6b8F36tnBF6d/RiKYl
         IACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772020811; x=1772625611;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTk7zQml9lxp+ZyuhcfS9TWrOQs8Zheq0CkHM9lcBYk=;
        b=kZsKfqrxqIZeY2Rsh5YZbbEIw0X6uGNL74j46Z1H8mm0ToASK+ILs42ItD5PL5Xtqk
         1LCneBmgjhipjb+TCY4/jImaYqMX7XIy6vHuKPPIu0AM8tmCv13Fdspo4Low/awx0+Ju
         cP8vAt86Jy01QiCXvkAPjH9FuRHhuqzOJngNcc19FHs7xrBNyP5+Dzmxzt4jNZ/oSGrk
         rXJTyI3Jalwx11GELNJbMck/7gF37JZyp+hs6jwsoFJ65hx4PP5E7iTjPoFHj6pFj9sM
         qo2iHrvUqi2/pxPv3DLwQr6AyxlX5sK7NZ5wC/2Zyn+TJdHjRtorOjJU3Rvfgtby/2Sw
         ZWsw==
X-Gm-Message-State: AOJu0YxHUm7ATpwCt6fTMI7HTWRlUxxpfLLxCqg03q3kBpB3M6KPHT3c
	WHOIwPRuoneOtaMBK4t0jKDGh47dxEd9ykAeJSFvyaVXbVaTZmkdSemBBCekxDfR
X-Gm-Gg: ATEYQzxKM4VVzjWhWPwXjT/T0c204i72bINHc/7q72p6Xhv6kTdVIUVvtA7dNSuussq
	KKdGRwXKFfPPCxdkPZxd9nV911Y9MzZghq/FC37ysHIsECN0Lnm5wU8BfbtRKi8CQTB7FrHvSBG
	9JDD1xbFsIHVSlkhZbwvt650dpKSJtX2l0u4ynx5Tid751Z/NWpFy8Qn11TkLsJqY0aET5xhe0K
	UVanHsgyNWnYviFS1AjJdTAGAg98Xt5OGLdmBEWdN0IdmhcbieaAqXw1Spcz7IPyk8O73a2ipfS
	UytLUR/OpNF3DOqiURsfIwddo4m75cxkhicVNlKmKETukENq3Q2JUHiA4ZVmbxfZdnh07KOzIW0
	MGi6yEV8UY05CLPhtKrF/OWOcgzrf/IeGRJcU0D/5v33IMPJ71ZIjk8ZcRwQxsr5uCEUsbGuIYb
	M78BBsytW0jLjRKywonnukjcfU0Hkt
X-Received: by 2002:a05:693c:25c7:b0:2ba:a1a5:b5b1 with SMTP id 5a478bee46e88-2bd7b9efc61mr6187117eec.7.1772020810938;
        Wed, 25 Feb 2026 04:00:10 -0800 (PST)
Received: from [172.17.0.2] ([52.234.45.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe78b9sm8580443eec.18.2026.02.25.04.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:00:08 -0800 (PST)
Message-ID: <699ee448.050a0220.3e725.0be2@mx.google.com>
Date: Wed, 25 Feb 2026 04:00:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5047527733837485694=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [RESEND,v1,1/2] Bluetooth: btusb: MT7922: Add VID/PID 0e8d/223c
In-Reply-To: <20260225104136.3943529-1-chris.lu@mediatek.com>
References: <20260225104136.3943529-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5047527733837485694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1057705

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.23 seconds
CheckAllWarning               PASS      30.23 seconds
CheckSparse                   WARNING   34.11 seconds
BuildKernel32                 PASS      27.28 seconds
TestRunnerSetup               PASS      583.74 seconds
TestRunner_l2cap-tester       PASS      29.57 seconds
TestRunner_iso-tester         PASS      91.76 seconds
TestRunner_bnep-tester        PASS      6.70 seconds
TestRunner_mgmt-tester        FAIL      125.37 seconds
TestRunner_rfcomm-tester      PASS      9.90 seconds
TestRunner_sco-tester         FAIL      15.20 seconds
TestRunner_ioctl-tester       PASS      10.89 seconds
TestRunner_mesh-tester        FAIL      12.54 seconds
TestRunner_smp-tester         PASS      9.16 seconds
TestRunner_userchan-tester    PASS      6.97 seconds
IncrementalBuild              PENDING   0.62 seconds

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
drivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4676:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4678:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4679:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4681:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4682:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4684:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4685:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4687:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4688:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4689:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4690:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4690:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4676:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4678:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4679:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4681:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4682:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4684:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4685:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4687:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4688:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4689:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4690:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4690:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.109 seconds
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
Mesh - Send cancel - 1                               Timed out    2.295 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5047527733837485694==--
