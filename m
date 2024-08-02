Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A314B943
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Aug 2024 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722595008; cv=none; b=ILQY1ruCEg6rsEOLb88ALV7WpFRLCDGSyhpb2Fou4qzYJ+KAL1RNzIwn9pokgUSNqEryVScOwFnKhboEoK8KtQll840vGiN0YlYK+4FRTd3fUSVd0N41hrwdtCLzkfasZCLsiOo4s1W+xSyxrteIvXkWC1jpYVJB0mq0ISeFwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722595008; c=relaxed/simple;
	bh=l4lz2JBmwUjsHdEHnjgzxl14zkSNW8iYfTPqQavOLu8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P+oVh/9j+Dhn8XrVb30T87UokQHE8VBEJUeamkIJtTBboo/s9W2SpcrCcOu8eq61XLUCZyUwcrAPwTnmLSpPvyIr8gqKOedwQbjorChbB1J7tr1LZMKW21N8fu3sY9mQWfjGoNxqijSy4hUcQzhZ9VnsMS+KARofZSbHoIdSe/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUCJujbs; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUCJujbs"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a3375015f8so121679385a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Aug 2024 03:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722595005; x=1723199805; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zC911mxh0nHfaSXAqI38n/QqHG4GiFx00Bs3c7nJkaA=;
        b=mUCJujbslfwWmEBHCHdic/AlG7YRZZlbnGVIzTyfjOM38TrfuDYw+fQfODmQTGTVvW
         fs3EYMXWLSk7lAqBrcoYE9LoRoFaBlBbtMqsEM0zgp/sF2fA8vaUnACXigQE2UNetcN8
         runHeZZg8N2Tz3mIZH90K5a8STi5VEzgTh4+QbWiAUFn5UBTxKCQrVLa+9R2BVEXun8B
         HxNUIkwFXZ+iTLUQcVHrBnUre3Ydz/1vy5aoPLTfzXAA3QVNTD61b+rNMQ0sO4fYeoBx
         3akEj87h52cDgNxFc17RNTIQkdEhIJIFiF4buWZrlwMAa3lRYGVbVprdWp3/mUTN34nV
         z8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722595005; x=1723199805;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zC911mxh0nHfaSXAqI38n/QqHG4GiFx00Bs3c7nJkaA=;
        b=HtmMehDX4KpHojq/kVhKQc0S+lb2iqoaJwvXUk+kNKiHL1xqXOPk5reaLHkmoXX+CY
         aikz6YROmQo2Ncm8LFNPO6qP+EbTMILosOJmCRn37hOkCyTSDV3NmkJtqE1N4WGVM8+G
         Rumf5h0R/XI5cz4FytSsujtuYYJlbIHQzcG664t7t7HFmpAnlkB/aDog6PTG8vlAcubW
         99BCmbq/xlXCPEuq9CwE96zu4CF8kC2OdzUYg+HML9TSKm8hN4kMrwoi+J5f0YQ8deLV
         q4khvVXcccnvpk8MuYZcN66oyWYW4Nofp/+i0DLFiOvknbEdUjYM1rVBQgFrH4NBdJMc
         StJw==
X-Gm-Message-State: AOJu0YwQEg+GH0tkEITmB7TuF5FP3jjuhU5NjvC0WOEYnuGBtd8pdDQh
	4TcM1TlMrHbcvEN8pK1LsGihKRSu4+6pUVDDDR0TkxYX8tcjk3CZV7ShQQ==
X-Google-Smtp-Source: AGHT+IEB84TJtrrOXtTs0bcob/RfPz8DlOlXfD+wfDYcFrrDPzvQZkS2FssynUxT7tL9lVcZepjRlA==
X-Received: by 2002:a05:620a:2682:b0:79f:498:2a67 with SMTP id af79cd13be357-7a34eed3c80mr306519685a.21.1722595004993;
        Fri, 02 Aug 2024 03:36:44 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.199.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dd15asm75126685a.18.2024.08.02.03.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:36:44 -0700 (PDT)
Message-ID: <66acb6bc.050a0220.87ed5.2e41@mx.google.com>
Date: Fri, 02 Aug 2024 03:36:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7256588990627023682=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+yang.li.amlogic.com@kernel.org
Subject: RE: Add support for Amlogic HCI UART
In-Reply-To: <20240802-btaml-v3-1-d8110bf9963f@amlogic.com>
References: <20240802-btaml-v3-1-d8110bf9963f@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7256588990627023682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=876189

---Test result---

Test Summary:
CheckPatch                    FAIL      3.83 seconds
GitLint                       PASS      1.01 seconds
SubjectPrefix                 FAIL      0.63 seconds
BuildKernel                   PASS      29.87 seconds
CheckAllWarning               PASS      32.17 seconds
CheckSparse                   PASS      37.72 seconds
CheckSmatch                   PASS      104.87 seconds
BuildKernel32                 PASS      28.88 seconds
TestRunnerSetup               PASS      527.54 seconds
TestRunner_l2cap-tester       PASS      20.20 seconds
TestRunner_iso-tester         PASS      37.42 seconds
TestRunner_bnep-tester        PASS      5.01 seconds
TestRunner_mgmt-tester        PASS      121.51 seconds
TestRunner_rfcomm-tester      PASS      29.14 seconds
TestRunner_sco-tester         PASS      43.15 seconds
TestRunner_ioctl-tester       PASS      7.97 seconds
TestRunner_mesh-tester        PASS      8.22 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      5.09 seconds
IncrementalBuild              PASS      40.27 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/3] dt-bindings: net: bluetooth: Add support for Amlogic Bluetooth
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#93: 
new file mode 100644

total: 0 errors, 1 warnings, 62 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13751350.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,2/3] Bluetooth: hci_uart: Add support for Amlogic HCI UART
WARNING: please write a help paragraph that fully describes the config symbol
#108: FILE: drivers/bluetooth/Kconfig:277:
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
#134: 
new file mode 100644

total: 0 errors, 2 warnings, 822 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13751352.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============7256588990627023682==--
