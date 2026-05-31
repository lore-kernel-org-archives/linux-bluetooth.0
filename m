Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025AC21773D
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780255935; cv=none; b=UjDl/kN1CAIBeDZsQX64Ei0oW25sXUVQ8JInUQ8/Acjlq5uL6WO8ZtvG0UOXrIv6l0Dyqztwxw9Yk94bVwOf7U7BDCFkolbFlCZRM3QP+PniTTCm4GxR3q4yf4ctZVdv4HUVoK75TpMqr9IamxG/EQzEJRdSk/qm0oafp9ZvJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780255935; c=relaxed/simple;
	bh=FbGsRLZpUlJtqbbdGk3xfhJkOqs/KBbEcvbIfHle6D0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XxvsfWo8Wn8ao79d7teWfrRBHvV01kdZGXH25VthZql86Vvt+ChqrvT/YXEWIkQy2RffYJ+pvZSA74rNSKa/tVHd1Dyw3sq0LYrv5yztDQqFZTqXygH7mIiM8b9knumRNl51c/uaYlKrBQs2p2Q4b3SOSCNu7YwQ19/WzqSwTMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWGpmXw/; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWGpmXw/"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5174a34800fso8968161cf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780255933; x=1780860733; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rFKRbMzUv7S8XYXLMAnlnQc3u3fZTVtBF7KZQYtPmXE=;
        b=sWGpmXw/bWAER7Va90nsy65JgpEox7uhmiwqQbr1QuIsGmlKLfVLSf/lptRf6ACkSf
         NEo0yeOTcEgFkr89cZktmkquz/xtvI7LaCYyOUbzH30kGLWLf8/MqGeERKp4Grhpxq33
         SIe45N2x4u7TSWMBteCsFEmb6IcJ+QG2PnfN6fwuVQksO8Mbwcgr1reAILYrg2F/XZAy
         DTCQmfwoCdzG3ft5D1/PWVzH4p1To28pz0Dhz5Gsva3egm00CQRxhL5qSC1UhHdB5tkk
         2c7/a8QWkd0Rj3TIa5TxYl4iKSvC8KbZulHTC6CHh2IiI6lUALr5SS6ui8GV7uy2UTqk
         uPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780255933; x=1780860733;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFKRbMzUv7S8XYXLMAnlnQc3u3fZTVtBF7KZQYtPmXE=;
        b=ZuA+EXVgx+rjJjNchD4C+5tkM2F1w+3t0SnZPkM/sJ/Z84oda0RMSHew9GOAIB0WZq
         z8yUy52LA0JWC1KE4+ZNAQti4e/cyvF8Pj8o0t9WmkxfuNsbsRcOxBlIszO6Qf3DoPMP
         dZfo/xv/tXUxgijwf3Tyjq/VlGAmZv0zDBLUPNzU3P0v3R5rDIP080nPrvjMJ+UQ7MDO
         9VylpnXaTNJrNBXSSHtvb45p6pNDIr6mdRk+kAUd2YnL6ftxH9u3inILVJYM+0mP+Piu
         NPODTBqVM3iDoRJcYbpnqhyNZWijyDfElCWI1Gf1yD/i51LxOZ017zVaqV+S1kjQgCwS
         5MOQ==
X-Gm-Message-State: AOJu0YxEi6GdXauTt5Zr92aCtutNt2Bof0iDmjsr7e9pq1jXh8uYKx0+
	PXk5eFALpcfH9vMPrET4AvurV2FUPy0i83Uv/O5+y/a1p2W2IHlYVkz2mFNJsQ==
X-Gm-Gg: Acq92OFyVwmdIxG3viHWLMtzlznnlKV0s8flORcbPYJto99nmHbt0QFz+9m4BfwIMHK
	zQoyZ95HuaBQtDD1SMX1KMe/7x2CfNUYCYFAwCsjQVqF0rygLDP07F/dIOEOmytg6/l+hBfxSUZ
	4jUGXFF9FgU5yCQ8+680W7PG9Ei9dYxGtPWdEeWwZ2imHdbjnMdrMeIDGy84sDjKu9fzSDQpA7/
	Gp1AI14stx+VdA4xsNog8T/xH76tG+Ogb/UIv3zWrDSZO9HEvCfXHKihVnNvO9+3YWWBo7vKX2y
	WBGAy81/w4cHlYslyDGfrHyVdEu9v6cSIhs5EVoLEtmliQEA18bA/RcwtYpZB7Y8yA4LG5H3pyy
	y0JtN6+Hbvfls4JY1lZQJ3Pao92dcZkTPmkEQEHpob1RcIUZ/sCIL2TYaVO03kgACSWNzvi0CJy
	6oYsTdWDmrfNxc+BVUwdbSzRu4R71YFsDP3oQDnhmvPQ==
X-Received: by 2002:ac8:59c4:0:b0:50f:ad91:8912 with SMTP id d75a77b69052e-5173a61746cmr132384961cf.13.1780255932933;
        Sun, 31 May 2026 12:32:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.198.68])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b06e54sm37754641cf.6.2026.05.31.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 12:32:12 -0700 (PDT)
Message-ID: <6a1c8cbc.8d510ab8.182f74.9adf@mx.google.com>
Date: Sun, 31 May 2026 12:32:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7423018637070842147=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kbreddy.rpbc@gmail.com
Subject: RE: [v4] Bluetooth: fix memory leak in error path of hci_alloc_dev()
In-Reply-To: <20260531185339.107188-1-kbreddy.rpbc@gmail.com>
References: <20260531185339.107188-1-kbreddy.rpbc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7423018637070842147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1103659

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      24.71 seconds
CheckAllWarning               PASS      27.34 seconds
CheckSparse                   PASS      26.77 seconds
BuildKernel32                 PASS      24.39 seconds
TestRunnerSetup               PASS      521.61 seconds
TestRunner_l2cap-tester       PASS      58.27 seconds
TestRunner_iso-tester         PASS      71.09 seconds
TestRunner_bnep-tester        PASS      19.01 seconds
TestRunner_mgmt-tester        FAIL      210.04 seconds
TestRunner_rfcomm-tester      PASS      25.47 seconds
TestRunner_sco-tester         PASS      32.52 seconds
TestRunner_ioctl-tester       PASS      25.65 seconds
TestRunner_mesh-tester        FAIL      25.96 seconds
TestRunner_smp-tester         PASS      23.39 seconds
TestRunner_userchan-tester    PASS      19.79 seconds
TestRunner_6lowpan-tester     PASS      22.57 seconds
IncrementalBuild              PASS      23.69 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: fix memory leak in error path of hci_alloc_dev()

27: B2 Line has trailing whitespace: " - Added missing curly braces to the if/else block in bt_host_release() "
32: B2 Line has trailing whitespace: " - Fixed a NULL pointer dereference caused by v1. "
33: B2 Line has trailing whitespace: " - Moved cleanup_srcu_struct() to the fallback (unregistered) branch "
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.246 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.303 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds


https://github.com/bluez/bluetooth-next/pull/261

---
Regards,
Linux Bluetooth


--===============7423018637070842147==--
