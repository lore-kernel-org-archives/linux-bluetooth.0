Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D035F60B
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695283; cv=none; b=GRG4eCBr3EGHdO0faDeV4b5hfOcfjaaW4rOcAkTtKDfU7tJeGReASYrPIeZkONIvVj7yPX7OgN63O+uS6zU0654ieSa1PFmkS8b/2As6S5f+s1Q78ZxzQMagixhrmdI82nUC4884og9Uj5Pv3GcvBdSHz3brYVqlOiQlv+gZRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695283; c=relaxed/simple;
	bh=GwT8CYiSreiT2+NduGAv0gMhN7zHLnKNFotX2vuOoDk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p96eZoM8CH7A1WPI71kzYEd+wq+COMEU93AkZ2joO2NrMUMpEDUD2Q828ijBlr36agSogmM8f25j6ZXU76Bb8Rg4E2qFmXl/mEZQ3BT0lzP9TCx68U1i4vMwZ+RRGk963AFIGuyCY6fYNba455qCZpxJKOIQrwrJocdXtOmDvTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdXCYNWk; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdXCYNWk"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89c4b4ece7bso1690316d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 14:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773695281; x=1774300081; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xzD/nEJOkroOfmVrjGcvfAIjSjrYba0Fu2y+n+uYJ/Q=;
        b=JdXCYNWkVWnRbkQnDFqGHnlfVfurQQK09CGAEMwett9T7L9v1v04wFnKpvQN3p+u73
         MjaitrOUARZo9LBOzLmX5seJqCBi/wzwfTO7f+s9YKgBaogLfl3soye5xOdHU5+aizBK
         A32+FFiM/TwcoM1AM2m3bTzdYNcdtVi52/vbK3vhebl+JKpOG1CquqAYBZdc1r95BWVk
         YBS66CD3aXuhr8P6LyMW2zaETjxWl0aLEsDEUfYRwDWYiP17iPg5wAp+8UIF8G9qjKIx
         ClLyVQ3ZlAgCZuzeb7msfMnFRryeMhNswRnMLWcSM3ff5qRlq/sIX6zew35wjNT4ocBZ
         Dpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695281; x=1774300081;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzD/nEJOkroOfmVrjGcvfAIjSjrYba0Fu2y+n+uYJ/Q=;
        b=PH9oPUTrmAXxBPZQeMDLx+/RzWbOhOuCfUDJWTEpv1o1tSQcEh+xHCiU9fsBsdYhDC
         1xadDg84Ejbd0sWvWcrMnqIa/LsMY9dUJrSjEkiajz8v4GEr/68+ugkH353nYjQY5voI
         7VBr5yUzLERro6Gxgpl2ZF3f3MUeFg5np7fq/y2iamnL1G61IHisxKD3H8tgZZlqa1/W
         KQ2H9D6hRvbgiJ5RZla5qwdnEJUtFL853QK1gkiSpFltOo3H+y44b9EVuqXYcf5CBauS
         eG8q9qgvHA1AODNpNHqlEZpZf1+KpxCqjrJHObkWrWMv7+UzBrfk1AgCs0kU3bmJw23r
         lrBQ==
X-Gm-Message-State: AOJu0YyERpLmJCz+GpxgKrZNZH/1P7yFxYCxLOMcYoKsp056nkl9q0ZW
	dAbN19WSAykmRcXgoE2J8HKwyyRtiLE+fMMRLDcL9StkGNKw8IHGxSqPhOZE5w==
X-Gm-Gg: ATEYQzxJ5L1ChLXTCMzri8hgyakMCf6PlgCWrlIQ/UhOuHXi6B52HP4rC1MaONL1ir2
	bUhFLJwNspY+Ybz8boKIPXCpMXR+tB80P/9WUukvVrcoNWO88OVgeYh8DQ19OcdtBt3rilHI6QL
	0ICLIlFf3bxwdTUCepc6fQ8fFGqwHPVf73rJx/GuxrPK1ZMKWo7n8VyFhv5XFkfQpHY085Q1AK/
	bJ41XZkudBRqWOMpRJCS0qb73QXc3fc8dDlWHP7NASzZscP//Su+g+oz3Tt/9xuHnYfkXBJf3F7
	qMvh2Vc27cKOcSLAJ2dj3/wujq4LB/LOFvahw50A+8GZbI9WMnoy/van0pYWnj1du0zpcctk9nX
	uKSyy8Z6fd2Y48/G0ebP27BDBAr2APZXDb6oF5N7/qaCgtnB25hS/f+zMAhrFbXi0siMW+TWWTq
	7FcZlKeAV9NeZI1+dgvksF++FwiuM=
X-Received: by 2002:a05:6214:1c44:b0:899:fa7f:7144 with SMTP id 6a1803df08f44-89c5e3b219emr16544926d6.26.1773695280990;
        Mon, 16 Mar 2026 14:08:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.15.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c4169dc56sm54131226d6.18.2026.03.16.14.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:08:00 -0700 (PDT)
Message-ID: <69b87130.050a0220.184b6.fc64@mx.google.com>
Date: Mon, 16 Mar 2026 14:08:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5065231271624664210=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v1] arm64: dts: qcom: hamoa-iot-evk: support Bluetooth over both USB and UART
In-Reply-To: <20260311090921.1892191-1-shuai.zhang@oss.qualcomm.com>
References: <20260311090921.1892191-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5065231271624664210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1064914

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 FAIL      0.41 seconds
BuildKernel                   PASS      26.51 seconds
CheckAllWarning               PASS      29.59 seconds
CheckSparse                   PASS      27.97 seconds
BuildKernel32                 PASS      25.97 seconds
TestRunnerSetup               PASS      578.09 seconds
TestRunner_l2cap-tester       PASS      28.13 seconds
TestRunner_iso-tester         FAIL      35.02 seconds
TestRunner_bnep-tester        PASS      6.46 seconds
TestRunner_mgmt-tester        FAIL      115.32 seconds
TestRunner_rfcomm-tester      PASS      9.76 seconds
TestRunner_sco-tester         FAIL      14.43 seconds
TestRunner_ioctl-tester       PASS      10.54 seconds
TestRunner_mesh-tester        FAIL      12.58 seconds
TestRunner_smp-tester         PASS      8.80 seconds
TestRunner_userchan-tester    PASS      6.74 seconds
IncrementalBuild              PENDING   0.51 seconds

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
Read Exp Feature - Success                           Failed       0.102 seconds
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
Mesh - Send cancel - 1                               Timed out    2.769 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5065231271624664210==--
