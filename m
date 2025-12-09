Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52F224B0D
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765301947; cv=none; b=gD/to7j1ufnaGnpVUz0xRWV/OtgMCsKzEaj3bCqvKsINSgtC1hER8H3bLkekGS5iGLy+YnPNbthnbnSK/gxfoFhXvrocxrFc0hYWPUzgtXbqo4jNqsjnC2kviK67eQPc47LQU2l5W+2vtYjyOIIpm8CIzwU5aHhVw8tTBbJM478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765301947; c=relaxed/simple;
	bh=WL9V+E1vOR4C3W46fo5eu1yUMknDMh2RVtep/zThSQ8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SVE8gyYyMUVkL3MMUy/uJYBSp6Zs7KeUUal2quPCVG5flpOxThKfe82NPWYVrnMfruCiK15S0wM/8944wv8QIPWH5tqdzj4aNedmwW2x/OVCfqvGqvyUYzmkcCLMX2oPOoa/O9PK7P0/Au89L4a5QKJ9CKuqzrNgrcAyJdugtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKbJz44A; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKbJz44A"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2da83f721so6998185a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Dec 2025 09:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765301944; x=1765906744; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jWL9nOD3VQAAg3d2NvHvcCwtPeJ/qdlraE86MuTpato=;
        b=YKbJz44A0M/eZPIRxQK/tEQKBaYstNuTRVtmC/dht7ZcHmWhlvO+UUIJaPCVLm43Ic
         W0p/GbuCDVL42Rr/yetLw34rggdxxQK/XnkjvlzIIQ3GzKBSd9fMbafs6B2oCqHWhX2R
         1s/ftEPzKTvRxZz+rbXRCrWR0ZUJpgRAbldWleZdVLH+CX/qgpPYN8F9EOYogv0RYhpw
         gEo4paF+h7I4lVAHounmNFVIJq7BrhRbnu4iI/FqfCY403NWlA2EUaGEerR2Zr60jAOs
         0EJREu2v5++kKKIyk4paIvYLWi55F2Nom5kxMq6kkTQrHpegd5/MOTxYTzJObUG1Ja4X
         JVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765301944; x=1765906744;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWL9nOD3VQAAg3d2NvHvcCwtPeJ/qdlraE86MuTpato=;
        b=A8gBzfnWevBFQbPO4kb+PA3QfiRGrC70LyJj01KpCu1MqMVerzt9Yu+N6Ni9HkiFoI
         yc6PzkyeXPjslW8a7KE+F2S1+bRpDHX/UFP7Qd7F0uc+dFhYnDabR+qnw2d9eMmIUd9H
         dfuAEfkSY2+7GSqkYJ2OkMgPQRz9BlCfXGPEowwigy0OrmyCiVvQ98CM2p+9PUOvgvIh
         uaaurvpjC0QD9I2bD/G+8q5eiJ8GDGQ/zPfdissAp0J/kwWtD9h8snI+lkcATB9wzXPI
         uahs8VBR3aVOkvKlSwWX+m5/kcsyzzNlQpgtch8sc9CV4zneBPLGlJbGWtEQNhGUD+9O
         0FoA==
X-Gm-Message-State: AOJu0YwujligsR6AZJvnZj4D3cyOBPyNe8smuQ2bE54zHXJWwLEMfZgv
	jMLf6w7UnStq/Zve6KARUB/xSWEptDOzMhCvtQEc78viweOX78oTDD53hyrZkQ==
X-Gm-Gg: ASbGnctNjqAxdFbRRwNtyu+/d4oLIj7YBGia4gsQcjCc50vl26yoGEMj3m+Y/M+u8Hp
	aS1gTeBCfpXB7FJsGXhZRVUWNluHULt46LrvlkV+ImXDUK2/442Ca/rF/PnM3rfmYoWXDijJ1Es
	MXfHNYpdeMqWIO81iTzBDpPENtp7AMWcJ2B53nEQSSv6SqyNTv5v3GHmkBBxvboRCS5nEvhQOI9
	J7ZyzFfhb6G9HGeSCd98KUCk0dz8NLVePgDnsZfEQSoW8VX3UCSDWOAMA/nCNX/fkmm0NRkwNHl
	rkl2wvH1GJc+56XxiiWRJm+wZzazao9DKzCa/cc6ZER/4yBkAvzQ9NRlAiv1Wj+Ajz4p1/D+nVD
	Zvd7beaOiWf4SCpvhnmIztD4huVZlVzRGGYB4BCmsmOHuYY+vtmY6fSsciXdDJ+TXX8DJL7e7O7
	g5VJzlDL97/HzQ4ZA=
X-Google-Smtp-Source: AGHT+IGE7x3HxOn3nCWm9nSbpdZ1XaJmU49MfD0+rhtj43sHtzuLEPv5wwYHuI07ADv+AcpE59ZAug==
X-Received: by 2002:a05:620a:28ce:b0:8b2:eb66:c5a with SMTP id af79cd13be357-8b9cf84d6d5mr322879785a.14.1765301943690;
        Tue, 09 Dec 2025 09:39:03 -0800 (PST)
Received: from [172.17.0.2] ([20.57.77.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b62529e75csm1380981685a.9.2025.12.09.09.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 09:39:03 -0800 (PST)
Message-ID: <69385eb7.050a0220.1e023c.7b86@mx.google.com>
Date: Tue, 09 Dec 2025 09:39:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0578573358092134449=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RFC,v2,1/2] Bluetooth: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER
In-Reply-To: <118c61c95ad4deab0e08d3a3c8b92910bc271281.1765297112.git.pav@iki.fi>
References: <118c61c95ad4deab0e08d3a3c8b92910bc271281.1765297112.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0578573358092134449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1031774

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      25.26 seconds
CheckAllWarning               PASS      29.22 seconds
CheckSparse                   WARNING   32.99 seconds
BuildKernel32                 PASS      26.25 seconds
TestRunnerSetup               PASS      562.60 seconds
TestRunner_l2cap-tester       PASS      24.39 seconds
TestRunner_iso-tester         PASS      83.69 seconds
TestRunner_bnep-tester        PASS      6.28 seconds
TestRunner_mgmt-tester        FAIL      114.47 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         PASS      14.35 seconds
TestRunner_ioctl-tester       PASS      10.21 seconds
TestRunner_mesh-tester        FAIL      11.56 seconds
TestRunner_smp-tester         FAIL      10.89 seconds
TestRunner_userchan-tester    PASS      6.56 seconds
IncrementalBuild              PENDING   0.83 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.898 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
WARNING: CPU: 0 PID: 56 at net/bluetooth/hci_conn.c:567 hci_conn_timeout+0x15a/0x190
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0578573358092134449==--
