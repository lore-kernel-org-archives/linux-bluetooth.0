Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3B74E26
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291928; cv=none; b=ZzOpjbHlYSplx8E2rvYA+j9x1hchLTBgM2PzA2pX2dSBnpcbI/CgdcYKYxOoLNZmalswRhSXMqYuRST5ttsua1m63oGMOb33Yap/cdNjhPH+MONMEaFkFAQ3YZ7RayjdV+UqCeBEQbpzGzVtnGiGmbnbeGUbgV5NCY3qHVGEyyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291928; c=relaxed/simple;
	bh=nJ0B6qVEVYuce0BoMABNrUJoJHXvRiYy2b9943lC3jo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rpUAXBE2OaKgQrIn7DrnYI91SaUgdOBuuOAEfDzhEO/Au25VbQLSDbQoKAZZFZrNaVeGRwALw+6rw7Yl8K9a646t93CNl+4ohORF9arM8cispnV8RG0i1/AVEerF4wLNbSf7gvl7scQUTpu6jXWF4VUCnRLA/H9+ugRW+tDkXtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+GMdjgw; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+GMdjgw"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48ffd139a9cso195710137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 01:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721291925; x=1721896725; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jk+V7GLZyssKBgU50CKLRyPpnG76qFxGLn4GTIMbpOo=;
        b=D+GMdjgwWRihwioZAxBnRqyb98d2PJnrUEu6rzNjST7/+8INY1FVk+yHezbemZUujD
         kx4uShgcXVtoeBfDAkn/sYuvAF5dggqQNYFLR1+WP4bBKf2oIEWdIkgZELas6Bf/aGf8
         fleuhArtacvtI6vaYUXVSaKA0twK31i7gwzPdqey7LCmcZ4zamSI69h7UI1F3vBhZxVe
         CKxDyTgct3aFvkujHDSsVTxoS7Lyr+LdES79kQNDp4PI5tctItY+9iH1SPtAue2xUaTG
         iiV2rNzpn09OuCFYA8WxwvIqQLFsmUU8cdDn+6PjHQWiWHbKom/0xI0wYV46XPoDy/VZ
         66Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721291925; x=1721896725;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jk+V7GLZyssKBgU50CKLRyPpnG76qFxGLn4GTIMbpOo=;
        b=FyS4EDhPSE16u+gJFz1Rv+IhIFdmmrwYkmBxrqUd+/H5l8owZoz/iG8mPKzjMcEoAM
         s07gWBAXRWDg6g93hl2zckqV/RvTdN7wcsUZtRsh570aZnFyxRICIvldOGP/AR3OOcHC
         ogHPXM+xYzC9OFs/rRhk1ESP+KAKcpXE1fnMrkUoXXOKsVzoGRQIC+pzdvoNtFC+yQdu
         PW9uGcZcG/uX/2j29VxyQ9dbiMXFm5ixGN8noLk9n0x6TvifzOWxv/3UJP+W0XPsoJNP
         lhh3xP3iU7D6nUrKH42oLZG+m+JbpbX565tfoaycSYE26DcUk3jOTIjfvmHD0CWjWjum
         T/Bg==
X-Gm-Message-State: AOJu0YyuVdNlMR+ffCvpYDhkRBiZRob8IMhYsxj/HiknP2cTYXh0JTER
	RiNPA/zjltEJH44aBCihhG2JZRsJLsl1sqjrIcorR9u5roVvtn8HRIcNuA==
X-Google-Smtp-Source: AGHT+IF2dhq23XIIs3vrQCMuDspMNd34+IocPmXJZfEuT4IAs5B33cUGPEgPc0Vx8vGZ4X+5MRlTXg==
X-Received: by 2002:a05:6102:8014:b0:48f:bbf3:b8b5 with SMTP id ada2fe7eead31-4915986a8afmr5708181137.7.1721291925099;
        Thu, 18 Jul 2024 01:38:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.46.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f96a238a0sm350041cf.55.2024.07.18.01.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:38:44 -0700 (PDT)
Message-ID: <6698d494.c80a0220.32ffa.010d@mx.google.com>
Date: Thu, 18 Jul 2024 01:38:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8921137989227291009=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+yang.li.amlogic.com@kernel.org
Subject: RE: Add support for Amlogic HCI UART
In-Reply-To: <20240718-btaml-v2-1-1392b2e21183@amlogic.com>
References: <20240718-btaml-v2-1-1392b2e21183@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8921137989227291009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=872164

---Test result---

Test Summary:
CheckPatch                    FAIL      3.75 seconds
GitLint                       PASS      0.97 seconds
SubjectPrefix                 FAIL      0.59 seconds
BuildKernel                   PASS      30.89 seconds
CheckAllWarning               PASS      32.22 seconds
CheckSparse                   PASS      37.88 seconds
CheckSmatch                   PASS      102.54 seconds
BuildKernel32                 PASS      28.77 seconds
TestRunnerSetup               PASS      526.54 seconds
TestRunner_l2cap-tester       PASS      20.09 seconds
TestRunner_iso-tester         FAIL      35.18 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      118.20 seconds
TestRunner_rfcomm-tester      PASS      7.56 seconds
TestRunner_sco-tester         PASS      51.38 seconds
TestRunner_ioctl-tester       PASS      7.97 seconds
TestRunner_mesh-tester        PASS      6.00 seconds
TestRunner_smp-tester         PASS      6.94 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      40.47 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/3] dt-bindings: net: bluetooth: Add support for Amlogic Bluetooth
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#93: 
new file mode 100644

total: 0 errors, 1 warnings, 66 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13736148.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,2/3] Bluetooth: hci_uart: Add support for Amlogic HCI UART
WARNING: please write a help paragraph that fully describes the config symbol
#110: FILE: drivers/bluetooth/Kconfig:277:
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
#136: 
new file mode 100644

total: 0 errors, 2 warnings, 838 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13736147.patch has style problems, please review.

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
ISO Connect2 Suspend - Success                       Failed       6.236 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 1                 Timed out    2.712 seconds


---
Regards,
Linux Bluetooth


--===============8921137989227291009==--
