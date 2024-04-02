Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC3B15A4A4
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079150; cv=none; b=Y1AV9gQXuj1CC/VDyYzbeRVRqrGuHpyL5Ne3sl0U6WQ4fDmlYXvRtcyLR+JdsC4Y2ad7Xo0YQZF4/yLJ/as6PpMM7Hu5xvHayTt+DxG2W6t4ITKSe9pRLAYUJsdnQncPGZI9HsyvKZUuu3if6hOfJYCrGEJ3O1/DmBfN6QY5wnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079150; c=relaxed/simple;
	bh=LpX3Kz0QwHVmJnXTij0dfK1aWa3C0PNI619gatxp2R4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CJJlAsYR1SwY8mqKEUwp+x96F8VtijXpdJZDiJlQ5wJH0k72fRvWP43IWrZv1+Te7dBBFxkMTY1wBXrMi9JYKaI5cngOYAR8jClOp+ZiI2F08QGfbDCfFPg5idn23W0+cIYyKqrQ9WSm/Pc/LGYURxhVLtcmw544eYLxOP1r+7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdE8fU5E; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdE8fU5E"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6151e2d037dso11511837b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2024 10:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712079147; x=1712683947; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V3K7u3rR0KGcsfseuUengOwdHZ9q5IaInEMCZx/hikQ=;
        b=jdE8fU5EffVFdnKwSfiWilZA08/SxaJ4QtO0ds3eRd+pPi47QMLr+n9a+xY0xhF+v2
         QbWGnpA8+1ciPOCp/UiWrMtz0Ve2bCcRMTftAJ6gysD+9pmFL4HIrQ9brnO0+6wqsK3b
         Pnr4bLStTJNbclIM7e3cIk6r9WExphV9hfMkqvAsOkdk/Z5mO9U/L1zd3QcAazF72lp8
         LJa2wKDC0N8+IKHMdDzHm5YJYRLQnQXuQX4wYWix1noA3mViMSbInzQlcX/aJbZ9cytm
         BTaPpUKqIPMNAMrR8sI/LawAhDrOwHdvgGnqBPodmZ5djEbw8Oew8iM3S5kNBvr4L40e
         b58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079147; x=1712683947;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3K7u3rR0KGcsfseuUengOwdHZ9q5IaInEMCZx/hikQ=;
        b=KnbHcNbdsm/qZPW6vxPC9QwJA+GZBkSfb60dADjU/wKOTnoXY9mQFBkGTTi/BM/kt+
         yMt2GmnjI3toe3n8UPgVeJApPn86EAcZCU3RQ/26S7bDWYQza+fZg9evW29oqk0f5k1A
         IaGqo35ME2VbpKPGdBH9vVv3h1+FN/xm1W+8Hd6EXMDLJosqWYgNyOw++YNMpQVSpD1I
         Pkllz+XrKLFR0I+4inbC2FpvM5UtOXVijQPuv7AREBpfvOCCvHcPGhps66cHoVSmSQf/
         kCYblWD3Jb0MFWZFpYMk5DX2oIhX73Ko5bJPKSo6ckXS0v8wq3wLFqDWjXIx8qDIuq0B
         usow==
X-Gm-Message-State: AOJu0YzLulq21uHJIOn4SB9by4btHvsP1cS6kyBkB08TZs2j8/ZKWDOI
	LeuD2E2WIKTvaptxUuA72gB0bFIzhQ8/F7XEGJkbku3vVtK4wgUlIihudGM9
X-Google-Smtp-Source: AGHT+IH9l3+sBncTw44P20xR6bhIxfyayBheDM0JEUaOvo7XVENwJxNM58lWtqDCkx80DWhtywN6/g==
X-Received: by 2002:a0d:d4c7:0:b0:615:2e01:d48a with SMTP id w190-20020a0dd4c7000000b006152e01d48amr1999643ywd.13.1712079147457;
        Tue, 02 Apr 2024 10:32:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.154.106])
        by smtp.gmail.com with ESMTPSA id g185-20020a0df6c2000000b006146c0a39aasm2066722ywf.145.2024.04.02.10.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:32:27 -0700 (PDT)
Message-ID: <660c412b.0d0a0220.bc993.9280@mx.google.com>
Date: Tue, 02 Apr 2024 10:32:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4516450158816577684=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v3] Bluetooth: add experimental BT_NO_ERRQUEUE_POLL socket option
In-Reply-To: <b44e1da7ebbfe99b74c136b8750981a4fb0ab243.1712075760.git.pav@iki.fi>
References: <b44e1da7ebbfe99b74c136b8750981a4fb0ab243.1712075760.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4516450158816577684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840716

---Test result---

Test Summary:
CheckPatch                    PASS      1.65 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.13 seconds
CheckAllWarning               PASS      32.94 seconds
CheckSparse                   WARNING   38.69 seconds
CheckSmatch                   FAIL      36.02 seconds
BuildKernel32                 PASS      29.44 seconds
TestRunnerSetup               PASS      527.55 seconds
TestRunner_l2cap-tester       PASS      20.01 seconds
TestRunner_iso-tester         FAIL      36.46 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        FAIL      110.86 seconds
TestRunner_rfcomm-tester      PASS      7.38 seconds
TestRunner_sco-tester         PASS      14.92 seconds
TestRunner_ioctl-tester       PASS      7.85 seconds
TestRunner_mesh-tester        PASS      5.92 seconds
TestRunner_smp-tester         PASS      6.89 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PASS      28.46 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/af_bluetooth.c:225:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic blocknet/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
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
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.208 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
Read Exp Feature - Success                           Failed       0.076 seconds
Read Exp Feature - Success (Index None)              Failed       0.073 seconds


---
Regards,
Linux Bluetooth


--===============4516450158816577684==--
