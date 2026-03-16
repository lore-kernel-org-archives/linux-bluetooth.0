Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A335F615
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695262; cv=none; b=No77LPkaRy1lqL4riA+aXR1+cIN6s/tPOt6ulnCi44QVvlwsHsZET0ks6ZjSjnpfbfIYK+bDzM48Kdqmah2HHbMfD5ljWvp2zXbdAyI/fx5WiiiHrkH0wh3nfqG2TlCqWb4VAsbrbEPDtJ6JqfcsbwE7GgZ5QR/9jPl9bOLPr8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695262; c=relaxed/simple;
	bh=RnIJ1Jxyb7+ljLLwHMNRzA3F8HZ+fDr0nR/mfrYDh9U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QSwF3q1CR7CZ7LU992JY+RfQ0LFbfrL5TVIelzq3+r3Y2I5JCK0CkCZnNEiaCJZmqlNJM88XzQdSap5/hB8eGDRkeM9SD4JY0tAnRKhM2tn2QCfPLHbPA1ePIKZgCgQ3Wp82SutYASR72aw4Gz69Ebth3wjB0+7CcRaLcNs5a80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXQDOtPL; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXQDOtPL"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-66f3e7d9eccso3113856eaf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 14:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773695259; x=1774300059; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d0ytTQ/WM3oVSpSatIPIjHY9l8QCxqMvG+NJmVD4oM8=;
        b=FXQDOtPL/jxi86p8nrkFu4uARzxKVyBOUtx8pIpTQbricn/t4qLCUKiLjL94MPV2qp
         f/ZFT+17GkiV0amCbO9YryH+Kz7y6cL6Ka4m74zA9S1wjollc5S4AhIwMJxURfha1uX3
         56+XbTulaoHlPSM6ln6r+RRmHwBws4Z1w61NwU2+hr2tkPPU57u/fBXd9NH+ihHR2YRR
         OVl5brHggWbtqz+PGkSv7bXh6WINdtgNJALBas6LeoVmy8hjSk9OFRnIQ06kHUoKjixz
         /qqJ/MR9w52InyLyHrhqlobFOQ/4SzDQHRdb+MOKO4EshNkQkx894mGISFjOIS13Lycx
         4UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695259; x=1774300059;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0ytTQ/WM3oVSpSatIPIjHY9l8QCxqMvG+NJmVD4oM8=;
        b=gQ6qQfC0Z/rSmmWXnGDfWRllJMtdcw7BsWDgMkhHLVu4sa+8saOuGiTcP7hQ2ERc0b
         79VjaTclCoc+PpM5J6jVLQ1Qb0jknt2cAZ6xBfaXdCvFh8fjC2z2+ih0qgy3xeYGJ3uk
         PBRGPneruai112VOxCeLV92Sz/empXDzP5TWAIenHWOxFfSDo5qY04Cfx2O6KturcykR
         Qpjbgr6eSmSqr4MQdU8j7qz7X83UsNePr4MCrp/0aIhDdUQvCILH1RPGG437NbWZ6BVV
         iRH9vceaOLM9YI1kdxb6qI0QQQlc24C5gwGRRIwDy4q4ac8QCiEbYpEDLu2KrNJ31AEt
         No/Q==
X-Gm-Message-State: AOJu0Yz59DbpyonF/ARlk4UVDrH2g5mmVSPIi6mJKd+N6UKQrTJyKwU8
	mg/+5ETMYpkA4n0Fj23Jm6ZqT6xXHUofWPliQ99fSuKDIJUW+9xtcTGyqG4uNw==
X-Gm-Gg: ATEYQzw6NYhcGDw/DsjrHpFpR7Pzsy51XbJjBDSqsKUUzWHri8WKIaBsXvxWKabm8aD
	6U4+r+9Y2pfCf1qapuOqqtj/KXhY/Ryk+dCM5zaPFygTMphjogYVXRN6NJxPPFFHzXZt28Pvm9u
	dSL3ZtotEk7k4ovNO3uH4/uTL7iR1ue32coyDlHSBweIoXrQFug1nUz5O0dRH8S0u/aAav+xhG/
	UGbVrpE8WmolbFqAKpHKO4dJ8GdzpKp5Tl8ktjtEVDTepMZvs6JPp8L2w8DvIHEBlWl6kNLZbm3
	go2T2lATAXfzz4gWGz/w7O9wY2HL2dzZgEYjfr1RrhgR4A7t67OcZXgy8xJQ6vEHnkLx8plFsVO
	OgnMUBPuPYrTduB1y2gk709Yh1n/o+NJOc+uKESs71d1tfrZjTnrLPXaT2Alwf7HFRnfoq8aY8V
	2h4jgPU6GBKtgHD9eG3qNJumCjWg==
X-Received: by 2002:a4a:e909:0:b0:67b:b8d0:a7cf with SMTP id 006d021491bc7-67bdaa6f1a2mr10479103eaf.63.1773695258821;
        Mon, 16 Mar 2026 14:07:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.29.22])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc9342ad0sm10003381eaf.15.2026.03.16.14.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:07:38 -0700 (PDT)
Message-ID: <69b8711a.050a0220.4a940.7172@mx.google.com>
Date: Mon, 16 Mar 2026 14:07:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8747424942709628326=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jlayton@kernel.org
Subject: RE: vfs: change inode->i_ino from unsigned long to u64
In-Reply-To: <20260304-iino-u64-v3-1-2257ad83d372@kernel.org>
References: <20260304-iino-u64-v3-1-2257ad83d372@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8747424942709628326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1061374

---Test result---

Test Summary:
CheckPatch                    PENDING   0.57 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 FAIL      1.28 seconds
BuildKernel                   PASS      25.93 seconds
CheckAllWarning               PASS      28.57 seconds
CheckSparse                   PASS      28.58 seconds
BuildKernel32                 PASS      25.37 seconds
TestRunnerSetup               PASS      564.29 seconds
TestRunner_l2cap-tester       PASS      27.71 seconds
TestRunner_iso-tester         FAIL      52.39 seconds
TestRunner_bnep-tester        PASS      6.42 seconds
TestRunner_mgmt-tester        FAIL      114.96 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         FAIL      14.36 seconds
TestRunner_ioctl-tester       PASS      10.38 seconds
TestRunner_mesh-tester        FAIL      11.59 seconds
TestRunner_smp-tester         PASS      8.71 seconds
TestRunner_userchan-tester    PASS      6.74 seconds
IncrementalBuild              PENDING   0.74 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Timed out    1.849 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8747424942709628326==--
