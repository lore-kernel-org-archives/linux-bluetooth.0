Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959482;
	b=1NKTvZv/QgCKD5hfyhxywlbDVVmiLj68uJYFDmN+1w90P1w9Jg9FMoSjQcfLy6M9N3dc
	 CM+TwBxaVMzsOGwJ+OLDvQjbgZ6fzCZJ9buMEKoOJGpOhUQcVlvYX7JulfE6bjaqwTVj2
	 TaCeDCSR1pJNCGDNeSE+cmeNwSkQDofqliOLjClF2I6SIFuhwkJiMxi1Q4fK540NvSt3l
	 z0/rsaFtCsX+Al6iKmb+4pOAM6puJqaSRQ/jngPSXh8t8Br3WS+m/IIG3RrHXkscv+smR
	 mtED0nakC3wSyjLLekq9cr6FjTnR/nEF5/YVSRLwnDnku/3WpEtGe63Y413/SkVq1Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=HsIkbd9pHOeO9/fGFPfTY/pXBX4hrlio3pPO9Fn/qEo=;
	b=ZETz2fRQaEcMGAlN6zV5abDzNFmKLQHFqnldMrsZzuMtuGaujy51V5Ei3ITlN51sNrJQ
	 k1LIG3RYXk/W2s6p5JRj7uGuTmW94QibRJOx29gKlQMEy87xnEygOtBC4joOpnhfNKR4Z
	 1VxZTzpHhqo6yfu99Wq7D5iPR/B05Su56x8YmR2+PfHtNwR2MUJfGQrfRSoAuZEK4ZRbQ
	 LHncohvJBwwuu44kmT2+4Jgyyy3JgY0+X9kQoqgj9mADoAS98ssyBU1KL2bkbfCP4SLeO
	 IaxW7+Ud1Q9KLC77jyG5UBzl+3gU++TyKEAOf8YKs4uI6uhliGdLiHdkIBhtJtFvssA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QA4jSrbE;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C57606A31B
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 20:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85C57606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QA4jSrbE
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15ea896ddc8so4025709c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792959481; x=1793564281; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HsIkbd9pHOeO9/fGFPfTY/pXBX4hrlio3pPO9Fn/qEo=;
        b=QA4jSrbE8LtvwLGapp86Rh+C9Pcrv6VjBeuR1UTZwmzWbRc4Ll4WX3ccjMxp0sGWwG
         8B+dfJLwSoYY9q4Va4bZGqUmn8Ma5jfuqLASJKIYXCyJUXohrOKY0514koW/tZRtZMa2
         yFYbiBdq1FHnPQnxAvTJ+94d19VTcxW+AE2s2b8gWjcAhMXoGExwvn0mgyrH1HnfoyHC
         V9coAXR/w3/lha7F3wGZxJE1QVDI1jlz4PvMH/6GFEkQ/9MUaIAw2u3X21hw2f3eKrwL
         yaE1QeNi1+DqW++b+nfykq8sFdAaOZ70WMuyhCaCDzIIPtnBGIJI0yDlskFuZ38KKNRb
         aavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959481; x=1793564281;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HsIkbd9pHOeO9/fGFPfTY/pXBX4hrlio3pPO9Fn/qEo=;
        b=H8VJIqLFEbELwItwHCn1KDBqruLPI97Bm1hUzcCvUGo/4k7gjs24bHBSzea905CZoq
         FxSsZ6IXmQmknhFogxnaEquX3RgoXTmzdNAESgKtQgmiCAlUroW1FwI4IIjWbCRYTgKn
         ANwH5EbRuslYZFsL03r1JrO7r7pzTPsX3kM9iBwxV/hatNVd9VdvyWxVD4FiEPVK/1gy
         PXhhB11phmsKSI8hgGIgr2rDRdnaC5F4/jf3J0vCH435bv3D/4KfLlhX/uPKZ5OJk7Y/
         bRyz+GoF6XMV8jKSNpLOdoVx1fXDpTYc8mmnvAkZsSbMQLAwQUDL7OFY7IlZfxGagNJZ
         pdQw==
X-Gm-Message-State: AFq9FYJnMPScpL0srA0ruOebEidlog/4QhzmoW56lNYJSEzBdsHwgSsb
	XLTPGkwwXnp1B2K1tFepiPYbF/i2OOKisXoR7oC27YGC5UkFq9C3kYFQZ6wxdZJM
X-Gm-Gg: AYBFou3SFkE8bHj9/mbnGl2bwHL2Dq58l1ROZ/UfiUSrSNAVZKl4lFzCPKSYo1Qo8L3
	LJsHAnfSKs0fmJxExQWwWAfYDe2IkNJqhbKk5i2AS7NHMGxidjTObl6Gcq7uR1GXAHGxfDtbsqt
	zWoPJxbysUFUxPFm6GeB2J8x5HtDE/EKQuBXAOwJvp7YjRvWz2ba5ESI4/2foVLb/kq9Sxwveo0
	hYjqOlrzwOjA3atf6+BpZjleGOgkcAsQhzEfOmxTvWEJL5uE1OsKITfhZ8II1JdlYBv9oR39VnK
	ysJ34hWl3ikZesta7Y+xegJjFKU41va7GYlkBjYfuxMks9vQdLbQ0De/oMZE9uBwvteb486yy+Z
	y3gnRROcy7Qc3r0mPcXKo11ngicuaADCcA5xER0H32i4GDWt90Dj90XlykY8FY/jjBQGrGSTtdL
	e8vUZkjbj0xgNsvDlkZ64FS8QyiG4OUL59tmdoTnlC4MlNawruroUkSsXLNn5gz7mBxsdjpFDAj
	WmfyHSkckgya0Ajr2Y56yyn5Kd4YDHweJAXl6PYxTdLRA+aArHOB3NaYXLFDpmp3zXWT+9QTjqg
	9746GA==
X-Received: by 2002:a05:7022:ea5b:b0:19e:1ad9:1c2 with SMTP id a92af1059eb24-19e1ad9061emr3423531c88.38.1792959481254;
        Sun, 25 Oct 2026 13:18:01 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.93.131])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a020df20sm20882490c88.6.2026.10.25.13.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:18:00 -0700 (PDT)
Message-ID: <6ade63f8.48d69adf.259d3b.4b42@mx.google.com>
Date: Sun, 25 Oct 2026 13:18:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5285834466874485427=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, christian.koever-draxl@student.uibk.ac.at
Subject: RE: Bluetooth: make the Amlogic W1 (W155S2) usable
In-Reply-To: <20261025192338.209574-2-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192338.209574-2-christian.koever-draxl@student.uibk.ac.at>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5285834466874485427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1193155/

---Test result---

Test Summary:
CheckPatch                    PASS      4.94 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      1.87 seconds
SubjectPrefix                 FAIL      0.60 seconds
BuildKernel                   PASS      22.55 seconds
CheckAllWarning               PASS      25.46 seconds
CheckSparse                   PASS      28.35 seconds
BuildKernel32                 PASS      22.61 seconds
CheckKernelLLVM               PASS      26.51 seconds
TestRunnerSetup               PASS      520.03 seconds
TestRunner_l2cap-tester       PASS      13.41 seconds
TestRunner_iso-tester         PASS      9.52 seconds
TestRunner_bnep-tester        PASS      2.98 seconds
TestRunner_mgmt-tester        PASS      83.76 seconds
TestRunner_rfcomm-tester      PASS      4.09 seconds
TestRunner_sco-tester         PASS      5.12 seconds
TestRunner_ioctl-tester       PASS      4.23 seconds
TestRunner_mesh-tester        PASS      5.10 seconds
TestRunner_smp-tester         PASS      4.02 seconds
TestRunner_userchan-tester    PASS      2.85 seconds
TestRunner_6lowpan-tester     PASS      4.13 seconds
IncrementalBuild              PASS      42.45 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/7] Bluetooth: add a quirk for controllers that cannot enable Secure Connections

1: T1 Title exceeds max length (82>80): "[1/7] Bluetooth: add a quirk for controllers that cannot enable Secure Connections"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/1002

---
Regards,
Linux Bluetooth


--===============5285834466874485427==--
