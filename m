Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE78061F
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911030; cv=none; b=OKad0DTFXXaOJft3wL1KpqHrAp8G1YX5ib7IrwmcVcjpFaKi4hhHbZUPB18KM+xyk6T7suemvMIKTgCkdCCPLeYCUAGsy5xCbiv6URElzxy27j7faxyTW7B8C4JugFMWF8n9R3d7Wvrr38nKxLQQtx4Ppo6Kq9WSw9m39dIVzuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911030; c=relaxed/simple;
	bh=d+8ICi3awg2LHgl++ekUDIHYop7eRcwygBDEmy/W0WQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a39NrJy+MaLuvHb2CNMmbHH1+Y9chC6DWzlwu6qeqVLrDg4EU0rrlYkmAQWgwPdiFiFwIshYnhD1gmvRN7EvL9Ab8CzJT/yjWm407+92ympMFK6Q8HJ9P/DTB7eL4HMA/wIib/1/gXapvIgq2njW8MetBOjgbLZ0CPyEiQBHpn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUMkDuVb; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUMkDuVb"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-783dc658bd9so142955185a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Feb 2024 13:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911027; x=1707515827; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TkGOQqQaf9zdXExL4qfKFIIzfWZ3i6rReaQ3WiXm5O0=;
        b=VUMkDuVb0mkBmW3mhA4fYJMV7UAGgzxySMwlltDvf214/FZlPZcAw7SPEHh11/EKTM
         PklNBzdi+jsVNxIiiu2u1WqH+WncudOrFAMGVy5dxH/fOV5Bre5Tm+eE3ef39cb8fKSU
         LlzD6aRbtSLHSQIyYbG+q88EX/pBEx2oVU339GbI+9JPt8A60uNNV5HVo5zpxYPfK8ua
         8ST4VTXms+s1/FzY38N7eCtglb58wtySTXPnItXMZ+2OTaFWkZMfPWAnZyy2Y2a631kh
         sK1xSt2cS8NVMsLJRdfxaT1GM8m1yOjVXM2Ou+ZEDKmR9AoEB3etP3m+N6eGGGn8ivcI
         FBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911027; x=1707515827;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkGOQqQaf9zdXExL4qfKFIIzfWZ3i6rReaQ3WiXm5O0=;
        b=GasBOKFogV1RPBSHhqpiI8TP0eOsKZ9t5wOuLDzfaioSUMLlYyuubuV0LnoEZb+Rkt
         HlJp8O0Muek5loZ7QewRsJZCLgAyIBLo5XeVggtZ8npFt0616UNiErgaIulR4KCdHVEp
         4BIZVZwBDAbwOv0t6h8swVOU0gt+jqyF1X48mNnJWCIPHEgzF8/MoiZ7AuZfou5SEMpm
         k+1Kn01UrBae0oh/BeBATwMsjJhV+HGQO8yL6RbHdqXaa0Ocj247GSIRuzX0Kts/oHkf
         QSUZ2Ww15/lnlj+i3XBGdxyJa4v4IoVDW/FZK1+m/XFZ1H0tlYFw7wgiL0BgqqK9Eyh2
         y1AQ==
X-Gm-Message-State: AOJu0YwSvInMGX34w0eLP8c4WHm6bMM55s84qu1LtTlN8jqyN468CbKk
	fbYJgG+c0WRjFEyhjmY5NyYTSDsWiJt8+ZZynvTMoYcJMYZjfgVcJ8XcqRpDDU0=
X-Google-Smtp-Source: AGHT+IHNWqWpvKT1SOfNKYAYmXfItGgn8lRHEt5qPJDPbrMmmdyv829IP/lC7cgdrPBKaTFEi0eE0Q==
X-Received: by 2002:a05:620a:4094:b0:785:4ece:6a10 with SMTP id f20-20020a05620a409400b007854ece6a10mr6794506qko.33.1706911026894;
        Fri, 02 Feb 2024 13:57:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU4fN/elUvp5DvdvxhcMRskE9jcIiFS4nmv/EbBU2L41zHDtTw1bcASC8qV5Xrg5dbXbL7i1ylRILSE2brZ
Received: from [172.17.0.2] ([20.55.222.98])
        by smtp.gmail.com with ESMTPSA id g4-20020a37e204000000b00783f534706esm998966qki.61.2024.02.02.13.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 13:57:06 -0800 (PST)
Message-ID: <65bd6532.370a0220.7db80.6afd@mx.google.com>
Date: Fri, 02 Feb 2024 13:57:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1776985525967227378=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: power: sequencing: implement the subsystem and add first users
In-Reply-To: <20240201155532.49707-2-brgl@bgdev.pl>
References: <20240201155532.49707-2-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1776985525967227378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=822186

---Test result---

Test Summary:
CheckPatch                    FAIL      11.15 seconds
GitLint                       PASS      3.00 seconds
SubjectPrefix                 FAIL      1.39 seconds
BuildKernel                   PASS      27.79 seconds
CheckAllWarning               PASS      30.75 seconds
CheckSparse                   PASS      37.46 seconds
CheckSmatch                   PASS      99.82 seconds
BuildKernel32                 PASS      27.11 seconds
TestRunnerSetup               PASS      499.56 seconds
TestRunner_l2cap-tester       PASS      17.17 seconds
TestRunner_iso-tester         PASS      28.35 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        FAIL      106.30 seconds
TestRunner_rfcomm-tester      PASS      7.42 seconds
TestRunner_sco-tester         PASS      13.23 seconds
TestRunner_ioctl-tester       PASS      7.87 seconds
TestRunner_mesh-tester        PASS      5.92 seconds
TestRunner_smp-tester         PASS      6.90 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PASS      60.54 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,2/9] arm64: dts: qcom: qrb5165-rb5: model the PMU of the QCA6391
WARNING: DT compatible string "qcom,qca6390-pmu" appears un-documented -- check ./Documentation/devicetree/bindings/
#138: FILE: arch/arm64/boot/dts/qcom/qrb5165-rb5.dts:112:
+		compatible = "qcom,qca6390-pmu";

WARNING: DT compatible string "pci17cb,1101" appears un-documented -- check ./Documentation/devicetree/bindings/
#227: FILE: arch/arm64/boot/dts/qcom/qrb5165-rb5.dts:820:
+		compatible = "pci17cb,1101";

WARNING: DT compatible string vendor "pci17cb" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#227: FILE: arch/arm64/boot/dts/qcom/qrb5165-rb5.dts:820:
+		compatible = "pci17cb,1101";

total: 0 errors, 3 warnings, 168 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13541336.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,3/9] power: sequencing: new subsystem
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#158: 
new file mode 100644

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#706: FILE: include/linux/pwrseq/consumer.h:28:
+	return ERR_PTR(-ENOSYS);

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#716: FILE: include/linux/pwrseq/consumer.h:38:
+	return ERR_PTR(-ENOSYS);

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#721: FILE: include/linux/pwrseq/consumer.h:43:
+	return -ENOSYS;

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#726: FILE: include/linux/pwrseq/consumer.h:48:
+	return -ENOSYS;

total: 0 errors, 5 warnings, 600 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13541337.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,4/9] power: pwrseq: add a driver for the QCA6390 PMU module
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#165: 
new file mode 100644

WARNING: DT compatible string "qcom,qca6390-pmu" appears un-documented -- check ./Documentation/devicetree/bindings/
#383: FILE: drivers/power/sequencing/pwrseq-qca6390.c:214:
+		.compatible = "qcom,qca6390-pmu",

total: 0 errors, 2 warnings, 256 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13541338.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,8/9] PCI/pwrctl: add PCI power control core code
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#170: 
new file mode 100644

total: 0 errors, 1 warnings, 130 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13541342.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[RFC,9/9] PCI/pwrctl: add a PCI power control driver for power sequenced devices
WARNING: please write a help paragraph that fully describes the config symbol
#139: FILE: drivers/pci/pwrctl/Kconfig:8:
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
#159: 
new file mode 100644

WARNING: DT compatible string "pci17cb,1101" appears un-documented -- check ./Documentation/devicetree/bindings/
#229: FILE: drivers/pci/pwrctl/pci-pwrctl-pwrseq.c:66:
+		.compatible = "pci17cb,1101",

WARNING: DT compatible string vendor "pci17cb" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#229: FILE: drivers/pci/pwrctl/pci-pwrctl-pwrseq.c:66:
+		.compatible = "pci17cb,1101",

total: 0 errors, 4 warnings, 100 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13541343.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 486 (97.8%), Failed: 5, Not Run: 6

Failed Test Cases
Read Ext Controller Info 1                           Failed       0.083 seconds
Read Ext Controller Info 2                           Failed       0.089 seconds
Read Ext Controller Info 3                           Failed       0.092 seconds
Read Ext Controller Info 4                           Failed       0.085 seconds
Read Ext Controller Info 5                           Failed       0.104 seconds


---
Regards,
Linux Bluetooth


--===============1776985525967227378==--
