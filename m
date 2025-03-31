Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735C21148F
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429787; cv=none; b=mkKuGA5jyufm0RutKVMWd+vS5FoIqY8l2OcZzkjj55eitGLjmvMczISR6ok/wlQrtqF+qwpLveMkx0uzvzIuTtup8kxnE1L1ZJLwAM5Pnhm1Vu3n8SAEKXwoWN6YeaiO5u8he51W/kKC9scKMaJis/IC1D8iDJfIz8isqXO9Og8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429787; c=relaxed/simple;
	bh=8cvTRcfaHTmyazg0/bfMR5mQUMu+my+6H9E3E4U+eqk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OQaQedQ8IiWgturhdRTgnXaakLiRtE9mdWtYUiS9VPmlwI3rFlTrvi2DypZqYHYqzCGK2GXDSljVrfkpUDXAkK2yCHy/PgjS7jd9RBEdmNca5FSRKEyIkJ/uBIH/Re+K9J2AI462fsF9nuZH2zl8p4mvhfxM8GHNIce8HPxS6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZDA82pq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZDA82pq"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso8093588a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743429785; x=1744034585; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tTlF5oMo6qHC/lyVGLst0ZHWLG3T8VuVpGtlVBClfN0=;
        b=lZDA82pqp4DazkHHdy+BumdB0Mx4XRWBVSdtI4KEWhCDnlKsN1XulUKGFMS94LfjKL
         5Bs4zpnlY+0gW0HE80R9/yzTy8iUtISrEDRPhmxjqnZ+5A8h3e0O/lSmQaQR4sGH/M4c
         fi4sLQE/A7M9besMob7kwH0udE8hHluxdAWnj/9/hQsTMHuBCGCWDVvvKZ4/CqVxFjXa
         fl8P4N51E38lUjieELJ6vRM8N0ZSTACzAlPNyw0Q39CZETwdzMWXgG+zaQpcV3djZq6A
         AWroLH4OdT7YAFFg6EZzt+ZzJdiGXyHrSB9rKV6hj/a01tAAJEiUJGruM9iX3n4Yl9ko
         rz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743429785; x=1744034585;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTlF5oMo6qHC/lyVGLst0ZHWLG3T8VuVpGtlVBClfN0=;
        b=hAzyBV+YQy34E3S9FcQCyp/dgOH6PT4EPpgQvzMgJGMREHfkj8Q1xKbFQuzTw/5spG
         ufnG4rrjk4S9vTrXAWF1DWuH1loOwd6+SpSGrftDyweimd7EPIpIb4UQbuF3d8zxkKC7
         9uDt/ggWvGrSjzAOUfiRBI1q+sj5OUmXvZjCS13+XX7zUuFsh7CKakuiqp0IDzP5lbaY
         UQj2jLBAGOOeCtGrShQhKVYhBZBgr60G/FPPHWf0N2vndpHWMOf8qMkOBglH9M+0+1B8
         mahd5IfHgNC3URD5E+Zo+ZY8FVcFNl1bY5Ecml/y6wuWKOcuU1RP6JQSX/GiW3AKdgUB
         iI4Q==
X-Gm-Message-State: AOJu0Yy+lo9+sL2A3wqlB0K57hG2qziMz3Vfjw/j0VidZMbOwHvHKEn7
	24vYrECTqnb1+aeNHaz57sjK9pFZg8zyCdgGk49B5U/t8kuti0jnvzf0lw==
X-Gm-Gg: ASbGncttSJAfUrCNPJ798qjwkTpLjehheaVEDvySpYXMSnNICmmYC/gS3pCRoHfD2fN
	tPKtGMf5HfEc3xNeqs/28CoH7IKOqwyKprPRas2P8bPzKcuo4Nukg+eYYIpmf8Jvb51lfp+hlLl
	IPcCQPDm8slA8Xgtpidu4ctuITz1BMaUQcEbaZzKxx1JnR/9hIKglNoj7YIjDcfykkkE4WFSGJ6
	4ZULNqdiLEkTHCFDNr940ShJeWrPmB41oOp2oiq0De6pA6kWFrv/JxOLbp0EuZuEnRpQcAmj/QA
	w9GJ/XX505T+pESIniHs8zrLyXaAW4q0yssSoqvR5qVRnQs4zQ==
X-Google-Smtp-Source: AGHT+IHyx8wAHEXuB5az2+hUkQLxQd+AXWYIy72itGshHAqJDWnT60hJuY+pkZDvhYqQjamBE6GlOg==
X-Received: by 2002:a17:90a:fc46:b0:2ee:cbd0:4910 with SMTP id 98e67ed59e1d1-3053186c82emr14882390a91.1.1743429784631;
        Mon, 31 Mar 2025 07:03:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.5.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dff36a3sm9545548a91.19.2025.03.31.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:03:04 -0700 (PDT)
Message-ID: <67eaa098.170a0220.22cb02.5470@mx.google.com>
Date: Mon, 31 Mar 2025 07:03:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6508741723719738442=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Bluetooth: rfcomm: Accept any XON/XOFF char
In-Reply-To: <20250331131503.63375-1-frederic.danis@collabora.com>
References: <20250331131503.63375-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6508741723719738442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=948566

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.34 seconds
BuildKernel                   PASS      24.51 seconds
CheckAllWarning               PASS      33.11 seconds
CheckSparse                   PASS      30.23 seconds
BuildKernel32                 PASS      24.25 seconds
TestRunnerSetup               PASS      432.43 seconds
TestRunner_l2cap-tester       PASS      21.47 seconds
TestRunner_iso-tester         PASS      29.01 seconds
TestRunner_bnep-tester        PASS      4.71 seconds
TestRunner_mgmt-tester        FAIL      120.57 seconds
TestRunner_rfcomm-tester      PASS      7.85 seconds
TestRunner_sco-tester         PASS      12.58 seconds
TestRunner_ioctl-tester       PASS      8.27 seconds
TestRunner_mesh-tester        PASS      6.09 seconds
TestRunner_smp-tester         PASS      7.17 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PENDING   0.65 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.153 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6508741723719738442==--
