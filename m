Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086B20D4E9
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772271855; cv=none; b=GkbC4iMpPeNtwKhl7Q1ShqFP1Uh243hs+DwMwYu3dOfuuW64KbnOFyelS/xT0pyXWHbtqpfgt8w9DbV9EkKI3NMDN2pXX3drmFk+tWpCZOidu+N4pRJzEnGtpox8QOBXmH0TOORBwVdf3Eh4aosZ3Kw3kkFpOR8qY46DUYuGG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772271855; c=relaxed/simple;
	bh=aZvDCwciVrNSqT/FUcIOcP0xvFANuWs/JEvNFT5Y0sc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dXnSiYQHqM2X8pCge4CRwYr1U+W+PZz1W9n5zYPb0QLGa+RaZGT6GKfKU3FlMoU5u95INvrsv4hw0UuoMBX1WAnU6YbgOpgIe9bn3MezHof0KocZ+BFM4d2FSn064h9sEwVZsBeYbFfgdKPG1oDE4UCwPUMHEuzUUQDG6z08xI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQYpiqor; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQYpiqor"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506c00df428so28404851cf.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 01:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772271853; x=1772876653; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9FoERd9ZghRkFw4Sh8IQ8gad4Dc0XgJ96YVSnnhjayU=;
        b=CQYpiqorfLuypFicnJBX+t8F7GgKEZGlQ62FsqnzyAqxKGAd8lPU/cT8LeZTBgfq+7
         xfdsC3fAbO1fhlUvH/QdZx/nqeY69R6Z7kglX+VHIJnXmeWUEcZ76Xin/SOIArggSKrX
         fz2ciOwlB7+EqlzoSgbFezyNY+moQzynY3dkq7afhPweAVdlNYmE6ZwtCOpJCZpEOE8z
         8w+hMea8MxTZMg8/lV7h1aU5Ym1I2rewCfGoAU6EztwhdR9orY4T/wmYsYkIdSk9ND5n
         T9SSBASt3a7+Zny0Lss/dPAeMrQw0nFV76CxBXlTPuOiItV3HSPtUjKrHmmx18rdxnwj
         x2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772271853; x=1772876653;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FoERd9ZghRkFw4Sh8IQ8gad4Dc0XgJ96YVSnnhjayU=;
        b=phH+1Oau5wnNqb/IC2oSwmbestXNKLAS2UxiC2tkxtaDi7VXPOkDndQ242R02PeBhm
         j6+hF7Lyx02glwuoicYX5a2PTwm3GwwtXeWJIL2bqVEV5+oB4Oe4UQ+C7F39n4V6qnqm
         oQnj8qSXcNGg1DJcx3m4klimqSlcUCHQ2xT2fVWbQsZLnJlaJLxuzxnn/qM/0GGSU17b
         iuV30IAWwWgCTh/005Hghpq8akvpZvOd2LU8Vg2+Ap4Ns0LVSk32daMnzCaf9u3M1hRi
         u9nkzXFslFSA9BoCiBnfuRecaw62WsM+azFcqMWZEvdbSDiMer3fNXTlqqr9Tf2usI+S
         1vgA==
X-Gm-Message-State: AOJu0YwEf1tgvwaul26Bi3qOJ4dQNc0b7B74YSheTDsLEZKM5bP5BbGc
	cB/d0ePaxuJHfSJZptvLubXC91x+KIMhxO2cgOU7m/oPun6Lo+nN+XC2hnAGVw==
X-Gm-Gg: ATEYQzwEAz9d8HWi6XxACDujuXMw6CW1dXwdIH/T0KxlyAWS7111VfR16I2DNT2lVmn
	Rpmb8xgY0w8TlNZShAOsv0zbygjBSq/j4X3IxJPf9uuNprL/h3x0SUfdEPy1mG9W9tknRpNzpdV
	Oz2V3FV3LwnHUt44fJMNTMP3/HaMSRrEOvt4+K1PHSv50MaMCYsZ6iFr6/CabZBKSineAgClmI7
	BLRLrmipbYU/45/czgDbbNzmfZiReAwJSWNkCTBi3jchRXUVtwQxf0GUcW8PCCD0F9DEW9PEuy0
	7En/qZUicpR4AskJS2Lhe0BdrdPRbO3BBougx27JBS8NfQ/gQVoSxBIwQrg9WD3+S0LX4QkLK2o
	M+EXLkW55GoeGzlmrs4knK8b3FKrYRMGbfvH1vEReRLDbNIGsRPPeLaFmEiXNmH711BAGYw9l3p
	hnJykDp3FGYtwnr9UUQuILrjPwUWQW
X-Received: by 2002:a05:622a:288:b0:4ee:2721:9ebe with SMTP id d75a77b69052e-5075293a93emr70008471cf.53.1772271853117;
        Sat, 28 Feb 2026 01:44:13 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507451cda23sm69176821cf.18.2026.02.28.01.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 01:44:12 -0800 (PST)
Message-ID: <69a2b8ec.050a0220.1b5bfd.5139@mx.google.com>
Date: Sat, 28 Feb 2026 01:44:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4810890085903513191=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3,1/9] Bluetooth: btintel: Add support for hybrid signature for ScP2 onwards
In-Reply-To: <20260228091239.230284-1-kiran.k@intel.com>
References: <20260228091239.230284-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4810890085903513191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1059383

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      1.10 seconds
BuildKernel                   PASS      26.36 seconds
CheckAllWarning               PASS      28.75 seconds
CheckSparse                   WARNING   33.57 seconds
BuildKernel32                 PASS      25.51 seconds
TestRunnerSetup               PASS      564.20 seconds
TestRunner_l2cap-tester       FAIL      32.72 seconds
TestRunner_iso-tester         PASS      109.99 seconds
TestRunner_bnep-tester        PASS      6.52 seconds
TestRunner_mgmt-tester        FAIL      127.78 seconds
TestRunner_rfcomm-tester      PASS      9.70 seconds
TestRunner_sco-tester         FAIL      14.62 seconds
TestRunner_ioctl-tester       PASS      10.45 seconds
TestRunner_mesh-tester        FAIL      12.45 seconds
TestRunner_smp-tester         PASS      8.88 seconds
TestRunner_userchan-tester    PASS      6.87 seconds
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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expression
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 94 (97.9%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP LE Client - Read 32k Success                   Timed out    2.232 seconds
L2CAP LE Client - RX Timestamping 32k                Timed out    1.877 seconds
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
Mesh - Send cancel - 1                               Timed out    2.725 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4810890085903513191==--
