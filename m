Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963143ED3D4
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719368; cv=none; b=rEMUwXeZ14C1xPpv+1szVlI/8qA2HHbMLH35CHvgcxfJDyL9v6/e+Ml1DcfgaVi6eRs7fS5WEYKdtBaYX+dSEQLD4/VNhNa/JGxmjukXINakJmZ1u/OFLiyRpWtm2l7j09WCMmRkGwY+jBcuQq9bAnF5ggahQvrYWFbd4TIVkJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719368; c=relaxed/simple;
	bh=0AUyN+KWRUpE2DtpGYq4MU4b4pyOj9JiON32bHeearI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H9Gc15PSEDmn0MB2fFvTRyjIQnorOjZb86P1dWsdX2e24+MIUc6XsiFGRD5HaStjj3dJVeqbcRQJOYAASh99kGbvB92l5fokJ6Q1tpfej/GrFXUFaxBBWeSyKuqU3UbtLa4nruwjuZDz/L2RIOV+Vy9kwI4UDXk386VAvIn0CvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMJkua0x; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMJkua0x"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-91080895355so1109677085a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779719365; x=1780324165; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f2KV1xFeiXmGBsXRnEL5nQSbD2KWbQ7NxWLqYY/xhEQ=;
        b=XMJkua0xvZ6EtPR2fOQTho9KgEEeAyjFTwdahxN3Ymx+WXNOYW+XF5RPTiGJZAd8/u
         8c52NAMN0zlZfFDgD1SdA/fYVuMu3uq9jIynqeUc3SgX7Ie6ucB53flCo99e00qiAQfQ
         tC17WkGsYKSm3baQrfuPQls44r9QWb3z5LiVqVLcj+90w5izQhc8pNRfphwtzm2QDxpj
         o4nF0hraUOzCenfXEyEZFiEbYTAyh1zJJ3HMXUAYBlle1b54jZhbvznadRGapODpD8qx
         CUQOt3KSjLjJbL1Oe7nZsL9C49FcnnPDk5OraXM04nTvKmp0ICMduQ5l3f8j/jiRbXaF
         DLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779719365; x=1780324165;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2KV1xFeiXmGBsXRnEL5nQSbD2KWbQ7NxWLqYY/xhEQ=;
        b=IBUNF8xj4n4OWqLrstqec+v7UxIrdQ4vVww7jACFfxkrHtFfMPkg7AFggR399pqod6
         i5yAY9ohu+dc8cA5lay70NRmUW6r0Jkd2QbYxBxqANDAzNWsqnIJwRCKa2alaWMyvE54
         Go1h0LHc/IMvRqKdDgqz5gQOBmI3BiDDGCRoEf9J6J0uhZRKsfXp/oV+c+MNglwnvmrW
         zyNpACjBYwUlGxeWHZRzvTKB1XvGmVjma2miuTjq2xENImI5c1rwzlkli0G0dasB8UiQ
         TPBqoJwX5bqOXwg+yOaoR/S6971nxDAgXZ73S9eoxUSjdqoezc7O7iOivkH/AiLIUm3c
         TgKg==
X-Gm-Message-State: AOJu0YzQGlbgn6UjWSkQxSXovBbq0+BBGfCk2PoMNQTLUsasDLfEBoFs
	TnY7Plnw7SGYGob9A6sQK+XgWDGkLXp8b3jK2DVOhrpZHihSqZj1fMB24lLIvg==
X-Gm-Gg: Acq92OEStqtfXidyRNuhGRP3Lsx5Y6DG3ivHSavdz/N5gFU/W9m3K6Wgs4ZEHgWCndF
	ZWoAFhtw8EO2BaManwyc+++NaAdl+XyZr8Ykvb+aXOIoYazlmAHOUSias3jEf5ccGo+CyeN6QkP
	0hyaCop/tvEy9UpBMX9RePD2vCBQvSLyyogXnxO5sVk/wKuV4ndDGLDcjeBxs58uo+vCusVc/O3
	2Jr7z8iHwg/MLMwL3hxbYxgo+LDPHFmkrpYXy1KPkeBlcQhD7vj9m7PjuiXOVMsre+xRLzrxn6+
	EnvndCE6Um6Yxo9BBHcoi9yeY5r3QxjUS5gSlQC0Zzp7uU4ZtTncIXuwDD/liJekp7ppSD1e7OP
	oegwERomdG6DYvnEjIr1koEUGgaaDNhYqUqZzceeOYwUTgX4cYXTOIgEZQIwfWpjkKF+d9theCM
	uLMFPP5YFUb+JMPQt8qJvuSZyK2OcTvFCeoSooHO5y
X-Received: by 2002:a05:620a:6087:b0:914:db7d:f693 with SMTP id af79cd13be357-914db7dfed6mr710400385a.19.1779719365337;
        Mon, 25 May 2026 07:29:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9f1991sm1051762885a.33.2026.05.25.07.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:29:24 -0700 (PDT)
Message-ID: <6a145cc4.19aa4c8d.10bfa6.b433@mx.google.com>
Date: Mon, 25 May 2026 07:29:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1790227691419162913=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, k@chaosmail.tech
Subject: RE: [v3] Bluetooth: Add Broadcom channel priority commands
In-Reply-To: <20260525-brcm-prio-v3-1-6259e10233f8@chaosmail.tech>
References: <20260525-brcm-prio-v3-1-6259e10233f8@chaosmail.tech>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1790227691419162913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100446

---Test result---

Test Summary:
CheckPatch                    FAIL      2.47 seconds
VerifyFixes                   PASS      0.58 seconds
VerifySignedoff               PASS      0.74 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.04 seconds
CheckAllWarning               PASS      28.05 seconds
CheckSparse                   PASS      26.50 seconds
BuildKernel32                 PASS      24.72 seconds
TestRunnerSetup               PASS      527.44 seconds
TestRunner_l2cap-tester       PASS      58.70 seconds
TestRunner_iso-tester         PASS      77.29 seconds
TestRunner_bnep-tester        PASS      19.22 seconds
TestRunner_mgmt-tester        FAIL      211.10 seconds
TestRunner_rfcomm-tester      PASS      25.41 seconds
TestRunner_sco-tester         PASS      32.43 seconds
TestRunner_ioctl-tester       PASS      25.88 seconds
TestRunner_mesh-tester        FAIL      26.00 seconds
TestRunner_smp-tester         PASS      23.37 seconds
TestRunner_userchan-tester    PASS      20.14 seconds
TestRunner_6lowpan-tester     PASS      22.74 seconds
IncrementalBuild              PASS      24.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: Add Broadcom channel priority commands
WARNING: please write a help paragraph that fully describes the config symbol with at least 4 lines
#200: FILE: net/bluetooth/Kconfig:110:
+config BT_BRCMEXT
+	bool "Enable Broadcom extensions"
+	depends on BT
+	help
+	  This option enables support for the Broadcom defined HCI
+	  vendor extensions.
+

total: 0 errors, 1 warnings, 0 checks, 141 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14593220.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: Add Broadcom channel priority commands

47: B2 Line has trailing whitespace: "--  "
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.241 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.378 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/237

---
Regards,
Linux Bluetooth


--===============1790227691419162913==--
