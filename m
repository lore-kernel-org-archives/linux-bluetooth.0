Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304719D8B5
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jun 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718548402; cv=none; b=gzCfmoyBM7IvXcSsh4nQ+iPpT2ey7QIGRMPjk2V/Xlxi6buK+C3bj9RPIZtSWH5AlJkMK3sxhB/VyTnZVCOcOpiOEzN95ufFwRFNZzZk11AhsxqVglC6Bn47/9yRj67Bq2pqiGIe6Bsx3LvEDLypKH0MisfRkINym8sUS9x33lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718548402; c=relaxed/simple;
	bh=cLZ9L30jmGZCHtUuUW636C6Vo5SN5u0N9L3vVGKDK88=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HFq68OJK+MKae/va67ZphyS3mVWkcbI7k3UrhmsAiBPxUFiPlwXaB6vFmcI6NUcSqn5HNsCFUj14wRVR/s40P0pArP+/ixFwkxIHZDFG6eii95gsGgWhjpiyH8Ht1j9tTdJlnnIV0hmeKB1sbuzHkulLpt932MKfHBLkodiMWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyQjgvdx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyQjgvdx"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso2961768a91.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jun 2024 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718548401; x=1719153201; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bvfb1ND+fuama1hJTcdelK4vdWhTF6vXCYiJKx060vE=;
        b=QyQjgvdx8h5j4p+V7Vn9/pBEfGd/0sfNXoQzMRh2MAtRgPT25No2xx2fAkiHx9DxuD
         WKLhE8hzMctbPef6E7jR1yrZFZyjf1Wj1ocmpbCUzkHq7NKVJphTdcsBTFFncO1bX1pn
         7xXz/UL9zFcmxAtgza1kAqSttmM8lTX3Czf05w343KIXVXbVVQP/GaUzXtAj4e/Wx/Dc
         rUDpMt9XlraJ3B4PsCQXKORqgrNyCX13Qjc3XR159JIti+llVXTkZBuYBw4fhCQFI8sA
         ro4c2yq4PSsqy8PhiR0a3bx5h/OsFKFN/iWyQkXFFNFi2R85EOuPVXyQiz6aKtLrmVqt
         pSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718548401; x=1719153201;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bvfb1ND+fuama1hJTcdelK4vdWhTF6vXCYiJKx060vE=;
        b=f57VUC/iSu5sKDXkRsorb8ahE/x2R0x58Tq2oL0Cl1n3bjC5n63I2VT6QtybsO4kn2
         GqUyYeS9SZr7euIItDUI+XmG+WGVq0P4/uz1ugokV1G5rWkRXofHzNB++mhubDeS6MCi
         k8WtHvNuRyVAYj38uExalK/uGQ+iV5eckpvCJ/RZxctyDikQfQu+i6ckhqLSW3k7o/UJ
         I57l5FRoQcXjuQht3Tu9HEClq/ZO0i73RhcZGRARIKBVcyQ8GSWYzivAfmq0eK08Ls9+
         B9oPUFGAQlN+rPmNJhD5Q0GyV8KVtZ1CntSHX1IcbkBcQzef72CQpyISITGM+mwK7FF5
         MmGw==
X-Gm-Message-State: AOJu0YwpIaguGleyxo33K87wRRXDC6yhuiYiofQkVkft8RCFo6CIvVoo
	EGhuBnEJqy4p6VtcMe+hbEjgjIVH/x4+3ERe3Y8XMXOmwPqsjd1EAS/JVw==
X-Google-Smtp-Source: AGHT+IE49ATEPk6kKttpjR8sLxEIAFR4NMKPfgoHm2pEsk5sGXHCRt+xLBevgLRf0Oq7G69471S2sg==
X-Received: by 2002:a17:90b:4f4b:b0:2c5:3a5:5e47 with SMTP id 98e67ed59e1d1-2c503a56f03mr2361513a91.13.1718548400491;
        Sun, 16 Jun 2024 07:33:20 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.123.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c467c6besm7369220a91.52.2024.06.16.07.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 07:33:20 -0700 (PDT)
Message-ID: <666ef7b0.170a0220.1856.4644@mx.google.com>
Date: Sun, 16 Jun 2024 07:33:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2629514976716591984=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eadavis@qq.com
Subject: RE: Bluetooth: handle value is too large should not be used in BIG
In-Reply-To: <tencent_410DFAA59E0DBA9213DDE8DD9399584FDB07@qq.com>
References: <tencent_410DFAA59E0DBA9213DDE8DD9399584FDB07@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2629514976716591984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862371

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      30.65 seconds
CheckAllWarning               PASS      33.08 seconds
CheckSparse                   WARNING   38.43 seconds
CheckSmatch                   WARNING   103.85 seconds
BuildKernel32                 PASS      29.56 seconds
TestRunnerSetup               PASS      533.58 seconds
TestRunner_l2cap-tester       PASS      18.51 seconds
TestRunner_iso-tester         PASS      37.01 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        FAIL      113.65 seconds
TestRunner_rfcomm-tester      PASS      7.67 seconds
TestRunner_sco-tester         PASS      17.04 seconds
TestRunner_ioctl-tester       PASS      7.94 seconds
TestRunner_mesh-tester        PASS      5.89 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      28.50 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.174 seconds


---
Regards,
Linux Bluetooth


--===============2629514976716591984==--
