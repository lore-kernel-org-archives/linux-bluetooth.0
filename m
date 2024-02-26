Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDEF131727
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984650; cv=none; b=l3ahaNwaYrCrtCi7c/Xdy5bYyFkbCS9UP9lmBAt3CH4o8h0y/LFp1tRF8g/SzUQj9xNc+jA/LPcKxeOvMq5Utc9zv7asSB3FD1Cb3N+0UH5By17ehEFuFOLuDTmfY606AaE9sM6ss60/aeS6gJLoZD5O/ZHlXiuUFlyXoNYE7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984650; c=relaxed/simple;
	bh=GgCEvxjR5NgMw41Fm19a6bNY5HrVzM15o35NcHcxRwQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k0l9uHAusZ1aa1UIBpFCbBYKIKgVKR283fjF2LdLCShf2OebLPce4wyuBYEEajNOKO4nhVcpG+crhwGAcQoouvj3AJ+rSBGIc+iTGiPxrYLeCYXrO3sHQQ5sbCn3BCciTSdD0vU4lNEN5L5f2cthKgu+3uiLdhOXkjD5Ao/xu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jom2IIiC; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jom2IIiC"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-787bc61cb69so233412085a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 13:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708984648; x=1709589448; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LHN5vJumEZUn2+/Gag9BxRqQIO2uVmYMOrq5H9GSV6A=;
        b=Jom2IIiCg1rtEKCNTIxc4lcbYXYjXp5t0S+Qu5aDPia9XgXxb4NcMl/NlzS6engNKn
         9qcLRBOWpvyf2YMGZ0u5fTFXMVTIqZ542A68m99kNEtNwaWIGJ4M0FliPNhieBKFbhCL
         1PMn7LGvPmf3IWY6ZqA8+QF2SpnpQtwGKiKG4fRpRkfior96yRtRbfPkCuGyZmMQYnQs
         AjnvXtMItxrHkS5dX7pcwZ7fxool/J32bEUaA3cT+Y3pKGI8gC3zHFVEd0W70VcDMyql
         xM+KMDzXcpGNVzl0A+5t+sGcZuhd8OR/K2cP4npmG2e5oJAQJnmhaRzccgXazjDe3i62
         stnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708984648; x=1709589448;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHN5vJumEZUn2+/Gag9BxRqQIO2uVmYMOrq5H9GSV6A=;
        b=L9LxQm+UBJabseWmW+hj3Z5ZdtGmoTH+F0uEfk9M29rsH3laVNBrMx2j7jJOacMIAG
         vo51s/nLJvZGTQEteXPiZYGT4aRdaXCEySqOup0Y0OhFZSJpD4QmXCNCaNruDC9l5Qku
         i6zmpYfxe6n8ZnUyl0a1m8tMzuklEW0JJR2kkwGOyqrDQJ2nA84Yy4CokrQ3kC+3bUap
         346wmoJMExcqagaG28IiEy9aWOwwy7yT2Y6GEG1G2BbHfya6KCokeLSIi4W39VaiC2ah
         9Tseq4wV5DpC7NGY+qu+q9eLUrxTTUzfLEJr4VKthq0v1dEu/efVSF3DHtl0dFNspDWL
         x7UA==
X-Gm-Message-State: AOJu0YwvWBJAn7OPiPbwGjkMJSkyesTcpUS2me5QW8jjPGJnKZGnvIpO
	TxcZESKuaXynyxuBmIChPsZRgnnl+1fQzRRDB72lrPu3g6BNLLf+dlx3jh0A
X-Google-Smtp-Source: AGHT+IH3GwQXEqMDJDargL/9FuTf9dhv9Exo/X1FenCX6qfdLEGkbhXPeJzixMO0IHJVWP8fl1vzEg==
X-Received: by 2002:a05:620a:51:b0:787:c498:191f with SMTP id t17-20020a05620a005100b00787c498191fmr405804qkt.25.1708984647958;
        Mon, 26 Feb 2024 13:57:27 -0800 (PST)
Received: from [172.17.0.2] ([20.49.55.98])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a16b000b00787b021007bsm2900366qkj.69.2024.02.26.13.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:57:27 -0800 (PST)
Message-ID: <65dd0947.050a0220.767f4.abd2@mx.google.com>
Date: Mon, 26 Feb 2024 13:57:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1139970841176657523=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/2] Bluetooth: hci_sync: Use address filtering when HCI_PA_SYNC is set
In-Reply-To: <20240226211539.1675928-1-luiz.dentz@gmail.com>
References: <20240226211539.1675928-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1139970841176657523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=830031

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       PASS      0.60 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      27.86 seconds
CheckAllWarning               PASS      30.56 seconds
CheckSparse                   PASS      35.93 seconds
CheckSmatch                   PASS      99.20 seconds
BuildKernel32                 PASS      27.59 seconds
TestRunnerSetup               PASS      505.56 seconds
TestRunner_l2cap-tester       FAIL      24.47 seconds
TestRunner_iso-tester         PASS      34.75 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        FAIL      118.77 seconds
TestRunner_rfcomm-tester      PASS      7.51 seconds
TestRunner_sco-tester         PASS      15.04 seconds
TestRunner_ioctl-tester       PASS      7.96 seconds
TestRunner_mesh-tester        PASS      6.01 seconds
TestRunner_smp-tester         PASS      6.95 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      32.27 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 51, Passed: 50 (98.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP LE Client - Close socket 2                     Timed out    2.076 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.142 seconds


---
Regards,
Linux Bluetooth


--===============1139970841176657523==--
