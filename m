Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3643B2F2B
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jun 2024 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718535548; cv=none; b=HvwXxYHvA26RHlR+qAn7kI/2cEEMwD0m4EvnCcDvjzHcyq7KvIPbcc/rOIVEKK4TDEOyELM4FuIArVkdz6nlONpoRAUDzSe4ACeaeibGgdWbhiEJSqDE6wTiHYpmiJMeRcYMYML37yiDJ3l8Dpl/O2v8nF210PazWfiIgANWxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718535548; c=relaxed/simple;
	bh=BxphZoD3GJkh7hWsq65lWbl1NmqcfmvMyAWCBumSAFc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NykJG9e4ag27OSX5IOHHWw3G8mQ9k8icOO/p18M3zIRFVs8fhbWZo1XPgc/3ybtXInFztyQE7AmnGRZRai9OaLaoRem9bT7z9f4BBtElk6fVQYVMeNCqlS4Unun9bNdkcbetZBgGlDYUX56vc+2x4Z6JctqEf5GovqlIq9sKcCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9j4/AcZ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9j4/AcZ"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6f9774a556cso2101768a34.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jun 2024 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718535546; x=1719140346; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gEe70plsvfdfP0Rv6Rpw6UZ9rB/p4741p2V5HABWAW8=;
        b=d9j4/AcZ3lVdkQJUNUAwfs6vWXGZVvI+JubpRD6npoknxhfYVSWzs8gk9gRgGdSSDr
         s4JV13u9v6wivr9X58iboADmLOpQehmoNZON0xQnQ2PbpMtO02Dy9pM0DnFRZiu6bF09
         p1KIN4vTafkcU2THVCbro64fYwsGj+Y7p+Al21Uf+b57okh3lIrAFSma2Nr4PRn1upbN
         Vw8SrC9q/B+7KDGWiQJnkEwX7ZNwpowRIEvrv9+1gVhnZLHZh4A/oFF3TE0ZHTrpy8lR
         7L1gzrWXdpd360F4+AMD1Jl1JXrki8zp4XdUiiEQU7k8EAryOUa1E1eGKw7/yxFbN+l/
         c7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718535546; x=1719140346;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEe70plsvfdfP0Rv6Rpw6UZ9rB/p4741p2V5HABWAW8=;
        b=KcqnoipkWdwg8wW9UiIwN+Cz99vfnoKKp1j6j69Hv8vuyaMHmYSkqAsXuJ5A5s9N0j
         efhKGNKpRt/2z1RzzhN+Br9DjxWZLVWAF4SlLBykA7BqZ5mxaH0NFG62GqVmVrEx6Iy5
         wTF0OQXoUtv9RxHeYMxELeuVhyV1X1m0UckzGQjSg/0U9NvMshtpGXuoeq1y/8FC/BTd
         5pAVxeCJpiN1sKMaDyWOHX6aiSmSb1E/lHeX4kMjxQT8epByNylaydI+LFHhP+JXn17U
         iqi83vOlyjuQo+LtEvH2KoPoSySRJPKEa+bBfTD7ao/ZjGrBN7tJFgYlH4XERnkdvIhu
         5NVw==
X-Gm-Message-State: AOJu0Yx7flIc+YCCWqBVeC7rfVkelPmotijg+5WvRd6N0QBvqBN2bvJm
	LSYFpliUoofH34FS1qvUph6/nJQCLKlMJwXV+JNbWmuscE0nYy1A4T07wA==
X-Google-Smtp-Source: AGHT+IH6qr3KBEhdJRSCbumIhyS60va8VshaOF/kvuKRRkFkE79t2OSSeitmWTOv4FmMpkMuV4leLw==
X-Received: by 2002:a05:6830:1d47:b0:6fa:91fc:fec2 with SMTP id 46e09a7af769-6fb9375ecf4mr7619159a34.15.1718535545796;
        Sun, 16 Jun 2024 03:59:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.58.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb4835sm42836386d6.99.2024.06.16.03.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 03:59:05 -0700 (PDT)
Message-ID: <666ec579.050a0220.39ff8.d4a2@mx.google.com>
Date: Sun, 16 Jun 2024 03:59:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5810291446581263846=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eadavis@qq.com
Subject: RE: bluetooth: handle value within the ida range should not be handled in BIG
In-Reply-To: <tencent_880C74B1776566183DC9363096E037A64A09@qq.com>
References: <tencent_880C74B1776566183DC9363096E037A64A09@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5810291446581263846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862356

---Test result---

Test Summary:
CheckPatch                    FAIL      0.86 seconds
GitLint                       FAIL      0.47 seconds
SubjectPrefix                 FAIL      0.28 seconds
BuildKernel                   PASS      29.86 seconds
CheckAllWarning               PASS      33.44 seconds
CheckSparse                   WARNING   38.13 seconds
CheckSmatch                   WARNING   102.54 seconds
BuildKernel32                 PASS      29.65 seconds
TestRunnerSetup               PASS      527.95 seconds
TestRunner_l2cap-tester       PASS      18.19 seconds
TestRunner_iso-tester         PASS      32.28 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      110.14 seconds
TestRunner_rfcomm-tester      PASS      7.36 seconds
TestRunner_sco-tester         PASS      15.04 seconds
TestRunner_ioctl-tester       PASS      10.65 seconds
TestRunner_mesh-tester        PASS      7.88 seconds
TestRunner_smp-tester         PASS      6.80 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      27.95 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
bluetooth: handle value within the ida range should not be handled in BIG
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#89: 
hci_le_big_sync_established_evt is necessary to filter out cases where the handle

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#94: 
Reported-by: syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>

ERROR: code indent should use tabs where possible
#108: FILE: net/bluetooth/hci_event.c:6896:
+                        if (handle > HCI_CONN_HANDLE_MAX)$

WARNING: please, no spaces at the start of a line
#108: FILE: net/bluetooth/hci_event.c:6896:
+                        if (handle > HCI_CONN_HANDLE_MAX)$

WARNING: suspect code indent for conditional statements (24, 31)
#108: FILE: net/bluetooth/hci_event.c:6896:
+                        if (handle > HCI_CONN_HANDLE_MAX)
+                               continue;

ERROR: code indent should use tabs where possible
#109: FILE: net/bluetooth/hci_event.c:6897:
+                               continue;$

WARNING: please, no spaces at the start of a line
#109: FILE: net/bluetooth/hci_event.c:6897:
+                               continue;$

total: 2 errors, 5 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13699512.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
bluetooth: handle value within the ida range should not be handled in BIG

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
3: B1 Line exceeds max length (81>80): "hci_le_big_sync_established_evt is necessary to filter out cases where the handle"
4: B2 Line has trailing whitespace: "value is belone to ida id range, otherwise ida will be erroneously released in "
5: B2 Line has trailing whitespace: "hci_conn_cleanup. "
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.190 seconds


---
Regards,
Linux Bluetooth


--===============5810291446581263846==--
