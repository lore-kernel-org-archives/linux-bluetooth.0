Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50481DF27D
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281482; cv=none; b=TwWDrYRs891nlNMBOJXk3XHvWMXLWCJJbw/BTSxu5PF6wIeHxp97zKWbB4AQq0Voz0brGCJr0vuwxT3cjDb37IdjOdyPpoXMI5KSucNsOW5BWM2Hg1Qt5ZEvq4VjSDG4JzaYbn8b6YB7tNJKVQs1GNztAttrwq7jVhEa07xCLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281482; c=relaxed/simple;
	bh=BYjoNcK9md1bedKChF8zttHPF6fpDL13Ti7bmGsql1E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ptgF7b++TmXlydD4SVVTKNfOao2HpA0IpY6b4UkrzcZf0tSi7nG2fNGzwl4u5bNjUoWjTP+5jEtm6RhrLjtIUD872XVjsWHl1ZaVOnshR7X3FmEgaRg6qCc0hbvFZqh4xQY+NnjnBmRYr7auE6J+TJqqyU555X6wxZCaIDZeM7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atBudRX3; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atBudRX3"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3042a388168so1248400eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781281480; x=1781886280; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mC8w0ESlPMdPVl400sCx0WQy80PDKlKPaVgjgCRstYU=;
        b=atBudRX3eUn+fDBQQ2452LwGdt6JbJnfHpqo52ooxPZYTZL5U7AMYMj1fQP01ZzXa3
         ny5/tpHf6ZJAfine/iKW8c4nttxo8iJ6yj5QocqwVqpKsbiMaBW6GbEmnkZFrxx0gg97
         UgoezipF+0tFKMo3ZnhOHKAgsQuyBnqxeSxEKYyu655dwxY33Kl8CGFTr5odb7vqb2nd
         xiRi46LUHYv6V6XBqY5blxf5FUR0zfqs7BI+EkyQqQGbVyTEg8t1vqGSTyRKDUlieHhu
         MpKnA5fC5bp3rqftm+ityGNlxgaPQFU0RolPP+J9JvK3LcMyT6H6GAlLKr4Rh6sp1TQK
         CksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781281480; x=1781886280;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mC8w0ESlPMdPVl400sCx0WQy80PDKlKPaVgjgCRstYU=;
        b=sgTXyO3e6H8U4Wh1t7NvPSIyDHHiwAWyq1cwbg8UaCY3rkFv4fouNqITkgbEI60p5y
         RVC8Ti2eZHz+i8v1cgjNuaztwndXhr1BP2vGo1grfinTrLgUKUelXefOm1mIqYAo+XVm
         45p4ZGNnThGmin1J0SaJTuQcsDG9kznhppcqm3KOmaQuVeMB8aobMLtltKQGAWh7dHOD
         6k57Au093FI67pP4FqYmxg6sEPduaXkut6siRChZKJx5XmaWU6ZCb238JOmPp4QV4X0f
         Ov99eaGctHrtKaNk1C1U5BJxT2uUVHI0xHYKGYGMYNwhbZCf81YsMt5k67Xjz/bJ1lhK
         C1EQ==
X-Gm-Message-State: AOJu0Yx0s3ModpC+4oW6LHmL/WyBohohVrjDXuc6A2mHRW0vvcKpgWCU
	2w2b46dT7aKwY9N2TWzdY/1Dvzz/ZT/lQ/ra4d5xHolm2h5ax5M0XTDZH5kwhg==
X-Gm-Gg: Acq92OH6wkH33GeY7B2M0ph1/WeDmnMWXZ54MsLOm1tez2IqcB8DL9DkOBgBtVBnz/j
	ythIWhKArjVPh9WX5FPJ+3ZPyxcgjHXQVVOs7BRh9x0hLhMy7zBw8rQhtUgkMpSxDghbFVBqk7h
	tLuKF1s1CIoKljQSmgE3dmzfmbtycugcpzLML8BcgNKFobMVclYYqxuc6iYuFxdOo+IQIbN9SoY
	KtaTOvjB1f6NnohEw+lp//WiKsSLBSst5CVVndPeOGOFktpol16xZvX4yMgJKQjEeOa6wNGuVHi
	PTwTEdhm+NjTJ2QBZ5oUoIy+ps+vt84RIHTEoxQ9HVDcz0QVUuJsk+26N74P0kfUGonfO73Nn4F
	czpTuzr6Iks35L3WRhUKr6AwJy70vgGwonQ+oWZmun7dfQJOLmwL+QxmnXMtiSvFL35Kc+u3vk+
	uGfMz8N7roMG5Z1NVqMpEh7hQUSQCX8oX8rMcHftej
X-Received: by 2002:a05:7300:642a:b0:2c1:67e1:61a9 with SMTP id 5a478bee46e88-30820cf444dmr1644747eec.13.1781281479854;
        Fri, 12 Jun 2026 09:24:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.53.180])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e4898c0sm4176441eec.3.2026.06.12.09.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:24:39 -0700 (PDT)
Message-ID: <6a2c32c7.4a342cbc.316e90.3f1e@mx.google.com>
Date: Fri, 12 Jun 2026 09:24:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3402763532386686968=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: Support for block device NVMEM providers
In-Reply-To: <20260612-block-as-nvmem-v5-1-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-1-95e0b30fff90@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3402763532386686968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1110666

---Test result---

Test Summary:
CheckPatch                    FAIL      6.99 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      2.10 seconds
SubjectPrefix                 FAIL      0.68 seconds
BuildKernel                   PASS      25.13 seconds
CheckAllWarning               PASS      28.06 seconds
CheckSparse                   PASS      26.89 seconds
BuildKernel32                 PASS      24.22 seconds
TestRunnerSetup               PASS      522.99 seconds
TestRunner_l2cap-tester       FAIL      57.69 seconds
TestRunner_iso-tester         PASS      82.59 seconds
TestRunner_bnep-tester        PASS      19.28 seconds
TestRunner_mgmt-tester        FAIL      207.46 seconds
TestRunner_rfcomm-tester      PASS      24.85 seconds
TestRunner_sco-tester         PASS      31.83 seconds
TestRunner_ioctl-tester       PASS      25.95 seconds
TestRunner_mesh-tester        FAIL      25.88 seconds
TestRunner_smp-tester         PASS      22.98 seconds
TestRunner_userchan-tester    PASS      20.31 seconds
TestRunner_6lowpan-tester     FAIL      45.85 seconds
IncrementalBuild              PASS      67.81 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v5,5/9] block: implement NVMEM provider
WARNING: please write a help paragraph that fully describes the config symbol with at least 4 lines
#209: FILE: block/Kconfig:212:
+config BLK_NVMEM
+	bool "Block device NVMEM provider"
+	depends on OF
+	depends on NVMEM
+	help
+	  Allow block devices (or partitions) to act as NVMEM providers,
+	  typically used with eMMC to store MAC addresses or Wi-Fi
+	  calibration data on embedded devices.
+

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#231: 
new file mode 100644

total: 0 errors, 2 warnings, 172 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14626125.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5,9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

1: T1 Title exceeds max length (85>80): "[v5,9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses"
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
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.249 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.236 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.479 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
Total: 8, Passed: 3 (37.5%), Failed: 5, Not Run: 0

Failed Test Cases
Client Connect - Disconnect                          Timed out    5.433 seconds
Client Recv Dgram - Success                          Timed out    4.987 seconds
Client Recv Raw - Success                            Timed out    4.992 seconds
Client Recv IPHC Dgram - Success                     Timed out    4.997 seconds
Client Recv IPHC Raw - Success                       Timed out    4.998 seconds


https://github.com/bluez/bluetooth-next/pull/307

---
Regards,
Linux Bluetooth


--===============3402763532386686968==--
