Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A037FBAC
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 04:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773030048; cv=none; b=rgdzjRZkjeKp2zI8N7YuIbaqKbWWbG13uJO5s4osRxbG+tJF/2/kBiPxOld4lCelaGcWlynH8K+m/kL9BtKnek641AEvGM2td42nR08Lex1jK3FQNIjizZ2Vub39CGs6AJMsC3ZxRmxGGja27F/EZFPolr+4anucJ049LpFNnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773030048; c=relaxed/simple;
	bh=4z2tSmK4sxq4ViL9m62E4Ad48l6KViinDXF8rt3E4rQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ri4f5GPrqIWB86CJiSX3C5djtbDKPnc/AAwopVxoMiaf/XqzVlWJXJ/pQSOsoK6JijbCp1D6Gy3EGrKAlSTeh92BV419FTAq9uGtcIlk9CPOO54vhXGMSCatUorBbN4Qafi6ZOL6YarKa3OcFRy/NoUAvJI+m7uxDLvINmq5TrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHgf0y7C; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHgf0y7C"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cd7284782dso122654685a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Mar 2026 21:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773030046; x=1773634846; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ISbbEVuzQ6YNa4x5+ojXUhnXmA1TprDOJZESwWF0YoA=;
        b=JHgf0y7CDWZssjTNDWmmVAd0/Gb/G58+jXQpirGPC3W2fvg1GcDdkW32mgMMaon/9u
         0LyqxnL5Du7/V+nEkzepRcBkLNswrJyvkcFw+WKAbDpORL4Fuwg1OdNTN4rrndjHLhgr
         vB/2yoMTbbsLe2kZmLb7tMZ5iowYBvP9VxDONIXB9UxZT6IJldVmP7ZosmAJwHVHtPIP
         Lot/4v/Tf/CyfwnzVtS6wvHP2452J5wS5sSRvEpXGZsjIUassT8PUGZJ/eUvKlPkXIsh
         nFK1CkY53A9arzWlydIRNv9I2mZheIvs8FsL2zuDqKZr6dJoxbsT3nQK9hvUYUOyOmHw
         PrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773030046; x=1773634846;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISbbEVuzQ6YNa4x5+ojXUhnXmA1TprDOJZESwWF0YoA=;
        b=AcOCsgKCAWDr2M6GcUJLnjtDZqw5gb5dIdHsUSp4KHBQhrfaSblO/SuQx0cCR2ZnbX
         Jo6GEGtzoEj4gzSIAl1I5k9Q4IvgDGh3x7z16l59TYU0Ayi43V6GdS45BbBIYBGHnJ9f
         MJoHa+/Ou+MUnHmbdCZx6J2YNjXaRNLiV7DfTnB3L9aIjzxaUCmL9/gNlYdi1HYblYW1
         1Usp39GwjpD8M9eLe43A3n7VOOQTBzJtrcVszqTS1c2K9+ysJsLxytASUoUlP89J3yg/
         082YzZCJL9JrtjkbIXuB6WY37kLtrhJ0lWljV4HS1VG4VWEpe+8qSS4uZNwhRI3i8M3P
         z8iA==
X-Gm-Message-State: AOJu0YxBQIKoXawAqI9otSTA/FmkJXA62Ozp+SzhTn3Z/KcK/yuBldUz
	Ftw7fGd/wRC/I1vpONWYOooYEf56MFTBQt4cHOY72hPJeRUEEVg5sVQFEVOZuA==
X-Gm-Gg: ATEYQzx/rXKW0IzxJBAP/r76+2YiwKtuaKi23VPHNQ3VQd84zoSTFGhC8ZJIQKmkbUQ
	PYgk+AA20ksiy4byWJyfIWFhQJHLu3Phn7oAUfSv3aCUeyNGOUkIErzR0OTwgTWZOuuxwTBRYwD
	PA4gGWYg1IsUrTWtMnDoLZSj/dGDBLAmGqk17lCGQfcq1kh/r3dY+0zXZdlpTh3wdKfMfzROh+I
	s4ZwB6xZS90QZ9jSd3sS3A4U4P3JC3WAtmKI+egZRVtLAXLDzj58zeQpA9G0QMN+HaguNSrAGOV
	WdaRMdjVknaBi4aMMk3ooos/2JbEFw3lbMI3fgAtwC8050YBDp7eyylQ3NrOXHgnRKxMD5dTFUz
	gSY0cX092IonE+8MoPbpMT6aF1r0RHPQW2vSAjo7J/xoTyUhXZDs3wuUjpX9mTxlpu8bnGHuImm
	A4iCcnq80dhDkB8+n1AflIKYNrluX2VA==
X-Received: by 2002:a05:620a:8c8b:b0:8cd:81cc:5568 with SMTP id af79cd13be357-8cd81cc58b9mr367276685a.44.1773030045998;
        Sun, 08 Mar 2026 21:20:45 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.100.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd88bef8f6sm135799085a.17.2026.03.08.21.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 21:20:45 -0700 (PDT)
Message-ID: <69ae4a9d.050a0220.17a91f.9da5@mx.google.com>
Date: Sun, 08 Mar 2026 21:20:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8807903978258307749=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v1] Bluetooth: btusb: MT7922: Add VID/PID 0e8d/223c
In-Reply-To: <20260309025850.3329543-1-chris.lu@mediatek.com>
References: <20260309025850.3329543-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8807903978258307749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1063387

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.52 seconds
CheckAllWarning               PASS      28.71 seconds
CheckSparse                   WARNING   32.57 seconds
BuildKernel32                 PASS      25.92 seconds
TestRunnerSetup               PASS      565.01 seconds
TestRunner_l2cap-tester       PASS      29.07 seconds
TestRunner_iso-tester         PASS      90.57 seconds
TestRunner_bnep-tester        PASS      6.36 seconds
TestRunner_mgmt-tester        FAIL      124.90 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         FAIL      14.52 seconds
TestRunner_ioctl-tester       PASS      10.37 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.64 seconds
TestRunner_userchan-tester    PASS      6.70 seconds
IncrementalBuild              PENDING   0.44 seconds

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
drivers/bluetooth/btusb.c:4673:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4674:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4676:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4677:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4679:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4680:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4682:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4683:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4685:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4686:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4687:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4688:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4688:1: error: bad constant expression
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
Mesh - Send cancel - 1                               Timed out    1.825 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8807903978258307749==--
