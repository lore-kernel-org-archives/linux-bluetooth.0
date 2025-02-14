Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F32673A5
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550946; cv=none; b=FQVJ85Vi6M6ZdWkze9JSK6WT0/dQPt9AOIAM75/sEyYBdGOFiTNvcctfb1FvUJVPsxnZ8puc4VN04fFnjZy0iERLEUbppavFFsiY6Zsqw0X3zNIoG2AUbd2nFqwUUqK2UObu6JU3bVptKsO6RJnDeh9dwTk3NxXoEEVLr/+U2yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550946; c=relaxed/simple;
	bh=+SFvHjkQiT8GMAfY3yYogghuSOFTA22QkEeGcB+K84k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YZSF8+6MUGqUGshK0Ho0f3nFo10dAIldA2/ufjMu7xWHZGRd3eKMrO6dBkY2HIedKmMRO6J72TXEWph0ygFJbRgc6/W5xfbATcDlht/woiDPokWlbT3kaJamk4KChvf1o6j8qQI8inoQzjD0r+DZS2cxz10mVRNUYh6t3VsGaos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mmxica1z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mmxica1z"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f818a980cso36900455ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 08:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739550944; x=1740155744; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nYAX7cJDrt9SghiIvWOFZpmcxvj5c9EwPKCKKKJkXhs=;
        b=Mmxica1zG+A3LMTs3pl2gXQHerKkIJckJwRfHWsq9T8fRxS/e9wSulyoNmnpwr8023
         QEOsv/n8D0BIBqNnb/G1IJJSobA+2Lwxf5FUxM58XkDw5yY17QGW5I+CVlNt3dVoHFkk
         ZNtJtB9CoG0gHmM/aNfu7lY6ViYxsy794u+bg1TaXqxaitDgdKCg7w198vMJKMxcU0IQ
         pSTawOp4MeNWrrc8UZp7YImEHGwfiKXGffp0xhyN4uaG4Vqzn3lsxnSc8oPrcy6P2Vmc
         cdf9uXUMktJkuA7S41AErDtFtRHyTEsQ/SXxSFFGMom4BvkFKE5cIUUvjt3aDSapbDCU
         0WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550944; x=1740155744;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYAX7cJDrt9SghiIvWOFZpmcxvj5c9EwPKCKKKJkXhs=;
        b=qdEWww6rhHDsdtyUeoHL1f1cfA/KlJKPVfCIAB19n4RPJ+Pr1dQJR8eUV7lx05mOtK
         p/kgydxL7dafOVPlgv9m3YQVCh2k9YsCvhxjudldrNUoZ9JH/xGjIqgPg4SnHX1NcCCC
         DnPNpgs5DV6e9p9sDf6umNEq7/sQCxxFtO+arZheT54Na+p5dv1LYXZfFMjl37ubXUIS
         wMxcuLhowP8bymkEMgePkhaKqLVTEkCAI/5m/PSqRGZKmQbI3e/zkv9+MePir8jE6TfG
         IgbJH2l2kIgcFIIynlnni5A4iCfHKsCD0uOaJkJVETMmFP6jf8r6slHIoK9jLLiKFVbc
         dCbg==
X-Gm-Message-State: AOJu0YzBerwSWqrzx752Hgsj8WFF+O/VaEwp5/+MEC6Sh1JCE9ZoW8Ev
	Aa6j+n7Wle4cMFL4rit4DFZMtFhZLsMTQzGOPBfyV+AC3ZUkCBQzA8vNuw==
X-Gm-Gg: ASbGncv3u/4WF6tCgs32Bz0PPgzafUevsopsfqpjD2E4XuSYqyhLEjtadh0XE6X9hP8
	d8+7kumHTm+ghgJxEzSGbnYqbO+ozhi+yld/I/oSWmjgR+TBbpkG3RC6qUgUgrYNzLrCBFc8jv8
	QZUwlMcJNch2LJR2E85JMJA83cdr7r2E1R2qSi3kN0jLAHZQB7YJhMxaX72NL4R1qiuv0wuqPOq
	xQ+Oxwv1U+rDx+o9RC2/eM7wpdkPscJ1e4V7CWWdb32EqBpABI/hee/+YixaLgAAr+ji1jtvbDB
	7POlp6Eb0JxkaiHH2AIavA==
X-Google-Smtp-Source: AGHT+IH+dwDbAD4zpqn17tkhprmcxv0QyB+kHLGbAb9MNXkC6nWE8Dx1FXjoi+WDPZEPbeOQFYS8cQ==
X-Received: by 2002:a17:902:dac2:b0:215:b75f:a1cb with SMTP id d9443c01a7336-220bbaafc7cmr182093955ad.9.1739550943875;
        Fri, 14 Feb 2025 08:35:43 -0800 (PST)
Received: from [172.17.0.2] ([20.171.99.223])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5dee4sm3097093a12.14.2025.02.14.08.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:35:43 -0800 (PST)
Message-ID: <67af70df.630a0220.120429.66a7@mx.google.com>
Date: Fri, 14 Feb 2025 08:35:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7697070590659837166=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
In-Reply-To: <20250214153711.887794-1-luiz.dentz@gmail.com>
References: <20250214153711.887794-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7697070590659837166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=934075

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.41 seconds
BuildKernel                   PASS      23.77 seconds
CheckAllWarning               PASS      26.41 seconds
CheckSparse                   PASS      29.88 seconds
BuildKernel32                 PASS      23.75 seconds
TestRunnerSetup               PASS      430.58 seconds
TestRunner_l2cap-tester       PASS      20.96 seconds
TestRunner_iso-tester         FAIL      146.20 seconds
TestRunner_bnep-tester        PASS      4.90 seconds
TestRunner_mgmt-tester        FAIL      128.43 seconds
TestRunner_rfcomm-tester      PASS      8.10 seconds
TestRunner_sco-tester         PASS      9.56 seconds
TestRunner_ioctl-tester       PASS      8.34 seconds
TestRunner_mesh-tester        FAIL      6.32 seconds
TestRunner_smp-tester         PASS      7.23 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PENDING   0.77 seconds

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
Total: 125, Passed: 109 (87.2%), Failed: 12, Not Run: 4

Failed Test Cases
ISO Connect2 CIG 0x01 - Success                      Timed out    2.745 seconds
ISO Defer Connect2 CIG 0x01 - Success                Timed out    2.263 seconds
ISO Connected2 Suspend - Success                     Timed out    4.786 seconds
ISO AC 6(ii) - Success                               Timed out    1.888 seconds
ISO AC 7(ii) - Success                               Timed out    2.508 seconds
ISO AC 8(ii) - Success                               Timed out    2.503 seconds
ISO AC 9(ii) - Success                               Timed out    2.536 seconds
ISO AC 11(ii) - Success                              Timed out    2.501 seconds
ISO AC 1 + 2 - Success                               Timed out    1.980 seconds
ISO AC 1 + 2 CIG 0x01/0x02 - Success                 Timed out    1.998 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.017 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    1.999 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.194 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.134 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.119 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7697070590659837166==--
