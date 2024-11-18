Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C319F411
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945517; cv=none; b=ndFdd/FEJ2yIGi2zpznN4jIqnKyHM2xzds39ae81vCcOJbsuEQ2agcaH8zlDPxPiZkgZHF4nlLkAB/ByFj1GaaEB7CT+LFqIQPki2pN/CTm8AEXZ3miV7W1i0Z2Ln9n6k8d5kjpdSwYVn2gcSy9ka8h0L0f0NRHt3By7seDEniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945517; c=relaxed/simple;
	bh=L5z4rMoGktWGowPkriiuorPR8d7jOPwGQhRB8dWUTTo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=s7RddN8hXoirEYTJ+SUNPnCPkteJKwetp1NhBzRybI2KYYOf5TtXrb6XjJmLc+lsZi5BMylULwxQcZnJrgUGdYFMfN0j27bUXhJGvqpqiP3GqIov2wDoQ+pTaFNBq5QqLlQf8gtBysYsJAufXaFcbf3U7/x3voZnxrHtjrvnIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBPAZM+U; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBPAZM+U"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ea45dac86eso1489172a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 07:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731945515; x=1732550315; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WWM1YSNFEtjrLGXXl7HYfZzHmcgoOpRCrwHVSacCmM0=;
        b=IBPAZM+UUJG1Ul+0OK9yyollhCM405cX/SdSTmw/QVJ0smKrQoG+/jV805Q+CN/LwD
         AR4VBUvO+y21kJlnzDIewd0fJHJaNjX4pJkviHayV+jEmQB0/MiUYyUWT4D1kaHu7TWu
         HBGIAPWmp4KFxfX2MCIcN2WwrgXFGJTLXzafINRT31DtWZs1vjh+73ccup6Vesl5spM/
         XHMVe6MNShOjEQTGYeU33VmO+LfFf4su6vN1xef6O/wdL0sFnjuGds54l4XJLPayeSSc
         fdKQjPLpaUvVekVOd5GOZVep+GgSKIDNflxN/6xWp2UODbHalmqxKVE/4xSM5IxKb3hb
         u/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731945515; x=1732550315;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWM1YSNFEtjrLGXXl7HYfZzHmcgoOpRCrwHVSacCmM0=;
        b=XR8d7Sx/sLO7mdep+C3datBFGoFVKobEz1qoSslMUFItbeOoZmZJ6rN0pp/e+4e9R1
         gkcijEdQBhM/Gi7vv+YUWk0RmIok+AN5gioDP8/TnI5LL4Bmepa4vBcImdQW62wGjFHL
         dRBzdcDNikoYJAXgGjHvjCdlkehE94EvXT7pV4dNNFJbZYhBOyvTmzKHh07D7HZ/NF61
         z2+kx/DJHRvdpQdU7+r4/bJ9cgSf008Gsz5z4wuH4DG5BoUrML4vM4WdJVpI57iiq0lR
         z36GmTGUAy4K87F5ZSU4DLGmSrfqTflmVQ7cBah07kNnbT6eQqYRIcfgHQPFVHB+1tvZ
         GS4w==
X-Gm-Message-State: AOJu0Yyo3Euolyt/tmb4v2d8SO0zjPvIL/i6eEzVnM8wwRETqkIryJ/u
	tuf+VW5NtrASpUHuY3VQUFhM6n7X558zjp+Mt2wD4h6T9z45931DNdenbg==
X-Google-Smtp-Source: AGHT+IFxuEUKwbUjbOl+zWx6Sms6KV0oOAHuOjz0PqLUkR0d0q7OzZFvilV3IBVU8wXZ5/YQprQumA==
X-Received: by 2002:a17:90b:3881:b0:2ea:7bde:4a84 with SMTP id 98e67ed59e1d1-2ea7bde5068mr4897680a91.0.1731945513496;
        Mon, 18 Nov 2024 07:58:33 -0800 (PST)
Received: from [172.17.0.2] ([20.172.24.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea4ec97e9dsm3267947a91.30.2024.11.18.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:58:33 -0800 (PST)
Message-ID: <673b6429.170a0220.62b31.d574@mx.google.com>
Date: Mon, 18 Nov 2024 07:58:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5825747978079651325=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
In-Reply-To: <20241118153642.2604036-1-luiz.dentz@gmail.com>
References: <20241118153642.2604036-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5825747978079651325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=910680

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      24.75 seconds
CheckAllWarning               PASS      27.05 seconds
CheckSparse                   PASS      30.26 seconds
BuildKernel32                 PASS      24.54 seconds
TestRunnerSetup               PASS      433.25 seconds
TestRunner_l2cap-tester       PASS      22.37 seconds
TestRunner_iso-tester         FAIL      32.39 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      122.21 seconds
TestRunner_rfcomm-tester      PASS      7.58 seconds
TestRunner_sco-tester         PASS      11.58 seconds
TestRunner_ioctl-tester       PASS      7.97 seconds
TestRunner_mesh-tester        PASS      5.96 seconds
TestRunner_smp-tester         PASS      6.94 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PENDING   0.99 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
Total: 124, Passed: 120 (96.8%), Failed: 0, Not Run: 4
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 486 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.202 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.153 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5825747978079651325==--
