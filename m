Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6355E402BB6
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589358; cv=none; b=cWvX80AfyZlw1hPEtIV8AiFkBSavGdnkeTjjmJmTcwCVwFBMydD85AmyiWyRr3XO2SNhzZTq7vrRJcTgwwRTHtQ9BRGSkvgnstrbbI1OVjttUyhHTyf0dv+guMbkgg49ouJRisKjCaGwR5d1nxMT9WsDBBeTefYfdkYRRdXHUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589358; c=relaxed/simple;
	bh=+Y8G7EyONQw4uotJLwcE0ky47fYKcDDxmWUDMv5iPQY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Yiy2ausFlZRRIXoqkblidaia3dFJlMKo07DoOdJsx2/3Fa+LaCa8xfyjZ+onSnBKbQgMU8C23vOR+ojY+abzHmSah4AHnkFLW2g+OvzbtcFWN4QPKbXR2Y3SoemY18mnyjuthRNfgdJET64y/6pbzYKn0P8K3U88hDE4H2A156g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIkWH6M+; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIkWH6M+"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f23e851626so12480546d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783589352; x=1784194152; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8Udh0s8eb/DmDiattibC7+UwyNERTU1Pz1KiEIX9sl0=;
        b=RIkWH6M+t6gExkJDDE47IUCcnpW/fAeZdT9UBwOJvnFkguwToUdfRpGhkpGDZBn1Mj
         LC715XXlptSR8g6OuXqJeba4+WL8ykrZmW3+fsNzxmcJYqquBe3HfXalsL1ACbb8dgpg
         fSYIbkfg07TIJtefQrmMnkJ32U6uy0lxAhCYd/h/M9SAPkORDl2O7FzLS90tPeyivSkg
         t6xY64U9OOc0M931WFr+QH93kDlRF+XOMmvH+cZ7P0qQoUmyxOJIpx7rt8UngVVinuDe
         MxVqHOgWTuPL+mdVkffTVDLxSXDBBi8+I5IsyUnIQTaOl+asbeLax9DXPyqIi4tuH6wK
         DKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783589352; x=1784194152;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Udh0s8eb/DmDiattibC7+UwyNERTU1Pz1KiEIX9sl0=;
        b=nS/ocyVVAfLLYDdIomgAkPNmoyXHchbhQXh8mJmjbbPQYLkaSvBNr1fKvXAATEyHeu
         ribjtgH8OdYpAwiD1XmFMjtwvAZPn2+7DlMGqRK8oqVNaLExRTCxZAjedzS6+ek9kHG6
         egBbtGJz5dveihEFlM/YBnrFdxBvFiwCvmEMANL9QEnokTiVZ2c6H87j9f/Y6GttQIB5
         ZI5T6Bm6Scz+Xkz/xbYlyTNuLJGsZtcGFmTE0nE1U+NxIrYwo6U5uvTUsjG97ImczD6W
         3acMd0s7XiTxHQhTvFt5ykSTG1kCgTNgIvWr8wGGSIoDOhhiQiYjrFNtqIN0H0G4g9wX
         8L2Q==
X-Gm-Message-State: AOJu0Yy+lZGuzX3Bx7TADwvXwqh7Og9enTzep/WZVMag4kT9vHQWzl7Q
	ykP7RAH57h7NIIZok0ZXOSjGSBoRVPDZ0GzMitGIgop9qu1IBQj9rzghdjYphg==
X-Gm-Gg: AfdE7cniRGkWWmIDz1cJFLZD0JSTN2LXaq9ZknyojqEGB1e1Ak0tjY3jJRH6mq1A3UF
	WCVq2Q97W28BLurDxuWFoHHwBcqz3r1vtc2doXpmzg+MbAqPG5ydhfQMYRXoDJ99i0iUIbU9iC2
	32nhtu0Mnu1b9WS1mHT9edwvqX5AF9IJZRtSddj/JPVyRTInJ9XpxlNrYu9g3vB8b8ti9er+bYw
	EDFZ8mgwsI2OaJuTk8pYtyz7TDuGawsHKUO4xNVD12a3VlOW8Wjv1eWCWOAKKumJ4cVClR0QMzb
	RW8ytHp5QZA/v9z/wcMI+Fd4siC4MFolTMqXb19D/koZbrjo+9DD4QDWq4zPFImfMfuCPQmQCyT
	nPNUn0SOGRbyFktNKI8X2lUt/CMe4SrsI/hUlEoOze62crH7vzYQnV7U2zjZE+GIDs0MhpQPEyx
	4bemGItJMX6pOuU89ZhuI=
X-Received: by 2002:a05:6214:c8e:b0:8f2:5a3e:c5fe with SMTP id 6a1803df08f44-8fec3cf65camr68753116d6.45.1783589351673;
        Thu, 09 Jul 2026 02:29:11 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.135.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbac2asm13518886d6.21.2026.07.09.02.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:29:11 -0700 (PDT)
Message-ID: <6a4f69e7.4aa243c6.1c4077.e83d@mx.google.com>
Date: Thu, 09 Jul 2026 02:29:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1339491246711760190=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: btusb: Preparation for upcoming Qualcomm QCC2072 support
In-Reply-To: <20260708-btusb_prep_qcc2072-v1-1-d835b187fd01@oss.qualcomm.com>
References: <20260708-btusb_prep_qcc2072-v1-1-d835b187fd01@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1339491246711760190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1124323

---Test result---

Test Summary:
CheckPatch                    FAIL      14.94 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      1.98 seconds
SubjectPrefix                 PASS      0.78 seconds
BuildKernel                   PASS      26.94 seconds
CheckAllWarning               PASS      29.49 seconds
CheckSparse                   PASS      29.35 seconds
BuildKernel32                 PASS      27.22 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      505.63 seconds
TestRunner_l2cap-tester       PASS      60.98 seconds
TestRunner_iso-tester         PASS      87.99 seconds
TestRunner_bnep-tester        PASS      19.11 seconds
TestRunner_mgmt-tester        FAIL      216.23 seconds
TestRunner_rfcomm-tester      PASS      25.43 seconds
TestRunner_sco-tester         PASS      32.82 seconds
TestRunner_ioctl-tester       PASS      26.48 seconds
TestRunner_mesh-tester        FAIL      25.93 seconds
TestRunner_smp-tester         PASS      23.21 seconds
TestRunner_userchan-tester    PASS      20.16 seconds
TestRunner_6lowpan-tester     PASS      22.61 seconds
IncrementalBuild              PASS      54.44 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[6/6] Bluetooth: btusb: Build the driver from multiple source files
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#167: 
 drivers/bluetooth/{btusb.c => btusb_main.c} | 0

total: 0 errors, 1 warnings, 6 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14674248.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.250 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.200 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/414

---
Regards,
Linux Bluetooth


--===============1339491246711760190==--
