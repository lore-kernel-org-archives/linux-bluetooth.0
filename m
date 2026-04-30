Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B254238BF62
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580285; cv=none; b=cUo4rGvhud0Y1+vH41WbCnFdEWP4x233e/EMakxzzhIFTBLiu2iF+YVVg7cs0zzU54xis1LxhHlDAvj5/FIamO0/uoVnYwlfG3Fez/yUahXZgCyBT2jeIjSmNxMJa4M2iVidDtnrpgq7pBpEu9ZqjNulMJQHi/7o/8gtwXFwJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580285; c=relaxed/simple;
	bh=tJCdTin1DI9HEXat9qFmvEQQQ0TynpA1zySuqXXczIY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mn8pRCjO7mHukUVxCytN2CBvatXmuZm20qGGVkD9N/Cc5USWZ7QrJWZKGkihQgNqV+cZdzHOU1zB8Les1Ws0z/ymz20Hj0NxSy+nTdgOYE6phM7pCmzjSqrYyTyoe9x1lB15TzRrtYZMbbtOSeIDuGclUvOQf2AZ4bJrXZO8gps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSRcE4p3; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSRcE4p3"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb5c9ba82bso201175585a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 13:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777580282; x=1778185082; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WY4yZfznlUG6LNxdErSEraZZhBp/VB2F1TCNGdiCzLM=;
        b=LSRcE4p3W2rVOO/yO7eggI6X3votZbYbF/miGVaUovcsifNiND4BNcAk3saTRxjT2h
         US0iXv+SEobw6tTEeIjqkJyDXhk6WzsZj2yebrC46YdV/cLsSUjHQ02K4jQSFuU7tZxX
         pQ+FmnjXbrs+twqW5BRja/+stoMImJ/6Cq2Qz7juuwcEayNMJJcJk5ptqPdIrMCM44+2
         4DqZYq9IoNaQxpiTc5UvGijzqB3P6emjfs8x/SX+HI6dxCOPTgdcWn+XaeQUeM/rGsll
         3yNVfVa4wy8D6C6cnftOjUThXRk2BdsXi0n5WvAi6HMYiUTVb3nhCq+0bKzW8sX//tKm
         w2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777580282; x=1778185082;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WY4yZfznlUG6LNxdErSEraZZhBp/VB2F1TCNGdiCzLM=;
        b=rF7YSwLcNK75TWC053vlVPrPesbZBLMR3WD+Jze1fSYysblP+JJWQXcWoB/xmdDLhi
         lYswfj0v/lZjH6+Cv+ubyB309X1rj1rri6xcE1eko7ZfsJCEinvMnE2u/X4nudKXVzIN
         p8iD073rmFdtkIlBayUEoWqzlO15tEgwaHUXKzuT/Xi3fnMYUVkq4F36861sCYBnqhgv
         2tGeTOftUbr9U+xSoAVF6jqKIqv8NiuA2m5lQ0eEvvLciFDa9OkhmoX8p9hkg1BsvKFH
         w1ajNJvdm2/FBC6fb1ayeIGdjFOSPaDCbdfveLFVWl6BmwZ7neNwx3DBNpZxT+jT1UH+
         1GZQ==
X-Gm-Message-State: AOJu0Yzp7b7ZUB+ZrTcb+77CK21k3RCkCNunoGcz72A8luyGuW+NbSxg
	toVWx1GtTICP4A++GmBSxR9IDlyg/KTdXisL7/BU9NowstkQi32asdX27KZD0w==
X-Gm-Gg: AeBDiesHU5LiAOLXaemnHiFqojIABqBBiaaeboKDRLa/VTE23elgYkpNEnf0T7tHRyi
	gAS9Sas44DUrQmX/Bczh7wAnv7nGdcQFfP+BxsEdcKyXxE1CepxAKHRwP04yPN6YkjvOlHMjTb2
	InynmKctjh9Sgm0QpeQo5S2JpbPxJ0pw+TcgyBWyZIwdg9e4uQEvSfzvvxWijvHyUdEExqh184T
	lUBpRWkupO8zsxQXZxrG/DVBLHo4KMlF4mD/WWm8Y7u3sYBBXhnVexBil78p+kDH1kfM0gd2BH2
	AOQuFhFll/vTmOCnjw3PY44tWtV3itS4alnl3lT8SIf8JOpAncw3sLZR+pC0Gw2rX/H12j2snoA
	9JxmibOcH5hEuQxRXt28XvqXnlzjJ5oCoM6oGqu0WgQUOWXh15zZnpdXydb3K8y0nsJVZzHtyIe
	PGfy2Q+h9OxCwyaHrz4NQrdole1VDeJ1vX4V0E6QIipA==
X-Received: by 2002:a05:620a:284b:b0:8cd:c011:fcc3 with SMTP id af79cd13be357-8fa86fac454mr740915985a.24.1777580282383;
        Thu, 30 Apr 2026 13:18:02 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.176.198])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fbf07861a7sm10855385a.3.2026.04.30.13.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:18:01 -0700 (PDT)
Message-ID: <69f3b8f9.050a0220.20bda4.8947@mx.google.com>
Date: Thu, 30 Apr 2026 13:18:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8143058507110862889=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v1] arm64: dts: monac-arduino-monza: Add Bluetooth UART node
In-Reply-To: <20260428025652.662502-1-shuai.zhang@oss.qualcomm.com>
References: <20260428025652.662502-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8143058507110862889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1086526

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 FAIL      0.11 seconds
BuildKernel                   PASS      28.03 seconds
CheckAllWarning               PASS      27.20 seconds
CheckSparse                   PASS      25.80 seconds
BuildKernel32                 PASS      24.04 seconds
TestRunnerSetup               PASS      519.97 seconds
TestRunner_l2cap-tester       FAIL      6.63 seconds
TestRunner_iso-tester         PASS      295.81 seconds
TestRunner_bnep-tester        FAIL      6.66 seconds
TestRunner_mgmt-tester        FAIL      8.83 seconds
TestRunner_rfcomm-tester      PASS      29.08 seconds
TestRunner_sco-tester         PASS      68.28 seconds
TestRunner_ioctl-tester       FAIL      37.35 seconds
TestRunner_mesh-tester        PASS      27.08 seconds
TestRunner_smp-tester         PASS      6.63 seconds
TestRunner_userchan-tester    FAIL      6.65 seconds
TestRunner_6lowpan-tester     PASS      22.89 seconds
IncrementalBuild              PASS      23.77 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 0 (0.0%), Failed: 11, Not Run: 17

Failed Test Cases
Device List                                          Timed out  -30.845 seconds
Device Info                                          Timed out   -6.203 seconds
Reset Stat                                           Timed out   -6.207 seconds
Set Link Mode - ACCEPT                               Timed out   -6.209 seconds
Set Pkt Type - DM                                    Timed out  -14.393 seconds
Set Pkt Type - DH                                    Timed out  -14.397 seconds
Set Pkt Type - HV                                    Timed out  -14.399 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.402 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.404 seconds
Set Pkt Type - ALL                                   Timed out  -14.407 seconds
Set ACL MTU - 1                                      Timed out  -14.409 seconds
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/138

---
Regards,
Linux Bluetooth


--===============8143058507110862889==--
