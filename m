Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F633CD1
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Aug 2024 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723185606; cv=none; b=DgHFn3OPCjWo2XFwmvVR8tLG0QJROIYSXgcdupZU9R2HXRoRNpbU9qpAu5JKozqE15pTuWRg4/Y9RcTKEE/Dx00BFkvj9/HGNSQj41RCX/o2xBa7op1mNEBynDEwjKvkvUCpVx7AWasEB/ajNo07Bomt5QuOnrmuSjtXUch7BN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723185606; c=relaxed/simple;
	bh=EqKrx/C7dnNTaWysTTgBKvJ+POEgVs53IRG9e9tvt3g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WppuiGpxtkGktuQYGs3kuhg0TgP0GB70w8JNbKP0Ufc0WZaB8UeAm/bmt2p+P2sNswHISlPDRZBKVcW+ekdDhNlqiAEn6Bo5CSz8NTO5Eyj6MJLA4AaDIr0eypp+Rgm+jpXJevFae4wG/s0Pc3Uql2EuPKUh+sIlTAN5r58Ls8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAo1GIut; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAo1GIut"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1e31bc1efso104944585a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Aug 2024 23:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723185604; x=1723790404; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L7PYc0/IKztROL4rE49o6DGicyBmnjfIczh+C0KMIL0=;
        b=GAo1GIutQ5vi3W09EJB3T0FrH9qXRGRwIWZVHdCLUtnE3dzyJNLJ0mDesTORnHbwbO
         /O8Q98NJe6dUyHzFVnnDFNoZxJdPXCdg5K5WB9Dm6yQBRVNjNq71wyWnv9BJiaovLn0K
         dmd/JwIAZw77HBYfZSQeG8AulQ1ZmIu4LRoalPV3n+0kq60gAUTf4l3z4nb19/H8Hhx5
         U7UwE9t3yNowbtAx39kPstk3T7NG6/ES/f9TcM2cxRuYzQwi2RnHZiVq95NF4cB2E2XJ
         ieA2XyRKUwvqNHHX5LAsCoKe1vloKU4DK6GUzKhvriFRTdfw6WBZSOrNCwj60x70Hrw0
         5guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723185604; x=1723790404;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7PYc0/IKztROL4rE49o6DGicyBmnjfIczh+C0KMIL0=;
        b=JfV5bb7mpXYdfAUpW6Rt4dAPOVMN9/okAa/sfGZSGRCAjyVMdpjbQ2M9zByheGShT8
         ZsNNeKtHXh48kOFkh6sR2e0V+o8p6FJ6P1yzpINfDbqNKBzW55SnKz/ID0jZNUmp3Jih
         qYw05vhOyF5Tb1lfCmb7Jw7/34KnBdVf+m4qrtoZg47Oo+C36e7ssGbvnHF20pMDr/2j
         FV+RGnShbhUzFTzDNhb5epBA+p5YOr+Wh/LTvYQ/GdebQhpwCRRoQl3TRdW+pzw21UkC
         QJ9DKVu70cM2sIMVmyf2+cbKRNB/h7XTsbO+PCM8Ka5ckPSzJwzGlucnHYF4Unef4LyK
         FKFQ==
X-Gm-Message-State: AOJu0YxkI8CsJtMuefc9FTGx0PzgbkzMC+k3DfC/9tAKy8IC8x8rqta0
	izS5fSq7BROj36h5/KAYTaV2CSoR95mOL1E69TQ623edcDF56gmIHWtxFw==
X-Google-Smtp-Source: AGHT+IF88OTRPyt28hpZTY4H5jBvWCtgSArkk3uCgBtUazRsRuuelMm98aeLy3SMJ2RCQ4u7tEv45A==
X-Received: by 2002:a05:620a:2953:b0:7a3:6dd9:efa6 with SMTP id af79cd13be357-7a4c17da7c3mr63746685a.33.1723185603885;
        Thu, 08 Aug 2024 23:40:03 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.117.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786cbeb2sm233636985a.110.2024.08.08.23.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 23:40:03 -0700 (PDT)
Message-ID: <66b5b9c3.050a0220.31d5ff.90c8@mx.google.com>
Date: Thu, 08 Aug 2024 23:40:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3017552717295469533=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+yang.li.amlogic.com@kernel.org
Subject: RE: Add support for Amlogic HCI UART
In-Reply-To: <20240809-btaml-v4-1-376b284405a7@amlogic.com>
References: <20240809-btaml-v4-1-376b284405a7@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3017552717295469533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=878052

---Test result---

Test Summary:
CheckPatch                    FAIL      6.16 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 FAIL      0.72 seconds
BuildKernel                   PASS      29.97 seconds
CheckAllWarning               PASS      32.70 seconds
CheckSparse                   PASS      37.91 seconds
CheckSmatch                   PASS      103.23 seconds
BuildKernel32                 PASS      29.10 seconds
TestRunnerSetup               PASS      527.95 seconds
TestRunner_l2cap-tester       PASS      20.03 seconds
TestRunner_iso-tester         FAIL      37.09 seconds
TestRunner_bnep-tester        PASS      4.92 seconds
TestRunner_mgmt-tester        PASS      109.18 seconds
TestRunner_rfcomm-tester      PASS      7.48 seconds
TestRunner_sco-tester         PASS      15.05 seconds
TestRunner_ioctl-tester       PASS      7.98 seconds
TestRunner_mesh-tester        PASS      6.00 seconds
TestRunner_smp-tester         PASS      8.97 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PASS      40.12 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,1/3] dt-bindings: net: bluetooth: Add support for Amlogic Bluetooth
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#95: 
new file mode 100644

total: 0 errors, 1 warnings, 63 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13758411.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v4,2/3] Bluetooth: hci_uart: Add support for Amlogic HCI UART
WARNING: please write a help paragraph that fully describes the config symbol
#123: FILE: drivers/bluetooth/Kconfig:277:
+config BT_HCIUART_AML
+	bool "Amlogic protocol support"
+	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV
+	select BT_HCIUART_H4
+	select FW_LOADER
+	help
+	  The Amlogic protocol support enables Bluetooth HCI over serial
+	  port interface for Amlogic Bluetooth controllers.
+
+	  Say Y here to compile support for HCI AML protocol.
+

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#149: 
new file mode 100644

total: 0 errors, 2 warnings, 821 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13758410.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       8.212 seconds


---
Regards,
Linux Bluetooth


--===============3017552717295469533==--
