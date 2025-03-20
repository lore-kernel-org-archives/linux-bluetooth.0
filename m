Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA3714B08A
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486340; cv=none; b=nbgS3bnhbZujwCBly5nEzbo9U+rK+ZdSKg6mIWE1ZgJ2ShHp4tvjR06/Aprsbz8xGnmAkfdKb+S/MWVH/zk5koouo+aOlQ2aDcbcvkQ3Px8gweaADLYYY7UG7ckr38s+Da5K7NrvRtxnOo4lwtcPgq4cDtyt+HDYnu+nONTBoUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486340; c=relaxed/simple;
	bh=uCuLbNCZqeVABQpWV+jOcvqUsKE201t9x9ps++YGkek=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LF57KKsmEygE9JTlZh9YIZ/Vbx1GBvL8dlIKZGjUfb5i8weu6PqOW+XpPV3HWUKKK8QkXcRCBaGm3W1ZHhRfKOL8AATZ6PmMWlT5oBSlr151Za6FrdOV7oFs5FQafTPEFDqw9cQ33Di6mwaDNIouTKsHbqxgiBSqNUG3bpJRaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXLoaUiY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXLoaUiY"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22548a28d0cso26232665ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Mar 2025 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742486338; x=1743091138; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tik0ZF5KC/qTb7yLExZNdVvRzcIF+ECMhnMjPRO0MTA=;
        b=WXLoaUiYmM/n46ctWOucN3BUv0ozq5kOtdwSKY/iqkaRzvI1Pnsqgnznl16rjigZn+
         QT/TLKm8UO+hQWRBHaFDi5UDclglwH6T3aRRFEETh2iLrpNfylQtbgi0QrrQEc+rBZhW
         /rvQTSoRaHICfBkTsQ5v9SSNSQKU9ZuvFCFmsVp6efhQIn4mBcu9f743Egeggl8wx77V
         ITvRrvTmkwH4iky0yrUTtMdVCQ87XbDTr0dV2zy8NBFN3aq68mv2RatKLS2JL1esiv8i
         8w9sCs/qtWu5ssSVP7IxpvW6YCR34pMRPQQBYDjE4NzCrXfhAaCJN5gErH7Dpb/ZRG6Z
         LGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742486338; x=1743091138;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tik0ZF5KC/qTb7yLExZNdVvRzcIF+ECMhnMjPRO0MTA=;
        b=o8gesCVaj1x6u6InkGKnEjviVQzfKHhJaTNev1ssQnuPgIymJDduu6H/0jGzAQfzFf
         vbVmxdPPVLzvRtqbYRnlH/GQpQUKmCwSCyEy6MSVuo2634mqebCNt3xgjn6a1HFN1IvW
         lnoeJ9JG/o+S1Wn/EQS7EX3jioIoE+8YCzobWiedxCfsCqCBRi2B8n406LnTZDlpq6Z9
         P7rIsfFdVUYr+3bih3b8xs+/JqYCEpyQJ7L5Lx9ROU/o78LqxS77x+JSQtbBBfY/sn9c
         6isF1WixOsnBamP7cie6lx7hqxWlpyS1xlUHFOS5xsZ4i9cL+t6KD93/82uMHmE78Hwj
         ACiw==
X-Gm-Message-State: AOJu0YzkxGocwaAR5iN/0zMhhUrHhYkwOy4YyId5wWp/WKDXsWLigQLg
	YpRvx8d6eGua95aljegfpU+REOyHDxT955aghlW3CtgPvAyha5lTlMZb+Q==
X-Gm-Gg: ASbGncuxtLy5PGEusgQhot6tbXkEDlznZezsImuxIDTokEaNorOfLmvLC2eacHTovvz
	UqQfOkQEa6MOhzaEYKbWIAJn3WSibhu5LN+VNVQaobUeLCOUoKzBW+25vRfw3/K0HI6YmWIRpSJ
	Wutz2oXtYNlLmNaX41Zd292gCs037xgTcCQSNu0lxnhOYyz+MWdAvzG/2jq0LG4XbVNuKtI4X8V
	Gd5SF/dozPk6F2mj16d+LPoxx4Q23PbECeF1oD2thFjAPphBFVC+Banc6IuQKtYD8S3003LtVTU
	Pv0KFGZ+z+k8cdrvVHZFGZewTi8tJdb1XLdK+Ndp9n9LjKfuHA==
X-Google-Smtp-Source: AGHT+IEHMQkMYqd5BtLEVkJ/BEfVZc/oiNnfoZ5fJrJ8MdOlqT7XUUkgr6E7BLqlcGYfGUjjRiZk7w==
X-Received: by 2002:a17:902:f683:b0:223:f7ec:f834 with SMTP id d9443c01a7336-2265ee25b2amr53423645ad.31.1742486337577;
        Thu, 20 Mar 2025 08:58:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.4.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4e23sm137114985ad.225.2025.03.20.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:58:57 -0700 (PDT)
Message-ID: <67dc3b41.170a0220.e41f7.2c81@mx.google.com>
Date: Thu, 20 Mar 2025 08:58:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7556149100943576673=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_event: Fix handling of HCI_EV_LE_DIRECT_ADV_REPORT
In-Reply-To: <20250320153415.1391223-1-luiz.dentz@gmail.com>
References: <20250320153415.1391223-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7556149100943576673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945967

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.33 seconds
BuildKernel                   PASS      24.11 seconds
CheckAllWarning               PASS      26.56 seconds
CheckSparse                   WARNING   29.91 seconds
BuildKernel32                 PASS      23.76 seconds
TestRunnerSetup               PASS      427.11 seconds
TestRunner_l2cap-tester       FAIL      21.16 seconds
TestRunner_iso-tester         FAIL      32.37 seconds
TestRunner_bnep-tester        PASS      4.61 seconds
TestRunner_mgmt-tester        PASS      120.14 seconds
TestRunner_rfcomm-tester      PASS      7.72 seconds
TestRunner_sco-tester         FAIL      14.97 seconds
TestRunner_ioctl-tester       PASS      13.77 seconds
TestRunner_mesh-tester        FAIL      6.13 seconds
TestRunner_smp-tester         PASS      7.03 seconds
TestRunner_userchan-tester    PASS      4.88 seconds
IncrementalBuild              PENDING   1.02 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 62, Passed: 59 (95.2%), Failed: 3, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Client - TX Timestamping                Failed       0.118 seconds
L2CAP BR/EDR Client - Stream TX Timestamping         Failed       0.115 seconds
L2CAP LE Client - TX Timestamping                    Failed       0.106 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 124, Passed: 121 (97.6%), Failed: 2, Not Run: 1

Failed Test Cases
ISO Send - TX Timestamping                           Failed       0.200 seconds
ISO Send - TX CMSG Timestamping                      Timed out    1.880 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
Total: 20, Passed: 18 (90.0%), Failed: 2, Not Run: 0

Failed Test Cases
SCO CVSD Send - TX Timestamping                      Failed       0.166 seconds
SCO CVSD Send No Flowctl - TX Timestamping           Timed out    2.480 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 66 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.112 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7556149100943576673==--
