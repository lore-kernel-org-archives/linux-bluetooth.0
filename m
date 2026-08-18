Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B2284896
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 04:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787026544; cv=none; b=sDARsTavdzjDAx9fFHFDXPNdETu7tUbKVOSrhQzH4InqMFpF1d9TLgyLw+oDWoGV0Nl/zCHFFq91kZN8wFU+UyQz1BagZUq7Hftq2z6r3KH8M1Ne4GZuzXzGqQ6+BMj5CyWWWWl00lNPGm/oLH4jONFPIpUnsEzRMWU3ByLc5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787026544; c=relaxed/simple;
	bh=QMUVVWE+6ria3wJ2btE55ydOAbQE4mtLsswDw10tn14=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hwBkn1ZgMjIZnG7TVZWeeE78Mt78gq6RQIwfR6VoQYYsLOGqoudmGydgi8zNXvv21HG1xeo0OFVAQk4DXhsoyYhAdQkRmJ4iYzBDrHIolTjDtCfQBxnyTRlJDQtVxFQg3CS+S5FB/GvWjz1UUqnNmIBYQrNbHx9EnFLqK76V54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uq3AdF1I; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq3AdF1I"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90898faf46dso5834106d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 21:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787026542; x=1787631342; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gnFYreYd0qOH0MNY7xQ7OM5UC9iGZu5IY9FTsziQ5D0=;
        b=Uq3AdF1I8a2BiEmgjQQ9Pu5EDORnwLTsXkeLBz5BsKPSQcMA+QPVWlKr/wewBIScBK
         /KSBWNPR6npPRqeeagVJUPXesN8pKp2XweScEhGZex9qows3JltBmKYINMPmRNnl6Ugj
         tka9ADPUR/nlhsNhYpuWQJ/Z10T1JVfsNMCZ52OUz5O0Qx5kIBCtkSHWqGA0KyXp3l9R
         8zvmgydO0TZHanhSMG4wCwkRyHZLHKf/J5ouHU8etYYbYqSB60yHTghaC5gM6w2whovB
         lEYKSUZXN7KBcoU8DGfTvFYNZwFnKrBl0dnPmO9lJEIxHCNNGgq/h3G/W5ZsGnCmpqVN
         YmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787026542; x=1787631342;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gnFYreYd0qOH0MNY7xQ7OM5UC9iGZu5IY9FTsziQ5D0=;
        b=HoM54jNnEsSfqQI74g+qO0ApwulK//c+L/01uIj5Nl6jFDYE7StKquVj37LvwdWsuN
         zOWMKxB2b21JvrQt7nscK1dE6uV3Ih15bynN8HZft2MXaFeQB+i4SwXLOzRtHl7fCZ/H
         UeBbjLWuw+oygPem4RzpGQ531eFytsc67dBETJTjSInIW1vlva1FFPz7f28tLX5uFaY3
         psbM2CwLdFsrf+701jejNEP2qC53yXf7otGjiq8QxaIp2fbP/LJsWwJYMjR8nofrDMr/
         7qu4Y5CIRNezo3Eab80tI76gKbnDzNFI7ip7TiNiWXxJnkBYm/ovXaUrvLPaD//MkSxO
         UzQQ==
X-Gm-Message-State: AOJu0Yxx05ZgeUEQDj0H6yuGpweNUs2P4quaqbnLfnAdQMRCbO49s9VW
	d2jIZrYatpmKHQ+7b4jvTixXA+YQxyjV59MnUun76zGvsNf6pezCWn3jS8j4eg==
X-Gm-Gg: AR+sD11kVqVzRIXwFijmVrBNNFuAboGRt7/5Is3CiyxFDH1fZ9KwMJzVl5qR3irqt7A
	xWIN3zHje+y2CQAFh3PW2mjP000VlkDgB9VG+eJiZgZbbT5Dv9ojnK+dNg3jMrt7REmOe/Fq/fx
	yiBOrMrPwoefeqX9yofyrl3JcqCMOVJAmTh/TCjTtqfEzM/BzvUT8tEzXl8YN/E7mHTQRnafYO/
	rNu+lUA+k/jUMStZrMLxsr99I8+lHAbu3z8BnBjlP3z+adEGpeVSlO+eWbng+QOtMsBnEhPhZda
	8UUDZaeexer3hhtgkhk8HJC7Bu6enOedrCvUtE7GPICcOSYWGWchvtqXOPUiikU3UzBxyMWNS7i
	CAlSr+nOWYLaXWC5V2bN3dLhpq9y0cfT8bBcdwFuuMgXdJZ7O7FkMM61FITXp0bHuiVdMIg+mTQ
	tYm4ow5y+Fs23AVWHpo3BgHQSwKz+bW4YIcVC51HfXaqwz45qA5deM6o3RaHUkTPPxMlvQaA==
X-Received: by 2002:a05:6214:ccd:b0:8f2:860f:4dec with SMTP id 6a1803df08f44-90a91d650d8mr323667336d6.15.1787026541526;
        Mon, 17 Aug 2026 21:15:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.34.43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c45936724sm24179646d6.27.2026.08.17.21.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 21:15:41 -0700 (PDT)
Message-ID: <6a83dc6d.7306e961.36f27d.0266@mx.google.com>
Date: Mon, 17 Aug 2026 21:15:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6995856967215229372=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, george.0xfff@gmail.com
Subject: RE: USB/Bluetooth: recover MT7925 after warm reboot
In-Reply-To: <20260818-mt7925-rfc-v1-1-284d856ac572@gmail.com>
References: <20260818-mt7925-rfc-v1-1-284d856ac572@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6995856967215229372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147517

---Test result---

Test Summary:
CheckPatch                    FAIL      1.94 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      0.66 seconds
SubjectPrefix                 FAIL      0.26 seconds
BuildKernel                   PASS      27.45 seconds
CheckAllWarning               PASS      30.18 seconds
CheckSparse                   PASS      28.91 seconds
BuildKernel32                 PASS      26.45 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      504.88 seconds
TestRunner_l2cap-tester       PASS      66.18 seconds
TestRunner_iso-tester         PASS      81.14 seconds
TestRunner_bnep-tester        PASS      19.30 seconds
TestRunner_mgmt-tester        FAIL      225.09 seconds
TestRunner_rfcomm-tester      PASS      25.60 seconds
TestRunner_sco-tester         PASS      32.45 seconds
TestRunner_ioctl-tester       PASS      26.93 seconds
TestRunner_mesh-tester        FAIL      25.95 seconds
TestRunner_smp-tester         PASS      23.96 seconds
TestRunner_userchan-tester    PASS      20.87 seconds
TestRunner_6lowpan-tester     PASS      23.51 seconds
IncrementalBuild              PASS      27.95 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,2/2] Bluetooth: mt7925: recover subsystem-reset timeout through USB re-enumeration
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#114: 
  Bluetooth: hci0: MT7925 WMT func ctrl timed out (dev_id=0x7925), scheduling device reset

total: 0 errors, 1 warnings, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14754479.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC,2/2] Bluetooth: mt7925: recover subsystem-reset timeout through USB re-enumeration

1: T1 Title exceeds max length (87>80): "[RFC,2/2] Bluetooth: mt7925: recover subsystem-reset timeout through USB re-enumeration"
36: B1 Line exceeds max length (90>80): "  Bluetooth: hci0: MT7925 WMT func ctrl timed out (dev_id=0x7925), scheduling device reset"
76: B1 Line exceeds max length (82>80): "  Bluetooth: hci0: MT7925 subsystem reset timed out, requesting USB re-enumeration"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.254 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.995 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/604

---
Regards,
Linux Bluetooth


--===============6995856967215229372==--
