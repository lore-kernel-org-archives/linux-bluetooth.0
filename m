Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275F446055
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792379; cv=none; b=B+Gm4OZ2n2cWcaJsUABvKkYQVoD5SDBm1Y1yFbV6beEmBI2UQOT5uDf73KPLtJRBQULl7azu43YZnaXgsY8pxZY/FIF4OTXkImyXvgWn4DSLyiQmDshAAb3PMz7p7OLjuESrJTGepi6xncBE6qONVLDSmC2DNRrCT5eKTGJhLvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792379; c=relaxed/simple;
	bh=3xU+vcLeANBVR8L21KexUkcwK6JBTmmG+bPbvlm7VHU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fvlxVil46pwGbMY8q8o44XnRkBnG59KLBmoMy0dAHCqNo+3+Yxu86cDSWiNoKjYtFuIU6KDgixFbz0hw5VRjGKcuo6tXty5SUeN741GncNH5X6F90/CFI7UeTxCOWtxa/qKzngmZsHh4H8nH9d4+4NoX8MrWzgsfvAaiQsUXiXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqY0k4fI; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqY0k4fI"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33c2520ad38so3627020eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 01:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791792377; x=1792397177; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rMTV3jDFl7L5TBKzECYWupJUVi7SwqlcDG3WSX2ghTY=;
        b=nqY0k4fISRhUa9ltRMeuv9Xr11xodm8p9cODLHFS5x3aQQqQKfFzLKKwzDOguRKPA5
         +K+ihj42EFHvRvWB3236leinuwVS01RLbzjWOHmJPe7+qTQZe+TMogYyUrY7mzKIf2Qe
         svXSHA4MN6eo2EJ+gb6CSxJfkii/GQzUC8b04utTWtwTzF6zYPOt0bZI/V13GZCOWm6d
         4vH4b+K26GAWfANhDmytNBm/rGb4dvz9MY82rvVc1QSiCEjpCH5C9dL6mNyIIzriOy5+
         ZBXVn6zRpyhdJhDqvWbIFXN1qPpoYoXNTSNX8+xBn3FUZAnCFAAjur3kXlw2J/VWEp4L
         ATcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791792377; x=1792397177;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rMTV3jDFl7L5TBKzECYWupJUVi7SwqlcDG3WSX2ghTY=;
        b=FLKpk65m/0HmNucdyXrDkOow2WTraHDi5EcueuFHKYMEAO6ODBXRAMN7j5envhIxRX
         lttiyeJ7exkrthPwVZRdhUKT3KtcAQdTAhneZMgLHuJGF8PzYArTr7dAe3IygDqPNRlG
         3L1fpczB7u4pvTnI+GYuKY8Z9uuep42JuYWPlAbbB+vxGKgthhrIHf1TR8tDGBhRXNTD
         ZphU/Cl03MnLWFAvBArNv88WB/4QSRbbjlcFzomZea8ij5X578PZWYaoj5gdhaaVs8L3
         e6639moZobqB0uO4boM90PYkzOPy0dPfWzv2exFeR8pGYNSgVjxoGDZRE12HpERNM3jS
         x4Sg==
X-Gm-Message-State: AFq9FYIDT1ynOKXfNXHzhBmIJfZiS4z6TOp6vM+Nr22cDSp+C5GNTWSd
	YSw//MFTm1Kg57C5PLpnHaKMYo89lNbo6C2W+O4SVauTvZ5ojMGAlvZRzMZemg==
X-Gm-Gg: AYBFou2phb0lXFTCk5QUsq0OcE828oAm0ulXCFb+1IjJePx89yfv8asE3RgpBG4AeaS
	rRkhUj1yUFWfPYD6djHqbYhL92aAy4Het2Yscmrw7pwsaN5nVepo5SQjWPCTuPfNKAHPK048cfv
	MAz4s6Ka3EXk9bOV2QZ/rQcHydfyIP8Xm8++3q0Sz5mT3PJIb0sk3P04p00pG0RxRno8m8WW+gt
	uOyA2FWDyQiie8WfgEnKwm6EAxoAf30bV1X51imr8/SfQrmwrNZvS+weM4V5+ZBQaTHdy3xotQ1
	TGeU2hcyJoXD0TbwwkGVwRai7NJJvt9dcqSNNnduGYhMo0Oqv+4m4siQ3H3oITLoCEh2BmdBOco
	TjH+oo3ORX1WGs3Nxsa1DvJ3sLxvKXsUmpAAleGo4Rp6XBTQhS94TjMHJKu2aX2rNmFHHYK7/eX
	ItgeeRNFVEB1kVT9xeRJYDWkIvTtY3LLtcMW4R1xFKw1N2R5aMcThu9+6doKQWMwuUum0L2qUni
	VyJr8wqKPLrmA4=
X-Received: by 2002:a05:7301:1a3:b0:35b:7dcd:dd57 with SMTP id 5a478bee46e88-35b7ddd267emr516947eec.10.1791792376584;
        Mon, 12 Oct 2026 01:06:16 -0700 (PDT)
Received: from [172.17.0.2] ([134.33.77.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3593b8b2ec7sm16302759eec.4.2026.10.12.01.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 01:06:16 -0700 (PDT)
Message-ID: <6acc94f8.695ff321.b488f.8174@mx.google.com>
Date: Mon, 12 Oct 2026 01:06:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8000064145515607980=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: Create debugfs directory before running selftests
In-Reply-To: <pm-bluetooth-objects-candidate-0188-v7-e3c91e5159902df34c8c@gmail.com>
References: <pm-bluetooth-objects-candidate-0188-v7-e3c91e5159902df34c8c@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8000064145515607980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1183544/

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      22.28 seconds
CheckAllWarning               PASS      27.18 seconds
CheckSparse                   PASS      28.37 seconds
BuildKernel32                 PASS      23.31 seconds
CheckKernelLLVM               PASS      26.80 seconds
TestRunnerSetup               PASS      575.91 seconds
TestRunner_l2cap-tester       PASS      13.45 seconds
TestRunner_iso-tester         PASS      9.35 seconds
TestRunner_bnep-tester        PASS      2.77 seconds
TestRunner_mgmt-tester        PASS      56.85 seconds
TestRunner_rfcomm-tester      PASS      4.05 seconds
TestRunner_sco-tester         PASS      5.04 seconds
TestRunner_ioctl-tester       PASS      4.19 seconds
TestRunner_mesh-tester        FAIL      4.08 seconds
TestRunner_smp-tester         PASS      3.97 seconds
TestRunner_userchan-tester    PASS      2.85 seconds
TestRunner_6lowpan-tester     PASS      3.97 seconds
IncrementalBuild              PASS      22.32 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.022 seconds


https://github.com/bluez/bluetooth-next/pull/899

---
Regards,
Linux Bluetooth


--===============8000064145515607980==--
