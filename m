Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD9316C86D
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718181457; cv=none; b=klH+lNYAPtTpUUR2i9U6q1r/Bsak4wEBQLB+/tTal+R+kgUiqO2dUsN6pDF/sbcXXNBnNbQiert2Zycy+2nyqMKfp1VR50LWWfatN5edSUQ561QMoxraLf5pT8PPixkuYh4sh74jLLn4smIlHT+4xWltMwXtp7x105X9sX+vDxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718181457; c=relaxed/simple;
	bh=Duu20BuK80gxE7GAciClkMdtwYlxlveATNiJUK/bxFc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aB7D6ZQxYclHo8uwGgUltuWGPw1XlCG4Q//LZ9g8OGY2Jr8KtPCnv7/h0yYJR9JmAjPfn8ENrqsEvRyoPzN6JJTWcQ711TMRwYM+Dl51Cai/q1vuoybkMO+KXB5fGWnc2L0+7Wp3uL64vaH4fHhIlEzrPUyktzUwocAG5M4WL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coMSSOgH; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coMSSOgH"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfb0ccbd401so3879042276.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718181454; x=1718786254; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hTyvqfRbP38b8SmoH2co+pLsFyXVsDGTwh/nI91pO/o=;
        b=coMSSOgHpPiKXjFpT+tsXOX9iZs9p0zJAjLNVOGkfejJ3toM3+EK6gwr1PBZ68Lk3g
         YJzdquBhzbZxCSue9YDKWVtsr2HwmCdCQsdO/TwlA4nqRACkXu8gdIq8p98woYeVY4T+
         YLX2beisItZpwzagHtuo5c+MI6OWy+0OGb0hsgKoMTiV9sBGmNrASXrg891m1ZPNLXer
         9Tin/aWbHVObNhJEjn4HX61xwyJbsmZCV+h02ouZ7khLyMjz5KFkouUAiVRm0fjuYbN6
         Bqnl44FP4GbnjwdVJAOxK3kLKuq4lc4QpZFUDP0zZVfqH6mobTZv2VbHxNDnh/DltAwW
         b1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718181454; x=1718786254;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTyvqfRbP38b8SmoH2co+pLsFyXVsDGTwh/nI91pO/o=;
        b=LX2nhCLuliyHHdlp43uaiyZtKznMk0uFTB+tj7plZdQ3bmqx3NiOnKCbIjFprmEBdW
         RGBePRiBnWkjfeuira2DxdYHwjx3iewD2wstNKpSHhKP462Yvdp9ROaCTXL66pmPDTvN
         U07VduwPP2Padcg+Nuxib5qJG6hJHz/zaS5whiFmxm9IzuOumHV2HFoNP13b/KKlmCf2
         6ZFc3hLIWSvBKJFG5OOesRU2Sz4pZhdkjCxmBZt39YnOrdGQjk05GroUUEsr48j5TUiF
         nur2cPok12Nmusllyacn8BOpdh7rcwYkudc0OKvH7mUeRngSB4gR5k4KDPMmJ9qe07+J
         w9TQ==
X-Gm-Message-State: AOJu0YzNH0+JthCjHV+hIFNRHSYMNlNsYPSl/LdR+Gi0QBoT2NcwXQ/F
	uDAe10vGFLwNWCQ47etzTSI6bxh8e4+Q8GAB4NnhWEY2Q01lguGE9si/xg==
X-Google-Smtp-Source: AGHT+IGWzyP4FFgnNgP1zyfzBRxyqOtNsYBuikH4FcucszdbePW1mEUznU4DJZJWdhdhlX1nUgHkeA==
X-Received: by 2002:a25:8385:0:b0:dfe:45f4:7c45 with SMTP id 3f1490d57ef6-dfe66c5dc5fmr994945276.21.1718181454102;
        Wed, 12 Jun 2024 01:37:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.98.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b07a8f5136sm31649936d6.83.2024.06.12.01.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:37:33 -0700 (PDT)
Message-ID: <66695e4d.050a0220.eaa93.cf86@mx.google.com>
Date: Wed, 12 Jun 2024 01:37:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6071248991043168036=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: Bluetooth: qca: use the power sequencing subsystem in hci_qca
In-Reply-To: <20240612080150.18375-2-brgl@bgdev.pl>
References: <20240612080150.18375-2-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6071248991043168036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=861073

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       FAIL      0.87 seconds
SubjectPrefix                 FAIL      0.90 seconds
BuildKernel                   FAIL      24.38 seconds
CheckAllWarning               FAIL      26.72 seconds
CheckSparse                   FAIL      30.68 seconds
CheckSmatch                   FAIL      81.52 seconds
BuildKernel32                 FAIL      23.75 seconds
TestRunnerSetup               PASS      534.54 seconds
TestRunner_l2cap-tester       PASS      21.96 seconds
TestRunner_iso-tester         FAIL      32.86 seconds
TestRunner_bnep-tester        PASS      5.48 seconds
TestRunner_mgmt-tester        PASS      122.50 seconds
TestRunner_rfcomm-tester      PASS      7.45 seconds
TestRunner_sco-tester         PASS      15.05 seconds
TestRunner_ioctl-tester       PASS      8.78 seconds
TestRunner_mesh-tester        PASS      5.96 seconds
TestRunner_smp-tester         PASS      7.07 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              FAIL      32.58 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v9,2/2] Bluetooth: qca: use the power sequencer for QCA6390

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B1 Line exceeds max length (94>80): "Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QRD & SM8650-HDK"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: BuildKernel - FAIL
Desc: Build Kernel for Bluetooth
Output:

drivers/bluetooth/hci_qca.c:31:10: fatal error: linux/pwrseq/consumer.h: No such file or directory
   31 | #include <linux/pwrseq/consumer.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/hci_qca.o] Error 1
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:1934: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: CheckAllWarning - FAIL
Desc: Run linux kernel with all warning enabled
Output:

drivers/bluetooth/hci_qca.c:31:10: fatal error: linux/pwrseq/consumer.h: No such file or directory
   31 | #include <linux/pwrseq/consumer.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/hci_qca.o] Error 1
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:1934: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: CheckSparse - FAIL
Desc: Run sparse tool with linux kernel
Output:

net/bluetooth/af_bluetooth.c:223:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
drivers/bluetooth/hci_qca.c:31:10: fatal error: linux/pwrseq/consumer.h: No such file or directory
   31 | #include <linux/pwrseq/consumer.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/hci_qca.o] Error 1
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[2]: *** Waiting for unfinished jobs....
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
./include/net/bluetooth/hci.h:2596:47: warning: array of flexible structures
./include/net/bluetooth/hci.h:2682:43: warning: array of flexible structures
net/bluetooth/hci_codec.c: note: in included file:
./include/net/bluetooth/hci_core.h:149:35: warning: array of flexible structures
net/bluetooth/sco.c: note: in included file:
./include/net/bluetooth/hci_core.h:149:35: warning: array of flexible structures
make[1]: *** [/github/workspace/src/src/Makefile:1934: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

drivers/bluetooth/hci_qca.c:31:10: fatal error: linux/pwrseq/consumer.h: No such file or directory
   31 | #include <linux/pwrseq/consumer.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/hci_qca.o] Error 1
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[2]: *** Waiting for unfinished jobs....
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
./include/net/bluetooth/hci.h:2596:47: warning: array of flexible structures
./include/net/bluetooth/hci.h:2682:43: warning: array of flexible structures
net/bluetooth/hci_codec.c: note: in included file:
./include/net/bluetooth/hci_core.h:149:35: warning: array of flexible structures
net/bluetooth/sco.c: note: in included file:
./include/net/bluetooth/hci_core.h:149:35: warning: array of flexible structures
make[1]: *** [/github/workspace/src/src/Makefile:1934: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: BuildKernel32 - FAIL
Desc: Build 32bit Kernel for Bluetooth
Output:

drivers/bluetooth/hci_qca.c:31:10: fatal error: linux/pwrseq/consumer.h: No such file or directory
   31 | #include <linux/pwrseq/consumer.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/hci_qca.o] Error 1
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:1934: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.180 seconds
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:
[v9,2/2] Bluetooth: qca: use the power sequencer for QCA6390

drivers/bluetooth/hci_qca.c:31:10: fatal error: linux/pwrseq/consumer.h: No such file or directory
   31 | #include <linux/pwrseq/consumer.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/hci_qca.o] Error 1
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1934: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============6071248991043168036==--
