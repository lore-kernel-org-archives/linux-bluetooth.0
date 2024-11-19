Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA41CDA31
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024269; cv=none; b=jfWbFjm9AQ440yigkqjgQUkiGzwuCbTTMCt3oAv6dns9ig/OrLW/Gz2/VZGuYLF6+OAtIIhv1JHWP38XBJJ+4cjXA3O9o2/q+yNnr8ok4Q+c20O6HvFN+7MJH9Iz6rbo2V83YQa1J++dhganL55XY/U3wbk7m/cE3scd/T+hp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024269; c=relaxed/simple;
	bh=5M9DhF1ahHdYb0jmgUYxsuYiMpWew3zQXA60xG0baCg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QVSsJa5HuhgTAJrxa6i4UNGFU23ctDKHDaqjtRk8s5fJH90WmQZuyfYZwFr9JithRvd/qiqVqqsk6/QIFrr5Y1olOBREwVF1vUI9nmiYsCeynZoI4cHacVBqSW504aWvwXYQ9z/j6bH9SrnDXU1J+7BgfJ1KcAn2+0x1VWQ+HzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF16Jm2L; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF16Jm2L"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e5fbc40239so1299072b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 05:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732024266; x=1732629066; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xNWkN7nUV2vx/gpItAFQ8Uu1dQsTqqM8TdYxxe3eJQY=;
        b=IF16Jm2LMMUPzWe9FaCf1XTlWdtUQNw/YolxUA5fQJKxz29FugwE1LhW/vMjTofAaP
         Cyg51SNs29XbK/UGE+JwlWsBpnmNnNCVsaCm3I0s1e8SU8GIjYkZQGJ5xWi4YNZv9eho
         /K9Z7bcMDhpVH8Q8tPSsMqnThcLp/CiNYP3nMoqoMyzvVoGavi375eKzZc067kQULfKM
         2PatWW6qxhJZjsaTlvcjSiFKduti2Kgf+fz4bWhocrGLMKsNaUbsdheXSwsNC/Xzx2Cm
         ak0KILBriYHKJENHgvogFj/ng8K0fREgxmsPpforovwJfOXL3JSNOQjamJ9UA/peYZXI
         otcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732024266; x=1732629066;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNWkN7nUV2vx/gpItAFQ8Uu1dQsTqqM8TdYxxe3eJQY=;
        b=ke+k/FplVu7+YTFSAdCi90KQ2rT2Y7IuHuqllzacD+f/O29Us3OYHvJg7eM+6I1LiU
         o834e/nAwB/H9QyEAWODBLWXPEZjCRxhIpNoOGyc8QrroZxkS0xyofRSUkaJGLnmbTb1
         mOtgyk7beDX21KmuirHnwtfuBLVbf83HpFDFQZQPpfxYaGSYh6u8wh9nW+Bd/0tExyce
         17fYDoacOBrL64AXnj4EYF9NptdCm/tMOkq8imNYPWHnJQnvTAUR1gtAMpl2SuT5qFE5
         +51oGYEvCDyG/RFiKmOT7xyLQ1GCD3dotpmISBzuxAWd4NCFcLCObkKBZWKQJFphqa+y
         ftIA==
X-Gm-Message-State: AOJu0YxgUqn96MWxBiT+L53Q6zUI4TDQwt+xv1FbswHN8EATHzEPrliP
	9/mUZhD022/KOE2kXJif789OUKvBCeMzL0Ygr43r4YKdRzJ3fa+ulF0Kew==
X-Google-Smtp-Source: AGHT+IEYxsZU2Os33+iOOPs5xadaaVPKGv58RACqVJSo81sIQGOxz0+mgK8ho2kwNbsUeMQHco3edw==
X-Received: by 2002:a05:6808:d4c:b0:3e6:366f:8e3b with SMTP id 5614622812f47-3e7bc8887fcmr12469986b6e.39.1732024266443;
        Tue, 19 Nov 2024 05:51:06 -0800 (PST)
Received: from [172.17.0.2] ([172.183.131.165])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dbe030fsm48641856d6.3.2024.11.19.05.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 05:51:06 -0800 (PST)
Message-ID: <673c97ca.0c0a0220.68c25.c553@mx.google.com>
Date: Tue, 19 Nov 2024 05:51:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7862325748081050147=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mhal@rbox.co
Subject: RE: net: Fix some callers of copy_from_sockptr()
In-Reply-To: <20241119-sockptr-copy-fixes-v3-1-d752cac4be8e@rbox.co>
References: <20241119-sockptr-copy-fixes-v3-1-d752cac4be8e@rbox.co>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7862325748081050147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=910950

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 FAIL      0.64 seconds
BuildKernel                   PASS      25.64 seconds
CheckAllWarning               PASS      28.00 seconds
CheckSparse                   WARNING   31.47 seconds
BuildKernel32                 PASS      24.81 seconds
TestRunnerSetup               PASS      441.63 seconds
TestRunner_l2cap-tester       PASS      20.75 seconds
TestRunner_iso-tester         FAIL      28.38 seconds
TestRunner_bnep-tester        PASS      4.88 seconds
TestRunner_mgmt-tester        PASS      117.97 seconds
TestRunner_rfcomm-tester      PASS      7.64 seconds
TestRunner_sco-tester         PASS      11.41 seconds
TestRunner_ioctl-tester       PASS      8.36 seconds
TestRunner_mesh-tester        PASS      7.11 seconds
TestRunner_smp-tester         PASS      7.07 seconds
TestRunner_userchan-tester    PASS      5.13 seconds
IncrementalBuild              PENDING   0.49 seconds

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
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7862325748081050147==--
