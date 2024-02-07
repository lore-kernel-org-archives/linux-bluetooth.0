Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA07E775
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316335; cv=none; b=CSFVp377gfUAT8CScBpj7zF7ku0ZU0HLNvfvH+G+//TdefPIz47Oj59N+LGjZPX9B2WoqspzgG0ZL/I2Yf/Ylov/xIAH/Xne64eYGvNWWo9U5jy0dyppBVxcMqbX/shlKx7ORCvYZY8usopJNsgQo9qgaOFrMJsUmc7QPTBjcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316335; c=relaxed/simple;
	bh=QtuUnC4R99OkqlQyasM3lSXb9hCAszl3ITpBNQU686M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OulldHiPSydUeD2qAoaZ68MKiz31VLnE5eaUkl8gVP1AjABg932bAOgcr6CwlHLGkw7a1bn2sNnIRgA9iuO8at0CkmpJVC2Mxi52oi/CCAkJlDOVQ0OWXM23NdRivkWNfUMMBe3eV/0FYfPtrhTyzfm53ynK/wGzKdRJLzgAzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qq6qvLS7; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq6qvLS7"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e14b858785so369934a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Feb 2024 06:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707316332; x=1707921132; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VfZ2HHpbuarT9nknyAbz40L/dYhUJVI86kXNtRNQ3BI=;
        b=Qq6qvLS7QUYJfBXwmk/IPEaWp/0B0+QGXVOvh8Yg44CIXY3L/nr43sf3XxQQO4yswh
         82VwfNHtr58AUvKmtInDzOwdLrAP4/vuyUGaJHva1hDqhDUOCwXAPyE26G6Fy/zKBzgg
         ZAWXvsl8QII9porg2spn9rhZ3Hity8U44b1VZqyBrDHRwV0u4zQeMFLLXwy0xkVoxkFw
         cfEtaUB855rKe8baspCR6JfPRh6vCT4prW1XxxOGe0Ycx4mt8XHyL5yULAyPAhmYnJjx
         z8k92JC+mJ8oVPvItDn1Uw5FpCjZgk8jTjJU+RmyH1sfFNVCvnbxQBdPLiXEVZ9oEcKQ
         8MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316332; x=1707921132;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfZ2HHpbuarT9nknyAbz40L/dYhUJVI86kXNtRNQ3BI=;
        b=pMB+MrJWEyGPo61TGjO65drpUveDhZf+TwCN5Wb1AM2EtQSFZdB0ux4n4zIpxI3TRv
         ixWQYSbw4Gp1G++6kKiHKy0IQXWbfSny+5PsDOOZKAbr04FlrcNKVzQQIagLknBF7Jhv
         Q+JqUjWcJX/JP9cB0qj9nDugYpEHxugT/SA9jL+ZLWe/Y8O5oYD3YOVmzLJ+zEpkmhjv
         XL0X81+BPSsrOJf4+VyFCVSkViSsIRwJAYUBV/ed+RpsxyVDzOmNVFd3/Ay31yRWnkyZ
         y6ms50JK2JKJyVfh85rNxF6uAkX/HL+G5xwAEBeSpms9b+lWsSa6j59eqgp/dUw6vYES
         F7Ow==
X-Gm-Message-State: AOJu0YzrGl4no8E+cRo24pDs4VCG1gX4mF4Kbv9gW9hqbUVbBc3iFJDI
	RSFK/4B+U7zEpKtfSCz/rc6hTEgFBoz0jTDj4E9bZFa/sJlsxCD0ZMS/4gXX
X-Google-Smtp-Source: AGHT+IHVcUTJpWUlCDbNc2APpyJfcBn9Ne04JnbTRRZkNeCacbqwUiHh0Fki76QQHC0YoZsEh52BFg==
X-Received: by 2002:a9d:6299:0:b0:6dc:5d73:d744 with SMTP id x25-20020a9d6299000000b006dc5d73d744mr6257597otk.23.1707316332658;
        Wed, 07 Feb 2024 06:32:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGbE+NhTfif/tqLjI/TsZPLC9wtiv63mlHRhrTH5Chq3r2s33ac06MNiEkPxeU7dL9ATlmmZblPHiTjdDtk1bCybzoBGKeyw==
Received: from [172.17.0.2] ([40.67.135.161])
        by smtp.gmail.com with ESMTPSA id a17-20020a0ca991000000b0068c9cd2cf88sm631556qvb.60.2024.02.07.06.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:32:12 -0800 (PST)
Message-ID: <65c3946c.0c0a0220.29e84.3adb@mx.google.com>
Date: Wed, 07 Feb 2024 06:32:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8081799890433782484=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: RE: Bluetooth: hci_event: Remove code to removed CONFIG_BT_HS
In-Reply-To: <20240207134211.29201-1-lukas.bulwahn@gmail.com>
References: <20240207134211.29201-1-lukas.bulwahn@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8081799890433782484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=823967

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.90 seconds
CheckAllWarning               PASS      31.74 seconds
CheckSparse                   WARNING   38.28 seconds
CheckSmatch                   WARNING   101.01 seconds
BuildKernel32                 PASS      27.68 seconds
TestRunnerSetup               PASS      512.95 seconds
TestRunner_l2cap-tester       PASS      18.39 seconds
TestRunner_iso-tester         PASS      31.07 seconds
TestRunner_bnep-tester        PASS      4.88 seconds
TestRunner_mgmt-tester        FAIL      110.49 seconds
TestRunner_rfcomm-tester      PASS      7.54 seconds
TestRunner_sco-tester         PASS      11.34 seconds
TestRunner_ioctl-tester       PASS      8.18 seconds
TestRunner_mesh-tester        PASS      6.09 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PASS      30.42 seconds

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
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 487 (98.0%), Failed: 3, Not Run: 7

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.198 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.198 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.643 seconds


---
Regards,
Linux Bluetooth


--===============8081799890433782484==--
