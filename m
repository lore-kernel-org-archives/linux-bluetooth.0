Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CD074E09
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442658; cv=none; b=KeNd/NcRhs705FgEVpYS7XwTIftsrc35VytHmnWOaV4rK3DwZqG6vBXNx10nDxI7Rr+wseRJM1BNm+oBL3SAqoKtBqDholVSCyhF/Jcvai4mGoXbfPtv2/+BEJ11g0mfqGVc7DB02vm/zlyhw3kiroc4NFJd/DPmbhPXZsDWY5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442658; c=relaxed/simple;
	bh=jXFBCIm5Ww/sRmZRYBtUwYQNbo3J8uCxL+i4F2M4xTg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nm7nTGq0Iu0Q6eQ1/3NvNwLQfoHUiNlpTJAKGddMJ90F9qEQ6JqD6WzylZOrYPu6PhSsONMVQDrYIFSHjFMRgBoZxAiaN7qmKp2Ed6FiKgQmA6cTs9BIfmKZsxaU1wStx6CKdu+Up7OoPgnPeJ3JmWikERKyDbh6D0aBlHWoE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxK5aR5q; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxK5aR5q"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7810827e54eso87111785a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710442655; x=1711047455; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eewg4cjU0gGFpj7sa8Rfa/up+IQDyIq8B7tyYzENgxU=;
        b=KxK5aR5qHgur6lOt/K/jR1eqCwjhjIUGo/O06ANBb8qZr2LYf2DSiGVfm0ve+Izlot
         F41SYNf2kcb2/7AgNZd+A3j6SVSxjIIyM3tpiCk/EvR85KfSCw0FC4DwOVaHzxWzPIhb
         QoxxtknrLMfnqyqg2fZxeCXCG9hm8cUcp+s9eWJcKio2ATOHbKuLlFGhuwsvrC4s3Eln
         CeYDzsd76A9gyUJ4u3um9BcL5A/1Y2nK4TDGNYLgO6SIa2mvSHwX8U6/bRMuBNGa5Qmv
         8hDLMK+B3eQk84Erv/zp+QSazcHEJ3l2BgbU9M6Qy4bpz7lUei2CRq5a1AmK8pNz29SC
         NX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710442655; x=1711047455;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eewg4cjU0gGFpj7sa8Rfa/up+IQDyIq8B7tyYzENgxU=;
        b=hhDgMq/j26rhz5aYSyltWhJUb6/0RcS322wE07WkKBtTT45HqivxmmWFfdiR/dZ5BP
         YxWo2yGfeoCOsjDxI7Mir9v7ywN7xaks1CWZAz8APVkqvvcpEgnOAkmwHqPFiBV+M5Hk
         yPQbJGqikbnNiQ/zsWQckOT4CJRUFqYO3pUvqR0hSfEhdA8HAtyQv780tBd5mGrBb8FM
         rlT1w2aKcMRkoZsUJsG3VJAWH0pGhhXfKpwyds521eep2HAIpQgUVIN74LOOVZ2tnSs1
         o4jlVsuQxArk9ung50EBOhuXKF8jNLFuqI/SxQyxIitQehYvVsbvwcLkK4XDF5SrkXtx
         dCeg==
X-Gm-Message-State: AOJu0YzCccUbq+ShBaaJi+H0GMRFzuT6s5dQqJ40k2V35TqvB8VCzoTA
	W8XDXufpPe2gVEGm0hJ3qfsYFyAa2YGo7k33/jUy5W6mWmnEWAlbqRp/FEBI
X-Google-Smtp-Source: AGHT+IGtRw1SHsKYltutUYUOOk4OAy2mJzG+hYqFLrcp/t/LE41KbVGEhd7iE3A6hwWSyVvJGo6VFQ==
X-Received: by 2002:ad4:56e8:0:b0:690:7e1f:97f3 with SMTP id cr8-20020ad456e8000000b006907e1f97f3mr1493751qvb.21.1710442655296;
        Thu, 14 Mar 2024 11:57:35 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.196.156])
        by smtp.gmail.com with ESMTPSA id ke21-20020a056214301500b0068f35e9e9a2sm802505qvb.8.2024.03.14.11.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 11:57:35 -0700 (PDT)
Message-ID: <65f3489f.050a0220.a3dce.2e38@mx.google.com>
Date: Thu, 14 Mar 2024 11:57:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5608475831197545385=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: add TX timestamping for ISO/SCO/L2CAP
In-Reply-To: <070880b4b69ca8523d08a16433b6f4ae0b1a19cc.1710440392.git.pav@iki.fi>
References: <070880b4b69ca8523d08a16433b6f4ae0b1a19cc.1710440392.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5608475831197545385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=835394

---Test result---

Test Summary:
CheckPatch                    PASS      5.54 seconds
GitLint                       PASS      1.64 seconds
SubjectPrefix                 PASS      0.60 seconds
BuildKernel                   PASS      28.34 seconds
CheckAllWarning               PASS      30.80 seconds
CheckSparse                   WARNING   37.07 seconds
CheckSmatch                   WARNING   98.95 seconds
BuildKernel32                 PASS      27.15 seconds
TestRunnerSetup               PASS      508.13 seconds
TestRunner_l2cap-tester       PASS      18.01 seconds
TestRunner_iso-tester         PASS      32.23 seconds
TestRunner_bnep-tester        PASS      4.71 seconds
TestRunner_mgmt-tester        FAIL      110.32 seconds
TestRunner_rfcomm-tester      PASS      7.29 seconds
TestRunner_sco-tester         PASS      14.87 seconds
TestRunner_ioctl-tester       PASS      7.75 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      6.84 seconds
TestRunner_userchan-tester    PASS      4.86 seconds
IncrementalBuild              PASS      89.80 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structuresnet/bluetooth/af_bluetooth.c:223:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic blocknet/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structuresnet/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:150:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.165 seconds


---
Regards,
Linux Bluetooth


--===============5608475831197545385==--
