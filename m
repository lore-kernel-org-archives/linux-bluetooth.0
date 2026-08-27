Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4C2480321
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846302; cv=none; b=FzatNaVj7H78hbGVH9+IYB7sfqPH8I4wspRmmpxcZt2/I4kjir210nyS7DhUeCTdjSuLBwN2AtuC0tlM2/Z+I0HrN+SMSuNqtywo1qsOZelTTCGx30jZ/Jqj5nK+zbBgPIxJuZy6prdRLssrvIp7YVB+7m042fBg/qVog+tGn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846302; c=relaxed/simple;
	bh=84fUSvNh8VpsDD7oVVdnrB/gxFs81DRXXDWX4ySwd2U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UTsV/N0oRVPSzv2OXC0g8AUrzkUPajvIJ5/a1/6VwEDXZYqON9Y2XmCgsgwQ+nioVxniR0rAF3fz374CHSoyVOLoKOFtGnZ/8TyY4Q4YQYUmOngekQZgij+06nHghlqR6jVw5jHJLqfdnVxNPUzTz+AyE8fKDwAKlvNWaiiBWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVoO+VSG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVoO+VSG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6d28aa26cso16816525ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787846300; x=1788451100; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=laimu4XTieUDBZcG+PeKicciQwKUwk2eRj0s8eTobc4=;
        b=oVoO+VSGICm2XvlaC2+V9RFZNZMKuKFNXK6yEhim9J70QgqGOof0EHWJsZZAc0o6tC
         hMQsNCM/YdSZ4EwxFPPlqwZtaRydgJtSoCnmOZ4kfERgMlIpMdGqFH2DH0rSrKP8DuXQ
         QC+yGtps4Smsrs8cdy7+vlQii1mg77Nsko9HAWJRHjfHyxm2b6/OHwjwEC+H+BTPPAH8
         ahEr3neuaBKDttQc8Q4D1a7i+IiKrqZF9pmaF9WQad7J5kXQh5SdXeE0ahDoFpENSO1z
         FUV5wDF3YWxvggMsHJE1OtAObFaZ1rfkp+tTIVNug0Jsw1iBcGFmPz8IbSO03nHseJSl
         mMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846300; x=1788451100;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=laimu4XTieUDBZcG+PeKicciQwKUwk2eRj0s8eTobc4=;
        b=tFM1KgvRhmyzRM1KVXnhQJ+MDzMsQGkf3kwc+gVwWJ3va53s2yDN7jSqPNv40GwFiG
         79vscaYwoqsaLSK3nEceq0Q2GTkLhujxqUK0lssOrKTkpMejW3AGKi1HSCno11AGk2dd
         NJ0JLsB1IgjFKcww7fYmAOmgGcTTNBlJP51yXtRn9U1q/7zD2nAoePHxSjVF2zrdnV2D
         lTpuU98NOQ6iJD58Dbwzo9ic+APfD98XIMgL0eYbEE5R8Zx6EQoWp4Lp6GrTDh29sndO
         s5SRyEzC5g5iVca8eUfaXppNHJP83Xf2A5c9J8pxt1+0c6YRAjaEEwfWQKSScS/RuzRu
         XUJQ==
X-Gm-Message-State: AFuF++mkj85mS3N0bZcDsof0pQDSxbqivlg74xREY4cLO+O/SqaF50bo
	jTKqaPhqsYvaR4oZddW/FBlITtcblaqYTyn3XTh7dQSJYZDvfATZjroWAx7K1g==
X-Gm-Gg: AR+sD10a5EK4RQD+41+uEWjCsK+qC5CXgWELXCYdV2i+2a/y19CheqaIcq10CnLusuw
	RzjnUFw7gAyAY4Ogceut23XKjYZ5OPb3I91Zmgv6/fxljmW3EOfiGGT9PaCHFOsQHOnKeriCEDZ
	ZGcZszvitqaxeLuLzIophcqWk/ygFzRlHJFKWvPyb7rQSjrwG6nHjAD0gPyEHOEs98nFXQtdrk5
	30Z8JZBUr3qLE57m1idygCAIUtOk42J92s8MB+HhYOvguYneWhySOUhf91xFt/Noo+tWNiu7GzL
	SYMITxfPSuFR/yzpogKQl+v0ACOE+TDU7cpmty2YDMQGnjn9HSBHyELBOZSoeItD4lE9kCQIX7G
	gVr/SMv9aXS+V93iDfimfa8b3D56HDr02LGkd+zrRI2C1kwEqSIc264kQw3CczjxJeMd52YLxzd
	slbJ6bQzMjXPT+a6Kho7EbEnZPa3TRKAhFYZFCrihtoZbFM/iddYUdJjOlluXHLs0e8pyGqzRNB
	g==
X-Received: by 2002:a17:902:ce89:b0:2c2:62ee:5a0d with SMTP id d9443c01a7336-2d707c2babemr279746495ad.14.1787846299875;
        Thu, 27 Aug 2026 08:58:19 -0700 (PDT)
Received: from [172.17.0.2] ([134.33.76.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283da25c09sm34605878eec.31.2026.08.27.08.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:58:19 -0700 (PDT)
Message-ID: <6a905e9b.cd442525.27dc31.90be@mx.google.com>
Date: Thu, 27 Aug 2026 08:58:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0958508993540855974=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andy.chang@synaptics.corp-partner.google.com
Subject: RE: Add support for the Synaptics BCM4384 Bluetooth controller
In-Reply-To: <20260827110242.1203546-2-andy.chang@synaptics.corp-partner.google.com>
References: <20260827110242.1203546-2-andy.chang@synaptics.corp-partner.google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0958508993540855974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1152597

---Test result---

Test Summary:
CheckPatch                    PASS      1.22 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.44 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      21.33 seconds
CheckAllWarning               PASS      25.19 seconds
CheckSparse                   PASS      21.49 seconds
BuildKernel32                 PASS      22.50 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      364.91 seconds
TestRunner_l2cap-tester       PASS      52.32 seconds
TestRunner_iso-tester         PASS      97.47 seconds
TestRunner_bnep-tester        PASS      14.73 seconds
TestRunner_mgmt-tester        FAIL      175.56 seconds
TestRunner_rfcomm-tester      PASS      20.09 seconds
TestRunner_sco-tester         PASS      25.01 seconds
TestRunner_ioctl-tester       PASS      20.50 seconds
TestRunner_mesh-tester        FAIL      20.53 seconds
TestRunner_smp-tester         PASS      18.28 seconds
TestRunner_userchan-tester    PASS      15.48 seconds
TestRunner_6lowpan-tester     PASS      18.32 seconds
IncrementalBuild              PASS      23.39 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.184 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.869 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/656

---
Regards,
Linux Bluetooth


--===============0958508993540855974==--
