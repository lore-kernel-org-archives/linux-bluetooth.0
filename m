Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370EB20DD67
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333483; cv=none; b=DyZJQjvN9chH6+Jh2i48mkCTu05HWI6/txkbCEsGOzFX+xyFrytldfgZj7HjYN8oPCB77dznFUpfz1aaMDsWgT3VhE9cvy6Pms+8Aybg3lzEtDjvArxojSQBTMJgvxqT+4fS7f7yHg7S6Ks6FilKEhGh8RejgpmEgsJl1odNjt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333483; c=relaxed/simple;
	bh=CEDKcW32gIzGiM/ccT2dGGw6fedxh5h5ZrudZKI9HTQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U5ulBRTcJEvwFWZ2B2owUoDDczxuSU3QGnF4ay2rauc4mRCh7dIY/YEdhFtDNt+kAVqXdOVc3EHy8rEOk1XlJqUWCcjs2A2lfXZDdNRDCClX3M/6I7E1OpOY0UwMJhlZQvS2rn66dSBOpuc5cPsW0NsWytMr5+ilafwVm3ZaCa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGs7k0dl; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGs7k0dl"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46695dd02e8so74382501cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 09:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733333481; x=1733938281; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ke/dJNjd5FAeYzZYpOSgTHh8oifgTOMYvzhj/pQ+N6I=;
        b=hGs7k0dlSw7T8XoVKcPk5mK+fh2fxIA4tjK8GQ6w3bjXtCrS88epa66Rb5BIJVjFNL
         Jv15d93A/NgIzLr5eeeyOlTleS5/dw9WNbQDOjdi++FWok9LmpBUgynuSFZwj4NOgkLR
         bzWmiphYXZBogOQOg6iJGiOwTcS/wQzP5GBxcwzghM87R/CmYIx+ON6bwBrS7Nz6s+DB
         S0MIrA6uXv1lXyQfx42vXN0YRMCWhirN4/WTG4YaYQG3Lnt9d9NEbSS6claPJ/pjoEaV
         eSOOq37DS+tUgOEgnLw3wWe/BzOWaoTnUz3aYlRldENLux4TAjfgPT03zMYMd256zq1c
         itog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733333481; x=1733938281;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ke/dJNjd5FAeYzZYpOSgTHh8oifgTOMYvzhj/pQ+N6I=;
        b=GHv9enFlyttnoaiORBIS5sFJ944VRM9i67J4kCsCxDK39P0zyoM/bdA8hAFXL6Lkuy
         BSe5dLDVICipGCJtrXlPK2gfoL49fsc8aBwWeaO8qC2V5QidzPxno9mYbFvehfEX54G8
         9xdrxEG2AuOU/7O1+93SRkH6/oQdpfLVAHx8Kw5wgb1enrMA5iGFId7ekier3gpXBNoe
         rRPHSO8Tc5SHq7ZVH4CBxdpacWMy5oebuTn4QzkldzzeZEmaS/El2XeonG6f2d7+7vE8
         /+vc63r9tyIgGM0UsgshF8SHO8HHfTkgU9VTGDq2Fj+zH9uVNLfv4svhEmhc0vJhL4H0
         Oy6w==
X-Gm-Message-State: AOJu0YxnUrUjk5qT0P/ZmZL3NubJPUWgSp8A7bMPMJ49YIC/hfcrNwx3
	TqOyNKg3pNEJulx2lu4OhH25pOz5Jf8tOq1MJhvKhOcne+m145XVieZAVA==
X-Gm-Gg: ASbGncvSgMj0tE7N08HJIm02tJgxHN0hg/YmaoLEb93Xvh+aEWQfXvhfmVXEvnjY0F2
	S8QnKJTCI+QATNA9uUB5IroAoZ/MipbwryMvlqAtaX4nop7IagnUvEFkbHQ53EzGVr/K3PQvSI/
	k1fN+9yuqkun1ieY8axLbumQRSJxPMh8a7Zpr2PD4Hwfv/kMp8fXHCt0L7pxtH6ItmXjKos49lx
	8Gya5zL6RSBFSzpBD15p6WnxcttgQj/uqly9Yx06jcVHYffqaXHhEo=
X-Google-Smtp-Source: AGHT+IEFSjCxXTEHgghcaqw4MMDtIPpRcYXtPGRmyBZCqX/uHA2dlcVipBw4id4HIpz8Wqy/F4Kq4A==
X-Received: by 2002:a05:622a:188b:b0:466:92ff:dc48 with SMTP id d75a77b69052e-46717ce5b2cmr84599411cf.53.1733333480809;
        Wed, 04 Dec 2024 09:31:20 -0800 (PST)
Received: from [172.17.0.2] ([40.67.142.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c424a31bsm76470691cf.82.2024.12.04.09.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:31:20 -0800 (PST)
Message-ID: <675091e8.050a0220.24b2df.99a0@mx.google.com>
Date: Wed, 04 Dec 2024 09:31:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4886554192297692101=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: hci_event: Fix use after free error
In-Reply-To: <20241204164840.14037-2-iulia.tanasescu@nxp.com>
References: <20241204164840.14037-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4886554192297692101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=914650

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.29 seconds
CheckAllWarning               PASS      27.53 seconds
CheckSparse                   WARNING   31.11 seconds
BuildKernel32                 PASS      24.92 seconds
TestRunnerSetup               PASS      441.77 seconds
TestRunner_l2cap-tester       PASS      20.61 seconds
TestRunner_iso-tester         FAIL      26.48 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      119.73 seconds
TestRunner_rfcomm-tester      PASS      7.69 seconds
TestRunner_sco-tester         PASS      9.59 seconds
TestRunner_ioctl-tester       PASS      8.16 seconds
TestRunner_mesh-tester        PASS      6.07 seconds
TestRunner_smp-tester         PASS      7.07 seconds
TestRunner_userchan-tester    PASS      5.10 seconds
IncrementalBuild              PENDING   0.48 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 125, Passed: 121 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.187 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4886554192297692101==--
