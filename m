Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C424503F
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497349; cv=none; b=cpGRMvCbNx8ta2h/umZSezUvvvR79xXkjMkvOH0MehO5nGSVRCEEb4u+KJ/dk/h6YljJ5Ig1HGmLHGtJBE26HoQV9ZQEGt0Og+XYuwZDxuq4KNOUW4nQUvG1wv4aeCg41cbQQ6Ou2aFc52wCCmJcB6vXjPHLJg9dAujLqogRtbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497349; c=relaxed/simple;
	bh=8JECnoabdjb0uQlY/N8esVx2WITbwLtcWxlkweqWQhY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KAKKahUYHyryDWeeY7oudpeV29hSF1sE7dC20EkinStQ1GCoo2dn8zgWMOy3zTlAFaofRSJv/T20uCCqYAOEWtf0MUvrwISFTwBOfM5rpEkQ1r9ybFpm58B1YYOS6Ml5Mh9OMcYYEANi9I/npesUdF3SgrJdoThvV5yz23yuX4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrfkukSA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrfkukSA"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7722c8d2694so943552b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756497346; x=1757102146; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oLzXbxT5zWshdFr+t+uVo3oHhRX6q/JQTvDdR3xkEIU=;
        b=XrfkukSAYju7IsJDYcgj1GDjAiQJAdJ98ui2p0/kgj1pABbIksPBL0U+igwRrfyjQ5
         QWYmm5iYs0Lfeg/F4gi7e+zytaevIzxcOtJZBQ5SA5lT5PMpgY77CsoF/DXm/tZE8YwT
         WZnkQHoE+PxolcEX0VgzFxua46F5Uftk8Q11SKWUBsbojjNHSBb0V7gwz/PI7ZZ2hw0x
         9wvT/16viC+1NtD0z+6LaxUILbqI0+U236QHQtROBNYZxEzZc6oE2gK35nL6f8Gbo9V6
         wEIrZ9b4iWs97Pit5uefU5gq1H3z+/a8eaHycwd/1ATaSodhDseFQ7Cp3Ud2d7Ipep7T
         5M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756497346; x=1757102146;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLzXbxT5zWshdFr+t+uVo3oHhRX6q/JQTvDdR3xkEIU=;
        b=mOMVXVzvbYGL9u95XpHDq4zkCMoFrZDpsWW9vzsRQTMEzQSXSIicZ61Q1wTfTke//S
         HWD86knKyuP8Mu1342/QGmepGuS+GFWBEabOP3BbrvLtK667FBjSRhyKmYvgabXNMNhy
         hRIKQUu+RvqgPz2cupblGihI2kGNj3Cv47t6/eCvb6ocpeQjVIVTeZKszBMl5zrQrC0S
         43hhyAjQqbux98j3SfkcXRtFwvHlrZEI4h86RX1L/jksVx8op5uvRo9CMhS20B2E2BCL
         XA3SMcZliJ/IXdAPDLJYF+MaNa0TaJ3ozMP6kGuYdrMe2Ne/dKD3ji1wGn/eaUZh6VDj
         Zn8Q==
X-Gm-Message-State: AOJu0YwJBWobB02rQfeuFzYLvfyDlUmKDLKGOzSfSnnFmFwn2QDvEVmP
	3YILc2nM3oHi+fWq8c1HyEL3yMK97u0Yt7DjQVGrurzyJfHm3ELhDzIhtprVhkc0
X-Gm-Gg: ASbGncvG8qO+c56GMHei70Gq4WZo0oGrGbOArkejAZlq+/wMSGYRBIGEynHexaYTwFu
	snfHZKJ3vHSbwNIKXFWRPZSbAGlL5pCisQ3SEZX9BHmSXJ58544DD+u781rL/V10OGrmhN3qlXG
	pL9yQB9ig10SO7docE2WR+OjqLyXyq1E+DtxjdB+GwpiLA0CZBary1AXqWxCb3fzmUVzJTv54uO
	j85xbPmYbPft/4EI/TV69Xbrlj+2R1IJU8AEsJYuhbLwI9qr4fhid/q0X352IiGGMkwAWXuGPaA
	4UmoqoRH6JJzWcPijd2uY8rBSAO+XjBLbDrxASqIG6gUCMKsOh5q0EQ6w2g3grTFZr/e/5N7wHW
	X0V+bXa9CDFDMjnRVtzsDGRRHCrOjN8SubLpLDs0p
X-Google-Smtp-Source: AGHT+IHwKREsmNx2RbF5QuhPfkYZL0GE3tjkYrY8STWH1KkP8SvIhV10nhkUJjJFZJ/2eAfdIE7kyQ==
X-Received: by 2002:a05:6a00:4b4e:b0:771:ed83:557c with SMTP id d2e1a72fcca58-771ed835a5dmr23062526b3a.2.1756497346036;
        Fri, 29 Aug 2025 12:55:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.126.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a0b3sm3227356b3a.10.2025.08.29.12.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:55:45 -0700 (PDT)
Message-ID: <68b205c1.050a0220.12fc02.de25@mx.google.com>
Date: Fri, 29 Aug 2025 12:55:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6715360362712077163=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/3] Bluetooth: MGMT: Fix possible deadlock in mgmt_remove_adv_monitor_complete
In-Reply-To: <20250829192104.2010557-1-luiz.dentz@gmail.com>
References: <20250829192104.2010557-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6715360362712077163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=997029

---Test result---

Test Summary:
CheckPatch                    PENDING   0.55 seconds
GitLint                       PENDING   0.40 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      23.91 seconds
CheckAllWarning               PASS      26.80 seconds
CheckSparse                   WARNING   29.84 seconds
BuildKernel32                 PASS      24.02 seconds
TestRunnerSetup               PASS      475.32 seconds
TestRunner_l2cap-tester       PASS      24.60 seconds
TestRunner_iso-tester         PASS      38.68 seconds
TestRunner_bnep-tester        PASS      5.77 seconds
TestRunner_mgmt-tester        FAIL      129.14 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         PASS      14.54 seconds
TestRunner_ioctl-tester       PASS      9.94 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      8.50 seconds
TestRunner_userchan-tester    PASS      6.18 seconds
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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.125 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6715360362712077163==--
