Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F20A33CD6
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHPYzVs+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d4ca2fd2fbso11339255ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 01:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704792764; x=1705397564; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9JgV/QrTO69VeUGkaMolR0rsUKmyALaMmwHNLPVLAa8=;
        b=mHPYzVs+0OqskEY4f4ZbqUdz8jixUU0L9ouQ6fLlxOfcyEpmXiSrfxH4vHceFI9EEf
         qTsyrA/V7uGt/e123Jfc3NwAxuosl/xqNm65BSHDL4EECDEbQtAt9VDfbwbZMG3Rh3lC
         txwxvtKxWdgsnj6BV1je6v5lpB27yxYbQ9IAwppznNwC+TAIzMyWq3dzcv4Bg6pyJTU5
         pw/XYnBxUWX+r9gC30gmBzzZYOOnigkO5dV61qfaitf7X7gd4PDE/E3TRpsTg3/Hd3XS
         /HFWDzVtXxkpntiZzl+3nfxkzUQ1JrwHzwDIVcGOvIRrZLBdZ6AIqDchAW+z1Dg+mSVN
         v0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704792764; x=1705397564;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JgV/QrTO69VeUGkaMolR0rsUKmyALaMmwHNLPVLAa8=;
        b=WJEMvvfFY4AZ7YwMVQkbUrXK/sr3Yinud1BjHjuSD+HmiMN2UP4EttCvwBhNkstm6j
         L/eisjXZyEAYbvwk/Un0m7zvGgik/ePWdiCX+BOLQPCVxuEOfg5kMiMw70MCB3uoBYMj
         Mq/tjvsty7UIXAQ39NtOSA0OeXHB/07mRIubnqp7Ju+D+Bh410+aTxAG0G9461T01Tc2
         mOrpV1U871lvqoQ4dY688p62vfCLGxqn+KT20t7m3u0Kj8EqmNfzmi1oYfO0bFqOnzTF
         /2Swqz8fJNMUMg6pc7TPOGXZXGYp/xSxAE78TUVM+fhigi2Q+OFjq/U9YJKpRHUi/3yr
         9k3g==
X-Gm-Message-State: AOJu0YyWRd0+h15Ymc84Euq3ydwqVm5coUfRtWIrECXAFb6TCeWLekMQ
	4dCeSN2J8tRrOr7mhJ5weMzs8uW84PQ=
X-Google-Smtp-Source: AGHT+IElIsai85MokrdDbmw2Q6jytCaK6nZosCChWd+2L/ETkZ5C8plbTJ+Y5H+se2z9VLu7wgMzPg==
X-Received: by 2002:a17:903:2347:b0:1d3:ee8d:25d6 with SMTP id c7-20020a170903234700b001d3ee8d25d6mr2447637plh.29.1704792764440;
        Tue, 09 Jan 2024 01:32:44 -0800 (PST)
Received: from [172.17.0.2] ([20.171.122.32])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001d46274b533sm1318531plg.138.2024.01.09.01.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 01:32:44 -0800 (PST)
Message-ID: <659d12bc.170a0220.2fccd.5149@mx.google.com>
Date: Tue, 09 Jan 2024 01:32:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4270197956216539605=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1,1/1] Bluetooth: hci_event: Fix wakeup BD_ADDR are wrongly recorded
In-Reply-To: <1704789450-17754-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1704789450-17754-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4270197956216539605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=815323

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      28.04 seconds
CheckAllWarning               PASS      30.74 seconds
CheckSparse                   WARNING   36.92 seconds
CheckSmatch                   WARNING   99.22 seconds
BuildKernel32                 PASS      27.10 seconds
TestRunnerSetup               PASS      436.36 seconds
TestRunner_l2cap-tester       PASS      22.97 seconds
TestRunner_iso-tester         PASS      47.10 seconds
TestRunner_bnep-tester        PASS      6.76 seconds
TestRunner_mgmt-tester        PASS      163.40 seconds
TestRunner_rfcomm-tester      PASS      10.85 seconds
TestRunner_sco-tester         PASS      14.37 seconds
TestRunner_ioctl-tester       PASS      11.93 seconds
TestRunner_mesh-tester        PASS      8.86 seconds
TestRunner_smp-tester         PASS      9.68 seconds
TestRunner_userchan-tester    PASS      7.27 seconds
IncrementalBuild              PASS      25.85 seconds

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


---
Regards,
Linux Bluetooth


--===============4270197956216539605==--
