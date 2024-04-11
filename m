Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF9558ABF
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850964; cv=none; b=MPeSNw6srls3/759sJasIemAM1ePEiXPq12UxvL4Ylmd+vm0Q3xZQsiTOtjKMghpTUETXIf/MxBfLFYuWOjtmXkTe7G2RMb58reVsc5tmN2OANO+ahTJ1u4l/Vr1Y5FgtSARSaHa+qmEx26fWCCjCypbnmLaN9L0eAWt3L4xwnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850964; c=relaxed/simple;
	bh=S9HcwtaqV3hXdxAZARmPsRLHZI/+ZBt24nuoouSHhJQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dUfS73tXP8xjx5pSheNndoagA3/MaFM6ELzC4OdwR9W+G+xKaFhAILCO6pPhGmwMOdCSR4mPPPKvcmwP1TDzR7U7dYlm37xpk38loDzta6FyssamEB3t25BzWFjuXL20QgynKL0IHOZ+jWq0p4Kn7/iyvytIGyXE3KtxHKaOVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCu01guF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCu01guF"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so39216b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712850962; x=1713455762; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BTek1SIqMGWzUDA3KpAQ2L2g3g6VsdLlPr+NlMqrLOE=;
        b=jCu01guF//kWVLNEniMGGK7CF/Bsr2qRWJLG5Rlnh5AwCvZDmAgbSNibqdokBajsrR
         AXdtBK1ED9HgL4VyxE3zlk5Eul55BzBWUxWEQ+/N6zGSfj4j9q62v8VrhvtDpCm/2DWP
         hDPkDjYBhg+PZ/aOpzDFe535cf2r+2W8TjO+5wf1tFV2ARk8MHWrL4tO6MQAcfbssEpa
         CvDwB+SsyXtV6k1pRDuEXbKVrmIz5WlZ7Ops2GTBwajRaR5AK5qEcWpsn3lVjjMSam1p
         cFB/y0LMdToDReXV/vdQBNmIWilnhCfAP5oJk5iMAtQQ4AvziIPO+wotaJv6X8r7BMZV
         GtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850962; x=1713455762;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTek1SIqMGWzUDA3KpAQ2L2g3g6VsdLlPr+NlMqrLOE=;
        b=GGbb75EM5L7Gc6NEnxsqG+GCJSnW2D+BJXmZXdHF5ATOn+LPP7f618dwROQd3R28Bp
         X2UjO10CucgUJJA5vtek+ug2QhebSs+9q3/J2uwRB2142UcOZZYlxmuGHCajThv+3IWZ
         bmw9JsdK56ShATEx7vpnft5JY20+jZp0GmYvbGCZjW1Nr+nBT5EvS1L14Gx5XfOEsavj
         bdvf5rdQv5NNaL4TCgNrFlejoj4Bhes3q05QNfQ4ch1kV/8//OnUC0BWjNhxhXSBW+kJ
         OdldE2VefaEunGZxqS0yANEIJZ3GcBQQjNWn1TjE97ByBgk022P/Z6RkOYiAPvFknn/9
         XwmQ==
X-Gm-Message-State: AOJu0YxNSbdYSWP+CBCtNa1wy0M+6aFnAfvcw1Jt/37rtRkeZcXojPNL
	28qxAGSdIZP9a4PGjTb9RNA9xxHFhMANL9dlhPn8SMoL/m/2wonmjct9Uw==
X-Google-Smtp-Source: AGHT+IGp4HOr+JiUJ06mfRSx6fr+pYTbSHXta4uOdj2h5egdGEjJCxyD4sIOAKaiAM8mL/ekZrr+lA==
X-Received: by 2002:a05:6a20:5609:b0:1a5:bc18:97d8 with SMTP id ir9-20020a056a20560900b001a5bc1897d8mr207432pzc.3.1712850962482;
        Thu, 11 Apr 2024 08:56:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.29.133])
        by smtp.gmail.com with ESMTPSA id y25-20020aa78559000000b006e6c0f8ce1bsm1333368pfn.47.2024.04.11.08.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:56:02 -0700 (PDT)
Message-ID: <66180812.a70a0220.af6be.3d08@mx.google.com>
Date: Thu, 11 Apr 2024 08:56:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1176526389130553922=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kovalev@altlinux.org
Subject: RE: [net] Bluetooth: hci_event: fix possible multiple drops by marked conn->state after hci_disconnect()
In-Reply-To: <20240411151929.403263-1-kovalev@altlinux.org>
References: <20240411151929.403263-1-kovalev@altlinux.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1176526389130553922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843667

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       FAIL      0.48 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      29.79 seconds
CheckAllWarning               PASS      32.96 seconds
CheckSparse                   WARNING   38.28 seconds
CheckSmatch                   FAIL      36.34 seconds
BuildKernel32                 PASS      28.93 seconds
TestRunnerSetup               PASS      521.35 seconds
TestRunner_l2cap-tester       PASS      18.31 seconds
TestRunner_iso-tester         FAIL      31.19 seconds
TestRunner_bnep-tester        PASS      4.63 seconds
TestRunner_mgmt-tester        PASS      109.11 seconds
TestRunner_rfcomm-tester      PASS      7.20 seconds
TestRunner_sco-tester         PASS      14.96 seconds
TestRunner_ioctl-tester       PASS      7.62 seconds
TestRunner_mesh-tester        FAIL      6.01 seconds
TestRunner_smp-tester         PASS      6.80 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      27.76 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[net] Bluetooth: hci_event: fix possible multiple drops by marked conn->state after hci_disconnect()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (100>80): "[net] Bluetooth: hci_event: fix possible multiple drops by marked conn->state after hci_disconnect()"
13: B3 Line contains hard tab characters (\t): "	// conn->state == BT_CONNECTED"
14: B3 Line contains hard tab characters (\t): "	hci_disconnect(){"
15: B3 Line contains hard tab characters (\t): "		hci_abort_conn();"
16: B3 Line contains hard tab characters (\t): "	}"
17: B3 Line contains hard tab characters (\t): "	hci_conn_drop();"
18: B3 Line contains hard tab characters (\t): "	// conn->state == BT_CONNECTED"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.236 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.091 seconds


---
Regards,
Linux Bluetooth


--===============1176526389130553922==--
