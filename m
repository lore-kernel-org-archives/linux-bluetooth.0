Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523D3EE1E3
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976756; cv=none; b=SrSxtJmJjbhvDi7dYNr4yWDIG2/NptKAls8OXbeDN1+7ghbFda5kxASgRKE3zcRAakBLQcu8U2jInJ6nmJFGsvLOmOc1q/YGHLSnIwCfqETnamn7O8lOFIIMZuwOFk+WwR6HJSNJIqQEbgCGSYRCCB8FtCe15vLzYpin5K4edEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976756; c=relaxed/simple;
	bh=oKKf0ejJG8V9u3+doHQs3u/afTo/4hhCPe7UZhdZJvo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e5Rj4FNMgoKGgcHiz7FxdBZedGYsUInFIpNeV8etPxpfS+FqkNjBg6n7VXHatYEs5Hqzat9pwX1NhsbhAuqLwICmuHxoA60dMNJAiFEROI+Mj+HjCR0EvXzY36RTafxwkcMQhH0aw3cu/xOCYiQCrUGbCGBKpHBD+O4Nf8Yxx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NePx/M+U; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NePx/M+U"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cad8076b01so13474435ad.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 03:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784976753; x=1785581553; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=brsg68vLhLj4zaZjcFzrbBG6gT1iaAqxrPeZj2D1pM8=;
        b=NePx/M+ULaEb2yvmKFLjPMlANLeCHOtRoFvvQx/1Xf+jArUM3ISoPpzFigdPQwNyBW
         YAuxObGRSUq77K3WKba1iU3HDQhtjQazhG41JKwUlFS1dWT4BPG8AfSVOMiJ9vZ4PLwN
         +pGPVKBOgntXxaS+6kGuCYxb3FXS399BRtXOh+qmb0hUIxDE3wIq84Ts17us7g4blLKN
         oTYwPmoYD6MVRqHp6DBpynMBTbHrf3/rGuooeCeVDBcnVBubkBoyhe0JcQQjfe8jEmpP
         HPQ+74VheC7WhwJhP4Pfq9p1QB76fLQstLuARvOznnjTWrcx0rEa6z89Rhs91pDn+odR
         6GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784976753; x=1785581553;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=brsg68vLhLj4zaZjcFzrbBG6gT1iaAqxrPeZj2D1pM8=;
        b=H7EzebdQW19CAtZpgPOuLl1pSccPIgUw0gkIM1YH6KemcC7o2oVMMEuI7Hq3FfOVrk
         dfMKdvtMPdlvZXZ2EliF7pFEzIu+XdTTwFF4neK9eKcBmey8La0UZiyts7TF5Y7wLEed
         oe63lmaJWHbidPareysZhzAOxZhWInOuUNnb4j9nBfzjFep7NHLSqrE+ssFZDwptnPT7
         nnNMF1Hs0hTEgLZarvuAzza8nrpFz7SkTyZAzV5LuStZeT6pvRRBsLJmM+sObNs5rFVG
         BhpqMuhEpHuM4Ae7eYuw1T66M+h7W+7IjfKk8dAy4qRRNl7pEp7GdnXsLZx9zlWq2Bnl
         ri5w==
X-Gm-Message-State: AOJu0YzHA+soLpLpbHz44MF2kdc6r3EPCAuwr/+whkarDkrtnQy8F5ED
	HXUUgZpoCEwe+xM5MWG+YFxOzYWtprq3cECxxxotLK/JzFky4NQM6G1RTEMv9w==
X-Gm-Gg: AR+sD10EbVTZKYPO1A371Egb+tdbUnSQUZjllpaaQDTrDtIOPF/i5xs8mFqshLcZ9o4
	gD1AHlkNfoVcBfm0vopQr+/FTafUNixkgLw8OSHcAUA8/8jSAt0ZDN55jLCV0BzVTwMKQPvcwGB
	p7CnUyKi3zMbISra5w3S6SzmjhnAnibA+eJ2VqZscqcBJ/N9pzAZoE4oBNF/G03HQlcc9sy+jT1
	An+Phlg/ras4Zm347mNb2yB8JtIXVQatuM5dv8xhlaOSn0xGOUZ2MuApIvxB80x4BPAYT8aSD4I
	1qliOcs1amFGIrWyrctw5rGEPgi0YFf5zZArswAVToVR6iI2yHz0kk5mkEcrIrt6+tDsNFhEEbi
	vslW4smUwDMgEcoJVC+/EYVWNrRLBJ1Uzusw1CYI3/3o82Y67CO0LCir5GXgp7fBIYGZrnbVHPO
	c2ugO8Vx/C
X-Received: by 2002:a17:903:1a27:b0:2cf:8131:75f4 with SMTP id d9443c01a7336-2cfde7aa812mr17711865ad.11.1784976752678;
        Sat, 25 Jul 2026 03:52:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1285sm10219874eec.5.2026.07.25.03.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 03:52:32 -0700 (PDT)
Message-ID: <6a649570.83ce629a.320329.e647@mx.google.com>
Date: Sat, 25 Jul 2026 03:52:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3764366260199334847=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: Miscellaneous fixes and cleanups
In-Reply-To: <20260725-generic_fix-v1-1-305aec261a19@oss.qualcomm.com>
References: <20260725-generic_fix-v1-1-305aec261a19@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3764366260199334847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1134336

---Test result---

Test Summary:
CheckPatch                    PASS      6.36 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       FAIL      2.36 seconds
SubjectPrefix                 PASS      0.79 seconds
BuildKernel                   PASS      27.42 seconds
CheckAllWarning               PASS      29.82 seconds
CheckSparse                   PASS      28.70 seconds
BuildKernel32                 PASS      30.25 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      500.70 seconds
TestRunner_l2cap-tester       PASS      60.58 seconds
TestRunner_iso-tester         FAIL      92.90 seconds
TestRunner_bnep-tester        PASS      19.37 seconds
TestRunner_mgmt-tester        FAIL      227.45 seconds
TestRunner_rfcomm-tester      PASS      26.72 seconds
TestRunner_sco-tester         PASS      33.09 seconds
TestRunner_ioctl-tester       PASS      27.38 seconds
TestRunner_mesh-tester        FAIL      26.98 seconds
TestRunner_smp-tester         PASS      24.37 seconds
TestRunner_userchan-tester    PASS      20.77 seconds
TestRunner_6lowpan-tester     PASS      24.06 seconds
IncrementalBuild              PASS      80.01 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[09/11] Bluetooth: btintel: Simplify btintel_classify_pkt_type() by hci_acl_handle()

1: T1 Title exceeds max length (84>80): "[09/11] Bluetooth: btintel: Simplify btintel_classify_pkt_type() by hci_acl_handle()"
[10/11] Bluetooth: btmrvl_sdio: Do not free HCI_VENDOR_PKT frame by hci_recv_frame()

1: T1 Title exceeds max length (84>80): "[10/11] Bluetooth: btmrvl_sdio: Do not free HCI_VENDOR_PKT frame by hci_recv_frame()"
[11/11] Bluetooth: hci_core: Don't treat HCI_DRV_PKT/HCI_DIAG_PKT as unknown type

1: T1 Title exceeds max length (81>80): "[11/11] Bluetooth: hci_core: Don't treat HCI_DRV_PKT/HCI_DIAG_PKT as unknown type"
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
ISO Disconnect - Success                             Timed out    2.152 seconds
ISO Reconnect - Success                              Timed out    1.996 seconds
ISO Reconnect Send and Receive #16 - Success         Timed out    1.993 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.544 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    2.006 seconds
ISO Broadcaster Reconnect - Success                  Timed out    2.714 seconds
ISO Broadcaster Receiver Defer Reconnect - Success   Timed out    2.347 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.265 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.781 seconds
Mesh - Send cancel - 2                               Timed out    1.984 seconds


https://github.com/bluez/bluetooth-next/pull/492

---
Regards,
Linux Bluetooth


--===============3764366260199334847==--
