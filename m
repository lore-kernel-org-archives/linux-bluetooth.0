Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2B14C592
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558974; cv=none; b=CZFRo+z+CR2tmHzIL7oTjcXCjZ5l/818ctUurumQDSZ+Ba7eZEBBObtCos7Nhq/rVq6UnWgKjtMqF0xMT6WA4fB1PjOwQZxvK5YhEC2jVfB4h71mxAS/rlndNKRLsXJ3m50kjKap8r6Z0D+bczbMxZ6XghwvdK+EmPR8EZU7YCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558974; c=relaxed/simple;
	bh=3Yx620YjuZn9L0g5lPjJl5oypRAftz0rs1MvQvBNBks=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uvJmoSMGesabzzrahk1iH3890HytkQlyE/iIqeKsyUc0PrOkk6Ek5TOw5VZqYvx7uRGtnU/TXHVlIrhTaSE51BcDqiUkAu8IpLcxlvT2BivGK8FAqZUArwN8zipQXgsIofgC4rol2R2AE4jsBYaD+EwPxPVGCyOPH4fDUs5F3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPLMrvy2; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPLMrvy2"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e6f72b63e2so18813a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711558970; x=1712163770; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=puSNBm1ovB9B505ifKifavpAcRWiJSljyd892/Vmh8c=;
        b=iPLMrvy2VZNqd5yeqNPf7IYS6ryXZsGCdmnDDqi6r0sfvNa72VnfGojkEF8R6r/Ld0
         mdj6W4myA/O1cbEDXj0e62WdIiVSUy+/1/8vllSQGiFUEPok/ETck/7FSkdsB2lle45G
         akofcrAuVdBK7UHpNv/czzlmzvESGRTHQh0tHzYKBdgT5y0R8QMYrXoPUu2hPWfaOMM0
         bQ7kWGu13jDRREW9JG+bKo4l7ByS7Okvv5s1nOpwC+JUFJ2Bxjk5Ix3q407j5guSqKKv
         OEpjHXjncVl5YOGTK0bHos5FZanj3djQIvfK44SrG+oWRrePdPMuekRG3iLak6rhsq2O
         fh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711558970; x=1712163770;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puSNBm1ovB9B505ifKifavpAcRWiJSljyd892/Vmh8c=;
        b=Da68Te0mrmPUGwB3I+3VeCtvjRsmbnZw8kZoJ3bd9MKLp47ShFWMOvrGWEWpnnHrrD
         WEQMpNKvu/++qw3PtBllFZzQ1uBuLCMc4xzLzHr/D8/UKevtRI55LVMnbcWQ02l6E8Rn
         m3Hlno+BTPytipWmX3iiXAr63qqNZRGPTDD5uM0uDAr7tRzZwfD49N4tW7M9I3eoi63e
         bNJUUBGLac+os8md1DPg69Q5lSLmbBex7LDNDpuvUnqxtgy+fpc5EFz+GbjE2gXjzcWV
         TRveJPculZPNT8ic7t2lTbjTYC/o56AXFf9GbS3UkOmvP/3DKmNyW3TcHb9AFxTKoaBl
         SVng==
X-Gm-Message-State: AOJu0Yz1rkxhxZVK6Xcv2Tb9zlTYF0+Kd5ZXW+kX/V4f5G/TnUeV4mbV
	dMtDpQU0E7yBsFackbr9oII0/BmUV/gT9XX59jQfef6FdtnNXj/aH9sNpaZp
X-Google-Smtp-Source: AGHT+IG7Y5T0Yysz5XwTw6w9lOhVIaECMr0P3bJohi5ONJtM4EOS40iCVKktDRA77qGZNF0iwMYeIQ==
X-Received: by 2002:a05:6830:20cb:b0:6e6:8b5a:814d with SMTP id z11-20020a05683020cb00b006e68b5a814dmr658306otq.13.1711558969860;
        Wed, 27 Mar 2024 10:02:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.199.0])
        by smtp.gmail.com with ESMTPSA id eh12-20020a056214186c00b0069183a8de64sm6476676qvb.75.2024.03.27.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 10:02:49 -0700 (PDT)
Message-ID: <66045139.050a0220.87687.32b6@mx.google.com>
Date: Wed, 27 Mar 2024 10:02:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7192424905286791003=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: power: sequencing: implement the subsystem and add first users
In-Reply-To: <20240325131624.26023-2-brgl@bgdev.pl>
References: <20240325131624.26023-2-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7192424905286791003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=837880

---Test result---

Test Summary:
CheckPatch                    FAIL      17.35 seconds
GitLint                       FAIL      5.29 seconds
SubjectPrefix                 FAIL      2.20 seconds
BuildKernel                   PASS      30.27 seconds
CheckAllWarning               PASS      32.81 seconds
CheckSparse                   PASS      40.46 seconds
CheckSmatch                   FAIL      35.39 seconds
BuildKernel32                 PASS      29.16 seconds
TestRunnerSetup               PASS      522.12 seconds
TestRunner_l2cap-tester       PASS      20.13 seconds
TestRunner_iso-tester         FAIL      32.73 seconds
TestRunner_bnep-tester        PASS      4.90 seconds
TestRunner_mgmt-tester        PASS      112.58 seconds
TestRunner_rfcomm-tester      PASS      7.33 seconds
TestRunner_sco-tester         PASS      14.93 seconds
TestRunner_ioctl-tester       PASS      7.77 seconds
TestRunner_mesh-tester        FAIL      6.00 seconds
TestRunner_smp-tester         PASS      6.87 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PASS      95.81 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v6,01/16] regulator: dt-bindings: describe the PMU module of the QCA6390 package
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#147: 
new file mode 100644

total: 0 errors, 1 warnings, 151 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13602138.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v6,05/16] dt-bindings: net: wireless: describe the ath12k PCI module
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#145: 
new file mode 100644

total: 0 errors, 1 warnings, 100 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13602142.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v6,06/16] arm64: dts: qcom: sm8550-qrd: add the Wifi node
WARNING: DT compatible string vendor "pci17cb" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#225: FILE: arch/arm64/boot/dts/qcom/sm8550-qrd.dts:891:
+		compatible = "pci17cb,1107";

total: 0 errors, 1 warnings, 137 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13602143.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v6,07/16] arm64: dts: qcom: sm8650-qrd: add the Wifi node
WARNING: DT compatible string vendor "pci17cb" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#228: FILE: arch/arm64/boot/dts/qcom/sm8650-qrd.dts:915:
+		compatible = "pci17cb,1107";

total: 0 errors, 1 warnings, 123 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13602145.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v6,08/16] arm64: dts: qcom: qrb5165-rb5: add the Wifi node
WARNING: DT compatible string vendor "pci17cb" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#223: FILE: arch/arm64/boot/dts/qcom/qrb5165-rb5.dts:800:
+		compatible = "pci17cb,1101";

total: 0 errors, 1 warnings, 143 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13602144.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v6,12/16] PCI/pwrctl: add PCI power control core code
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#186: 
new file mode 100644

total: 0 errors, 1 warnings, 212 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13602149.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v6,13/16] power: sequencing: implement the pwrseq core
WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#1328: FILE: include/linux/pwrseq/consumer.h:31:
+	return ERR_PTR(-ENOSYS);

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#1338: FILE: include/linux/pwrseq/consumer.h:41:
+	return ERR_PTR(-ENOSYS);

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#1343: FILE: include/linux/pwrseq/consumer.h:46:
+	return -ENOSYS;

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#1348: FILE: include/linux/pwrseq/consumer.h:51:
+	return -ENOSYS;

total: 0 errors, 4 warnings, 1234 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13602150.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v6,14/16] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#183: 
new file mode 100644

total: 0 errors, 1 warnings, 360 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13602151.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v6,16/16] PCI/pwrctl: add a PCI power control driver for power sequenced devices
WARNING: please write a help paragraph that fully describes the config symbol
#155: FILE: drivers/pci/pwrctl/Kconfig:8:
+config PCI_PWRCTL_PWRSEQ
+	tristate "PCI Power Control driver using the Power Sequencing subsystem"
+	select POWER_SEQUENCING
+	select PCI_PWRCTL
+	default m if (ATH11K_PCI && ARCH_QCOM)
+	help
+	  Enable support for the PCI power control driver for device
+	  drivers using the Power Sequencing subsystem.
+

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#176: 
new file mode 100644

WARNING: DT compatible string vendor "pci17cb" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#246: FILE: drivers/pci/pwrctl/pci-pwrctl-pwrseq.c:66:
+		.compatible = "pci17cb,1101",

WARNING: DT compatible string vendor "pci17cb" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#251: FILE: drivers/pci/pwrctl/pci-pwrctl-pwrseq.c:71:
+		.compatible = "pci17cb,1107",

total: 0 errors, 4 warnings, 107 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13602153.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v6,01/16] regulator: dt-bindings: describe the PMU module of the QCA6390 package

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[v6,01/16] regulator: dt-bindings: describe the PMU module of the QCA6390 package"
13: B1 Line exceeds max length (85>80): " create mode 100644 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml"
[v6,02/16] regulator: dt-bindings: describe the PMU module of the WCN7850 package

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[v6,02/16] regulator: dt-bindings: describe the PMU module of the WCN7850 package"
[v6,03/16] dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[v6,03/16] dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390"
[v6,04/16] dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on QCA6390

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v6,04/16] dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on QCA6390"
[v6,05/16] dt-bindings: net: wireless: describe the ath12k PCI module

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B1 Line exceeds max length (83>80): " create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml"
[v6,11/16] PCI/pwrctl: create platform devices for child OF nodes of the port node

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v6,11/16] PCI/pwrctl: create platform devices for child OF nodes of the port node"
[v6,14/16] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v6,14/16] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets"
[v6,16/16] PCI/pwrctl: add a PCI power control driver for power sequenced devices

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[v6,16/16] PCI/pwrctl: add a PCI power control driver for power sequenced devices"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.185 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.097 seconds


---
Regards,
Linux Bluetooth


--===============7192424905286791003==--
