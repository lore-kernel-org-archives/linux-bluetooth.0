Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7116E33993
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771311292; cv=none; b=Qvxetho/1EabdvjA3q33sHIWPyoXWQ5f66BBMUcUWuVelII3JGhKXt2W+0Hlnr+ndjLYg5Wp3MRjDJx4+IDnm8fV/vhOGHuv7nx5mG/wKTcaxj0dQMgSfkptwXjp9V9tMW3UC69qvcAyKBPLg5kgTazVxLXpWTLlHZPq219gwJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771311292; c=relaxed/simple;
	bh=zjOiNKTVJRAzkwawZexrMzPok5cXqcjw4Hep6Bb4CsU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Bi+VECr7o2Z9osYZV5SZYny9GnZYmCWmeyYHNl1UCy+pTIbMmprK76rqWjEDJq/m5yD5BuYfhMUHvJ8HFR5rdaPqy+yIIBxA3VZ5ca+GEwjs0cux7VK1S7CwDE7BVooNuGYUQeBMg/kBiYTDjd/Y4Cyqfo8cG/6S++MbGZ1tgt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI9CqBDw; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI9CqBDw"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8cb420f7500so390728785a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 22:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771311290; x=1771916090; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ziADZQFMR1FuyYTDmQ2HS3FAqc/uHE5PJWSNBYoSo5Y=;
        b=jI9CqBDwkD67Gh498E4y79JKwAL7Nc2wpaP+D70kifLRP2Y1V29MEIfKg/QAq0hvuS
         sbknkkzZzOm2ZwrDEoV8Yp38t0r1CwFaltSU3h6oKhsI5ORMV8lmb5KFkMKYc90LH4Rx
         vMDX8fG2Sj622LkzRSKujB91eD5zYJRyPq/Mey0G2+aWv0nZyxBpO31ZWH11UT4Y6fvx
         yX5vh42c6tQiWoNnElf0mCr4YMGDcDdMfy3jhqMiPWr3kC1djqjgY2YNotA06d9dMW0g
         i0M1KRvTxZ6NZP6VCV2oXYXM2/6n5hq1oalIQwFB0WzbmMzMlgmVtI/SExyUTg+AyyOt
         k5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771311290; x=1771916090;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziADZQFMR1FuyYTDmQ2HS3FAqc/uHE5PJWSNBYoSo5Y=;
        b=BvKETJiiHn3ugi7elqEC1cNjtzKg3QIMHiKFJR6IHoTZklpzhu9Nyp6kB5x6coHWwO
         FTqacKq3/HAmeM9tE+5HL29M3ABz3LnvP2YS9p1BjN2PEPEllF1/dvVPbiPw6EqXtERq
         o4FlOhefNi5tDAwbp6QVRgkYzDCVt4dD7Ek1rVZdXwVfpGgpL0H81ItJCFAPLZcmcUWo
         RsD2DIGqmzsPtm6N13YM/OizvAERbDpRrs7necaS3ZcctdKT58Mq/VLu4EK4jx0tuw5Q
         OKlV05LREyP5xbNGSHpBApKfF77m233N4ktte9nLwOmnElsHeF1qz4pd69JgUx1MsWG3
         ahUQ==
X-Gm-Message-State: AOJu0YyDDbGF5jlx3pvF7xMMwgq9+GXIhE6L5CsSLmoJm2JKbWwA7Eqo
	jNRLLDWjHs6mkZ9zRN9SNUvToazSRdGw+t/xdsNKYSc1YsfjX3yxnEXvl/0Ij9Pb
X-Gm-Gg: AZuq6aK2l5V8Jg9dOllM1mL0RrQNxLaConTVp8r4c02Xi8lYOh1IaxdzPa00BuXhCIl
	BZsnQ785l2FSbRiDxdYTHYM2Wz8mheC+AY7nSXJx+revetdbdHE1dPr0XlUraugI8Stv8/D/KdW
	kWj3BZCBHR3xOEecITDCKz4KxP8NJRZMzgw5kdSmVxJOvm1mvGAmR66VWkmg9UyMwhb/Hj6Xg3s
	e4KHQhhViFG9kylYDkXXcFXU7I+FPORt/qn+BwPprUqHZby1ZH2RQTphJ0YuL3YL+x7+wy0l1os
	tu9EQ8NR8nnHBRPVWDz5qsAys3yZzgdcpARwnY0HlhHirpkAMJaLlpsJN5YkHVdrlElNIzS2cnC
	PkXat/eJwyGh77ttigwofHZdASaqeBZwWfqTYfwSbxnym2eSRFSK5pRF+adGCUQORYQhsGbJX3w
	aYOGp4HjiALw+hQfu/Mi4ovemoe1A=
X-Received: by 2002:a05:620a:370d:b0:8b2:ed29:f15f with SMTP id af79cd13be357-8cb4bf973f5mr1199645585a.21.1771311290084;
        Mon, 16 Feb 2026 22:54:50 -0800 (PST)
Received: from [172.17.0.2] ([20.161.71.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cca728esm154711046d6.21.2026.02.16.22.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 22:54:49 -0800 (PST)
Message-ID: <699410b9.0c0a0220.15e6ad.1e7b@mx.google.com>
Date: Mon, 16 Feb 2026 22:54:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6134259982750912628=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vivek.sahu@oss.qualcomm.com
Subject: RE: Cover letter QCC2072 enablement
In-Reply-To: <20260217054731.3058567-2-vivek.sahu@oss.qualcomm.com>
References: <20260217054731.3058567-2-vivek.sahu@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6134259982750912628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1054758

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 FAIL      0.48 seconds
BuildKernel                   PASS      26.64 seconds
CheckAllWarning               PASS      29.41 seconds
CheckSparse                   WARNING   33.21 seconds
BuildKernel32                 PASS      26.00 seconds
TestRunnerSetup               PASS      569.64 seconds
TestRunner_l2cap-tester       PASS      28.66 seconds
TestRunner_iso-tester         PASS      91.32 seconds
TestRunner_bnep-tester        PASS      6.47 seconds
TestRunner_mgmt-tester        FAIL      116.52 seconds
TestRunner_rfcomm-tester      PASS      9.60 seconds
TestRunner_sco-tester         FAIL      14.58 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        FAIL      12.53 seconds
TestRunner_smp-tester         PASS      8.78 seconds
TestRunner_userchan-tester    PASS      6.89 seconds
IncrementalBuild              PENDING   0.86 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btqca.c:1051:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1052:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1053:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1053:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.109 seconds
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
Mesh - Send cancel - 1                               Timed out    2.663 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6134259982750912628==--
