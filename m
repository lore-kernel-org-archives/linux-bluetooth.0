Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E801684BE
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767670452; cv=none; b=quMZSDUiqXZor5kM+SFm/ccE1NnnGc+NVySk7wWRTX8kB+JUGf5fCdeTnD5pkuWxJQKFmopEmd05+11GParu2xzcqSy9xaHL3xr8zzUjuVsLtVFPwyOORZy7FquMOpUJ9MBYZ4RxPz4cYmG4mRLP4m04g4UBjFcNHH4TZYV+p6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767670452; c=relaxed/simple;
	bh=IYuVziOaKNYUhcLpPeSvW/aopDykb1UZUf8ZGiLl0Q4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gWDpyn3zaSSILBAtQ16imMlC7ZXjuMKILj8WqgReZ1MxFfxNE4JL9XPoXOMHHJt2FzH/QlhSR9Y0Spz70HVkzXy4U0u3iYKy7LEzoFr5aod7+ugSftA4mjzqF3VNrJCQL6msB0TWmNjCRTGm4wPH31ueTYnnYG+hkpIrNe4sgk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2u+4MWm; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2u+4MWm"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so481936a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 19:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767670449; x=1768275249; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HbUQ76C/dLNr5yPg7KT/rYxUXCU00RB50M/dAIuhwto=;
        b=C2u+4MWmvBnz0hXBuEiPWC2RjAyVWMXam7KqritXGMRtq+ra1l98sHuVAMoT7z5c24
         c70ttEgcKNIi/JMxaJ+25vDgfC4r5Qks4gWdJ9O+PlYvAJ4PhA400+wQwGOjjeyvpybF
         LxZVKTkI0ORSKnKsPSq8L73hshUKOP1rf1eqHy+ubZb00re2LVyeB0as2fIhurgJFsx4
         U00wJAVz6FMZB61+T1qic70ZBIXVg9e3QCKukau+cYbYFgCVWTOn7wdl/cle9LjRrfZ0
         bdBo2Ha5c5oIeEedtkzakTcOWyJm6FqExfkFKazt3y2dOD65WCoN7LFWEHtlqQhJ4+mr
         XNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767670449; x=1768275249;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbUQ76C/dLNr5yPg7KT/rYxUXCU00RB50M/dAIuhwto=;
        b=myF0XSwyBfHyQhJA4OnuLYytT0C16doe3mtDwSMO4f2a+Va9YFB1+PqHuUGr25HloO
         rujJjEnYkALTG73ZGPG/4+ZUqEEK9HdcALpCGnjfPlsVLa+B9hpA+Va2pQLvzSHV7Hlt
         sW+VcZNMAqkW5JqggRubHHukM3i3mXobpgvgYaSXLfTHHup04t68daSCDVHcXeZEBXVe
         Xh7VldjGyu6HSKhQ5KTflxHXHoaaV8fvNkT4TMO7duHepciNU3GJrmNoufHQkpku71ia
         Ht75KAihXDlVlD1sT7jYEroCuI9ZpfYrnSlaVIMso3VzqWM/iEVWgx+purrB9k/G5Lns
         RzDQ==
X-Gm-Message-State: AOJu0Yz+eMJdIunZK1tnF/+7f15YtpuLXPDa6YunZ0lwzggrtbjBNCjp
	FJq33n4TXzKGCYNL41+N6+PA4t3wUGJaMj9BRaKaQrZGXkDJLxnxN/c8F4sB1mwo
X-Gm-Gg: AY/fxX7FL6UEdZE2FNesThqCLsSDTnFMP3X2Fr1EhhKOLoH7w5iqq2LSZTqysvNvxeo
	RCLDzKq7nAd+s3Ra5H1612o4s0JrFqY2Hz9AL5K7tp5fEF6m9/SCjsEEe/TLAeFhxIFvtqy06qg
	wjUNC8hxH8VLPJ+SHzbtv/LtiH4R+f5Yyl8IcNNr+NidgmkNYhxvHovvDRi8y+h2XupmX64+mP5
	Tv4udcgB71pibNpfeleH9JqE1F1OR7393eXC/wvFUvptkkyVOMPe/iWFoWrd9ysRvp6QWAT93BK
	sScEqVsc0MBvI98Nt3buPuRhf1DRyCkdQ60ZBNACxcpzI+llRRv21rRZhDLJ+LEDhNScsxCxyOS
	SgpvJp6G0UEg5ssUZ6tvfbnMuVspEbzK3IOUYkjzUDw8/RYwxardJ4p5TGyf7L/D9VAZl0mWTHV
	/4TUpmOqoISl9QvyMK5jK71sta/1A=
X-Google-Smtp-Source: AGHT+IEflsMxzH+O4IvaTqpXbugeQ1s6fYMEGW+RTgjiL0OC+lXoXq+rrdHovbzLDBYiics6zezeiA==
X-Received: by 2002:a05:7301:22a2:b0:2ae:4fd7:ba56 with SMTP id 5a478bee46e88-2b16f920aa8mr1155354eec.23.1767670448644;
        Mon, 05 Jan 2026 19:34:08 -0800 (PST)
Received: from [172.17.0.2] ([20.168.119.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd8fsm1669544eec.20.2026.01.05.19.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 19:34:08 -0800 (PST)
Message-ID: <695c82b0.050a0220.2edab2.5260@mx.google.com>
Date: Mon, 05 Jan 2026 19:34:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0756551143090425173=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: Bluetooth: btqca: move WCN7850 WA and add WCN6855 firmware priority selection feature
In-Reply-To: <20260106024806.480779-2-shuai.zhang@oss.qualcomm.com>
References: <20260106024806.480779-2-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0756551143090425173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1038770

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      23.55 seconds
CheckAllWarning               PASS      26.54 seconds
CheckSparse                   PASS      29.04 seconds
BuildKernel32                 PASS      23.33 seconds
TestRunnerSetup               PASS      511.59 seconds
TestRunner_l2cap-tester       PASS      27.94 seconds
TestRunner_iso-tester         PASS      79.87 seconds
TestRunner_bnep-tester        PASS      6.33 seconds
TestRunner_mgmt-tester        FAIL      124.17 seconds
TestRunner_rfcomm-tester      PASS      9.41 seconds
TestRunner_sco-tester         FAIL      14.58 seconds
TestRunner_ioctl-tester       PASS      10.12 seconds
TestRunner_mesh-tester        FAIL      12.48 seconds
TestRunner_smp-tester         PASS      8.65 seconds
TestRunner_userchan-tester    PASS      6.70 seconds
IncrementalBuild              PENDING   0.89 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.146 seconds
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
Mesh - Send cancel - 1                               Timed out    2.777 seconds
Mesh - Send cancel - 2                               Timed out    2.002 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0756551143090425173==--
