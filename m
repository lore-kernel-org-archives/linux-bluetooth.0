Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C0233557D
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892498; cv=none; b=qS4krT0YA4CtxHaARacEhiW02+l1UJ+iP7mjAOHoksbA5BPz7AHGUAIl0W/nMQ6Tgwqt+3CXirNbLAkYZFMpO3NFgQ6KcotjI1ravGhhIAYbQkkWm7enmx4j6g9uO+brrWBJ4tTcJooda+AlC4qHLLAkHD9ZI7buOtZ59lpnJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892498; c=relaxed/simple;
	bh=xnWUAwqmzZyC0b6t/Dyg+V22USPX6PAWZM7Fok7g1Y0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dKQsxNyChfIiZlR2HwWHnEA0qJ1dx9Dq6q8Uqg/rtkJKGds8EG1JNkLsuVEt4R+IDLTUZAafTD7zQotx+rfnG+l63jQANceSuvXMVb0Qdi/Kjxkfek4fOFakqvq+g8Zb8Wu4OwJRTGE4jpO6npV/SCj+c2U17U48C+L1wBue5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irxWumyM; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irxWumyM"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5171a8d3a1aso271981cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779892496; x=1780497296; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H7Dsc20wrwPo1gv5XiufC68XIjfZp2OedjBle1J0eaQ=;
        b=irxWumyMYNOBFBFDYIaP7lHo2X9xLp+5zJqx/8qRFbxkEU/la4xRZOYvOyadvGsZGW
         jGdSLlqMcc3shP+GifBN/UDlihJL7xL5DSU2DsoJGLLet5RX6IZLukP4GgrmB9KhDY4y
         lPvQ+OnGezDfkHux2z9tyKjgjXMc4wvQ3T03i/7E+JtIPAoNArcHtgO/dwxh3lZ+BfBb
         IpI/cDtBrJkoRnvwlB3x1G9Hm5guXAmMAoJi6FdmziH1x46o6weFYDGR9nMO1BLbh72B
         MrT6jqZZXhgN1mm/gM8NLMiF7ejrUeTIGvtXB/FvH5e0d8M0c2L/7MD/EUiKV+kfcXKg
         QQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892496; x=1780497296;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7Dsc20wrwPo1gv5XiufC68XIjfZp2OedjBle1J0eaQ=;
        b=Td6MSZgAKgIYZraCuuEHntCA+5OeO9KNt8Z0X52xvt6dmpdBI8vp67yu6OXbYBZkEs
         FKiLlxyyn36/yh2U6FnCltoIWv/imkWcjicYP6qgCQteiwEWB6lCXPOuFiOHeZmrWuPP
         8kZSNls+vtBxDqEG2gk5dq3mQYkfo1zU1ZDWxnAFwcPXzvjirnvSnAF1TzUxfRUUT446
         Au+WVdOoVQIsa7ontidNTFw6PYZM5lNh7No+Tx1WrWfTpJHIUxqNS5f7uSpVfLr7wm2c
         iEVhZGvEJjHkl1gaJsjDPfxjJOzD5Tpc4FCwsP2Pg9JhA0RRqUiSxgMNmaB5GyTBnBTI
         xiWA==
X-Gm-Message-State: AOJu0YzF3xga9r2c2TP3qWXWD1xzfLQoHfU65vp1S7fYk5yKTi4Icm8a
	GLQupbqAEF7kZVpWGxIykY/0YjXW3Le1yebDSTo1w0kF24xtdVnFsZRKw1HFIErR
X-Gm-Gg: Acq92OEin5HRXGPlWpIO5cDQL0Mj6HCaiMvM9VGUtdfdCZ3XDdgOCQHq1cy05uDN6sa
	GVTkV+hlQMqGy70cvQRdDdsoNnEBaqAgPNE8z59UVrOJOkLFW8ioJmTCvP3kbYm/wqWqvTKNFJP
	YVBjXPGfPbaX55iAVH9/NDQtJyqxuitVrBFgeAtBnrOllEXLexc0/XiYuoqvh8H5dFsFudYLo2F
	0uRHVudBMikY9xutRrUy9gj4uHf24uQHjlsfOfU+8ISr0ksnPMh1K9y7FB7aEXKltwj5Mg3Bb2o
	3tF3zsISDseCP87hVQg9cVW7rCAe2HZfCW6gwPa58nPN8/A+wsLDgSYGNVhtExRTMqPy86MPjQr
	pxbUIDKCTpQSj7xhLb8+kK4fS7X9UH9vkiBLlnZWO9QgoqkqEYSm1+XGjnLo5AFU38QOMVr0sh3
	qYLiZKJCUnuZ1TJdiJHz0pvcLoLvQa2A==
X-Received: by 2002:a05:622a:4d4f:b0:516:dc75:1aca with SMTP id d75a77b69052e-516dc75415fmr254423991cf.26.1779892496214;
        Wed, 27 May 2026 07:34:56 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.34.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccb377fc60sm51037216d6.17.2026.05.27.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:34:55 -0700 (PDT)
Message-ID: <6a17010f.0ee877b3.94763.d2de@mx.google.com>
Date: Wed, 27 May 2026 07:34:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1627230515105310353=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Bluetooth: MGMT: Add management security level changed event
In-Reply-To: <20260527115841.267098-1-frederic.danis@collabora.com>
References: <20260527115841.267098-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1627230515105310353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1101615

---Test result---

Test Summary:
CheckPatch                    PASS      1.66 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.50 seconds
BuildKernel                   PASS      28.67 seconds
CheckAllWarning               PASS      32.03 seconds
CheckSparse                   PASS      30.47 seconds
BuildKernel32                 PASS      28.42 seconds
TestRunnerSetup               PASS      613.90 seconds
TestRunner_l2cap-tester       FAIL      61.35 seconds
TestRunner_iso-tester         PASS      80.34 seconds
TestRunner_bnep-tester        PASS      20.17 seconds
TestRunner_mgmt-tester        FAIL      217.24 seconds
TestRunner_rfcomm-tester      PASS      25.59 seconds
TestRunner_sco-tester         PASS      32.88 seconds
TestRunner_ioctl-tester       PASS      27.11 seconds
TestRunner_mesh-tester        FAIL      25.93 seconds
TestRunner_smp-tester         PASS      23.64 seconds
TestRunner_userchan-tester    PASS      20.19 seconds
TestRunner_6lowpan-tester     PASS      23.27 seconds
IncrementalBuild              PASS      26.27 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.274 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.247 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.006 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds


https://github.com/bluez/bluetooth-next/pull/250

---
Regards,
Linux Bluetooth


--===============1627230515105310353==--
