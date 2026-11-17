Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914593;
	b=Pe2blarj+oHUNinhyewsmidOYS6i0HqAi7vC6AfpHUfDi+uakxOJMc7dAoOAxhLE9tZd
	 gfLYFKFA6jcvg83irw5kEer4qo0+xFEUJNQDOxDGG8xfUHWBZvaTdwnDFc1VUJY3z8xAy
	 5y4xIf4y5Vok4WtWwmcwRDvA7nUc1iIXaLSctZMjiknxOt4G0pqlL++lEkWKVW7/FMcyI
	 MTWKZwYuhdVuOcHNArWWbkYnB+YsHZrC17WpJFY1qpVdWC3sReGbhMwaZ9sfzLXPghHaj
	 OBTJBPvIqNB7isu/ZGi+lgrd/2oRWQCA2dtg2OWqN7YyPbbu9n8Rr9KbUgQ5NNObZMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=AQ4x/JNIOZjxvzdsTKbbIQMdInTfNa0TWaaCNJTRLkk=;
	b=rEw1gx4WCGZQHne14BcHhgf1aArLoX6M5cwc5PQOiyIZGrbcww5uTXtfM1Nw7hODYw2S
	 H6mvXtIdOCymj5k2NdH4ZP8kcGsVJ2cX5d12DAWw1lfV07kzo7ShYemfCWXqlil6/HcXq
	 Wlj0ekbGgQ4P+eASPvExbgJW5hzhEe1y+85rp7MinJZ1ejESg1rJ7bkrkOkiRsfVC29AA
	 mAItvHxyRZy31sY5s+W1V2v8XhJff7dHqd1sHwYn4pdUyKJRx1vDLEnJS6pjMNBvGn6uL
	 b3KLnjV+s4ik1XKUgcJQD6pDFUBC0zK6Ovmut/cNBJPOXeLEakzCC2WQegOHdIh0mOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CeGfZUCF;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB6606A330
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 11:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22AB6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CeGfZUCF
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-71ad099391dso1340465eaf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 03:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794914592; x=1795519392; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AQ4x/JNIOZjxvzdsTKbbIQMdInTfNa0TWaaCNJTRLkk=;
        b=CeGfZUCFpGpOzvwYezL8eWBGixhy8WtxklYyEbdKEFbR9cj/+jqMw5c3kUlwiLf8S3
         iCVlz19p0CuUh4fW/wp+N7ihdogVtlrrhiHJsUX2In3uvu1Y495mVFo4BzyPLxEp+TIf
         AmBj5iEV9C/DqXCCCJcDoUacd1TTEA36QJsUuAUMsjLB4Mz2gh2hso2pFTG23GYLK86L
         I3ITeush8VL4rwCnpgyi0jujZ9F4J2h9X25rFVgz6QVGDfny2J1ixqjJVt2j0BTHQcA5
         AEs4RY3qiT1IRG0aacpvLoWh8TaIyYuuS1QPIgQ4S7tCZI1DRaRCqSpDjCenQg9Y8Efl
         ArTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794914592; x=1795519392;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AQ4x/JNIOZjxvzdsTKbbIQMdInTfNa0TWaaCNJTRLkk=;
        b=UKjhymUN29ykObY2S6KCyl8mBU86mQpBrjAtaAvs8pMO2Avhi0kFV75YiKJSOj2rzs
         7URzTg+vD5M8+EzFy+CWMkN4S3wyDT+jd6nYP+6GrYo/EK3UGQEdh74cQskCdHv2YrpI
         C6fHDtYVVCp8Rv0KXHDymMEiccY77Jez1tHFwXIgieynqyxig4fDcY33MFF4EzQQuDAP
         /35QAMn5nJPCk9Yk3uHNmPuXqYPaZ9YV7IP+wYKc7ZvMfacwnYDnTPu/2XeJiF8i2+f8
         ymWXfTIe50Nsw9gYLlSffa0GBOFgzhbshXCqsaoN3K+Y0Pu6tjQ0iel9ujqqWFL3i3jf
         evsA==
X-Gm-Message-State: APuU4Z+3DDcmaFfC1NGWZMxg8vPFjC56CTeiN5yGdD7B4APcrX15FC5y
	VfKyrMI4n0SAY5qqWCQQmnwYYMYrx1zCpjtvGNDlXjEjI/b3AMS3RToR6jWk7w==
X-Gm-Gg: AYBFou1Q4pa9dL7+YgSW/F/Knz+u0s7GDxQZTqTNZcQ7TEMztyFtSCRlwHIfjBKI17P
	1uV2b2bTltZ2W5dt9Q2g3KP7tqb3ZCch+uWdoW58x8wEWyCrVtvPwogWhon8mVcYkB+UxOeJwvJ
	/ZagPZmNwtKDWMO7aT8AQHSiGll04w7+Gq/vuVUjVzt3VLVlFs1kt9V5emVUXYt9jG+WZW/OaOB
	qzU7L3xRDK10G6Q4YAQknvkqB5QUHY4NAiotIuuSiw1bk7U3hV1twT+1uZ7hdwKfasY+8z/m+Ue
	VTuUhdKAZ9r4ZCGYSw5+s/tyssRlKa16G39OK2iyMQ2XC9WWUQsg0/VyQVFQBTixlAZVtcfZqyb
	xCGL6acbCN1+17H7mEU7MBIxid6ZBv7K0q39KNbkaPc41jojPokG1clj10aK7VJY45ohl4YiFkC
	rEliGP9TSDRVXYhZHNlEmTO4+4aZXZ10pfSbEYVFvvtK28JqqCWZYy8XDCZR5ZrVCKPa7AFVJHU
	9qsQswU1dLMzpkLDIYRTDLbPW7qXaatmAqfGYcQKsX9n1Ng8NmcvoTyjfEFwg==
X-Received: by 2002:a05:6808:4fe0:b0:4e9:eb70:b98 with SMTP id 5614622812f47-56e64df5911mr16213928b6e.32.1794914592056;
        Tue, 17 Nov 2026 03:23:12 -0800 (PST)
Received: from [172.17.0.2] ([20.29.60.110])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e6fc42a8asm12443207b6e.3.2026.11.17.03.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:23:11 -0800 (PST)
Message-ID: <6afc391f.24a8470f.359c5.be84@mx.google.com>
Date: Tue, 17 Nov 2026 03:23:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3655799892979800613=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, deaner92@yahoo.com
Subject: RE: Bluetooth: Fix work queued while hci_dev_close_sync() drains
In-Reply-To: <20261117023344.278269-2-deaner92@yahoo.com>
References: <20261117023344.278269-2-deaner92@yahoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3655799892979800613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1213344/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.65 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.81 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      18.92 seconds
CheckAllWarning               PASS      21.45 seconds
CheckSparse                   PASS      23.41 seconds
BuildKernel32                 PASS      19.56 seconds
CheckKernelLLVM               PASS      19.68 seconds
TestRunnerSetup               PASS      415.63 seconds
TestRunner_l2cap-tester       PASS      14.99 seconds
TestRunner_iso-tester         PASS      11.13 seconds
TestRunner_bnep-tester        PASS      2.91 seconds
TestRunner_mgmt-tester        PASS      83.86 seconds
TestRunner_rfcomm-tester      PASS      4.06 seconds
TestRunner_sco-tester         PASS      5.01 seconds
TestRunner_ioctl-tester       PASS      4.16 seconds
TestRunner_mesh-tester        PASS      5.08 seconds
TestRunner_smp-tester         PASS      4.01 seconds
TestRunner_userchan-tester    PASS      2.86 seconds
TestRunner_6lowpan-tester     PASS      4.02 seconds
IncrementalBuild              PASS      21.95 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/3] Bluetooth: hci_conn: Free the unset handle when adding a connection fails
WARNING: Non-standard signature: Assisted-by:
#135: 
Assisted-by: Claude:claude-opus-5-5

ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
#135: 
Assisted-by: Claude:claude-opus-5-5

total: 1 errors, 1 warnings, 0 checks, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14991326.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,2/3] Bluetooth: hci_conn: Refuse new connections once HCI_UP is cleared
WARNING: Non-standard signature: Assisted-by:
#139: 
Assisted-by: Claude:claude-opus-5-5

ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
#139: 
Assisted-by: Claude:claude-opus-5-5

total: 1 errors, 1 warnings, 0 checks, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14991327.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,3/3] Bluetooth: hci_sync: Disable connection works before draining
WARNING: Non-standard signature: Assisted-by:
#139: 
Assisted-by: Claude:claude-opus-5-5

ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
#139: 
Assisted-by: Claude:claude-opus-5-5

total: 1 errors, 1 warnings, 0 checks, 29 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14991328.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/3] Bluetooth: hci_conn: Free the unset handle when adding a connection fails

1: T1 Title exceeds max length (82>80): "[v2,1/3] Bluetooth: hci_conn: Free the unset handle when adding a connection fails"


https://github.com/bluez/bluetooth-next/pull/1142

---
Regards,
Linux Bluetooth


--===============3655799892979800613==--
