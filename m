Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB02DEA6B
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778344; cv=none; b=leH30B3jaKPQBveB2S/Eo41yNez2JWB0Z9lSW5ncGWHX4Nx/MtKfmJfXCfgpM3bLEPHwwLvVvhC3Ol8lkYZZetsK8mf+aTB+Rt07JdJdohcefL47U2hmhqAXj6HFRcz0rhdDm0xIhqvLyImP2Wn5s95UbvuP6iAr+Oo7P1p8Vwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778344; c=relaxed/simple;
	bh=yskryxokDTBN/oBKxzcucuNDsX7i2fU8nGS7uWAZ6+U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tZEjTOpvlhjxWAwfhx2H5s4b4FtQhUDLGRQ2FVtVMUKFiAc9DQezEiGZUj+qyc2xag+uaQ5dz/bnwlgapZHpBmf05jKmJuiEuEuf+UYl3oBtweAl+B0TAjE65a5POh+5ByM+3yix0WdXA/oEHKnrImzfjZFMAp1TBzYWDwjRv8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwqPTyvC; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwqPTyvC"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30bbe98c3f0so382690eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781778341; x=1782383141; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EpFyTNgQBtP7GUs/HfBnep+JtHge2F3La7+q+xzs608=;
        b=MwqPTyvCzLouaihJZcO4Fkd+oHP+AMu9mYJy98o7ZlTrm4rhDBtnez8XsPQafl+pCy
         cOS9DNk6OnKJKkAH4y2MRasZyc2Eap+9AUXQrBucoBKWiFb626VgEAYNLZ48qNHLprLe
         70snoR9iJt3RkPGMUYWqpEeML4HXk6O1FBi+BG/ZC5YcwVU42nLru1Wv3T0M6JPKWOIm
         7ijKB/uiSUE+FA5G/kw0bVjAoxcd6IudIu2cJSfST2J1402lM3eHk5hu8oD9PHKkyzCW
         oR9Qr0yiyXwRgJlL0rSXWZo7tyw8Te0INs8rVHDMHRVe7Sy3/xHei+BzdIm9hSwh6WxW
         svCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778341; x=1782383141;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpFyTNgQBtP7GUs/HfBnep+JtHge2F3La7+q+xzs608=;
        b=BnXbxOZaB55djLVoeYlzXUnuLdPlssglgKebA7pdGV07LVdAcdoNkbLfMyMG8MLpFo
         S7ZGNYotBc+cyawtuylfon7dOe/gEIl4Zvt3gsU7KuYZibqslipqMnxe97HNgX1NHMoc
         7oCV2sMvdN6nCye1HsNNpSDUzuSNZBCb94WQujbTsiuw+MlzlUmtH1DkRUERbe+n/buw
         Xu4N+ceYaG4IWVLvIpkgEh9XaSSRlkQG1jGfFBugeFULGlBtrw9cbdpihAF8zxR7IMXi
         x/2x4SF4E+aE3eB6aAS8WC2CTVEFA8tp7u82W22MHwz/E8ZpFFEWJDdcHWDiJHbAl7fX
         ZVXA==
X-Gm-Message-State: AOJu0YxScCp7GMhyLb9hM4UT1phjcYOChXe5+KwFaiGf4/yw0wrlXchA
	LjGHvl5CKozKk/c4cCSKKpYXlaZG6pqu95o0FelfnEfkDV2lJwq+9GJwwLSMmQ==
X-Gm-Gg: AfdE7clDmpVGAC1HBFME8kZ1PmzZMQCaVCd5R8UaOMOH5mBuy/uJaJxAbEToY7mO20m
	VftBfcZWwoL9dGM46XJdYpnPDXnnrVRIpsl45NojvZLCGdYMDJ9WqDMSbcbxtq2IbVRA/PDnBbW
	3rYyv35/ACSY/Bc9ajgZsvdcad9fkV/p75D52lEocpHVW9HRS/yb6CP++V6uRyJ51snEGxEts67
	/Xz+o2RbWKTYayJ+EnzJAxghF9rJd2PTA5a1a26UTHPqOSuUknYgleUY+wPRYHbATUur7v7tLko
	N6A29pDxVmBRXvJcE9ZbBGz79VU7VSiCLk3xaEVQOWjxqg63QgTC9SYdsrw2AcivcFNumjAE3Zw
	GhTYS7Gb9eOesfw/fnyxCeJHyE8PUtHhEp3LtlhLlI18uXUVAcMWFqzbQfKpULFPwfGjVZMoXKs
	OBrdi0603YiMg3w8caZM/z
X-Received: by 2002:a05:7300:bc11:b0:30b:fb9c:f8ff with SMTP id 5a478bee46e88-30bfb9d0809mr756282eec.6.1781778341325;
        Thu, 18 Jun 2026 03:25:41 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.167.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e92096esm26280778eec.15.2026.06.18.03.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:25:40 -0700 (PDT)
Message-ID: <6a33c7a4.ccb52036.2c1070.093f@mx.google.com>
Date: Thu, 18 Jun 2026 03:25:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6761948228636108030=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v2,1/2] Bluetooth: hci_core: Add reset_type parameter to hdev->reset() callback
In-Reply-To: <20260618085016.9173-1-chandrashekar.devegowda@intel.com>
References: <20260618085016.9173-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6761948228636108030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1113309

---Test result---

Test Summary:
CheckPatch                    PASS      3.18 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.40 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.91 seconds
CheckAllWarning               PASS      30.25 seconds
CheckSparse                   PASS      28.70 seconds
BuildKernel32                 PASS      26.46 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      581.35 seconds
TestRunner_l2cap-tester       PASS      58.38 seconds
TestRunner_iso-tester         PASS      92.91 seconds
TestRunner_bnep-tester        PASS      18.82 seconds
TestRunner_mgmt-tester        FAIL      208.89 seconds
TestRunner_rfcomm-tester      PASS      25.41 seconds
TestRunner_sco-tester         PASS      33.27 seconds
TestRunner_ioctl-tester       PASS      25.48 seconds
TestRunner_mesh-tester        FAIL      25.95 seconds
TestRunner_smp-tester         PASS      23.08 seconds
TestRunner_userchan-tester    PASS      19.83 seconds
TestRunner_6lowpan-tester     PASS      22.69 seconds
IncrementalBuild              PASS      27.01 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
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
Mesh - Send cancel - 1                               Timed out    2.705 seconds
Mesh - Send cancel - 2                               Timed out    1.985 seconds


https://github.com/bluez/bluetooth-next/pull/330

---
Regards,
Linux Bluetooth


--===============6761948228636108030==--
