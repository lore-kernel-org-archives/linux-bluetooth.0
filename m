Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1163DDB1F
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343486; cv=none; b=JDedLlc3NCUCerWnzOCb0qfwXxmibRA55bepVM2mA6Wmh33Ujpxyod6TVFKrfLCHGSwWYgTeJwLVvoHV7m7Nfye2uUZhJKNtGqpF3FUY0E4hR3/0UC2L1hUleYRfOhfkor9jfFj3udbLcIE2Rve7jIZLmj1bjJ35YYdEnb12IyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343486; c=relaxed/simple;
	bh=TEbpbURkBxLAAzZhgrsOXYk3/7eNBZY/GFZdYS7x7jw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MFYhj83X0D994li1SvzfH42XczhmmYKLcRFuLyFvzKNVbpet3/klsqrWlFdPPbg8iI4MRMe6pRcLiUNvxrqhDp+QlM5Ldt2MavC4yT0Ymoo49a4ew4klAB3dQrfzGmQgaBrBn5SgCHb97OOWsDoMLA4LzULGsvDqEMMPngmGJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4ZWNYxj; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4ZWNYxj"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c999f162c9aso1953883a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 06:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783343485; x=1783948285; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lgzrF+O9sse4ePpwOBgorMwiQRPOF7l8eRWpWvigiD8=;
        b=n4ZWNYxjQ5R9g5+HcuU+rFTYNVh5xuAQtHxiIc0RnoioZqdb8qV3SEhxcbkcrZJs6S
         oPnmH/dskxDOXH3eCirwzcYehExKx6g8zYWOPh44eEnJzHucZvEtYYmsxwkLFu3BARBv
         GoPKhjyPP4/90VpB/oASX2xOb1NeyZA2k6yjChjr7vd3V+CPBR5brouimT1j26ZxmSci
         Z09Bg2dTX+7MEcumgEgh2ULtBqQIZFh/q84jnNZ08PWREJqvWG2VnUOYiEBd0vwGUpuo
         Sm4Z74OUdClSC2Vs6mEv8uq1wTD8EaP2VMk/gN0GXnK7xuo5jvaHAJq66JurOm9UBKtn
         HfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783343485; x=1783948285;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgzrF+O9sse4ePpwOBgorMwiQRPOF7l8eRWpWvigiD8=;
        b=aLYOzDmp08WkWfkUofWSOFXBkXREPhu1JYmOsGRRHdKyS0qNZ/gLNAtkUZLm64LCkz
         tu0yuq36tXDdAoIwZyCnEvWIeuGDD4X7OVWVI3GaETVLqZYV+VEbuVCOzZloEQQDZFcG
         aMaWaI+qqBLJ1psAKQngV3zgprawKXACQelWv5QldqfTyLCHa2V3V3T6K1DLBOZdM8RG
         /PDfsxhb3KoC8i9GWcV5rQD/pbxdZvfUk1n24WIV+2FYgwBeBUwRJH3ygaH3LHQTTSu3
         X82XWjL+Y5oCCGFGNuIw4bZ507KnZpn7AzS9KnRsKZqPYOZyv49kF7v6n0jNl6cEz4Le
         W0rA==
X-Gm-Message-State: AOJu0YzArnqazbzZP7Oa0MHB6v5N7tkY2Zn9rpGJCnOX5jlBlYfTaZt7
	pV5A5vRsMoirA3TAiV5T75JTmg8mX77YQtTLIkLBgPiVyE+cJeZCoIn/C9Qqrg==
X-Gm-Gg: AfdE7cnZQp236I8FxhA7h0a++XnEEX6/DRHfQsU5SwNLaxH+hwzn2aIbCq5y4ZE+6JX
	TS+zW+W3361Llf836NU2rYH40hi0N8bVbm2MTF+WgQrIIUegfwbUWsgXmlTw6oTTA+iUeRowBGS
	XM3Zn6NT2bLFa5aDKuDisaDJIkJwCFiwXzZxj+ulXXYY0lRaokPBmibziUbtsbz/omRkCwYABgI
	/POyAliF1EO3tr18onc5T2C1GXngNk1DMoKhQNBQZTRFAoTvHO3l3nUXdM3cn3MxvJScetyGlzI
	Ud5zr6du9ThCyjTXJ6a0BzWGKXpQECu3317AH653w7MpMfFAPP5j8ysfYqzTMijitNK1PqjqY+3
	l2aU3a3GmaDko+xAw8sKHxkf/GXhh3ydFTwhi2xJ1+JVF31xpn3R5j1xzewHOEn1esWVsOAUC5g
	j0J0q/zJNDnNzRl+KG6jA=
X-Received: by 2002:a05:6a21:730c:b0:3b4:8ba9:4d8e with SMTP id adf61e73a8af0-3c08edde9f6mr629042637.23.1783343484655;
        Mon, 06 Jul 2026 06:11:24 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.166.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a1bsm54455158eec.3.2026.07.06.06.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:11:24 -0700 (PDT)
Message-ID: <6a4ba97c.4a342cbc.134cb.9ab1@mx.google.com>
Date: Mon, 06 Jul 2026 06:11:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4055443072441778856=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v1] Bluetooth: Increase HCI_AUTO_OFF_TIMEOUT to 10 seconds
In-Reply-To: <20260706121525.2717691-1-shuai.zhang@oss.qualcomm.com>
References: <20260706121525.2717691-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4055443072441778856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1122329

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      28.22 seconds
CheckAllWarning               PASS      31.62 seconds
CheckSparse                   PASS      29.52 seconds
BuildKernel32                 PASS      27.54 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      514.33 seconds
TestRunner_l2cap-tester       PASS      64.26 seconds
TestRunner_iso-tester         PASS      98.47 seconds
TestRunner_bnep-tester        PASS      20.43 seconds
TestRunner_mgmt-tester        FAIL      229.99 seconds
TestRunner_rfcomm-tester      PASS      28.67 seconds
TestRunner_sco-tester         PASS      34.43 seconds
TestRunner_ioctl-tester       PASS      28.20 seconds
TestRunner_mesh-tester        FAIL      27.34 seconds
TestRunner_smp-tester         PASS      24.92 seconds
TestRunner_userchan-tester    PASS      21.42 seconds
TestRunner_6lowpan-tester     PASS      25.81 seconds
IncrementalBuild              PASS      28.01 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.277 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.442 seconds
Mesh - Send cancel - 2                               Timed out    1.981 seconds


https://github.com/bluez/bluetooth-next/pull/404

---
Regards,
Linux Bluetooth


--===============4055443072441778856==--
