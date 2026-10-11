Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729483A759D
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791759120; cv=none; b=Mdg/dSaZ0lxPgVG8ex4SF4d7LeeUnD6O9m1kDCmwu2Y/5NMWiOBYLQ2Pi1D0rMYt5F5T+xIRFGM4ClKM0bT8s79uOwvX1h8bvgTXv6TVNlP3xZkJGf1DgyoU/5Ot8FfJR0iS5KDSoj7dZ4McaeaN3X0Si6Q428zEpBjvm9QsxrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791759120; c=relaxed/simple;
	bh=jmCPRKWbTVnxV/0+x+4lF9Svq08mhAhNZW2xAeKSXM0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RWuot1vBvTRFe4LJ6dnWFG2iuf/Xi15uN5oKBUDbBGqopY4St9RHiybE5mLtDJg/s09fLnkMeKSxVEwATIWg2kWbDSdh8PISJ+0L4CiDSGLKA8zURb6eLGGWSoIF4LPkhndfsb0/ZfwfrKZsqNrQRWa7bTSYiB4TRz9LvosKUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/Z4xBsC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/Z4xBsC"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3aacde0cc0fso448824a91.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 15:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791759119; x=1792363919; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IeW4lWnzDrghpeTshx+eoq4ClBQkkB11qrbnH3gWBAY=;
        b=T/Z4xBsCwo759LJISkhpQ+f7/T5EzfI3zonoCgufsCltTXpAwVnKXdTPyA1rFLyrIn
         bt7rmNTCJWYFXcFnNV8D2RZz8OMJ/vvIoWmDzRCmGwNwh8SEnoY4GLZCvcvTAgOICVrA
         v1aFkhCFCVJNZSea2+R6SzwDGwM8eXJ/hV7Q81EgGdyAVf8tV9ULSiTQzdX68ay2B+gH
         R0aT5+D29d0KDTg9v/lDY7eyT3RMt1MBmyu8rcODb9Q7652lPTaCZ+YqfePH6E0W94g8
         17mJOCX2gVlxnNekElL1yFB1DlVb8dZAkuw/L+X5EF+GYoqFEY3vt2SxOgcxSfpAsWq3
         /B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791759119; x=1792363919;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IeW4lWnzDrghpeTshx+eoq4ClBQkkB11qrbnH3gWBAY=;
        b=oOp9IsHrc8vHAFe+om0HY/QTgEL8B3pjJHA5PeUkiIUGlk7qokHVUEVAheUmc5PfF5
         r7EHo3qZq2MyhlhTMPiOU5K5ZjV8ipVJHnwS5wirmENiHQojyK91Skaoi5+mdOzHZX/W
         lRDajB7hm1qlR6LTZm4rlLd1LQ1dkVCxio/rv/jl4CDuaO3r1dvPB+Pw337W0zNH/obr
         I0WQf/NahNpom4o1GMWPtAqAy22c5s8nO5M9LuQOyrpopEXQ0gnZusKWLmdUbchEjCWe
         ByUk44KprBldi0d3MvkP9yhoLF905E0yPIczgYIq4+9wCM1fZn7BnKbDAxhhG3u/vAts
         azGw==
X-Gm-Message-State: AFq9FYJhvN2c7v7mQSJq9Pd9AyOo56jIwKID/Btvaei1954IBPZuJKi5
	UTCE1xzMtgfVwTxeklNDa6PqJEJn+CwxKP5ZrT6+Ij20FFAETKBTJgb5PeNX7Q==
X-Gm-Gg: AYBFou3ps4XpqWpmw4V9zdGCEfa4DPw0+hA4pTScn4oR4PkK7/C0kwfwquktsMZHQ9l
	/Y7c3GZzgRsJF95IwiHJCF64lmFTM2R2OhWIO83id3k4obuvVbNWipA++S7b/bz70ORPWKfkh9l
	ero5aIoMLxnjbtylH84xTSHhqf96FcKSHSL53hgVo9EhoRsIpjtJD9LTuNT9WROk5L4sRcnrtgb
	WS+tvPBQQbqLUwzIZ1m2lIFuOm8INpSrWk1XM9FaYHGM5ytAF1qki02bQQBEcjB5bcKmOhMuYfm
	V5/frcE1uAg/EfzIKZqOZut8pd3jbNG57gV8Kraj/XuvN+W2SUf7Q1u4C0elpZVcD/qruf7oVXA
	H9KvosJs/E0BIz+U/TNoOvVfxxats4XQNpdcFdeZQijQzTu8rrTmihwf8H9BIO09Rh2qf+65PxK
	1wrOwT6UVpTSFo+eOFkC6gUL9t/WxNjSGlz4rpr8VCJY4c8sBihHsaU/DGTO3LZbhXZlSgG6agZ
	lYZkSP3iEATqQ==
X-Received: by 2002:a17:90b:3c85:b0:3a7:8ef9:3bb5 with SMTP id 98e67ed59e1d1-3ab3a90b5e6mr6450422a91.10.1791759118706;
        Sun, 11 Oct 2026 15:51:58 -0700 (PDT)
Received: from [172.17.0.2] ([4.155.237.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab39234b62sm14081124a91.16.2026.10.11.15.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 15:51:58 -0700 (PDT)
Message-ID: <6acc130e.687c8b1e.1539a0.1804@mx.google.com>
Date: Sun, 11 Oct 2026 15:51:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0928603002493392056=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Indicate PAST RX ready to userspace
In-Reply-To: <fda2d67929dd3888eecaf1faaa97b3f3c16829ed.1791750397.git.pav@iki.fi>
References: <fda2d67929dd3888eecaf1faaa97b3f3c16829ed.1791750397.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0928603002493392056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1183465/

---Test result---

Test Summary:
CheckPatch                    PASS      2.07 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.40 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.46 seconds
CheckAllWarning               PASS      33.16 seconds
CheckSparse                   PASS      36.03 seconds
BuildKernel32                 PASS      29.22 seconds
CheckKernelLLVM               PASS      32.85 seconds
TestRunnerSetup               PASS      771.93 seconds
TestRunner_l2cap-tester       PASS      12.40 seconds
TestRunner_iso-tester         PASS      10.56 seconds
TestRunner_bnep-tester        PASS      3.13 seconds
TestRunner_mgmt-tester        PASS      61.09 seconds
TestRunner_rfcomm-tester      PASS      4.37 seconds
TestRunner_sco-tester         PASS      5.56 seconds
TestRunner_ioctl-tester       PASS      4.58 seconds
TestRunner_mesh-tester        PASS      5.43 seconds
TestRunner_smp-tester         PASS      4.22 seconds
TestRunner_userchan-tester    PASS      3.09 seconds
TestRunner_6lowpan-tester     PASS      4.32 seconds
IncrementalBuild              PASS      47.37 seconds



https://github.com/bluez/bluetooth-next/pull/897

---
Regards,
Linux Bluetooth


--===============0928603002493392056==--
