Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1B1E5B63
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771060714; cv=none; b=fg+FS9hP94juz1mIo9P2J0Y9bi433DIWO2JsH3KRKZxSqRZJMoIKX1tJ2yfH6hSYBhl/HV/TaemywHSj+ni1cFiKM5z2ny+ePXrk1/UlMQGI4fYUf9BA+phjB5CXf7a6rIjom7ndy3Z58YhPm/5z/ehKkdyk00+MDKDLnsufbNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771060714; c=relaxed/simple;
	bh=GZcAtUmRDfSKxMWLkglhpsEHxzOhSPG6tVsCv6gcTK8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Yh4ET8UamK4SWSDAv2u91t3yQP0K/7FtcPozzjDrgByvUb1uY52COmPzmY0tsXQvhuVPW2vzwo7MJPVmCSTeoxPtlH8w8KEIgl1vFJvuP0h+J5OMXFVx6lzYePR3JYavTkP8CkqF9x2ftD9npLcq5gyBWPc2m2E1Vbdf0EnfDk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPt09y+j; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPt09y+j"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-896f82e5961so28426346d6.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 01:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771060712; x=1771665512; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab4Qc9pKcOcpHatyWiDtKBed8yOsyGJ/klTLE1whEVA=;
        b=mPt09y+jQz+6LmqOLIsqYn/EJrLAwVKLkBJaYiLy9diAxXmzIc/Tuanr65xIqDZZfL
         qLlMaLG1LJeLpozkKXPuPDQJkozGQCGwYfG1JzGHEbbLTPfLtCRdn5bylPNjSjabZHvl
         EKnVB6FUy5zDlMsiSXIUrQKtmCGpVHQz65NpCOUvm9XrhQbZpDyGT8Xn7VI4PnAGvoYD
         kO3SKQeOa1e7OwAJAFX1AZMpPi/MgLZ4z1NQeQXWRGxtSzKDOvd+Vt4MvcEZHeAMgy9+
         VeHXzpnebdUU6k5myDc2W5Ax/QQk08wmc2eejyb3pCgBRrN6luUUbROkRIjUGje85nK5
         1iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771060712; x=1771665512;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab4Qc9pKcOcpHatyWiDtKBed8yOsyGJ/klTLE1whEVA=;
        b=U1Mm1HpXyEYDmXwaReDeRcdj/4fJxSCsri+7qOhrfdOFQFpDIRK3tMS/W/OmVdhKlZ
         1ut+1iEyuote3+cE8y+h2PzGM0fi2JLbMZlIf3mwFs6uRjNmlB4w3bxiNII5KcUW/iwR
         IpMb2E21ks/cfZxgS7zsODb+cXidd3r5RjcIUy+86aV0b3xQ+Nk152tWVg+xqCEwYhPy
         Yftlw278n913AfUGSMp7SSn7cWci6B1zT56aEayK3JSdGD6/EUmUZqq8O85l+xOcDS/L
         7g8jMN660bYmGgAWyY6ZZGvX4HB8Zrhr1QMNJgA+sBT1KEwNW+vyzONGJXpaf7mYvk9o
         G77A==
X-Gm-Message-State: AOJu0YzAirjABYQZz1tjd78creE+Jwi4yaj3/f9zXhdpGBx9crr60Oon
	/UwqdBWhaoqAhyQt3f+rfC65QdFOxAENoiC2n4K8PwakqeY9IAvH1svy9plAOh57
X-Gm-Gg: AZuq6aJ+HNGM3cQ8Lf51NPYuDAckcyg+dk7e2IRUwPtlcm03Ir51RnCvMDz0+qgj2vR
	GckfAppLk8mjbdTn/b+pU6mDO7XPaxX3yVQQhzSQzeSSrWNcWyVWSLh+RTLlsk8kJ2n8FwnQ1xu
	QUYHyd0c7klbPsDhkmOnnJu0inFMccLNjOPBh/QcGQ+NPjVu9QT/Ko/3N05q+wbxKaetd7yHnEE
	Ct194vNtjmmUNDDb97/Sc7HeO+6YjCK3koWtiGw1dDNm47LdUohz+2aXQi1BoCAlnSjvOHnewQ2
	v1gv7ao7N4TLYszTeEaR9sxGkErhvxPBjZ3/mfONpK4s6g9kWbLsQ6lKvlTZBQoIp5lFcNYnWYK
	BgcwoDQnFqcYpTT2KFb2s9S2MzoEnssPJ5fwnmbA/awZnHMpkqAMLmzHAgJS/cwhyL8CoYJ7Oqn
	f8EMMQTDsFLKC8b+rd53b4szz/Yc67
X-Received: by 2002:a05:6214:da5:b0:896:f47e:fd51 with SMTP id 6a1803df08f44-89740489d41mr32978976d6.47.1771060711676;
        Sat, 14 Feb 2026 01:18:31 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c8505sm772725285a.25.2026.02.14.01.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 01:18:31 -0800 (PST)
Message-ID: <69903de7.050a0220.395893.a47a@mx.google.com>
Date: Sat, 14 Feb 2026 01:18:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1337764220917559876=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kush.kulshrestha5@gmail.com
Subject: RE: Bluetooth: btusb: Add support for MediaTek MT7902
In-Reply-To: <20260214082738.139047-1-kush.kulshrestha.5@gmail.com>
References: <20260214082738.139047-1-kush.kulshrestha.5@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1337764220917559876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1054128

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.27 seconds
CheckAllWarning               PASS      31.01 seconds
CheckSparse                   WARNING   34.01 seconds
BuildKernel32                 PASS      26.34 seconds
TestRunnerSetup               PASS      572.87 seconds
TestRunner_l2cap-tester       PASS      29.91 seconds
TestRunner_iso-tester         PASS      92.73 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      118.59 seconds
TestRunner_rfcomm-tester      PASS      9.48 seconds
TestRunner_sco-tester         FAIL      14.78 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        FAIL      11.41 seconds
TestRunner_smp-tester         PASS      8.81 seconds
TestRunner_userchan-tester    PASS      6.81 seconds
IncrementalBuild              PENDING   0.43 seconds

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
drivers/bluetooth/btmtk.c:1508:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1509:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1510:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1511:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1512:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1512:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1513:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1514:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1515:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1516:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1517:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1518:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4669:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4670:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4672:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4673:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4676:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4678:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4679:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4681:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4682:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4683:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4684:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4684:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.110 seconds
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
Mesh - Send cancel - 1                               Timed out    1.796 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1337764220917559876==--
