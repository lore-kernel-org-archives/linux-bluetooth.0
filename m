Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9AE37CD2A
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340401; cv=none; b=E3p/8DWqfRnAD2503Sjcvqa3JrawFYmPGCi0iblavzliInt1nf8ztL/YF1sFuibkeJs1dbQ5Ii2eON4yFLgFZ0jk+dmqWN7YumsLA4KEEjRTYMqRGc2cC9nRQ+zi4XjNnXlFVgp/7c+j2qo/OoaoPIuoKZ9HCh00xe4hdGAQOkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340401; c=relaxed/simple;
	bh=8EclzxWpJFmzO4aiWUbnyzrhucC5ht7auYD2FZIYcNI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BGaYsa+JPYauyZJQU9nH0JshwH+CpKgSaWmgiuWAkEt7cN21PkfYu9U7DPH0Qamm3G9+XrjQOFII3les6lqjA84mMvpoUYsca1F5kW/zJP4j9abGpzgITlh60TlPnoySI2ZZW1Bc8bmBZxD6vkt9fmpe4/3C2cfrIPCgAGOhYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxNgC4MD; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxNgC4MD"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-91550fe1619so212593485a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 11:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780340397; x=1780945197; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AFexc9gpFw1aus8YPKLxer3c0YuPoHHi9MP61TwHHLo=;
        b=cxNgC4MD+54enhxXz1LMIoXWWmKCLT82CJHsfUkeWmgYRoDAdgUwq7YZ45zUN+paTS
         fG8hREY1DZ7yjA0ULN8wiU55HSji2MMTC5amUKBGt32adD/K+nCZhYSape0f0btocq0a
         UrieSwkOwo1LsryvlCPacRWQb/g+MPvA8Ai/b18w5QEvFxpUCl/EikgjIBenbTGdNktd
         F6js5NndqAodBw/hNE8AOs2NEHbQRbPs8gPaL4SD46nfeNs6po6MwB1uf4TVQVHSqKgP
         OilYw1Lpnbgjsk5bGFdFA8FaBl3j4jZGxJrRp9C8+PZwPArS7NkMBuYI4gS2iMnuQkdB
         jCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340397; x=1780945197;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFexc9gpFw1aus8YPKLxer3c0YuPoHHi9MP61TwHHLo=;
        b=lMZply2pHm0vwInOrsHBY8Y6w2AN4mTHtewlf1RLZ37XKmIy483mqimyi2cQ7B1xMS
         OvVlGgkypnADlhXhK9UldP2ohioXWGi0Wx8UsHOG6fZ67/2fP3nf7TLQqXpA5aKtOReo
         720ZrR6Kc1kHzHoDMsmURzPiaXOeYB4GKA6YrlIUL3vao80XdcNhszMK9Oz5irRKE4Gg
         cnMvSAJzZ5ymCwmBifxhcyY5+HmTCB3rWpV+kaPmqE5o4gX/rFk7OSZCvNhamQpq28qK
         LC+DAlv3/eH558dybz4DfvTmDw6qc3E5LBihAxMG39A7SfX0gSCckyabcXHCeooqR2Bb
         EUHA==
X-Gm-Message-State: AOJu0YwvfvvR4uPhJw84YopIJIUSDAtDyqzTX01szesgAURJz31Uhd32
	3vdv/O/ov33FFu7wmFkNf/IynUPliuYqMYx38OAfmNavjQwamSd1LVJmxsWg1A==
X-Gm-Gg: Acq92OEEqzSYJqchMa4jn2295Xgbh3/1xootFoctGQQwTxUDOpRgRXMWQgMgG6l877X
	chj0iCgGMNnfvp6xAEdX/JkkO2jLOCJvfpKZ4Va/7VnTVaUXrwtSPNO1vYSXdgpHnVOE82PC2PQ
	KceaxNCvjt/GRYsknmaHOxLP9wqysNL4RRGgQG4thOEryyvAFgkP1XrxzuCiYDid8phAuMnFUth
	tz8jkmFA5CqgQtt5/+wsbED3c+vYJjlMSRZG6BP98tpXbVgsJ7aXirYq84Eluot9VNfLXXOfn7g
	+Pd0Qahq0SuJt1EjXWuxapQyRVVXwLSDihpL02LscL+KLNiigKzNFdZ0xwzYb6ep/2xWJtro8Xg
	gUiKThaot24ORnjLB+TldzhelqxZ58aXH2uoZfD2cqd+PHd5NPq7neGxxlZhMc5GE269JiP5apR
	TtrkRNyYA7Lt1stzxSiwReZcHxTLDHjHPJ6bv+V+Rf4Q==
X-Received: by 2002:a05:620a:a0d6:20b0:915:673a:62eb with SMTP id af79cd13be357-915673a64b6mr399710285a.2.1780340397369;
        Mon, 01 Jun 2026 11:59:57 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.198.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532628da5sm1127899585a.36.2026.06.01.11.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:59:57 -0700 (PDT)
Message-ID: <6a1dd6ad.1aaa4c8d.158c89.129f@mx.google.com>
Date: Mon, 01 Jun 2026 11:59:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1266726850140577581=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bestswngs@gmail.com
Subject: RE: Bluetooth: eir: Fix stack OOB write in eir_create_adv_data()
In-Reply-To: <20260601162203.1253918-2-xmei5@asu.edu>
References: <20260601162203.1253918-2-xmei5@asu.edu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1266726850140577581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104138

---Test result---

Test Summary:
CheckPatch                    FAIL      0.78 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      0.40 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.38 seconds
CheckAllWarning               PASS      31.35 seconds
CheckSparse                   PASS      30.08 seconds
BuildKernel32                 PASS      27.75 seconds
TestRunnerSetup               PASS      606.70 seconds
TestRunner_l2cap-tester       PASS      64.46 seconds
TestRunner_iso-tester         PASS      93.80 seconds
TestRunner_bnep-tester        PASS      19.81 seconds
TestRunner_mgmt-tester        FAIL      220.39 seconds
TestRunner_rfcomm-tester      PASS      26.70 seconds
TestRunner_sco-tester         PASS      33.44 seconds
TestRunner_ioctl-tester       PASS      27.01 seconds
TestRunner_mesh-tester        FAIL      26.98 seconds
TestRunner_smp-tester         PASS      23.79 seconds
TestRunner_userchan-tester    PASS      20.52 seconds
TestRunner_6lowpan-tester     PASS      23.05 seconds
IncrementalBuild              PASS      32.28 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: eir: Fix stack OOB write in eir_create_adv_data()
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#146: 
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14605450.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: eir: Fix stack OOB write in eir_create_adv_data()

11: B3 Line contains hard tab characters (\t): "	if (adv) {"
12: B3 Line contains hard tab characters (\t): "		memcpy(ptr, adv->adv_data, adv->adv_data_len);"
25: B1 Line exceeds max length (82>80): "  BUG: KASAN: stack-out-of-bounds in eir_create_adv_data (net/bluetooth/eir.c:302)"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.257 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.782 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds


https://github.com/bluez/bluetooth-next/pull/269

---
Regards,
Linux Bluetooth


--===============1266726850140577581==--
