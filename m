Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F243025290F
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201474; cv=none; b=TXa0YmMYJbrGHrO9Lt7q/vtk5P5PzZec+MnoE6NY1nlgX3Q2X/xK59DpzZCSANnoKUmwuLLG7E7t99MxlX8ATh77PKSrgEL5xBqBS3zM0tBvYjYD4lgcetNwcT6Lkrpv8NOTsLSPAWcvT9CTBA3bjnELxELVtqj/x+kqdoWaBjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201474; c=relaxed/simple;
	bh=tvRMrDsxkFlQf9IFgpFczSkkN+qgpG68GkpuuunU3Lc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RfpDdPHih8Hbu3wljemyOqLmgT9gV045UtRsqTsXHAHHKhvz0nIsgqFMY2UCy6cAmKYvbYZCq5Y0Xk+SLwFKI839GMe3jDULWdEuXx4qyxXgf6hi6TCRUPJqQND3SWwqOxvndKMJBYrO6Na+SAPA6IzcZYIKPY1IUOFbr1WP7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGPiB3jY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGPiB3jY"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fe848040b1so14865126a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Mar 2025 11:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741201472; x=1741806272; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/r47WVf1KIIzI/11ZoY3YUelRla3I9Lgks92dcIbysg=;
        b=QGPiB3jYQOguDlHLop2VaxFRtK4eVglarHWEmleMpsVotXzvJrUdAvU/i5lDhvt+XO
         PuNBAZxg7bsYmPX3dsaoyrZxdWZUShYECKoCuoL0NPCBegaMV2BVYMqaNpoCVzzyktgQ
         nhZYFg4SR2ZbmLOtD43BhwIGe2Oprun+7/F8VGutaTWvy1t+rS6CeW2ACKaiELLe3+fU
         Iy3/AG3ijBjASm0EE9/YrFr3t/ReLWwrkHo8mYUCqlHCG4520vrKU/NE3HDMN8TIcQim
         c2ItrK7B5yCmoipjn2h1ks0waYtLpYtm9Kx+Zof3VZJVpoGT2pse82RRmbDa6t2Kru89
         ErtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201472; x=1741806272;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/r47WVf1KIIzI/11ZoY3YUelRla3I9Lgks92dcIbysg=;
        b=ZyuBOdy+s2xlhF/YbB56+MLjdw622J0AXqh57TitKZL5xl81leZ84wJcNdY/fXYECV
         NCc9Kvj9as54+PWVrtPiRGLwEBH+N4c84XBbEkNA4Kz5mIfornKKQ2F6Dh/tSwZugNXu
         mdiECiCvmv4aNIEjxUW1RmRN6uZACoPBUOHNIpIIEc2naNKyawsBZHenAHB3TsNRfHtu
         vxJUNUr4/OcTbMc3qzOS1B5xNpBoAONE5AdLHylOaXwo7hlr28BN7EPFmt0LxBl4Fj6c
         /MKsao4BxtCr4gtUbz7qm2CEweghGha6qxveqfKsNI1OnVc9S410lA/2sDcHw44T1BFI
         sTtw==
X-Gm-Message-State: AOJu0YwpOu9ur1AkfTIDPdy/wE4u61Y4zQ1LxBClqpOii5N09CpDRDV3
	jU+ej7SOgmK0dSJFCKXnNzPim9RyD0XY/bqapPY/76RD2FUWs/I1QEAYoQ==
X-Gm-Gg: ASbGncsM3t5kg33RPER1QFgEibhhMWTkTIe0eIJofstpv9xMLkRalPxuLeOosiFJ6cD
	60ynvWUVpna6Y79nw9glIV8z8M+XbMJjARRh9hlAyOXf1AJP7M4rObetWq/JTSSvKokMCb+k5Xn
	z/8DwOQ+V0qrg2jLERIJWFW6jUjfvqbAfeAW6CZ8pxN6F5/wGQBfughsGVB5dZqZ/hRf047JHhy
	dhh9v9rQ7V9wm9Y1r/neVfoKVmbINHYBL8goF6ZrdMGdPxAlGqCy+ekLaG+BlfljN+hFgXQVSZ/
	Lx+rlKtDgmK1ePzJ7jWFNUHKzfMti470EHOLHFFu41+hDCuL/A==
X-Google-Smtp-Source: AGHT+IFuURK12l70LzR7vGH/6NSQ2Y6KQmyBmQc/oy2POGjZNOekpHZzIitEbNHD4WDZcVuBgbJUNA==
X-Received: by 2002:a17:90a:c888:b0:2fe:a79e:f56f with SMTP id 98e67ed59e1d1-2ff4972cb1bmr6899557a91.13.1741201471827;
        Wed, 05 Mar 2025 11:04:31 -0800 (PST)
Received: from [172.17.0.2] ([20.172.29.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223f4b95aecsm16232855ad.83.2025.03.05.11.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:04:31 -0800 (PST)
Message-ID: <67c8a03f.170a0220.19580a.4062@mx.google.com>
Date: Wed, 05 Mar 2025 11:04:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2042063786204671949=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v6] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
In-Reply-To: <20250305182603.409335-1-luiz.dentz@gmail.com>
References: <20250305182603.409335-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2042063786204671949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=940675

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.53 seconds
CheckAllWarning               PASS      27.07 seconds
CheckSparse                   WARNING   30.65 seconds
BuildKernel32                 PASS      24.29 seconds
TestRunnerSetup               PASS      433.82 seconds
TestRunner_l2cap-tester       PASS      21.04 seconds
TestRunner_iso-tester         PASS      37.80 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        FAIL      122.37 seconds
TestRunner_rfcomm-tester      PASS      7.82 seconds
TestRunner_sco-tester         PASS      11.76 seconds
TestRunner_ioctl-tester       PASS      8.47 seconds
TestRunner_mesh-tester        PASS      6.12 seconds
TestRunner_smp-tester         PASS      7.20 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PENDING   0.71 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.213 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2042063786204671949==--
