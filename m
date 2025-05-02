Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958D1F1513
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746221531; cv=none; b=pojrTR2YzWn1BpQwUnOsRGeDDLrVkFW2OOp3fcM21rFFPRDROIqTVbj1rOqIHMu9yXNH3H4CqXaYFmNPDF/Z8CgE/CZHymSsb+wxcpT1Ufo56Rm9qhH1MZSOFbW49avytj8Sggk5FUyRfF0ZtqPODdlouLKiFuIfMuNSUgG00Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746221531; c=relaxed/simple;
	bh=Y8VCq2PueyEWycxFuOFLCsgBZsjQtXaD5xBM1nrPooE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gGupC6CIdhfFq65xb4bpeVA/FZd+/TnYNTAPcJF76uyoIJpvibHfaVYpfvLEtgonjI+/xqFgHDF9D8XlcBMoA7jaHLl0maeTFpRK9LMsY0N8weE0bAmEzmv5xPZm+kPMZDXgkUi0gsy5O0uTzOw9dHgKF5nsslEBCUGFsiawnZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVyh/5qB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVyh/5qB"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso25744066d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 May 2025 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746221529; x=1746826329; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3sqT1h3TjYn+3+iZ2Ndu9r3c1pCx+od/tyNp6iNANsQ=;
        b=XVyh/5qB/lwhoKAQfbyuTOdxkfQoE3XqyyiOMriqXuSsGFFmYlksf8pn7JMZrzcDdE
         Hq0YDu8GDSa48Vcp/UoSRQP1ol94BgUKZuOLajjtMz3+bNnNAUd02tckgMroHx0Nb1R2
         /QKrlI0l/8b77mHbr8Ca9LdP4BxY99XJhtlXkOV+5cY6E2WDODB4ekf9mvVjhOuuSnq+
         S8u0n9+8PHqjj922agm+0aOKmmhEz2Pg3tf9ETyigCBAoQrpqweWJdp/XfvuSGTudoQe
         ilrxr1P5zBCkpHL1XGS491jzGAJfwJEv+XobI7f9bQnBl0hjaJ13twv7NvoD6AAEzvDv
         TcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746221529; x=1746826329;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sqT1h3TjYn+3+iZ2Ndu9r3c1pCx+od/tyNp6iNANsQ=;
        b=USXVYl15MpmYQaQj4/uUh9EKbxFdrGAplzeLV2nVWobAOyx1j1DZe1TEGu7jP5o/P/
         GCH4m4JXzRNoZdyf3gfwxWtOvxA1L2SBGxd7+nl1X0vfAxgRrcvaj+2Rh6x2Rr4tb2nz
         D88v/LaCtrngF4O6XeWOHeYNN7NnPzs6kcVYI540QCyjwRCEHzcQPhPCWm5fBZgVC9NN
         EZoIcKFn4jjzDWB5jdDMFzGZKDzLvKnV7zPojEmLxS6l7X3u10LaIpX6/HtrXV+lTL1F
         D82gbrR9OOGL98FtS/mXJTJckwfuEJTKSN/b743YQUtWzDu1l3CKkGjm20L1MGPkJIiY
         YSEg==
X-Gm-Message-State: AOJu0YwUycNCSbOjjC191OD0CZWMPLd813H4QKpnIYQYM50i6s0jONrG
	vxFVfUcW9+lrEGoTh9Rdq5Bn/sbqHp7yBkCuSNEXY0cUFuWARyPTHJYrgOcH
X-Gm-Gg: ASbGncuQCT6yaMquKh3YidiFrJyThkZqIuk3zBM9ueuh8U/41h98Dy3bSnU2ltwrWKo
	xcy9SHfo9xBvDhIem++lTiIwBeftozQe+0CsUY5foM+QrHosUwxbfLDAgQ+0JCEpfWFpKBJLff0
	YXyYxLAehzzg6N5PsoaFlvPt4H8SZDEbFWIskVucFg0HbXVgC0x6HwC9kgJ0XiM/u0aF1Z00kyY
	vsV60+vruMEtFSshubWTaTakI/XjHerFhNLQavEniyAWSDKjN0xbz3LoyRAM8cEwN6dQMElodAc
	sUdWKIdcuZSBOa6eT2yzeSmfiz2a3qG9PbhuTkNAzqjq8A==
X-Google-Smtp-Source: AGHT+IFT8cy8sEc2bgQcmWx+3eslF9Ko0Bksz+uEBSss8Z4TUAZ7glSDQgwj/mYn+GJr6510MoIJ0w==
X-Received: by 2002:a05:6214:258b:b0:6eb:2e88:d47b with SMTP id 6a1803df08f44-6f51525405emr68560596d6.17.1746221528900;
        Fri, 02 May 2025 14:32:08 -0700 (PDT)
Received: from [172.17.0.2] ([128.85.160.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c4540sm23473326d6.43.2025.05.02.14.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 14:32:08 -0700 (PDT)
Message-ID: <681539d8.0c0a0220.82e38.fad2@mx.google.com>
Date: Fri, 02 May 2025 14:32:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3938532564217221405=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4] Bluetooth: hci_event: Fix not using key encryption size when its known
In-Reply-To: <20250502205208.2815502-1-luiz.dentz@gmail.com>
References: <20250502205208.2815502-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3938532564217221405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959228

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.26 seconds
CheckAllWarning               PASS      28.29 seconds
CheckSparse                   WARNING   30.74 seconds
BuildKernel32                 PASS      24.24 seconds
TestRunnerSetup               PASS      456.36 seconds
TestRunner_l2cap-tester       PASS      22.18 seconds
TestRunner_iso-tester         PASS      29.62 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        FAIL      120.20 seconds
TestRunner_rfcomm-tester      PASS      7.77 seconds
TestRunner_sco-tester         PASS      12.99 seconds
TestRunner_ioctl-tester       PASS      8.26 seconds
TestRunner_mesh-tester        PASS      6.07 seconds
TestRunner_smp-tester         PASS      7.21 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PENDING   0.90 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.193 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.151 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3938532564217221405==--
