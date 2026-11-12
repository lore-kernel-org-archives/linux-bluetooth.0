Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459789;
	b=T0JUeJA8mUHRvgkxqvD+uglhGVAyuQvfBKF5aF5hEfj1ug9EaW/JGO49VZ2TGe6MNCEY
	 H3JLnuITbppcK1cn64WUPRbhdg0iBhd41dROMBJnliVW+/H86J/Pr6ATYElVHf3KJIKWb
	 Gsoynw/lZXmJuM4dX4MJkmTV9RKTXwVKuSb/BAXAlK3ssvXp4t/0DOm+zAgMZ146Oq+1y
	 Ex/6Kdv1Wrv08J8X0B4yinErch89aT4arLzc4rv7lhcRfjoHeDK5GW+bLJWtgK6dI53Qu
	 5nbdode24qbdQX0QEmp4xZu4AjTxI66k4mw2kRHuIQY8XcHsd5JC6BpBZ2+PepCdKOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=l1bY6YWFwPQKX0v6kIU/Xzx/56OfScTT3+4y4Qqt9g0=;
	b=ta4sgleETJnpfPo+q+jZrF5vvgqkXwxCCUo3SI3T2gZkgXOLEAEECofVgm50+1o2M10N
	 MV6NA7nThRV6QWnfbMzaFfKz7tylcbtbb1E9SINwyVA53QYdC3WAywMWeLLwCd0/yIP2a
	 ngTI5Cd8RVv9ZWwz4+hgz6KC7a0N8uXd8RSis9VFrX8JRSPR9UBBzFIrLTInKv/UTTQzM
	 1GfsJH/smJxOMdLC7COG3Next0eFMO8t+tfTqsraxrdpacrfs9pO/ceqh/x8SGZ1XCXQH
	 IZACIZ8KTD+FgPloUp00McIS/cb72yzgsFVbzxmJ/gjvKJ7ThAXNKZ0F1b78i1AAEqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zBwcmqN6;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC31606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 05:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBC31606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zBwcmqN6
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-372bdb942dbso4978099eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 21:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459788; x=1795064588; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l1bY6YWFwPQKX0v6kIU/Xzx/56OfScTT3+4y4Qqt9g0=;
        b=zBwcmqN62IathAe6Ro+zZyKA9fnVtCrqlnfTZSx+KxCsSmvSEt1sP1GpXLrykTI3L6
         zDe530qQPHIJU0iwc83jqFsYFNx20O9xAZhaIrYtRw1jcmcVzqWe9hYGzySmYnRVvI3k
         AfS/yxE/SzQIt8QC5pwoB0Hbu2xPICY8ipkhDsgYSQ+7P+u3NDLBRagsZ0HlYRc/saKh
         9p5mnB1bhcFHLV+8JXbbbOjkLmxrHQoLHVY9hugQj+Z7lm8DQ9Pht7VguinFp3okhAuR
         N5L/nYaigapXyaBunn/i55qaaPdv/HPYSMihCFOhHkv/WB5xj5QVxs4Xgdv0D3/spKuU
         DrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459788; x=1795064588;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l1bY6YWFwPQKX0v6kIU/Xzx/56OfScTT3+4y4Qqt9g0=;
        b=WJQF0M2hUjfCN2ZcXrRVVu+/mVUbp9dTZol+5DCoJPFB4yDCAtc1E7GkYies0b3U1o
         lP8Ag2AG7FMsxO11muHrRiBwGnELjpy13NUfUQrOlKvTp6T3pScxdLnANboSXGluwx24
         b7hoZaeGa+ErspXs/PHdASlHhKqK72bXxiR64BHROah/RxWXyUvHbk0uXe2vVTY96YIF
         Q++cxIOBFP2VXZU17IdWrC/KBKPDahqRjhNCIN0lI04ErazYH/tYGWI2R2J8w0r2NQMp
         g53YEEz04xiL9DYcaz4ZThXBUgBCJcGAHHZ+OhRmcW9DHAEZqDi0/XBhtel5Uu765pbr
         7jSA==
X-Gm-Message-State: APuU4Z9kd4ROlXHOC57DpEwI+yESdYpA7bSJkIIaDdn1k5L6+dp0uLwN
	shOBPU9dX2YYOx0tnYlY44akg0/LBBRlzvaHEeRKRPyYSU08TjU5tPNxZNQRmA==
X-Gm-Gg: AYBFou3LwjWX232jGten1g4DHx9yRXXySBBlHxCWK1T5NKYg0uwUyK09IqE8uvqxgAm
	+msgcVuCH0yjVj7RFCVGkGomFHhRq4AuZeQNzLK9dDFciHIqF7H4aq6+OoFgStZ1IRaMMIOExK5
	mHnABmniqCZ4/mruenwlERJJAv2zYOGJQj2D6Dwz82vspQt2so66JB3d5YrCGA5qVQd2h4tqFX9
	hU6tsrYSShDr0KZfL2mIHMAWtufkmKO+0YmnFHpBX03o+tyU0W2hCI/QizlB+I/FEn1Jn2AhF2R
	0rr8j2wfRlk0QS+NJV30/WQ6re76dUyj+FBFTOPwPYEXR9MXr2yPfu9i7PioTLt79EOJH84Fdo/
	syGslZQu/5mBfQrGkH7f621neDYOoYze7yw00npsYMk/388M1lupaW9PKOR4oWaKmstwefuk30v
	IjPkTCFZ2aRlNCp8trl1SKHtSIXHY1yYe6aD5kTIu7Nh7JGl98YD8/dvF9Ce4VCV9TzDe1clL9p
	8mPNuEER5VXHYY7AAdGwdP3NqQoiOjhaia9RCSpKnlAmVCuiqYElHEBl24B5es=
X-Received: by 2002:a05:7301:dc2:b0:36e:3ebb:7ef3 with SMTP id 5a478bee46e88-37687212b5cmr4664756eec.39.1794459787848;
        Wed, 11 Nov 2026 21:03:07 -0800 (PST)
Received: from [172.17.0.2] ([13.71.232.176])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c7c50sm41675752eec.29.2026.11.11.21.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:03:07 -0800 (PST)
Message-ID: <6af5488b.fc76328d.13695b.b41a@mx.google.com>
Date: Wed, 11 Nov 2026 21:03:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8938799513590832067=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,v9,1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
In-Reply-To: <20261112023025.187702-1-cochcoder@proton.me>
References: <20261112023025.187702-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8938799513590832067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1208989/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.33 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.54 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      29.90 seconds
CheckAllWarning               PASS      33.63 seconds
CheckSparse                   PASS      36.22 seconds
BuildKernel32                 PASS      29.67 seconds
CheckKernelLLVM               PASS      30.95 seconds
TestRunnerSetup               PASS      695.15 seconds
TestRunner_l2cap-tester       FAIL      14.38 seconds
TestRunner_smp-tester         PASS      4.37 seconds
IncrementalBuild              PASS      31.38 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,v9,1/2] Bluetooth: L2CAP: Keep credits from completing security upgrades
WARNING: Non-standard signature: Assisted-by:
#129: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#129: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 628 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14974664.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,v9,2/2] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
WARNING: Non-standard signature: Assisted-by:
#105: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#105: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14974665.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 111, Passed: 109 (98.2%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP Ext-Flowctl Server - Accept 2 Close 1          Timed out    2.009 seconds
L2CAP LE EATT Server - Reject                        Failed       0.019 seconds


https://github.com/bluez/bluetooth-next/pull/1118

---
Regards,
Linux Bluetooth


--===============8938799513590832067==--
