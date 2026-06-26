Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081A1DA0E1
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463161; cv=none; b=bvQeeUS0GCaM22UxKl+fVq/QEfiyKmOhRtTZK2rTZG7qNAGR5LRprBb/XNV/rFSFe6zEm241F58cvxwpHso4Hn6MEkgolUY/CHHeG4bY9cWSLjyycfNxXgV9ZBMszWQFJTtbPudFoGiGgSYsZa+W+qFN4UFU7QqRMub9Bg+Y9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463161; c=relaxed/simple;
	bh=ejoiUeHue3lCltkh0TZsZp360yRLKxUEEsbptY9lVvM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=htVaIlsSAjtErCOh3ijaUiZlozreQK7aOCwl0pUr2IVJqNotyyM6SEqPruk6JNSsKCQPeboXA8au9IJcnuN0aPL5SwR/HxMpc4nqyDqUpfCqIFohbopUGtDGf1iBT9fhcTJB+eBJoJCUZxO6Q28RgRCilbWMCgQz2DN1RnKda5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKPvJE2K; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKPvJE2K"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-139a5f4ca15so851067c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 01:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782463159; x=1783067959; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CO72VQsPQVSFv1W05y18v2AFxaV3yOoXi+XmzmeaE1M=;
        b=JKPvJE2KMzu9zPcn+PqMDA0wdIpSDFFurKk+byCcw6icSlG/AxO/ze2xA/8vEX08ol
         pGJpmhZ/+ZufiJiqD1xQahSHTJ9QdqQvsUpumIc65JCXUYFPUoq2KAFdJTaHuzNcbYGI
         asH7Qq/dEcyMg0iw9DbkjqVkbB8bDKDN6ddxAOcscmDB5EIZrCRFsP93QHIjTP1VX2VD
         GMM/Uk288fypVJ1eVFFQoI+JfiTQ/GbV55WAcPYZQ6oVi1Hu0ioueVXFl56kH5QqmqNN
         qg/8CmDHb0vJTdWXUV0MKQ6/+lnw6Ew690AVsYEXsmYPEaWSaZLfz6tBjlp3p/P7+8ML
         5Nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782463159; x=1783067959;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO72VQsPQVSFv1W05y18v2AFxaV3yOoXi+XmzmeaE1M=;
        b=s1P9kHAZL1NSXeHhNd+xvfEjW+hxS1KJXVNwKQsDcTJM2g9a2TnYAqBh0J4kM1FdXj
         AS2Qf/+8Neava0j1qSo3AUAqteYk4r8LjZ2YYiMFp3AVNensyXttHkKoidQ+qwYHLOcV
         T0Pg54tUpmxAfpAqPKwb4qRcqpRlhIPwqkEQ+AkIBAQU9V7Yn79LvA+b77FxutmboFM8
         oOWmh2mxfsKyo8dDxGL+SrOFoscGO5vRPKP64bPe24ePGuSDnsEW02zUwlKMgjotFLJi
         HbcTomnGSAvfckKWHkGj/Bsi1feDkINDpePO51qIB2Xowf8lsHYL7DMrLdVbjnp4KajU
         w98A==
X-Gm-Message-State: AOJu0YxJPTzySnczYdgM7IO+Z3MU/AmtIrGQmkJi0Va6A7BpgnSiMebn
	zVbTTIUXf+QJxAynLqC3WmBiGrVGZD0PYeweEVtUydJzsh8hhR5v9jDTYhZj+g==
X-Gm-Gg: AfdE7cky0/8s0SEU1LX5AERdTWzy3K+1xCK5sdKCTQUQ5ewgS0eO+ush1P4nLeQmLay
	aaFmD3Ril8HE6i5oU956UL8SwD7rC13SY6M+Hj9nOS4tVt9gqHjhOJuVheI6MSF94r6XqzTxsW9
	wqXy1UTMPAO6FU+aZSa37cl4eYXYYuUWbi0gHlXGgC39Llou7lXsSpt/8SpXdLw5AnBVwPDcYbO
	Uyn1pQT8WgwkvChZLPfCKcZY/PXE5AFqlii7B3OyNpiHKS7KJjQXXRQhQWSUtY7mkexBcuO4Eqf
	4OSTsDI9tOG8je0pOEmoPwBYJw1Ekt4wjxRbtLmxEttkaTVJ/14KVuxwjH8Pjdcdrd5+j/yjxXg
	bZIqJdu0TOPVxTTFrYjFeD/3H4Lu9+yPCuddmPV4341VlZ6nTEZu33zGY5lYGiZcYr940EVkOYE
	+gLsU8vXDtkKghmMJ/KO4=
X-Received: by 2002:a05:7022:410:b0:133:3bb1:8d40 with SMTP id a92af1059eb24-139dba6db68mr4704838c88.15.1782463158685;
        Fri, 26 Jun 2026 01:39:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.151.118])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139e78317f3sm2120410c88.9.2026.06.26.01.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:39:18 -0700 (PDT)
Message-ID: <6a3e3ab6.331483e7.b2c6.6a4c@mx.google.com>
Date: Fri, 26 Jun 2026 01:39:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1069128489825856229=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: btusb/btqca/hci_sync: Clean up btusb and fix several bugs
In-Reply-To: <20260625-bt_bugfix-v2-1-93396a6f7d5e@oss.qualcomm.com>
References: <20260625-bt_bugfix-v2-1-93396a6f7d5e@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1069128489825856229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1116853

---Test result---

Test Summary:
CheckPatch                    PASS      14.56 seconds
VerifyFixes                   PASS      0.39 seconds
VerifySignedoff               PASS      0.30 seconds
GitLint                       FAIL      6.75 seconds
SubjectPrefix                 PASS      3.22 seconds
BuildKernel                   PASS      26.93 seconds
CheckAllWarning               PASS      29.60 seconds
CheckSparse                   PASS      31.00 seconds
BuildKernel32                 PASS      25.89 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      503.08 seconds
TestRunner_l2cap-tester       FAIL      60.66 seconds
TestRunner_iso-tester         PASS      80.79 seconds
TestRunner_bnep-tester        PASS      18.64 seconds
TestRunner_mgmt-tester        FAIL      206.27 seconds
TestRunner_rfcomm-tester      PASS      25.66 seconds
TestRunner_sco-tester         PASS      32.94 seconds
TestRunner_ioctl-tester       PASS      25.81 seconds
TestRunner_mesh-tester        FAIL      26.24 seconds
TestRunner_smp-tester         PASS      23.77 seconds
TestRunner_userchan-tester    PASS      20.22 seconds
TestRunner_6lowpan-tester     PASS      22.61 seconds
IncrementalBuild              PASS      73.79 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,02/12] Bluetooth: btusb: Fix BD_ADDR byte order in btusb_set_bdaddr_wcn6855()

1: T1 Title exceeds max length (81>80): "[v2,02/12] Bluetooth: btusb: Fix BD_ADDR byte order in btusb_set_bdaddr_wcn6855()"
[v2,04/12] Bluetooth: btusb: QCA: Fix populating devcoredump fields on unenabled devices

1: T1 Title exceeds max length (88>80): "[v2,04/12] Bluetooth: btusb: QCA: Fix populating devcoredump fields on unenabled devices"
[v2,07/12] Bluetooth: btqca: Simplify qca_send_reset() by using __hci_reset_sync()

1: T1 Title exceeds max length (82>80): "[v2,07/12] Bluetooth: btqca: Simplify qca_send_reset() by using __hci_reset_sync()"
[v2,08/12] Bluetooth: btusb: Simplify btusb_shutdown_qca() by using __hci_reset_sync()

1: T1 Title exceeds max length (86>80): "[v2,08/12] Bluetooth: btusb: Simplify btusb_shutdown_qca() by using __hci_reset_sync()"
[v2,10/12] Bluetooth: hci_event: Log error for HCI reset status error in hci_cc_reset()

1: T1 Title exceeds max length (87>80): "[v2,10/12] Bluetooth: hci_event: Log error for HCI reset status error in hci_cc_reset()"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.268 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.236 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.456 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.604 seconds
Mesh - Send cancel - 2                               Timed out    1.984 seconds


https://github.com/bluez/bluetooth-next/pull/354

---
Regards,
Linux Bluetooth


--===============1069128489825856229==--
