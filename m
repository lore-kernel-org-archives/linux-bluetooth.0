Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C8E45A294
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140631; cv=none; b=iNSUzzZ+TXH0DuesRtVVCWi5db4c1VhHKQ5w220YW7je8RoVLB0K/quJuDqkM1+FrrHxekOj8HfECzB05OqOi4y4Z6ZkT6r+hGx337oWtz/4gwqO9Veru+VHAFNHj6lmU4ROETeQqmD0r9EG3gI6SJq9tIM+k5Yl1WvvDgX9I2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140631; c=relaxed/simple;
	bh=H30zbVl3Eh43xQJOqhQt2UJJUer0C6PBAgYez+R+G5w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HfCp2/vyuGWzdxsg4X9D7yay4Dmyl2hvGnl0dRVvmWFly/pQZtnaFppgSuBYLcyv8uNQHQLACdW0DsVxLS1HQkUsxNCfNpL7GePA5aDBYIiGnPIJ5Uwt0/q/TnRZblIr7P1mDsmOn9wufwWHJMEUIyBR1ki21/EuBXdXFJz8GxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S42nSB/j; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S42nSB/j"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e507b079dso11444b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 15:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140629; x=1786745429; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IQZ4u3wMpsno6UZLRIlTea7MgY9Nhnu3Wq4JqvWKy9w=;
        b=S42nSB/jA6UhdP634pk9XWoG4TO6N7wcisUaAll84E2d7WI8Azj4fYhEVyBgNYQ7SB
         RfTTBFA9kxNOeE0ibth6sdcJ4PaydVJet/Ho5Enz/EZLSjz64uPNdEHG7qTPM6p19geo
         Cy0shuBYqaKMFpm8g3y9MvSMXTEgVIudSwXEftD+w2UvZaKMH+hEJxRaaqBjcnGwe+DT
         Ec6mtarxtmg42G2tiqroL0mfUdCG81utYta3n1JtkUjrQ47Isuv6LFNYmfMyLUA7Qg6g
         unuFt12Y1FMy1xBjMWkF0GT+vzg9OX+wy28F4OgqMWS/JGthLgFxj4C4wZj6LxBNCsd9
         Bs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140629; x=1786745429;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IQZ4u3wMpsno6UZLRIlTea7MgY9Nhnu3Wq4JqvWKy9w=;
        b=BrUH9FoJKAesQXrCPBjFK/rl9fC3VR5IRYq5CaTezQF558hys5bJ5rhXVqU2J0n7TW
         GO7XRmPeZvuJYNidZ1Z45wNjoeVYaUcVYHfAJGy4mph8Kf/5RykXXrfp4+LfaKLTkEL5
         CRO7mrXTcF2GRe51r9tpjvs8KAUYvcPR0OQBBezRIHytlmrmq0b0yruNF4w4pq1O5paG
         wUq+wWhqejqk/NfNEp/HbY9PTx2vMCKvLNEQIF0cXrLlewHbQdfbL6HDTESntIyxKwyL
         ScpwdXPX0r7uTQP3zkxFjx1f/mjkABTr0kn5S+3uS1garl/3o59rlnKIkGUrSGrKTfaq
         n0og==
X-Gm-Message-State: AOJu0YySBcKoA71WDj1OW5kxyH4aKaPupIAuzpvpgfYYgiNVexYeLoZu
	slGWVi24tVonDk6ReEPHd1dPgJUTv/iCa9zv4vnX0jHnYjwtWVVpUiT+KNSkDBZx
X-Gm-Gg: AR+sD10bx2nJ1usGEGnxawxZte0Jmo8MlGM91PGLgnkFmyDsVjZt//+Us7FOoHYK8m2
	ez7PTBuzHjGJuZM47hJ8hmqdc1RwkmcEuJARWJS3g2Feql/t1i0JzCNqzogsuIu88ctlx883fVv
	DU+5MiLcS4zdK2+5DkRhPpVnaLlBZ+jUQ4bSiEACumUsiaLeQ1nmgG5hUCK4xteYbMv/F0CSlH6
	A+u2d0ma34sMk45VA8sXCeGE+0A1OunSwgQMJrV7nX76D9+/b2QaAOBxysz27cMelIspJ11b5qf
	ubc0j57xxJTFwzKsayhmlR4dM0Mvwxwmw+U4HzjkPyD+yTPtclVMrArg6WeOdtdAznbunigCNma
	tV1zhOiqzx2HRYeBQIFs7PyLr9449jPmHaRNulsEhaUUjZtH9eHuFqnFOS9/7eboDrLLI7cKM6y
	IpobCrupXIVh0k2A4kxKf9TnF4UVxHif4Yvms9wTs+awPV734ygoPRkEhl9VBXkMXuRQ==
X-Received: by 2002:a05:6300:6d82:10b0:3cb:d156:d362 with SMTP id adf61e73a8af0-3cbd156d365mr1789650637.3.1786140629027;
        Fri, 07 Aug 2026 15:10:29 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.3.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b95b20sm10156546c88.15.2026.08.07.15.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:10:28 -0700 (PDT)
Message-ID: <6a7657d4.7d702ed2.13dab5.cc5d@mx.google.com>
Date: Fri, 07 Aug 2026 15:10:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5683762508607554240=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rahul.samana@oss.qualcomm.com
Subject: RE: Bluetooth: qca: enable QCC2072 on RB3 Gen 2 Industrial
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5683762508607554240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1135254

---Test result---

Test Summary:
CheckPatch                    FAIL      4.30 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      1.32 seconds
SubjectPrefix                 FAIL      0.48 seconds
BuildKernel                   PASS      22.62 seconds
CheckAllWarning               PASS      26.56 seconds
CheckSparse                   PASS      26.14 seconds
BuildKernel32                 PASS      24.61 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      412.88 seconds
TestRunner_l2cap-tester       PASS      61.08 seconds
TestRunner_iso-tester         PASS      89.26 seconds
TestRunner_bnep-tester        PASS      17.04 seconds
TestRunner_mgmt-tester        FAIL      210.66 seconds
TestRunner_rfcomm-tester      PASS      23.54 seconds
TestRunner_sco-tester         PASS      33.66 seconds
TestRunner_ioctl-tester       PASS      24.51 seconds
TestRunner_mesh-tester        FAIL      23.82 seconds
TestRunner_smp-tester         PASS      21.68 seconds
TestRunner_userchan-tester    PASS      18.12 seconds
TestRunner_6lowpan-tester     PASS      20.91 seconds
IncrementalBuild              PASS      30.06 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/6] dt-bindings: bluetooth: qca: add QCC2072
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#192: 
new file mode 100644

total: 0 errors, 1 warnings, 39 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14713184.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,5/6] arm64: dts: qcom: kodiak: mark PCIe root port as bridge
WARNING: Duplicate signature
#182: 
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

WARNING: DT compatible string vendor "pciclass" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#195: FILE: arch/arm64/boot/dts/qcom/kodiak.dtsi:2299:
+				compatible = "pciclass,0604";

total: 0 errors, 2 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14713188.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,6/6] arm64: dts: qcom: rb3gen2: add Industrial BT UART overlay
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#206: 
new file mode 100644

total: 0 errors, 1 warnings, 139 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14713189.patch has style problems, please review.

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
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.237 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.868 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds


https://github.com/bluez/bluetooth-next/pull/553

---
Regards,
Linux Bluetooth


--===============5683762508607554240==--
