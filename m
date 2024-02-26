Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C8132C0A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983226; cv=none; b=uO7P7UHjCLkwQK0cq02ym4DszDwL1LV6hP3crcT/PBWed16siByfiQ0FL0saQq0AZ2miRRF+niBZyKy6nti0yQlpqTL2/cgYyvyHBBdYq1OYhj+f0K6Kn6335s22jY54YQ0TppLQQTwiMs+23dCn4ZdoHN2KWR0bGR/rSPaMOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983226; c=relaxed/simple;
	bh=7TmzFKhIS2gxZbpLzKnNerNLS55Kn/Y+vb4S0RV0dZE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Rk4TSgvJxbwA8W8KT7Eyr50c5XW9kyi3vjNwo4lCcu2Qo+BhDVeSUxJCX4GNEKPmcRnptGGzYs4IC+coL/Jk//MHXl+m28KnVm6IptH0EzAKNfqCNM0u49RJjouSVyLaV/C6Ojj33vXG2liFoDVvZNB5XNUSZw6+Ev4hTr5+KU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=In0HERE/; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In0HERE/"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6901114742bso3975526d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 13:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983224; x=1709588024; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ELwaw5VTcstsInvW3UiboDoD5sly10aWVPSj6o6QXs8=;
        b=In0HERE/XGm+7OpOT3klG9ozXGhCFnL+FnxGj6v7FoaPazMbcIOvg66/pVZoD/tq87
         mnY7PGRzolCYRRtvKhb0XddFrh9QPfYN6VVqdyk+doaWWIzr1l3Ezes+5FWalAypCnkE
         86oS36dYf/eX0Z3fSUUcs1zDO4UXq4QcTpxkkuE/nsC6mGtcz8GeJp8N+u8f5q3M11SM
         pCPJk2meeX6wSKnUkeYKBz+K/NZcf4jVCD4xTVVqORh75OF5JHGfhud5SrEWjqfRyOFX
         /rgZsiJ48uwtzaQp4pkrVYz+H+MQXGiC3CAE4ANERc6zz1mRHcc4wvMcT2i8FU82wMRN
         84Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983224; x=1709588024;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELwaw5VTcstsInvW3UiboDoD5sly10aWVPSj6o6QXs8=;
        b=bigmXfEqpa5UqlWH+SKC1ajl92r+8+O3l+nE6taPKZnXbVuX2edikGzzfDxIrYGIvD
         IB6Z5tMMiHW1UGupqHHBEzekOwJhnseoKa06JbyEr0JSFAVGE/XGHx9irfq6TCrIkXiZ
         x3WE5lhPkDCDeaF3H2r0CmA0e+OiVWelsf3djTIAXaeqQJxDXewdXOSrSakB/DrBVKFP
         GwL0xCbGt6h/RptBzsYAwYGW2U27c+1WdLJxr4cJWTmEwNjGh4SPYlO8a0RpBNF2tDYS
         0/B/5A3WcrW8txN59rsF6Sq43DC5ioaWfMyKgRFFQ/Q/YiZh9oz4WxIyNIxbOgk76NG7
         wyjA==
X-Gm-Message-State: AOJu0YxQuV3HyfJAsXw76jXgT06KHVeM0ZnuLqjg32eXeTC8co40hk5h
	h6mED2CdhJQ7AsR5QqvPqfwN2yMA4u8C5mTwhn9I9oaHUmBbvbvSq9xlisgs
X-Google-Smtp-Source: AGHT+IHuOFgGJpzm1GPtwHPmfOK6y/KsnVVBmpacG4V9+K2oGorjMPCa2W4HMx7LFsHIlATrdl5XbA==
X-Received: by 2002:a05:6214:508c:b0:68f:9e2a:e049 with SMTP id kk12-20020a056214508c00b0068f9e2ae049mr442252qvb.30.1708983224195;
        Mon, 26 Feb 2024 13:33:44 -0800 (PST)
Received: from [172.17.0.2] ([20.55.46.118])
        by smtp.gmail.com with ESMTPSA id ng5-20020a0562143bc500b0068fe4969e23sm3396697qvb.87.2024.02.26.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:33:44 -0800 (PST)
Message-ID: <65dd03b8.050a0220.70366.bf07@mx.google.com>
Date: Mon, 26 Feb 2024 13:33:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6916105738412826075=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: hci_sync: Use address filtering when HCI_PA_SYNC is set
In-Reply-To: <20240226205257.1671077-1-luiz.dentz@gmail.com>
References: <20240226205257.1671077-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6916105738412826075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=830022

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
GitLint                       PASS      0.61 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      27.68 seconds
CheckAllWarning               PASS      30.38 seconds
CheckSparse                   PASS      35.78 seconds
CheckSmatch                   PASS      98.42 seconds
BuildKernel32                 PASS      26.86 seconds
TestRunnerSetup               PASS      496.81 seconds
TestRunner_l2cap-tester       FAIL      24.36 seconds
TestRunner_iso-tester         FAIL      44.93 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        PASS      116.50 seconds
TestRunner_rfcomm-tester      PASS      7.38 seconds
TestRunner_sco-tester         PASS      15.01 seconds
TestRunner_ioctl-tester       PASS      7.93 seconds
TestRunner_mesh-tester        PASS      5.93 seconds
TestRunner_smp-tester         PASS      6.90 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PASS      31.07 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 51, Passed: 50 (98.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP LE Client - Close socket 2                     Timed out    2.155 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Timed out   10.248 seconds


---
Regards,
Linux Bluetooth


--===============6916105738412826075==--
