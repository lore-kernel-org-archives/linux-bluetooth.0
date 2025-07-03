Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4850224FD
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751565763; cv=none; b=h31WQJ/h7t4xXECrkw8/pfaRWo5KRjkK0ujvsrrmL4PQkkp7mIPgHdlxDu2Pg9HxzyhLitEhYdiXAHIBmDJueeGU6dITUJNabBRm+T+OiAI8J09e8+rkVI9ETyzzztr4XFarGDaJIrBOlT6rD64WeCK2BiTrzKaWsSVSLiQoGw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751565763; c=relaxed/simple;
	bh=gstqKVP78lRXJ5gfDu+0QlGSftXOQSTsWWckW4i/fwk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m3uM6lvA7JR2OB2BV6MXGaG+gFcD/+9UruW9byFDwl2u4S1HUrVay6CyiKuKfd3ki6QrKtLvIRzBPR/Vs5vV9cbGSu/qKJRVzn2NTw/T1pTrhu9+y5D/MtwhJ3JwKMCvgS61er3KIG2d/V+w31h6G2mhD0iCTQGGnxyfBsXEpw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liP6ZVax; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liP6ZVax"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a58c2430edso2533961cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751565760; x=1752170560; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h5nYda0pEsE1ggXTJtEXQJcCvKjYySDeXEyrs3/363o=;
        b=liP6ZVaxLk/w5d2sGDE+qTEqdkw5M9iVzCyLo+yDtzR9AoVt9c+KeBPwYz5IbT7Aq0
         2Njc2arQBbEgfvZKDDykzbJnyIZm91SR2f9vWvp9c145+y5uPvgpd98IGWqT5CxRIupg
         FEfTkYZzwNfAC5iQqKN9Z+A4VvJ6oFwPlSBRk0+dEeeVmnfTw8LVX10AcDaSXGtm/4Zf
         Ko4WA3FV1AeIDRGtN599Wwec0auiULclMue75Nh+0lB2PQsxfBIJF2eQFrJZb7/kZlE0
         9vNf5i+ytw8JCrZdjniJSSmhyaV8f4HIeJh7jwdWt4WJA5tS09Q0f01poJQ/1ESUjuwt
         ztGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751565760; x=1752170560;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5nYda0pEsE1ggXTJtEXQJcCvKjYySDeXEyrs3/363o=;
        b=vPnYVomXpdQR94wuHGbTyMLHGySTMYAH3Xg48xUC8LHtyn/uI42Fbt/xBXH5l8UMAw
         EP/CSD8MTA510NJvg5u9rauDFFRpZMEKUYSEujLPsSsHXbxoudxw8ViJYUpIb1V4phHK
         l9FPrCJFvHkJqBHJkjbI2r2o7akb2GT+uEsbKCB/SJ4btmBgNAjCk8AhKytZf3+x1OHR
         bbxybhxxtW3TXPPhv9wWnt+JXoADO+Vvq12bZcwBWvQCgeTiivzI3F8rAOXypHTgLchK
         shSPcM8N+nNqjIR2gBNez3Wrsl9pihVhYW4D+psjKwmwS841x5BHojkNJC2zdR8CQlmb
         y1Gw==
X-Gm-Message-State: AOJu0YxDw9WEm58HDBOm/lFOEgMd2mfHhkjmy1EN4+7VOtTra3HChQif
	VTaj/gJMEojp9FkKpMlV795zpSHyOmK6TMKtdRV/l0oJGwGd/p2VS4awC3ur0w==
X-Gm-Gg: ASbGncvTFTpmc14HtwmknVf0tYhCuJVVj+rU76aizowma56oewGdHzwg0W9cdlQoBy5
	VRF4CqAOv5vWQsFV/90Gs/Kbg0BbfTVya6urv+w8uhGUWX2awmMbho+FqNzi0guI0zKgCH2w45R
	RgIJkpYfD8o7NfvuauKpbZEjiY2niCf/uvcVuRzqWdxrVLHZnALH718SHcqMotLI0psJJkDq6FB
	j88tV7EArbiQYN7fyvE/AAgI9iwhPKwWOHER/T17WE3ND1crkRh7/yAEU6zKWnElAG5GOgrCpus
	fMz2fWNO/87qbJPpFXvtOARx9JslK+9RJXBlu+mHBqSHp0GGsfS//ukNLAI6uM9Lvg==
X-Google-Smtp-Source: AGHT+IFZd2GsJ5qX6txrC1ict3HU/CDZxTfHk0QLPp6vj4KBbNGLg5GJhgc2VqSYNEmBHsvbv2iTQw==
X-Received: by 2002:a05:622a:a08:b0:4a7:7c8e:1d5 with SMTP id d75a77b69052e-4a99508ec8bmr1553921cf.17.1751565760220;
        Thu, 03 Jul 2025 11:02:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.62.74])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a7a6c6sm1413991cf.43.2025.07.03.11.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 11:02:39 -0700 (PDT)
Message-ID: <6866c5bf.c80a0220.7b098.0ed5@mx.google.com>
Date: Thu, 03 Jul 2025 11:02:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5219040396025727001=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Bluetooth: Fix typos
In-Reply-To: <20250703171815.1011001-2-hadess@hadess.net>
References: <20250703171815.1011001-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5219040396025727001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=978733

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      23.93 seconds
CheckAllWarning               PASS      26.61 seconds
CheckSparse                   WARNING   30.61 seconds
BuildKernel32                 PASS      23.84 seconds
TestRunnerSetup               PASS      469.08 seconds
TestRunner_l2cap-tester       PASS      25.18 seconds
TestRunner_iso-tester         PASS      34.20 seconds
TestRunner_bnep-tester        PASS      5.91 seconds
TestRunner_mgmt-tester        FAIL      132.24 seconds
TestRunner_rfcomm-tester      PASS      9.34 seconds
TestRunner_sco-tester         PASS      14.72 seconds
TestRunner_ioctl-tester       PASS      10.10 seconds
TestRunner_mesh-tester        FAIL      13.56 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      6.22 seconds
IncrementalBuild              PENDING   0.53 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.206 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.282 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.126 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5219040396025727001==--
