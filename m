Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969686;
	b=xRxMezp3Ilq11OTi4W8MdyT/vKSDN6lPJPc9FXgULYAfsG8Y0Psp2j3xQr5KaMFnIWo9
	 jH8eN/afdsXp/K1KNdoV9ovOL6jMCOHWOtjVjzTDldE1GYEoG5cyGJW9zfE5mgmD1ThFC
	 jrpeAtK9A5BhVWbIZVijerZLwjjQHTrR53HUN/3l16YQ7ARPQTSJ41KWdRVg30ng0ysOb
	 C1Pxm6m6RbgaIxIwc0erjFpU6NA1TNCLP8UwNCP2ccxe0YWrJcY/2Gf8TQQtUH8bj2xmL
	 t7R8FmRreNi/oM5c4UfmLQi01u6OM4Zv5FoQ64CQdaO1Ifa/vlmd7KzsP6lPYfVP/hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=NbmZrv3+14VuVJK73DoFsJI0biu5MR5ulOTia82r7HE=;
	b=Z2sDhALmLnKjtL3c487u7hlx8W/e+KPjAATVHEI+P5N0RbTnzBUMa3vr44CCsF5xtqx8
	 zd/pUNLPZc33w04EEPMGhQ8fDPZWpzC12PbA9dbPfQFF2Drto1Ai+bdshIVyTwKgVMEwJ
	 ea1RTWpm3mawieYHDFMHpvKMDFp0hAkzLVF1PPAFsYNrr1iwsqqkaq35koawLKy0p9xFA
	 xixXthe7HcHBS+A1dzSG8fBa6Gdmv/9D8Ho5n5G1CHMiYAcCsmVVzjdDUtzRl9qID3E3i
	 NHPZ5/igX/zUfvHuwNaY6J93MnZf8xmO3dPLPBizunW91KXdJtPPuKENrqY4+edGjGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHFRnyFk;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A784606A325
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 02:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A784606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHFRnyFk
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-55d30c054dfso5386211cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794969684; x=1795574484; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NbmZrv3+14VuVJK73DoFsJI0biu5MR5ulOTia82r7HE=;
        b=xHFRnyFkgDqA2Vp+r1647Zkvucdnl6xsI00s7JujJZ+VEnA5U05UobQVlYqOep7tcZ
         KXAFsjAW0SDQPlersfPncXERv9F72ZOPonw+sWv9XDitR4K4CHjEIWop6aCG/D310Mjv
         lbmPQtzfSldezDK7lLcq57dQeDyRasERgEXqELXQRIbBek9IIjhU9xFD7cEWqhSqI15z
         9VWifUpqa7UzlA1aABzsLl8NzfKvOO5i6wI6O9IgtSksLaHnAK9dnzRewwMZ7omsticN
         b1FhhSs4I+nTGJ8MUr26beHMJvonEdJtHTdU+6uPJjXzeP1oH4irTiaPLAX+fgRu7N4d
         E/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794969684; x=1795574484;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NbmZrv3+14VuVJK73DoFsJI0biu5MR5ulOTia82r7HE=;
        b=x6bdLWYYN0LAFaxEOprxTXwwVevzu1aZsGs7pUTA/LyYVcjXWO+yrTo52stkfzN5aX
         zt2kkalmcKIrDAuNO7vKOwQtC4UyhHX39sEHwOBumYRAm2I+/qIyjEIcYAF3Ym5uDrRZ
         sSzkIR9yFgdse2yMh+Nn0NDFB/lA8CcGpCX3rshlPbe5eMf9Cv+u5gsDqmejP2R8PtfP
         YeNqxMKd9FGgo/SYGoZAvqgwgbsE79tOjuo280bO1502ZrrNBtUfYxOGQZ47jN97LmMx
         FW1DnNp5pJXXrmI7Je0MYy6DQc1p28pwCio54Wq6MpkW9+sTpxW0eRh8L1QB8bfceC1M
         SeTw==
X-Gm-Message-State: APuU4Z8rpvqGgF96Ks00nsofPDJgVOZc/dxJ9XceToqO1vb421J32gv1
	ehvaQdVDMUWu1RiJP0qRgqNe/8ETmLfdbvrva0m96h5VgRqXTll7jjm1FDhkTw==
X-Gm-Gg: AYBFou1ll0phwnEfbKSh0Oxnln5/ReB0mtudFWPyw7jxZEYJNyHYr+BcW20DthelLMM
	jT+cXi3u1ojCoe1leTFFd4Ljzcc2nqxfbTf9Nb6mlK+kO1W6hPUsAJjgVMlWxyIGSjTrZemLlqi
	WT0MFl82EtiExh/yliFyOpqbRsoLXcLBXZNw52pQQS7Dn9W5jaeW+ZkLQa2BwHCuZxu3PKlz7Ep
	MGpe/ziK8ctb+P3d4Za+MWMoXADEu2uWkMuxkNpI6CGWB8hIihHTd1bXc80iqrApgKNMWaCxaSW
	ZddPg5b09hwe9Ogb2tW20eHHpzZA0woD/s0I1xO5iQmp4g2jFth0E4HwFAzVxNiFzyBOO0EpXYE
	ti8DCMLzjkJX+pa5dGRDUgyM7zaptl7MGtPqgqGO+iD+nTpMRjDBwyImkzFlP7nLlixMuvpOm9v
	Sjk4m6Ki5+kpOylFVkxheQQGDZJj8PziOF5mPK1jIt4jpZdVoJN3D7WyTTSgiCW0SirYAx/VIk0
	wENs5SPutYKvZxfLzYxFnfBrGXPzwOHUbERMrTylpRTIVshRDNya3KuUpmtkJELVA==
X-Received: by 2002:a05:622a:1f0a:b0:55b:f867:6f4e with SMTP id d75a77b69052e-55d5a32f421mr20997421cf.5.1794969683759;
        Tue, 17 Nov 2026 18:41:23 -0800 (PST)
Received: from [172.17.0.2] ([172.174.199.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d58fea489sm11508451cf.6.2026.11.17.18.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 18:41:23 -0800 (PST)
Message-ID: <6afd1053.d364f834.328c42.6170@mx.google.com>
Date: Tue, 17 Nov 2026 18:41:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3977998250419574103=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: Fixes for issues reported by sashiko.dev
In-Reply-To: <20261117202032.3848411-2-luiz.dentz@gmail.com>
References: <20261117202032.3848411-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3977998250419574103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1214259/

---Test result---

Test Summary:
CheckPatch                    FAIL      14.35 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      5.88 seconds
SubjectPrefix                 PASS      2.16 seconds
BuildKernel                   PASS      31.33 seconds
CheckAllWarning               PASS      35.12 seconds
CheckSparse                   WARNING   39.84 seconds
BuildKernel32                 PASS      31.32 seconds
CheckKernelLLVM               PASS      34.60 seconds
TestRunnerSetup               PASS      749.61 seconds
TestRunner_l2cap-tester       PASS      14.87 seconds
TestRunner_iso-tester         PASS      13.20 seconds
TestRunner_bnep-tester        PASS      3.20 seconds
TestRunner_mgmt-tester        PASS      88.83 seconds
TestRunner_rfcomm-tester      PASS      4.50 seconds
TestRunner_sco-tester         PASS      5.67 seconds
TestRunner_ioctl-tester       PASS      4.72 seconds
TestRunner_mesh-tester        PASS      4.53 seconds
TestRunner_smp-tester         PASS      4.42 seconds
TestRunner_userchan-tester    PASS      3.25 seconds
TestRunner_6lowpan-tester     PASS      4.43 seconds
IncrementalBuild              PASS      91.15 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,01/17] Bluetooth: mgmt: Fix read_index_list() buffer overflow
ERROR: Unrecognized email address: 'sashiko.dev (linux-7841362e-9b8f-465f-aa22-e99c315231e2)'
#127: 
Reported-by: sashiko.dev (linux-7841362e-9b8f-465f-aa22-e99c315231e2)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#127: 
Reported-by: sashiko.dev (linux-7841362e-9b8f-465f-aa22-e99c315231e2)
Fixes: 73d1df2a7a10 ("Bluetooth: Add support for Read Unconfigured Index List command")

WARNING: Non-standard signature: Assisted-by:
#129: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#129: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994716.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,02/17] Bluetooth: hci_core: Take req_sync lock in hci_power_on()
ERROR: Unrecognized email address: 'sashiko.dev (linux-1baf7393-3aeb-4fa5-806f-19cea743b9f3)'
#125: 
Reported-by: sashiko.dev (linux-1baf7393-3aeb-4fa5-806f-19cea743b9f3)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#125: 
Reported-by: sashiko.dev (linux-1baf7393-3aeb-4fa5-806f-19cea743b9f3)
Fixes: cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")

WARNING: Non-standard signature: Assisted-by:
#127: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#127: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994717.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,03/17] Bluetooth: hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()
ERROR: Unrecognized email address: 'sashiko.dev (linux-a364929c-cd00-492a-a83c-5425d042b09f)'
#127: 
Reported-by: sashiko.dev (linux-a364929c-cd00-492a-a83c-5425d042b09f)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#127: 
Reported-by: sashiko.dev (linux-a364929c-cd00-492a-a83c-5425d042b09f)
Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")

WARNING: Non-standard signature: Assisted-by:
#129: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#129: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994718.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,04/17] Bluetooth: hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()
ERROR: Unrecognized email address: 'sashiko.dev (linux-616b1f8e-06ec-4634-a907-5eb4e82f66df)'
#125: 
Reported-by: sashiko.dev (linux-616b1f8e-06ec-4634-a907-5eb4e82f66df)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#125: 
Reported-by: sashiko.dev (linux-616b1f8e-06ec-4634-a907-5eb4e82f66df)
Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")

WARNING: Non-standard signature: Assisted-by:
#127: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#127: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994719.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,05/17] Bluetooth: SMP: Serialize link key updates from smp_notify_keys()
ERROR: Unrecognized email address: 'sashiko.dev (linux-7482a666-d2a0-44a4-9e0d-05354860a5fa)'
#136: 
Reported-by: sashiko.dev (linux-7482a666-d2a0-44a4-9e0d-05354860a5fa)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#136: 
Reported-by: sashiko.dev (linux-7482a666-d2a0-44a4-9e0d-05354860a5fa)
Fixes: 6a77083af57f ("Bluetooth: Add support for LE SC key generation")

WARNING: Non-standard signature: Assisted-by:
#138: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#138: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 161 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994720.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,06/17] Bluetooth: SMP: Check smp_data before using SMP_DEV()
ERROR: Unrecognized email address: 'sashiko.dev (linux-9bc9da90-02a8-4a87-a603-87d0a4cf464c)'
#126: 
Reported-by: sashiko.dev (linux-9bc9da90-02a8-4a87-a603-87d0a4cf464c)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#126: 
Reported-by: sashiko.dev (linux-9bc9da90-02a8-4a87-a603-87d0a4cf464c)
Fixes: 94f14e472812 ("Bluetooth: SMP: Fix trying to use non-existent local OOB data")

WARNING: Non-standard signature: Assisted-by:
#128: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#128: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994721.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,07/17] Bluetooth: SMP: Don't create the BR/EDR channel while unregistered
ERROR: Unrecognized email address: 'sashiko.dev (linux-a921c99c-0b41-485c-91a4-1c6e54b45b0b)'
#130: 
Reported-by: sashiko.dev (linux-a921c99c-0b41-485c-91a4-1c6e54b45b0b)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#130: 
Reported-by: sashiko.dev (linux-a921c99c-0b41-485c-91a4-1c6e54b45b0b)
Fixes: 300acfdec916 ("Bluetooth: Introduce force_bredr_smp debugfs option for testing")

WARNING: Non-standard signature: Assisted-by:
#132: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#132: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 43 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994722.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,08/17] Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv Enable
ERROR: Unrecognized email address: 'sashiko.dev (linux-42bcc244-62e6-4295-802c-f9a512ca49a3)'
#125: 
Reported-by: sashiko.dev (linux-42bcc244-62e6-4295-802c-f9a512ca49a3)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#125: 
Reported-by: sashiko.dev (linux-42bcc244-62e6-4295-802c-f9a512ca49a3)
Fixes: de181e887ac2 ("Bluetooth: Impmlement extended adv enable")

WARNING: Non-standard signature: Assisted-by:
#127: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#127: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994723.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,09/17] Bluetooth: mgmt: Reject zero multi advertising rotation duration
ERROR: Unrecognized email address: 'sashiko.dev (linux-24ecb695-0c5c-408a-a016-a980c3115e95)'
#126: 
Reported-by: sashiko.dev (linux-24ecb695-0c5c-408a-a016-a980c3115e95)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#126: 
Reported-by: sashiko.dev (linux-24ecb695-0c5c-408a-a016-a980c3115e95)
Fixes: 17896406ff35 ("Bluetooth: implement read/set default system parameters mgmt")

WARNING: Non-standard signature: Assisted-by:
#128: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#128: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994724.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,10/17] Bluetooth: L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()
ERROR: Unrecognized email address: 'sashiko.dev (linux-089f015e-6251-4fea-85ef-7d6761e8c457)'
#125: 
Reported-by: sashiko.dev (linux-089f015e-6251-4fea-85ef-7d6761e8c457)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#125: 
Reported-by: sashiko.dev (linux-089f015e-6251-4fea-85ef-7d6761e8c457)
Fixes: 66af7aaf9edf ("Bluetooth: EFS: parse L2CAP config response")

WARNING: Non-standard signature: Assisted-by:
#127: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#127: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 23 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994725.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,11/17] Bluetooth: mgmt: Fix mesh transmission locking and lifetime
ERROR: Unrecognized email address: 'sashiko.dev (linux-4ab89465-fc27-4d91-a870-a8ed49b22e91)'
#147: 
Reported-by: sashiko.dev (linux-4ab89465-fc27-4d91-a870-a8ed49b22e91)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#147: 
Reported-by: sashiko.dev (linux-4ab89465-fc27-4d91-a870-a8ed49b22e91)
Reported-by: sashiko.dev (linux-ab941894-dbe1-49da-8bac-c52efda6eaee)

ERROR: Unrecognized email address: 'sashiko.dev (linux-ab941894-dbe1-49da-8bac-c52efda6eaee)'
#148: 
Reported-by: sashiko.dev (linux-ab941894-dbe1-49da-8bac-c52efda6eaee)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#148: 
Reported-by: sashiko.dev (linux-ab941894-dbe1-49da-8bac-c52efda6eaee)
Reported-by: sashiko.dev (linux-4016f774-7ac7-4b8a-916f-587ec9d597d4)

ERROR: Unrecognized email address: 'sashiko.dev (linux-4016f774-7ac7-4b8a-916f-587ec9d597d4)'
#149: 
Reported-by: sashiko.dev (linux-4016f774-7ac7-4b8a-916f-587ec9d597d4)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#149: 
Reported-by: sashiko.dev (linux-4016f774-7ac7-4b8a-916f-587ec9d597d4)
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")

WARNING: Non-standard signature: Assisted-by:
#151: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#151: 
Assisted-by: OpenCode:claude-fable-5.2

total: 4 errors, 4 warnings, 0 checks, 369 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994726.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,12/17] Bluetooth: MGMT: Fix use-after-free in mgmt_powering_down()
ERROR: Unrecognized email address: 'sashiko.dev (linux-e45413fa-48a6-43f1-90be-638841567534)'
#127: 
Reported-by: sashiko.dev (linux-e45413fa-48a6-43f1-90be-638841567534)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#127: 
Reported-by: sashiko.dev (linux-e45413fa-48a6-43f1-90be-638841567534)
Fixes: 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs")

WARNING: Non-standard signature: Assisted-by:
#129: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#129: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 34 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994727.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,13/17] Bluetooth: MSFT: Protect the event prefix with hdev->lock
ERROR: Unrecognized email address: 'sashiko.dev (linux-246df501-f32c-46fd-8779-7fa755ed7f9d)'
#128: 
Reported-by: sashiko.dev (linux-246df501-f32c-46fd-8779-7fa755ed7f9d)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#128: 
Reported-by: sashiko.dev (linux-246df501-f32c-46fd-8779-7fa755ed7f9d)
Fixes: 5031ffcc79b8 ("Bluetooth: Keep MSFT ext info throughout a hci_dev's life cycle")

WARNING: Non-standard signature: Assisted-by:
#130: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#130: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 88 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994728.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,14/17] Bluetooth: hci_debugfs: Fix racy toggling of debugfs controlled flags
ERROR: Unrecognized email address: 'sashiko.dev (linux-442108d5-76ce-44a1-a84d-16b44d6a26a6)'
#133: 
Reported-by: sashiko.dev (linux-442108d5-76ce-44a1-a84d-16b44d6a26a6)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#133: 
Reported-by: sashiko.dev (linux-442108d5-76ce-44a1-a84d-16b44d6a26a6)
Fixes: 4b4148e9acc1 ("Bluetooth: Add support for setting DUT mode")

WARNING: Non-standard signature: Assisted-by:
#136: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#136: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 110 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994729.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,15/17] Bluetooth: hci_core: Hold hdev->lock when removing advertisement monitors
ERROR: Unrecognized email address: 'sashiko.dev (linux-8b358899-5ac9-4687-af16-58420a4d9bba)'
#129: 
Reported-by: sashiko.dev (linux-8b358899-5ac9-4687-af16-58420a4d9bba)

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#129: 
Reported-by: sashiko.dev (linux-8b358899-5ac9-4687-af16-58420a4d9bba)
Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")

WARNING: Non-standard signature: Assisted-by:
#131: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#131: 
Assisted-by: OpenCode:claude-fable-5.2

total: 2 errors, 2 warnings, 0 checks, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994732.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,16/17] Bluetooth: MSFT: Free the response of the monitor commands
WARNING: Non-standard signature: Assisted-by:
#133: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#133: 
Assisted-by: OpenCode:claude-fable-5.2

total: 1 errors, 1 warnings, 0 checks, 56 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994730.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,17/17] Bluetooth: hci_core: Don't fail removing a monitor unknown to the controller
WARNING: Non-standard signature: Assisted-by:
#130: 
Assisted-by: OpenCode:claude-fable-5.2

ERROR: Unrecognized email address: 'OpenCode:claude-fable-5.2'
#130: 
Assisted-by: OpenCode:claude-fable-5.2

total: 1 errors, 1 warnings, 0 checks, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14994731.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,03/17] Bluetooth: hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()

1: T1 Title exceeds max length (86>80): "[v2,03/17] Bluetooth: hci_sync: Lock the lookup in hci_disable_ext_adv_instance_sync()"
[v2,04/17] Bluetooth: hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()

1: T1 Title exceeds max length (83>80): "[v2,04/17] Bluetooth: hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()"
[v2,08/17] Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv Enable

1: T1 Title exceeds max length (86>80): "[v2,08/17] Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv Enable"
[v2,10/17] Bluetooth: L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()

1: T1 Title exceeds max length (82>80): "[v2,10/17] Bluetooth: L2CAP: Don't use uninitialized EFS in l2cap_parse_conf_rsp()"
[v2,15/17] Bluetooth: hci_core: Hold hdev->lock when removing advertisement monitors

1: T1 Title exceeds max length (84>80): "[v2,15/17] Bluetooth: hci_core: Hold hdev->lock when removing advertisement monitors"
[v2,17/17] Bluetooth: hci_core: Don't fail removing a monitor unknown to the controller

1: T1 Title exceeds max length (87>80): "[v2,17/17] Bluetooth: hci_core: Don't fail removing a monitor unknown to the controller"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1145

---
Regards,
Linux Bluetooth


--===============3977998250419574103==--
