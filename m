Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C80CA40
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144002; cv=none; b=aEJULiO7Fjxn1XVuHPNeXiCKlFulq3ZEB4tESaQDifMEsc4CQ5CUPYNAzGMeFw9hC+RMTWaDSZs5VYlWE9ulhZ4pFtCpv6lFT/aX4WsEHYorHc7ZvC9sk8Cvqb+lPcMG3N0onFiuiXQQbNZWlS+IHV0GhqP1T+SQ2vW6rdxuw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144002; c=relaxed/simple;
	bh=cH/O1OY75iSWmLtQVArqkVYpiT350CACzkiXQTFhrxk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VuxVFCyy0m//DwrHt6Ve1ezeC4cz1+5znMsA4Rfu6SjiPctTACeAg6+dx+29Q7n/5vkK2aDYgCGyVja2VLO6e4jng/W5mM+fqgtmwp/m6itbsVFphUSzQfV6Rygkz0X9rtb8hFIommdtAtDGKoAYZ3Wxyxb0e9hiUEY5KX4ps74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2rHXkvp; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2rHXkvp"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c965efab0fso3792351a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721144000; x=1721748800; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BVlYAEkWBTeMCnK7Q+5H2PkGA9lmBNxpexOPJA/3nVY=;
        b=l2rHXkvp7fqpl9//d72fsvisaAfb7quPqD7UR6NvTLRnXqeCXnw/Phwlo0UZGPD9VF
         L0eaIv6ZvEOlxI/RS1tCEwhQt3SiX38LtfHtQd9tXXvgYS3RSKkN80/sz5FxdPs+lvY2
         y9I/JS0H6wNXX+hQAJwqF2MgyPBTRJhUbyBRKBDFK7uLECri1Otamoc+haKK+WIOe51+
         wcx4zlY0mNT+uIfnux6Z8cQRKK8srTEWZk7+y4a1CZarUVtQOCUf/TRp2511vwOEkjO0
         Uqez21VmTBbZFiB4qhGxlKQ7vSoe82jQyw34vbHOnROBwwZaOyuUTSdMWe5fOSjzgr3u
         m2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721144000; x=1721748800;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVlYAEkWBTeMCnK7Q+5H2PkGA9lmBNxpexOPJA/3nVY=;
        b=j6ccjZB8vaRPCXaP9agcRbFIiXz4HIF0wsv4dIGL+dJNKQslrqPManUzkx174ymAie
         ourlaxhx7ZBGx5C9unHgis8t91W1U1e35hcqKXolFaUiHf/6pUOIUMgYvDgzIfQc5gBd
         7bxJglFM1BnQRwiHkwoOIXvbsGnn/Zwgr0cyxrwDTAb1PRJuW3Q/BuxqExdzBTSJNISe
         dIpr18DzjWrW+jS5fmplu/jRjPnEj7knhC9s9XQ9DnBklXndNvfe6Vxpz65P0FUbMzf3
         Q5JblnWKHqOUZsBUiodom7+7Nc4MRyL/H3Ri4s41Ez3Byj9IcimPOpupd1UbK6RQLIG1
         g65g==
X-Gm-Message-State: AOJu0YwQfZ1AqbsVtuSUvhTH2vdYh5ZLPjiw+YJVhBz/S5cFDm1lGmx3
	bUE2upZidrXAWsW9xVM4GIaRzGrOqMZVwKhYhCyljkWJjk/arOTcUVVADg==
X-Google-Smtp-Source: AGHT+IEdTrWHn8e1uw2ZI/JOhwZUwb0TDQdsTBoGEvRIr6zpMj+1jal6EVGAG6OKOraqPUUQMOjvlQ==
X-Received: by 2002:a17:90a:c38d:b0:2c9:81c6:b0eb with SMTP id 98e67ed59e1d1-2cb374000dbmr2023932a91.5.1721144000000;
        Tue, 16 Jul 2024 08:33:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.142.206])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd7046cbsm8457253a91.55.2024.07.16.08.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:33:19 -0700 (PDT)
Message-ID: <669692bf.170a0220.dd2b9.fe4b@mx.google.com>
Date: Tue, 16 Jul 2024 08:33:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0809749923647800293=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: Fix suspending with wrong filter policy
In-Reply-To: <20240716150126.512727-1-luiz.dentz@gmail.com>
References: <20240716150126.512727-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0809749923647800293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=871711

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.74 seconds
CheckAllWarning               PASS      32.75 seconds
CheckSparse                   PASS      38.10 seconds
CheckSmatch                   PASS      102.56 seconds
BuildKernel32                 PASS      28.75 seconds
TestRunnerSetup               PASS      528.01 seconds
TestRunner_l2cap-tester       PASS      22.05 seconds
TestRunner_iso-tester         PASS      35.14 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        FAIL      112.32 seconds
TestRunner_rfcomm-tester      PASS      7.47 seconds
TestRunner_sco-tester         PASS      15.07 seconds
TestRunner_ioctl-tester       PASS      7.93 seconds
TestRunner_mesh-tester        PASS      6.00 seconds
TestRunner_smp-tester         PASS      11.27 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PASS      28.15 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.192 seconds


---
Regards,
Linux Bluetooth


--===============0809749923647800293==--
