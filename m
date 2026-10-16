Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DA630E858
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129685; cv=none; b=NRxXpAZL/CuFaIgXLoJ+bwU41cCh9/2Uo+/gXv83q72tjsLXCZvxYngUMPx9hEkXA+fLDY9ZRkeraNnBmrxVJ+er8SYFVWpyXQ97/swvqzBZvs8B7VxzKVwAnAfkNHUh3n8ny8trXZdCFm9112rfIahEXFfBBOnMMUdecUsfJsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129685; c=relaxed/simple;
	bh=2dACQMJl4sUug0+txV2l1Ll2IuOTeKcI+X8uFqnL3ys=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mE5WLdrnlVRtUy6jKEOeynV5IXDnR3fSIZM7360TPIECzL2kH8uitl3A3lP+NKuh1OXnkel1M8D4nfUqW0wDNELg9C+Y7kU0jrwlzs1M/RhTMXnEsFZ7FbXW7yeqxUgSygJa7aW3uw306VJfFhoxZBMvUPiEhvhTU/i3g3OQUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwMmWv/u; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwMmWv/u"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6cfed5dd071so4597987eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 22:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129683; x=1792734483; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tBEZoG+6kSU8/fnTWQ6RC1ACPH6+2wmeT414nXwxess=;
        b=HwMmWv/uCLHkSwwI6kK1vH+1GovdjrUavKxE9/jd/onveNzddZXAdVDU2pRyFVcajK
         Nv8HmDWf5y4beVDxwkZ5dKrW8GCDjYuOEo0JMNr0w5kASqyLRNuyDN52yjkrGmVfx3qG
         2ozzz3vl/4M2WvFCfaZZ+ouD2lRjfRElaG7z2PNkBaKvxAZv7cOT8V8iQIjVDg32/B1V
         n4Q0AZzFu1nu7LTNnWWJZgjEY895gQP92h6/QiJRf3fUjc9XsmedcHCmNwqFbe1cYgRs
         T3vMYRmux5TdFnn0ERL2hbO1lUwv8pK90PxwJzyq7AuFkeI95JT1cQz5EVwDd+fsizTN
         V6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129683; x=1792734483;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tBEZoG+6kSU8/fnTWQ6RC1ACPH6+2wmeT414nXwxess=;
        b=CWA5WLEKYa0kgbt/qnYE2cAIv0hr+/7D7Z87r7DS98IPDV24docQoSR/v1zqUYbnRV
         8gmiTq0LOWhEM9vdSu+Xl0aK3u2GZAnWgqPgFm4NvA8pQBaVU86FIyWLfH1Vw6O9Nli7
         rCo/EsJgAUuFqhqoNh+i0waFS//vcFinCh3vljBZWBjWK427GSYeIfnr2nhKPnb+vFNH
         CV1wPpXJPLCUIh5+1x0M8sHKwRb1KV2jOq1wnUNiocmFuzSpRleE9sfiFvxuL2jVC6gb
         4V6lxKap4YJRHiNTRxKO6FNKh27mHXThEQdiIiHYGQzT49vmnvpAU1K65kUoB68Pt2jV
         v6rA==
X-Gm-Message-State: AFq9FYKJ24CHcbyGA9x7FU8MDF4SmbdrWdcJvIgEMDaF+1VI4j/VItjP
	oxdgHXr/ApTy9ywnRnPVwc6tMB5PJSRmrNMHEQLYiqqNPVzj1PXz8S46syAJng==
X-Gm-Gg: AYBFou1u6l1e9vTGtmJH5hcsK1OnLt7+ohji9B76zONqYzRBCHr4Oa1cpo5qrV1oRrj
	cJFIy49CkfeLdSrrHae3mfR/aOOUe6orpxz2kivHyXx2cYhFqUCEGM0Fdnukdzw5pEZCsVtwDDo
	U/ALmZULH3DJRYJ0bRXFq+/iLYALvyhEE8F1xtn6PssEST3kJKukkSqImfU/A1yhx4lroGkKTt5
	yA0O74xrnPzixzsz2o5FRQyo9sFJUK3mbv0sL4Zn3VclXlqeJO0bY3GaCCB77fSkd3EHS4lss3G
	MTPezmXOv5ems+H9vea7g5OwAWJSqJx+D2Ct1jLZrVrqATuCKw6C9N2druYKgkE3W7LkgozwqkQ
	8+MlPJMolLAGC7pvMHjkxBdE/i/hPh1YhI9BSDE43qiMeMAKl4UPXUrLPPAWwAJuIaBgiM7B1T1
	jvfNH1EUGbOi1XmX+RrIdhjmQRTCi9VokfeuLuk6QatJi1WFlGRWYU0dypGe2fEX6pjBJHRLtgS
	eQt/mynX1moM/E=
X-Received: by 2002:a05:6871:e9:b0:48f:fd06:76c7 with SMTP id 586e51a60fabf-4a2a8809e8emr18082551fac.9.1792129683123;
        Thu, 15 Oct 2026 22:48:03 -0700 (PDT)
Received: from [172.17.0.2] ([13.89.124.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73adff016sm986954fac.0.2026.10.15.22.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 22:48:02 -0700 (PDT)
Message-ID: <6ad1ba92.36cccf01.34499c.bb0b@mx.google.com>
Date: Thu, 15 Oct 2026 22:48:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9114953380818220804=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: Bluetooth: add hardware rfkill handling
In-Reply-To: <20261016025921.1719986-2-aluvala.sai.teja@intel.com>
References: <20261016025921.1719986-2-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9114953380818220804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186897/

---Test result---

Test Summary:
CheckPatch                    PASS      1.99 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.55 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      25.91 seconds
CheckAllWarning               PASS      29.72 seconds
CheckSparse                   PASS      31.55 seconds
BuildKernel32                 PASS      25.91 seconds
CheckKernelLLVM               PASS      27.12 seconds
TestRunnerSetup               PASS      604.69 seconds
TestRunner_l2cap-tester       PASS      13.85 seconds
TestRunner_iso-tester         PASS      10.04 seconds
TestRunner_bnep-tester        PASS      2.87 seconds
TestRunner_mgmt-tester        PASS      84.81 seconds
TestRunner_rfcomm-tester      PASS      4.20 seconds
TestRunner_sco-tester         PASS      5.23 seconds
TestRunner_ioctl-tester       PASS      4.35 seconds
TestRunner_mesh-tester        PASS      7.53 seconds
TestRunner_smp-tester         PASS      4.10 seconds
TestRunner_userchan-tester    PASS      2.91 seconds
TestRunner_6lowpan-tester     PASS      4.07 seconds
IncrementalBuild              PASS      25.28 seconds



https://github.com/bluez/bluetooth-next/pull/956

---
Regards,
Linux Bluetooth


--===============9114953380818220804==--
