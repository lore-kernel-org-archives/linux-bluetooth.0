Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A2B33986D
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869552; cv=none; b=V9PV9Bs5t2uoglzpiyx/rACVeiv7r4K/wWkgvJlG/Q1UprN/TuswguEcRIC3fkZNA3hg8SY4inK9k//SqHifhdlnNmejGiSksMlvN1gDy9MlITEuorAmNtmjlEw0gLwWibLJw75ccBfV6JHV35JOZv0Ne5QS9YskvkagiJMnrcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869552; c=relaxed/simple;
	bh=5H/FXxNghYW4SDrBTtnlO1LF0R3LbHAeaiRl4DkEooY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JCYNxQZEyoQNmp+vXoXg/tKwLfsTczCMpG2YQ7aKaMpOR9Fty5WdjccSPCm/hnj4RVcIYXoj+PBHmybMrl/oUUXLyYEI4TPT1MXIo4e5NSGoXDxs+cny9G9zvd/PEM9dqVKUWjmzhYt6wGQNBRE592TBAikQ7yvDhiuDncaAZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWfgWETa; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWfgWETa"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-896fb37d1f0so19099786d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 09:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771869550; x=1772474350; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9L5l59oBnSoJbBev9DVbVng2Au9n38H4RJrI1RIhDCc=;
        b=NWfgWETaGtYSLwkYkfZZVJrVT3nVJSu6seaDWgspLF447cOmNNKXW82SAoTA9/0VnK
         MtmEMakjVfuxbSPmEBy34sI/H8eUcJstkayHUJFWNxg+inU4O/hci4jtjol4nFI3/Hkv
         YCBEmRHr/QcCcT2ch0Dgi0SfvXyi+LBuDPzWFgsi2+OmLhd9DOorS175wZ/jkjOJHgvt
         x9Zry8YMmmShTdFFZDNBHXAlsUFR2v3kdxDHiz5MMWPCzdqZJ985tFEjIKmMRBG/54t6
         F4dOFMr+521bn7dS99/sJuVrL45l/NMrYigJJvclXqu9+XsCQVC+dWurp3EalYTi4je7
         q3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771869550; x=1772474350;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L5l59oBnSoJbBev9DVbVng2Au9n38H4RJrI1RIhDCc=;
        b=X6ljfusrgfN4H2tAC55P4m1fMN/yftwb6pmsL2ONV4+HMEKZ7ba+kanV7tmzD6ATzU
         iU8O/FDivtn+TqOdm6dfK3c+NGTzjPdjg5datgCBGGmqfE297iTQFlNJ2K4hh0zYBOoq
         hLq/8bFtbaNYwheEh+uQ4BqOmFs5LripbLGWPsJT5HqrivC3weIpdxrnUWJ/SyqnaHmM
         +pesjump8eJPt6jHxzzoZVxJNIj/lBdeH+rb1iZa3ksiITcs7jjw2XAFmhR6QScds2/y
         li93+XAmILyr15UEjaXNaNIrj/Ht+/szr28WuDBv0sgSxQM4LFf6lTaXhwJrenz8+KGp
         A08g==
X-Gm-Message-State: AOJu0YxdvdTtLh5oFap0KhaYtL2wk2Mytq0p1h4VZlDQQf4vjAxlVLLB
	WXzao7zYiCO4gFkZQLTlRV/bFP8ZQFwPf2NYXtq8oMoogPyIMNDlUFqSmoqIxzeD
X-Gm-Gg: ATEYQzweVLns6OJAFkT0PRYWeJCmDQj5iLcpl4EV780KKvhvcqTIz7eO7EtvHlcbUPd
	6iQO+5RT/9LG0ZuNtD9QqFq2aw0jYdafCcGKOIRnIYD7VMAGIQuLUkYHUUXe4/gNeuqSS7KC95G
	xD23L11HjSADTXt12twNEVsge8UNeuqq58z3J/AgQSL1uB3cbtF5p8qho0oJlrzIowBkTfmu+eP
	Ps/hKNeU/IKEo52z+8BPP3BAxMPmhagG9+Az1blLMIx8gYmUKly6nnMoMzXmJhX+h/qxVPUXGN8
	sQeD1Gg2tu39kHpdfVCQhg0j8Fs1E1K0M7wWrTNV9RqN0aNMA6lUp95W5A4MxTteaimlYeYROT8
	PJAnktINiV0H3bgyh66GXeWmUDL1TRN2+ZloxO79dPCHdxz9ApcjTXVz/jFfMnKHzx0nkTZRmYC
	MLKo7YpyFZR8qfuEp/ha/3wiwRCAY=
X-Received: by 2002:a05:6214:f05:b0:895:c06:8cbf with SMTP id 6a1803df08f44-89979db8304mr148105046d6.62.1771869550360;
        Mon, 23 Feb 2026 09:59:10 -0800 (PST)
Received: from [172.17.0.2] ([20.55.13.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e7741c0sm71357486d6.50.2026.02.23.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:59:09 -0800 (PST)
Message-ID: <699c956d.d40a0220.3a8223.5168@mx.google.com>
Date: Mon, 23 Feb 2026 09:59:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7091966608365625999=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/7] Bluetooth: btintel: Add support for hybrid signature for ScP2 onwards
In-Reply-To: <20260223172104.167471-1-kiran.k@intel.com>
References: <20260223172104.167471-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7091966608365625999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1056669

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 FAIL      1.15 seconds
BuildKernel                   PASS      25.84 seconds
CheckAllWarning               PASS      28.09 seconds
CheckSparse                   WARNING   32.17 seconds
BuildKernel32                 PASS      25.02 seconds
TestRunnerSetup               PASS      557.32 seconds
TestRunner_l2cap-tester       PASS      28.20 seconds
TestRunner_iso-tester         PASS      93.80 seconds
TestRunner_bnep-tester        PASS      6.36 seconds
TestRunner_mgmt-tester        FAIL      116.46 seconds
TestRunner_rfcomm-tester      PASS      9.44 seconds
TestRunner_sco-tester         FAIL      14.51 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        FAIL      12.44 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.82 seconds

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
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3867:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3868:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3869:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3870:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3871:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3872:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3873:1: error: bad constant expressiondrivers/bluetooth/btintel.c:3874:1: error: bad constant expression
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
Mesh - Send cancel - 1                               Timed out    2.739 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7091966608365625999==--
