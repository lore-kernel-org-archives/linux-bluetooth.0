Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95FE27B353
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980418; cv=none; b=o0ai14EbYZ2ijv+hkPsRyzIhNVCCitiuEfDmXqRdoROo/ghzTtMFI6jI/Yl+vhOTempjY+P9BoU8jvzS31U3McPaI8ZOTWNnbsNfk1n+LPiufm/0gg4nbYF/5gb+oJAs6CBxYUQhOkUdFlMZtWbutc+I0xuGJmnvEnEfhmMdMi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980418; c=relaxed/simple;
	bh=LvIu5FanHo6xsb6OMrzNL4VG17zi0zfd8VVQNicHPSs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jF5pDEQVEMolCAzh/DMZ60P8IHJyRo//vLqMYRapiyEIKLelkvHXQbOArLeOh6mbV+ATqPvZQbG2jWpVTxa2dP85hrzw8hJtr53Uzek1qrbJoPLGTrzcDKWfoLFotTovfzxkKq4DESjb+f6/RCVPiFP6ifvjYO+I/2MJ0Y1CuSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmBmMxgg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmBmMxgg"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50b3488fb31so2084881cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774980414; x=1775585214; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LcBpMCRdszSJPOfbNEakKlO4qY/7F6rxX9o9kBmx/Vg=;
        b=QmBmMxgg0AbCUZqZ91wm2NosTZbn+SoltZSMJZcRkBWG5Px5edfBEHxnfcSurY70UV
         muW004acAAyVLl0+VPkileJnt8MCHzbBPm/9L2pRZjPUJF7StDRSlL1DTPTrqvdlWPxS
         R8g09pbJL/N7zyRw4LRPPM6nQJLtZvKFgv7totr2q5tgR2WdVNHMHDuanNOnjaATaZbr
         VzZdVEpAN077bfOLS6uchNE6+Gfo39y2NaJoxMhCWbFLv3oItF4jxKTBUZS89Uz/jxo0
         nQ8WfZu4XJldueYPbXYlpII2H3+thdRXMaFG0qPNMJtQ2Yxy4Mm/BuOEkxBHLxCe8T2L
         EzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774980414; x=1775585214;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcBpMCRdszSJPOfbNEakKlO4qY/7F6rxX9o9kBmx/Vg=;
        b=KvBFGID/TIkFn5Muxk1HcJv2+TimPSLCBklBBQpT3qUjr73Q+dpKTqqirsM33iffab
         Un+tX7nWQVLxZiI+v99wCCcd/WLGJp90K6ZrG3EX3Ev7uFhMFD8NeQuGOOdgLh16IFGq
         6PQPgegX7AekbzVbGk1zsegw1ikXK/UaVZ6o6lmo5YK+Wl+B7JlA5GrsWxy+6viQWotS
         auS7nXKAbX49xtdcBN8zi1IHr0WQXslBLNPJ3+vaGLgpevu/j2Fk0oypliw48zATGKOf
         RzgS/Hr9HAx97gFr4feSRlHi2fx/nge3c6DB16MVDdo7hZkBFAFHcoFnd4U12yPKq800
         SSmg==
X-Gm-Message-State: AOJu0Yy67K1OZVBQH/ncVKvd2gGECbyfIHiccvHRSkTAtcJHbDXc87om
	MLynkK3yYY8skFLa5YKeWPYH841qwL6AC9OqHJBJpbGVUYw98+lmVFWzGGq4Mw==
X-Gm-Gg: ATEYQzycTSIz9u5vDqitJpHeOVl0xFkI1dC+nIlYACb+jJ7HdaE68qIgLxDtWgYvgVU
	ju3ThqPHOVK7/m2V6F8QzuxiOE5+Hlno0uUT38viSqJsdIm8qZHsnBXGWftRrPo2AhS/UzT03dp
	2YsHI7FN1b1UVlwCqp2PvI1elyD5T4DibzMmEHM6T76gIqQxUHzSZ8j71PU3oWIvziWcpdvzUOX
	dzoS44om8BrhhlsR3CdB/3AU+Y3YQkjyA6lPf7r2jFe3SJpPmNUEnqPVjZ2QswA0+LhsxGRlvhV
	9xtoDX9Hg6Dh34xu/IwWuXnIfZvfQDIlj0xDOfzzofJrp1XcHI8CAPZf63+mJR/29+ArWcFjsJr
	HBRwYaHi0VxVgpTB5rn/TwXN3ehYxTiDrHS7U04GAS8Gjg8qx+0ibpqlcCCtqatzSf9v6C4snrv
	yemYiLABtMwJuoa7b7YeEqXOKQXvG8Lqk=
X-Received: by 2002:a05:622a:17c6:b0:509:4410:4487 with SMTP id d75a77b69052e-50d3c244d15mr5497981cf.24.1774980413808;
        Tue, 31 Mar 2026 11:06:53 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.133.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2a80ef0sm97192701cf.0.2026.03.31.11.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 11:06:53 -0700 (PDT)
Message-ID: <69cc0d3d.c80a0220.2a7c27.fdca@mx.google.com>
Date: Tue, 31 Mar 2026 11:06:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4996757091254694512=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, floss@jetm.me
Subject: RE: Bluetooth: Add MediaTek MT7927 (MT6639) support
In-Reply-To: <20260331-mt7927-bt-support-v5-1-6f31b4342daa@jetm.me>
References: <20260331-mt7927-bt-support-v5-1-6f31b4342daa@jetm.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4996757091254694512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075323

---Test result---

Test Summary:
CheckPatch                    PENDING   0.65 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.81 seconds
BuildKernel                   PASS      26.40 seconds
CheckAllWarning               PASS      29.78 seconds
CheckSparse                   PASS      29.19 seconds
BuildKernel32                 PASS      26.25 seconds
TestRunnerSetup               PASS      567.87 seconds
TestRunner_l2cap-tester       PASS      27.69 seconds
TestRunner_iso-tester         PASS      35.66 seconds
TestRunner_bnep-tester        PASS      6.39 seconds
TestRunner_mgmt-tester        FAIL      113.16 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         FAIL      18.04 seconds
TestRunner_ioctl-tester       PASS      10.08 seconds
TestRunner_mesh-tester        FAIL      11.54 seconds
TestRunner_smp-tester         PASS      10.45 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   1.01 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    1.850 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4996757091254694512==--
