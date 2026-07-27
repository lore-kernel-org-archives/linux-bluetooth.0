Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA63E866B
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143200; cv=none; b=hv8g9hKyuxGcirNCahCd0E3uXKRSUoLPfQweNKzemxA1OPL7wFMBiHUGm36OHjCLz8XOXDBOtdaVMHBP2EbTdz1W/QmeUOZiK3TvHGhmVtN35bI/Stp8tPhIFz19vyxL1V5JtiEc9HwPv06490ai5mtMIam8hdH/FswdprENa44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143200; c=relaxed/simple;
	bh=N9j9yUpmPN7u78zi2aXxiFqu/evUDyVQFFKnGZ98kUw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TRTdAxXmSF5Mg2GN06L7tuBqBPaePmxsLRgy2yISW6aHQ2XhGqtecT2uyqIm/S1xUCyG45uowmelAeQcEBUeEWvCVkrYAWZuCCfTUk5/Xv9Q8wq3R970TVE8ZFqphYXYPetMaw2IrcFkISkwt2Ol0CqdEOJeZvVfP6t6ZluTdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT+cloB/; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT+cloB/"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f0d6853360so20230986d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 02:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785143198; x=1785747998; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YFKieLrCAuCezawCxCcAqz4pDXSpnKxXOu0cVUQS3qY=;
        b=dT+cloB/T6nSO/gg95mT8pGPFaV21ped+rFnLEdXWpWBbJSeJsRpneKFwQD8fdUo2u
         iE01fMS9q9aoxSTxj0VUaOTDlJAcEgjKygRy/Q+/nQ1J+jMYW9qqNviYDwSde12MWQsR
         V1gjqESxxCYCgE6hFkXijvCu+iIWVnEmlXbWPyh4JnTE7DKdvfou+LzXVVzpzNhiKwO9
         EX0nGBCPiYV9v7vE2+Ut7hjNClSbJr8zSolJW0xs1VJVPoFjlblKL7wLPBh1QLEzxHYV
         tcmdjKx7xQtSBo8noUoSr1Bdr89ro6Zt+PyHC4sGea4PFrboI6b59lDegir828XWMrnO
         qDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785143198; x=1785747998;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YFKieLrCAuCezawCxCcAqz4pDXSpnKxXOu0cVUQS3qY=;
        b=arsgkYFZbbGWrIiLPTkD5Ys7RITJfViAjw8tP46/xO6iqiyO/NJ7PtnFdP7gQ2sAom
         NICC0lnHEevhZ6tJVnq2hx9L7W9VW3isOaxK0HETD6LKCWfhabHFM/4Jt8v2SkzyO/df
         i2zyUfwPI15isRAxyfNyG7VHuO+0ETau/ZGv7hiRpdPMN8S/QQ9Ya3Ulcj6xz5kHaEws
         Ae9Pw+1+3WppwSFti9MXdGym1md3pYTwTP2fAnCZ6vN/j5ZSfSbsN76HeAHDECqGRitn
         qTvbPcg/CK6dkFRJ0cT0rUJiRJyR9mYFShe1fNmrPugtypUst/LfNKh+oXi32P9gtrEP
         LPcA==
X-Gm-Message-State: AOJu0Ywm9RFATMVten0rMDBQnomnXelIyQuKl/VIMyl3nDJtI1XZMnYx
	I9biu051uLNsMNYYQtSMI8w8U5Zza+UBiSheljgxbepip9tSGyS1wld38w/tEQ==
X-Gm-Gg: AR+sD11It4yrkK/xPyjdWr8H8qsaCuSV0VfMkW0re64oN5bp7g0bq3XEFkD1+oFtWUn
	ARAsAyvR8/LtL/yWWCDCRm2YUAF3PIkS/PiOqoviiDHHDOAWUASRVx9cbOmieWR2himF1XJcVvd
	+pnrbUSWmYjBXg+qS2KJEHOCRsCUSmTIOTudTrjthTzCArNUKTPuzSWx9FSBCJKXxtplpk/lNXX
	993l1g/0qBjlzUo2liE5jEizgHXE6rb08KTdut1XeRO6Z3CYrP9DmAvN+WC/eygWvK8XJfPUoPe
	8TblvoFcbxE4rVB0t2+SO5kAERjFPwkr445wUIj+2hDze4dyccCXdjA2UJMGBiKwBwilL0mbXfA
	aozq42smWcHFXTDp1hA/u5XNwHl2U3LSsCPqcYlwHmOqd4BBAOpYjJ4RQlAaEvM5ymXQhEKYcIJ
	G/oHVSn0KZYA==
X-Received: by 2002:a05:6214:e82:b0:8ef:ec2c:6b70 with SMTP id 6a1803df08f44-907ec8ff643mr86077416d6.53.1785143197787;
        Mon, 27 Jul 2026 02:06:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.44.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e85215d7sm60967886d6.9.2026.07.27.02.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:06:37 -0700 (PDT)
Message-ID: <6a671f9d.36695ec4.392fa4.e850@mx.google.com>
Date: Mon, 27 Jul 2026 02:06:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2706297734095275178=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v6] Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs for PLDR
In-Reply-To: <20260727052104.1026824-1-chandrashekar.devegowda@intel.com>
References: <20260727052104.1026824-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2706297734095275178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1134881

---Test result---

Test Summary:
CheckPatch                    PASS      1.19 seconds
VerifyFixes                   PASS      0.43 seconds
VerifySignedoff               PASS      0.57 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.15 seconds
CheckAllWarning               PASS      29.94 seconds
CheckSparse                   PASS      28.33 seconds
BuildKernel32                 PASS      26.38 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      498.11 seconds
TestRunner_l2cap-tester       PASS      60.57 seconds
TestRunner_iso-tester         FAIL      103.03 seconds
TestRunner_bnep-tester        PASS      19.12 seconds
TestRunner_mgmt-tester        FAIL      217.79 seconds
TestRunner_rfcomm-tester      PASS      25.83 seconds
TestRunner_sco-tester         PASS      32.01 seconds
TestRunner_ioctl-tester       PASS      26.13 seconds
TestRunner_mesh-tester        FAIL      25.91 seconds
TestRunner_smp-tester         PASS      23.73 seconds
TestRunner_userchan-tester    PASS      19.71 seconds
TestRunner_6lowpan-tester     PASS      23.13 seconds
IncrementalBuild              PASS      26.09 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v6] Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs for PLDR

21: B1 Line exceeds max length (81>80): "  - Added ABI doc at Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 141, Passed: 134 (95.0%), Failed: 7, Not Run: 0

Failed Test Cases
ISO Disconnect - Success                             Timed out    2.673 seconds
ISO Reconnect - Success                              Timed out    1.999 seconds
ISO Reconnect Send and Receive #16 - Success         Timed out    1.993 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.246 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    1.997 seconds
ISO Broadcaster Reconnect - Success                  Timed out    2.764 seconds
ISO Broadcaster Receiver Defer Reconnect - Success   Timed out    2.293 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.246 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.267 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/498

---
Regards,
Linux Bluetooth


--===============2706297734095275178==--
