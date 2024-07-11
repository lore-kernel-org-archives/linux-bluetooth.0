Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53F8F72
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670402; cv=none; b=fpsmXL2XsoEhCEZv30uMp1dlddRIJ46+bq6f/OqimXEIDUui+rwbf6rFIK9A4tdi4UIMjIghliy2vsR10L+WpE9gbAyVEy30/KAyLVKMvX77uhhmvqsfndG197dFq3LXDZVKwu8ohUkf+eKux/TQ6x6I2hOct0ZHahCgBJaZuww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670402; c=relaxed/simple;
	bh=wXOJfpKvypgCke70gGw2g5VX+NvDc9Ferfqc2Dhulmo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K+lHzoVM3o5pgtAffsYoWgtif2+Bndr4cG+n/zAFwAtS9ReUj6vGGfRsfQxzbipZd6QPiEdP6k4FlwsE3c13Vy+EFSeMhzn6Bg32tk2QIDeFGuuk6pLPbLsYG9pxehvQ4rY2f6PeCotc5mv0HOLEO4gIo44MpT+oazN1tiPCjGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2ipNzBD; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2ipNzBD"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79f1828ed64so27661385a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 21:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720670399; x=1721275199; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tR8zk9dZBih0ZHoPqd6+1abGF9vQEbpRjfwQ8TfD8RE=;
        b=l2ipNzBDAreZ4Was4ZBJxwYBVYOpNc+mSRoJhD+SyNZCrNx2Hgv2vneYyM5e1M4ssl
         rltIAducFEkvtZbuPJ1nHVcZX8fpLeKoINKiwkPevyHaN26yr8VMOlCWv+wMrdz6GsOI
         M2bw/QUoNPiNB3ZVIHQn/oAlGvRJYJ/I6oOqKpHeU0ZMYImvA4iUa4MIe+yRBU+yUQwZ
         h46I9HrgGTK2nKYThcVmkAzOY/7Un3/yKGEK/FGxxl0yPRyVVbbwcUeC4siGGP4cO93Z
         0AbPuVmZiqUOthC+QjtgkviWanWapPM7QanxRwA13THBBYQnHvrHdNEgzwwt0NTUIfZL
         Yrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720670399; x=1721275199;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tR8zk9dZBih0ZHoPqd6+1abGF9vQEbpRjfwQ8TfD8RE=;
        b=bMKYsSsGeiukQw0LqTfOPalpACWfk0n92z6ACg34smpC+jVIDiHcBgASIxTlJ0X0nx
         xzXhvcGoOFg6vIiXGx/R23Lb9aPYihgojSYwHGRudnWzQpbR6PlTHE03XeN4CdojIdHl
         dI+pIup7AG4INWhyfXfKTiD1XSl/h2apD8wMjffe76bphiVTpkJSG8+SQxLnJT9u5q1c
         D4+ZW0Ur2SOdVhEGsovsunZeHPyup70xHwj3SZf0JoiYEjQ+giCLjASK5Et2yG3SOHnI
         UR69XSFlIQ6TKQiUE4amsyBBcUNaA6jj45XnYfRDpKl6kVczFT7U+9clL8QUA25Q1Yef
         Jp6Q==
X-Gm-Message-State: AOJu0YyD6Usllhnow+E0H2T7O3tv/pX2EuOY7BWPxc/3QbdD9WDVZCaK
	JmJjn3KUWaAM3al2Rk76Rk8GxpjQmOIgAWebiQb/I3yPDQKBbgE/AHZ1rt7x
X-Google-Smtp-Source: AGHT+IFF8P3GKyKPvKIww/nXAXXkSIF6MXY/txHvyHpgxjNKd2HU3jca2gCHdp74TXCFuTjIjcRFmw==
X-Received: by 2002:a05:620a:1aa4:b0:79f:67b:4fdc with SMTP id af79cd13be357-79f19a36bb9mr1135473685a.2.1720670399361;
        Wed, 10 Jul 2024 20:59:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.113.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19028226sm251253085a.56.2024.07.10.20.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 20:59:59 -0700 (PDT)
Message-ID: <668f58bf.050a0220.a4216.af69@mx.google.com>
Date: Wed, 10 Jul 2024 20:59:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6388595368082686375=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_qca: Fix build error
In-Reply-To: <20240711032252.3560262-1-luiz.dentz@gmail.com>
References: <20240711032252.3560262-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6388595368082686375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=870309

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.69 seconds
CheckAllWarning               PASS      32.18 seconds
CheckSparse                   PASS      37.86 seconds
CheckSmatch                   PASS      103.90 seconds
BuildKernel32                 PASS      28.80 seconds
TestRunnerSetup               PASS      527.58 seconds
TestRunner_l2cap-tester       PASS      21.94 seconds
TestRunner_iso-tester         FAIL      34.60 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      112.95 seconds
TestRunner_rfcomm-tester      PASS      7.40 seconds
TestRunner_sco-tester         PASS      16.98 seconds
TestRunner_ioctl-tester       PASS      8.42 seconds
TestRunner_mesh-tester        PASS      6.08 seconds
TestRunner_smp-tester         PASS      6.87 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PASS      27.54 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.235 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.190 seconds


---
Regards,
Linux Bluetooth


--===============6388595368082686375==--
