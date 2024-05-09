Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65017BBF
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715216786; cv=none; b=uYyey+yKkYYvme1thP3VlLajB0TDHvhlkyjWIqTLfko1YE+jwyYfsIIeOOF0Z8OqezErbF2oP7uBtxLnL5R754OlyFNE7CnYin2tf2LIJ5gy1DkUDc/yZajSo152NdkyeOqLDB/AIv/Vyh1gbJbowc7l1WO3GVHEB/WzkmXWpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715216786; c=relaxed/simple;
	bh=5Jwg+45qDPKJis2CBLgPmxqjSc7kbPEDv+9Zbcf0ByI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iWjOEjdc997azSIwgvW9WmKzWa+eBHYaHXAQb87LeMlZRV9zE7FwVxW8JtV0zeoIJQVMFCiqR4FenhlP/lm7kRrqKXZzXyAPpOVYnnqauv7cStIQs0cj6Xo1J8KCsWry2HSMtjWMg9YORWjVid+BvAYP784o2gR4tR9Oy7trwpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVaX0fW2; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVaX0fW2"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6a1548d65e0so1666416d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 18:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715216783; x=1715821583; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MD/UD0ISFKFI+mgOaXflvAn+N+vr3uqM9TJ/qeQZkaQ=;
        b=CVaX0fW2H0/0p8M2lDMTt1J1dWIrlzjaei/1rLpEoXAkbkyCIq2Ir5LsUyDa9AIQbC
         /RB6mlrRS9EOX1UUkMGk/P49SLB69jYIzQ+EJFOkHx8PBfHn8OSwdtDc+xzMxDvl070N
         G2Hk6P1icXo+XAuuhR6MPsQSruiWFjzkxPZmRl/O37G6rIOsOXiIl4so7fnppVNW3BJJ
         CTmn6/0z1TebA7Vn0cDrIoJ3r5JmhbHhosOyGzOZ/XT2+V8Ke5sffyct93Q12QLNasRQ
         3t7X7Cmt0U+3qYR9UAkEk2V0weE72p/fhYkB3xqjgAuzB3EK7kY/X6+ahNtWWg0gfsiE
         mrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715216783; x=1715821583;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MD/UD0ISFKFI+mgOaXflvAn+N+vr3uqM9TJ/qeQZkaQ=;
        b=WqbHfzbS4kLWy28gB1bwF3VSkvsw0OQOQHJYvpT1moEfpk4+UJaqI3xKoK1cQAYUwP
         x1v9w4lsNMVwOmVbT44PisBGX4J7R4p9Wvrxq7zGqpCpcbrWgoqTN9yxDHKcXpjZFxR8
         aA6kKmVjsBq4IvcNFA3841xKRGzgBuRVbEssPHA35hZ9xzXS+HCj1Mt+BvTzRKTW7ELo
         UeaovRLXX3RsExeKMVhHUXg+VmVx/9nZRPHcbcHHqb2a0W6Kiu+2AKmcja1ZTgMbp56x
         lx/H7vKUVxzTqj5YGQUHIHGgTfUUyrcnykRmVcMUYBWl5RhrtHi7abL8taIGJjYVea6L
         y0KA==
X-Gm-Message-State: AOJu0YxQK8inagmhgr7w2RwZl7moayarsWyoc3HrTW3NQbzhJ2eB4fGU
	BsWEgU8VMryRlrIYFnQV7cgJhqZeXTj8bnuT//GsdkQVOiHB2aCmHnl+GQ==
X-Google-Smtp-Source: AGHT+IH5WuBs9o4I6rykdGlsSI0FiWbSWgj6MC6NJ5ms1qvy4MVriOtbbeiCtuMTlx0JQmSb3cKc9A==
X-Received: by 2002:a05:6214:2623:b0:6a0:c5c8:b4d1 with SMTP id 6a1803df08f44-6a151478909mr51721516d6.34.1715216783294;
        Wed, 08 May 2024 18:06:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.95.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f196bffsm1558016d6.71.2024.05.08.18.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 18:06:22 -0700 (PDT)
Message-ID: <663c218e.0c0a0220.769da.0a00@mx.google.com>
Date: Wed, 08 May 2024 18:06:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8288872273413771816=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, linux@treblig.org
Subject: RE: Bluetooth/nokia: Remove unused struct 'hci_nokia_radio_hdr'
In-Reply-To: <20240509001138.204427-1-linux@treblig.org>
References: <20240509001138.204427-1-linux@treblig.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8288872273413771816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=851727

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 FAIL      0.31 seconds
BuildKernel                   PASS      29.81 seconds
CheckAllWarning               PASS      32.29 seconds
CheckSparse                   WARNING   37.72 seconds
CheckSmatch                   FAIL      35.62 seconds
BuildKernel32                 PASS      28.50 seconds
TestRunnerSetup               PASS      516.77 seconds
TestRunner_l2cap-tester       PASS      20.34 seconds
TestRunner_iso-tester         PASS      30.71 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        PASS      108.31 seconds
TestRunner_rfcomm-tester      PASS      7.31 seconds
TestRunner_sco-tester         PASS      14.94 seconds
TestRunner_ioctl-tester       PASS      7.61 seconds
TestRunner_mesh-tester        PASS      5.76 seconds
TestRunner_smp-tester         PASS      6.75 seconds
TestRunner_userchan-tester    PASS      4.88 seconds
IncrementalBuild              PASS      28.45 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/hci_nokia.c:279:23: warning: incorrect type in assignment (different base types)drivers/bluetooth/hci_nokia.c:279:23:    expected unsigned short [usertype] bauddrivers/bluetooth/hci_nokia.c:279:23:    got restricted __le16 [usertype]drivers/bluetooth/hci_nokia.c:282:26: warning: incorrect type in assignment (different base types)drivers/bluetooth/hci_nokia.c:282:26:    expected unsigned short [usertype] sys_clkdrivers/bluetooth/hci_nokia.c:282:26:    got restricted __le16 [usertype]
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============8288872273413771816==--
