Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCC154BE7
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754599; cv=none; b=JZ7fLutpDgV0zb2Kk58anudXZIsF3F6oE7ugtuMZh/cfLuoCjA8nKj9eu8VTdA0g8IL/mdnKyoMOekObnMFsga1i2NMBmlVnXSp+M+0RE1EmBVUXgzxI+grYxlm0q6IdMafjN1AGag/Ox26FzdbemLGdIzvmOW93xaBU3PecJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754599; c=relaxed/simple;
	bh=zSJWuHQTJoTx2818wlMK1YC229+wQmbrERk6B+aG32w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZhRuxq437wvukw1kzHXSfNopWJE37CpvEYxHfhTjgFt3za5APHlWl118gw3lIr+IEUmOzJIKozzwvAbgc62sk/YnttY6CYZ8sSRqZN3XI2Q7Krxw6axnyc/MRXNunrFBngX4CqcuBxx8kk19rD7FMKyaluFCMhrOJCND3KiQAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tb+KzUkN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb+KzUkN"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-434899d6d2bso13427951cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 06:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712754596; x=1713359396; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xQAbiBm3c3w9GOcNrCExAKBeBxXTtq/KWAxs+T2GHQY=;
        b=Tb+KzUkN42sATkF2F4hGUdVWk73esiWKdykFXiLLpR7gaKC/25/BY54fl2XJnv1SGq
         GSMmg1okXMAITAKMHyKPKUIwGw+h/js4C1W7O9SmMmB7hiHYoJPrlhZDJA0nY9l0Qr7R
         WlsLVPvqU15UubVoc207Szx72C3nY6tGymYVGoVwoanJdBvxvJtkreCui0nGGngKBYon
         aJkstQHruYtxWWQw7vMa++A930n6u3NBBSWWivYGKvcSzZBAN//mIwO2h56o+hbMZK5P
         4uJWv5lZAhAfzjkUjioY10ylkVfSy8sfRajHuLVGVaecTiHv1x/b0SGS9cVSqwRWgKXC
         lm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712754596; x=1713359396;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQAbiBm3c3w9GOcNrCExAKBeBxXTtq/KWAxs+T2GHQY=;
        b=AfMQx+2rtoZHzDpYo9uy76JvPA2zKWqUsXwQ7VWgnrL/1fkaHhoOgXhh5d0K2hULd2
         K8l00Jh4Cow4raET7jk/89GnFtJjHQH80zogsgYdXqpgbH3TbFCwec/miNKsQHV8dST2
         yMk2a+kHYKEJccF7z758X2hc58PQxNDcy9GRaJtMJkkNeWl5jCiDBqHhJRMXMDts2tO/
         h9DFZ9D3X9Q4q9/PpTf5DHN32y+3FidSWJACmaUOEbR/3mTl8ikjA0B/Zy27ey48qNRn
         cCv079BgyIiMSnkzJi44jPk/+O/edRk189IOGZc4hwYuvzqMlH4aPKSMlKjhb8ItMkWz
         l4Iw==
X-Gm-Message-State: AOJu0YwuVKcKB3kHCqf0LBuVJHxviF1j5m1LDbnQpLHgTDC6R/hDk2o4
	GHir7QBgLJ+iVhkW0TE705gNy7QAj8LNIQJB7XMbWzv7PTcTs0dZE8XIlCqq
X-Google-Smtp-Source: AGHT+IHnx31LkWMWPcT+Dd1GFNGXCzrna9EruZ13O/2pnEvWkZlycZvoPeRz7Spj4uUnKH3VGkQasQ==
X-Received: by 2002:ac8:7d43:0:b0:434:9855:dc79 with SMTP id h3-20020ac87d43000000b004349855dc79mr2381541qtb.12.1712754595634;
        Wed, 10 Apr 2024 06:09:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.46.145])
        by smtp.gmail.com with ESMTPSA id q13-20020ac8734d000000b00434e990098bsm1412485qtp.77.2024.04.10.06.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:09:55 -0700 (PDT)
Message-ID: <66168fa3.c80a0220.7312b.59f2@mx.google.com>
Date: Wed, 10 Apr 2024 06:09:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7327757627076139032=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: power: sequencing: implement the subsystem and add first users
In-Reply-To: <20240410124628.171783-2-brgl@bgdev.pl>
References: <20240410124628.171783-2-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7327757627076139032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843230

---Test result---

Test Summary:
CheckPatch                    FAIL      16.93 seconds
GitLint                       FAIL      8.77 seconds
SubjectPrefix                 FAIL      2.19 seconds
BuildKernel                   PASS      30.45 seconds
CheckAllWarning               PASS      32.94 seconds
CheckSparse                   PASS      40.05 seconds
CheckSmatch                   FAIL      35.10 seconds
BuildKernel32                 PASS      29.13 seconds
TestRunnerSetup               PASS      522.11 seconds
TestRunner_l2cap-tester       PASS      18.32 seconds
TestRunner_iso-tester         PASS      30.89 seconds
TestRunner_bnep-tester        PASS      4.70 seconds
TestRunner_mgmt-tester        PASS      114.43 seconds
TestRunner_rfcomm-tester      PASS      7.31 seconds
TestRunner_sco-tester         PASS      14.99 seconds
TestRunner_ioctl-tester       PASS      7.73 seconds
TestRunner_mesh-tester        PASS      5.79 seconds
TestRunner_smp-tester         PASS      7.01 seconds
TestRunner_userchan-tester    PASS      4.84 seconds
IncrementalBuild              PASS      96.94 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v7,01/16] regulator: dt-bindings: describe the PMU module of the QCA6390 package
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#151: 
new file mode 100644

total: 0 errors, 1 warnings, 151 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13624277.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v7,05/16] dt-bindings: net: wireless: describe the ath12k PCI module
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#149: 
new file mode 100644

total: 0 errors, 1 warnings, 99 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13624281.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v7,06/16] arm64: dts: qcom: sm8550-qrd: add the Wifi node
WARNING: DT compatible string vendor "pci17cb" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#227: FILE: arch/arm64/boot/dts/qcom/sm8550-qrd.dts:891:
+		compatible = "pci17cb,1107";

total: 0 errors, 1 warnings, 137 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13624282.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v7,07/16] arm64: dts: qcom: sm8650-qrd: add the Wifi node
WARNING: DT compatible string vendor "pci17cb" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#230: FILE: arch/arm64/boot/dts/qcom/sm8650-qrd.dts:915:
+		compatible = "pci17cb,1107";

total: 0 errors, 1 warnings, 123 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13624283.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v7,08/16] arm64: dts: qcom: qrb5165-rb5: add the Wifi node
WARNING: DT compatible string vendor "pci17cb" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#225: FILE: arch/arm64/boot/dts/qcom/qrb5165-rb5.dts:800:
+		compatible = "pci17cb,1101";

total: 0 errors, 1 warnings, 143 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13624284.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v7,12/16] PCI/pwrctl: add PCI power control core code
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#188: 
new file mode 100644

total: 0 errors, 1 warnings, 213 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13624288.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v7,13/16] power: sequencing: implement the pwrseq core
WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#1330: FILE: include/linux/pwrseq/consumer.h:31:
+	return ERR_PTR(-ENOSYS);

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#1340: FILE: include/linux/pwrseq/consumer.h:41:
+	return ERR_PTR(-ENOSYS);

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#1345: FILE: include/linux/pwrseq/consumer.h:46:
+	return -ENOSYS;

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#1350: FILE: include/linux/pwrseq/consumer.h:51:
+	return -ENOSYS;

total: 0 errors, 4 warnings, 1234 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13624290.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v7,14/16] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#185: 
new file mode 100644

total: 0 errors, 1 warnings, 360 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13624289.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v7,16/16] PCI/pwrctl: add a PCI power control driver for power sequenced devices
WARNING: please write a help paragraph that fully describes the config symbol
#157: FILE: drivers/pci/pwrctl/Kconfig:8:
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
#178: 
new file mode 100644

WARNING: DT compatible string vendor "pci17cb" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#248: FILE: drivers/pci/pwrctl/pci-pwrctl-pwrseq.c:66:
+		.compatible = "pci17cb,1101",

WARNING: DT compatible string vendor "pci17cb" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#253: FILE: drivers/pci/pwrctl/pci-pwrctl-pwrseq.c:71:
+		.compatible = "pci17cb,1107",

total: 0 errors, 4 warnings, 107 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13624292.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v7,01/16] regulator: dt-bindings: describe the PMU module of the QCA6390 package

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[v7,01/16] regulator: dt-bindings: describe the PMU module of the QCA6390 package"
15: B1 Line exceeds max length (85>80): " create mode 100644 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml"
[v7,02/16] regulator: dt-bindings: describe the PMU module of the WCN7850 package

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[v7,02/16] regulator: dt-bindings: describe the PMU module of the WCN7850 package"
[v7,03/16] dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[v7,03/16] dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390"
[v7,04/16] dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on QCA6390

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v7,04/16] dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on QCA6390"
[v7,05/16] dt-bindings: net: wireless: describe the ath12k PCI module

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (83>80): " create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml"
[v7,11/16] PCI/pwrctl: create platform devices for child OF nodes of the port node

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v7,11/16] PCI/pwrctl: create platform devices for child OF nodes of the port node"
[v7,14/16] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v7,14/16] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets"
[v7,16/16] PCI/pwrctl: add a PCI power control driver for power sequenced devices

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[v7,16/16] PCI/pwrctl: add a PCI power control driver for power sequenced devices"
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


---
Regards,
Linux Bluetooth


--===============7327757627076139032==--
