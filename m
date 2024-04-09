Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C412F375
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668090; cv=none; b=QoUMIWf5gyKUBrs/8LHP2GqE0MjTdMHY+4xaBOpqFSPhL6NxjL6ykirhKXopSfZih1jV+wWCiKo9b9aVqag6lJysiyB+XCVqLvkPO8hdFt3OUBH7LAm1sv14p4B/k+UJ8F8OOP9wE7jz7GURXI0CdE2JNme6SZAHs+5DA7KoVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668090; c=relaxed/simple;
	bh=HVk7+i14K8jZ3wMKgrRPLTcgU2RWSfkf1ZshvgEKvtc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ARXP9k2MOQPGvc2MyeM1QN0EmZfVXbOOYl4cRrSWswYPYXDBnhe1X4rgNYslISFYht+QjCRmmPm5YkT0gyZdRMLuqXGPZJ7Ldb9WZ+kwRi7+9T3VDIJkfaIuonT7nE2nkw2KRlT7bjpSIiYbq0ii3TEcRENDuVGNvHZWomjdhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArBEQx1N; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArBEQx1N"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso5006558b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712668088; x=1713272888; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PRMdT6BoV5bbf5ys+VwBqD78dWStZhKC24PoJcmngis=;
        b=ArBEQx1NuVZVjeo0tBmiwTwtu/PIztvVquKSQZ1xNX/oAumbeoun1YdcjogtYDyw/I
         k4xTc264cvEin15FKOUGh7T2Q5h2NprKS7yKaRx1y42Xv5kcAZ8USVR5gTXVwiwB7HWK
         lWIWa9HZ0xSKH2akNQadAmT8frEl9YI1Lx30gYSOOwN6uQHdGsG2aFQWzXLoz031CWDV
         y2BlsSyzh4mBxVoA+kZo3F67MhYcK1NqrDmPbDGi0y2OCCzXG4ivz4jvLecbKiVrgDUM
         EaiTWG4z2pD7pNL7fx51IZP0uTmCc5kWf+kTlEmAjPe8p5pmkgX2p0mmjzBfcUHb6lwF
         EESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712668088; x=1713272888;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRMdT6BoV5bbf5ys+VwBqD78dWStZhKC24PoJcmngis=;
        b=fkJyjcTC1VGbVRwoDeA9HKPbYTbCXxxUrkK1ahnCpQiO4f95OtIeTfUmooAuMc82x4
         vgL0FVdUt7/5QYLoT3QgfN1A+Y5BvGSuFyvkOWAIyZ/An45gVx/fv7+zHcoG2wPG7oQh
         FMECI/aa2rymWdUnYGCwhG0SSxdNqXXDXu0kv+IUNVzbRRRsL5oOr/w3+711HXVRUnXt
         5xAyVqV44CZBQmUS8909A3xsbiG6FK7pyjPFKmILgclHHmXkFb4iAj0OrXcI5WSeEGpN
         qWg8Da7Ppk9Gd7xu/IiTowGd5xnQMeygoCHBVC0UGuEdOO+7z7zYRUq8Ha633H+dtage
         NMqw==
X-Gm-Message-State: AOJu0YxfhXwTHQSy3IN9G6Xn527G6SNfv1iRYX+W5+oj65XXQvk12pms
	qIaD4GgGtz9sWkNXKTb0gVnTqP4oZVk4qK7hNPofgbvxVbuxl+QSxfOv4evB
X-Google-Smtp-Source: AGHT+IFKUX5j/vrpoG06Oe4XzgNnZR2/OnaR2Zdlcx0Bvtc9eRNSYiwzwuDPbbR0zaWspUtjtzarPQ==
X-Received: by 2002:a05:6a00:2191:b0:6ed:9760:9ba7 with SMTP id h17-20020a056a00219100b006ed97609ba7mr974397pfi.22.1712668087723;
        Tue, 09 Apr 2024 06:08:07 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.123.150])
        by smtp.gmail.com with ESMTPSA id fx8-20020a056a00820800b006ed4c430acesm3032341pfb.40.2024.04.09.06.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 06:08:07 -0700 (PDT)
Message-ID: <66153db7.050a0220.7ac3f.86b4@mx.google.com>
Date: Tue, 09 Apr 2024 06:08:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2586163578802291296=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eadavis@qq.com
Subject: RE: net/socket: Ensure length of input socket option param >= sizeof(int)
In-Reply-To: <tencent_15CA920ADD9ADDCA19654FBE8DB5A5B88D07@qq.com>
References: <tencent_15CA920ADD9ADDCA19654FBE8DB5A5B88D07@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2586163578802291296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842803

---Test result---

Test Summary:
CheckPatch                    FAIL      0.88 seconds
GitLint                       FAIL      0.46 seconds
SubjectPrefix                 FAIL      0.43 seconds
BuildKernel                   PASS      31.15 seconds
CheckAllWarning               PASS      33.29 seconds
CheckSparse                   PASS      38.65 seconds
CheckSmatch                   FAIL      35.17 seconds
BuildKernel32                 PASS      29.25 seconds
TestRunnerSetup               PASS      532.15 seconds
TestRunner_l2cap-tester       FAIL      17.25 seconds
TestRunner_iso-tester         FAIL      35.88 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        FAIL      113.82 seconds
TestRunner_rfcomm-tester      PASS      7.51 seconds
TestRunner_sco-tester         FAIL      15.66 seconds
TestRunner_ioctl-tester       PASS      7.73 seconds
TestRunner_mesh-tester        PASS      5.73 seconds
TestRunner_smp-tester         PASS      6.71 seconds
TestRunner_userchan-tester    PASS      4.79 seconds
IncrementalBuild              PASS      28.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
net/socket: Ensure length of input socket option param >= sizeof(int)
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#86: 
The optlen value passed by syzbot to _sys_setsockopt() is 2, which results in

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#92: 
Reported-by: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com
Reported-by: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#93: 
Reported-by: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com
Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#94: 
Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>

total: 0 errors, 4 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13622424.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
net/socket: Ensure length of input socket option param >= sizeof(int)

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B2 Line has trailing whitespace: "Here, optlen is determined uniformly in the entry function __sys_setsockopt(). "
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 55, Passed: 40 (72.7%), Failed: 15, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Client SSP - Success 2                  Failed       0.072 seconds
L2CAP BR/EDR Client PIN Code - Success               Failed       0.057 seconds
L2CAP LE Client SMP - Success                        Failed       0.060 seconds
L2CAP Ext-Flowctl Client - Success                   Failed       0.056 seconds
L2CAP Ext-Flowctl Client - Close                     Failed       0.064 seconds
L2CAP Ext-Flowctl Client - Timeout                   Failed       0.061 seconds
L2CAP Ext-Flowctl Client, Direct Advertising - Success Failed       0.063 seconds
L2CAP Ext-Flowctl Client SMP - Success               Failed       0.069 seconds
L2CAP Ext-Flowctl Client - Command Reject            Failed       0.064 seconds
L2CAP Ext-Flowctl Client - Open two sockets          Failed       0.061 seconds
L2CAP Ext-Flowctl Client - Open two sockets close one Failed       0.066 seconds
L2CAP LE ATT Client - Success                        Failed       0.063 seconds
L2CAP LE EATT Client - Success                       Failed       0.064 seconds
L2CAP LE EATT Server - Success                       Failed       0.060 seconds
L2CAP LE EATT Server - Reject                        Failed       0.059 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 121, Passed: 120 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.164 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.171 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
Total: 15, Passed: 12 (80.0%), Failed: 3, Not Run: 0

Failed Test Cases
Basic SCO Set Socket Option - Success                Failed       0.085 seconds
eSCO mSBC - Success                                  Failed       0.078 seconds
SCO mSBC 1.1 - Failure                               Failed       0.079 seconds


---
Regards,
Linux Bluetooth


--===============2586163578802291296==--
