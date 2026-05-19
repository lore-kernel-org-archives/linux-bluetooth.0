Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D434040D
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196618; cv=none; b=qxwtHIda+VA57TpANEM1xZZwqLYmqGkd3klqn8Kkn8qjIKX6SPFnhxP4UFPCnCCQTGq5ySmhxI1zEion0iToCggSFpzSqPfCPz2OKBnbtEBWqAbcldsb18bhsg6EspY573hP+kdaccnZazPpvzprtfW99+1farNALXCOXFgPd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196618; c=relaxed/simple;
	bh=HgmX1PjFsKDhW91pyAkSNhCEcrCaVaHaX74U7EqZGk0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XDYbxQz5bnuomgMQEAjn6ebPLLqVIwxXRXEDjeUW3umOzT5FHhRORTDMmKvKrVNlwQaDPeOddN2r3CFzzSCny5DdzRrzdlSV9qzWSvESVcPvSZvwdF09KbEDOXnqeyF/9+keVEBQ5OKWL8CbdApx6LwGnOK+2QmPPUrupBweE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeTJyxYc; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeTJyxYc"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so13006195eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 06:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779196615; x=1779801415; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b7qV6NiuMSiaHpHDl/bkupyQpjbqy2mcFnlFfMwQCVc=;
        b=IeTJyxYcSUtBfu0IWsSPeTIpWvzd0FxENAGDhk+GgLgg86ODo8FivTEhqmOl6VhyLv
         3oUpPIDlowy/qftRkKQcTMuzPEjGxeSO9MlTadfLUe3guTNd75BGvO48Jmy4L9VaUWTZ
         JL1fefvu1plDZQjLsU385bVTcC1qzNLQ9cvIw3skS2d/PKjYNyy0LvzphcY6/EoVYaKQ
         DhbNff4kCLtoGvFbbcjCMIK4M3Gi0N9J7zfXWWGZ9yehILPx+if2MeBhEZDlgJgt9MKP
         ht0vWFgtMHJ+/tRdw0S2z5sZdC59UA5yGlcl4TUaHNWCxUsvX7+8Gb30f/RUQeM1NqKW
         IfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196615; x=1779801415;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7qV6NiuMSiaHpHDl/bkupyQpjbqy2mcFnlFfMwQCVc=;
        b=KVZ7HNLqDs7qz/Vkc6704gSw3oYsTb/fb45YuvJoK8NhCRxgpEdTjr4H9fZKR4j07+
         rvTbDtGvHTobP/mA4HTxh1SOEt7vYm9L1QKMeO3oltTFHzXjdq9K0Wk9noACvwApHZjP
         hFrpcwTsWYP5KuVMuk0IYijJ0+Q4Ks3reV2w6X9vXvIkn2tCpj56NURwOhv/PvEuqTBp
         dVCJWnR5DhJ5q0JTq42GPGkLKjChReR6ZZ8sf9yGjEjpEYfMaZVXjBjWI+BVjctnkYBC
         c49Ao5R9UsxtM5RNQ0hh47sQJ3xn1befYZtifgB8vpNhLWKq0pEQjxUIGqFHPbL3P2Nb
         XYHg==
X-Gm-Message-State: AOJu0Yz4gRKrWw1Of0DPq6+KtuLkxufRBYQIeVrEosjQy35xodabBmDL
	jubVMccUt/qRl4guixW6qyWIbeVpYcJSkgae9mK7f3rZsxG2n8AW21cNx2Nstg==
X-Gm-Gg: Acq92OHQhnJ0DIS8cBFLI8GULp8BBCWsBf+Pv9Kdg/fzAvumDdFczxnSy61f/DWi7R1
	TCgHNcTvm7pUixFAbcrInWMpICd73Nawtuv+NraKEAY8V2G97bgF6OcC2f+CB6yvfzHPQi6YjWE
	0YXr1p/nDd/Xqax+D3kx+nF8QixdslNZc5iudMmhnbaFrVjrLwXcfTm+siazMksLOc6DBrO5mN4
	1urNoSSDKqoVXm7FlrS3eYri9c8MXHrRE2cAqNtP358Jf6GZMm5JmHvcw+x/aMvrDm+7+1DbetX
	WidpkJ2h/t0acFICrtnIDccX2QUDAcPcd1llgwTJxvI/ERooq2FRMQpm6OaJrF104iOw7JF5fE+
	ci9a2i8QeoPd/930h97HIK6ApilZkl2g9vYdNI26v16ZhXsTC/N4HqZJp/M/R8uKgt0uW74d8fO
	q0HJGKtn7wofWYsaAqCa7hKZGbqOHObEw=
X-Received: by 2002:a05:7300:d706:b0:2d3:f43c:d684 with SMTP id 5a478bee46e88-30398191408mr8639226eec.2.1779196615021;
        Tue, 19 May 2026 06:16:55 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.211.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6f6sm20578936eec.17.2026.05.19.06.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:16:54 -0700 (PDT)
Message-ID: <6a0c62c6.d08db960.4b0d5.e8a6@mx.google.com>
Date: Tue, 19 May 2026 06:16:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1825991424141285688=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com
Subject: RE: Fixes/improvements for the PCI M.2 power sequencing driver
In-Reply-To: <20260519-pwrseq-m2-bt-v3-1-b39dc2ae3966@oss.qualcomm.com>
References: <20260519-pwrseq-m2-bt-v3-1-b39dc2ae3966@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1825991424141285688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1097194

---Test result---

Test Summary:
CheckPatch                    PASS      5.38 seconds
GitLint                       FAIL      2.04 seconds
SubjectPrefix                 FAIL      0.68 seconds
BuildKernel                   PASS      27.13 seconds
CheckAllWarning               PASS      29.85 seconds
CheckSparse                   PASS      28.89 seconds
BuildKernel32                 PASS      26.11 seconds
TestRunnerSetup               PASS      577.16 seconds
TestRunner_l2cap-tester       PASS      378.64 seconds
TestRunner_iso-tester         PASS      597.42 seconds
TestRunner_bnep-tester        PASS      18.52 seconds
TestRunner_mgmt-tester        PASS      2022.79 seconds
TestRunner_rfcomm-tester      PASS      63.23 seconds
TestRunner_sco-tester         PASS      141.44 seconds
TestRunner_ioctl-tester       PASS      133.59 seconds
TestRunner_mesh-tester        PASS      60.51 seconds
TestRunner_smp-tester         PASS      18.42 seconds
TestRunner_userchan-tester    PASS      20.59 seconds
TestRunner_6lowpan-tester     PASS      51.38 seconds
IncrementalBuild              PASS      38.82 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,2/9] power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[v3,2/9] power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices"
[v3,4/9] power: sequencing: pcie-m2: Create serdev for PCI devices present before probe

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[v3,4/9] power: sequencing: pcie-m2: Create serdev for PCI devices present before probe"
[v3,5/9] power: sequencing: pcie-m2: Create BT node based on the pci_device_id[] table

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (86>80): "[v3,5/9] power: sequencing: pcie-m2: Create BT node based on the pci_device_id[] table"
[v3,6/9] power: sequencing: Add an API to return the pwrseq device's 'dev' pointer

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v3,6/9] power: sequencing: Add an API to return the pwrseq device's 'dev' pointer"
[v3,9/9] Bluetooth: hci_qca: Set 'bt_en_available' based on W_DISABLE2# presence in M.2 connector

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (97>80): "[v3,9/9] Bluetooth: hci_qca: Set 'bt_en_available' based on W_DISABLE2# presence in M.2 connector"
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


https://github.com/bluez/bluetooth-next/pull/215

---
Regards,
Linux Bluetooth


--===============1825991424141285688==--
