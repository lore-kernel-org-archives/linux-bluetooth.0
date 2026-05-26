Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA99843C075
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807458; cv=none; b=gW0SlpgGPRCTfjshPfifpwL/ZdJXJnY3c89y+Nsu/oqcxJXOQuRPM7a6eOY1d+Ff8lXwerVAX7lp0P1IGo1yk1hnn2MJK6hFWrNsXF/xEkLBH9kKU8upRqfqasqGYgnc3WQrWTxMj2z88dHwdYGWeKoa580E/81d+BMSjUpCWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807458; c=relaxed/simple;
	bh=NUCHZaO1lkffxCiYlCValSwfz8cgKTD2cva9iggkGWQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=B3vV0MkQFbacpq6Yn3IqsF8Z/WrqczxX01vfodbms6nNKxssCyCrnqduNWtzEmFQ0qwe+Y9rGL7qaVJSGaNCI3YkB/1XHwYiJxB8y6m+HtaF+jPIw0F4fzQRmBec17kE9rKmhY4xIXOn4iHAULmm6cmfCK+6+7vimVLx8a2FRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtGxs1bO; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtGxs1bO"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304545f5206so5833531eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779807456; x=1780412256; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0AwcvAWnWIvnPexj+jS2NgCI0t/WWEcWVnIwN9fBx1s=;
        b=VtGxs1bO4vKf0UQxM3IDXw3LFvAD0yasCMZmHYlQruoDS4iJOCJK2/p0Sg2ABKT8jj
         2lW1BPJVfC5/bSvNbkFblptdeVnzNSwUOmAHVvDYFJ9l8nAGnaeidCsl9VTTnBZZEt9n
         gvmb2N5L9eh64XPZuejh2i2IwKCs00k0pqgOetMJxrCMMzDiAOzWhGpNwG0UBX5ZZLx2
         a5fJuMa1pXggBV8D1BwkdZMqOUnVf/MlEluFeBiwsNhCMSdGROS9GLOLWC6ywlkaJr44
         RrnEcNI67Pq1Zdm4YVhaW/JIxWvSMuZkM/u9uezLlNHIjMqCEYDNDuBxlXPbhazkmza8
         adRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779807456; x=1780412256;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AwcvAWnWIvnPexj+jS2NgCI0t/WWEcWVnIwN9fBx1s=;
        b=SDQDA4b6oTgQlj2ipUD+IU3N/MBRcrHF6UA0C9T+UC8+14/b9phANPRptH2ftldrkD
         arBNa3Egp1eI6GmbDDv95kcNk+k/Le2xJnI7SVO0QnNPrcejDgtxZPS6UmHcCKOB8lsC
         GagjedNv0Mr59s3B4dFogG2n+J/GjUuoxN69XJmb7DCGXSGbq8JxH1ZlBb0/b9B8+gPs
         9Me7zge1qSZpA6uHOf3C6qHqXPvTHQIf4YR4irTyhVlTCQoNxrU2p3WaZhlAmTkJIALN
         dyH3g8ByAmDpGej6SBb5AwOQIg0yXD48gGNhFBfyQZ0nVZBofRAojMLF3QXXBEuRSxeL
         YxJw==
X-Gm-Message-State: AOJu0YzSW2SjE8ehQp+qO64wlsaG1Z8IfMVBxJ+dFWgdxfZFxEyZ0pps
	1Bj5hk+QuEbTJ8UOaGyNYHYrbxjtS1Rk7Ve3T8OP8HQSPJQqgsXztapYF7w69g==
X-Gm-Gg: Acq92OFwSaa7Kx8kIFzQW8CT8XZUwYwJpGCvndzZ9+ffDSdoVbDslLvXBnhHDYs2VuU
	sUaEdZqZH0mYZdlYcu/fFmVik7BIEbkqyhsCvpuxENcjaRjhXFmEwAzYK7Qjof+mv5+jjsQdYWq
	bWZ5MfdVCuNTeZ5k78BOlH58TLxNoAYd138Zgy4wXQIq5udicWt078od3Mp+2z/khi4P2jaeN89
	79Kqg4dIgbJkvWoSxzghRRIVco005ZNPoIqoVA5lCqJQqFrubxDUB0E+sgdX+VWYTR8QrxFHEy3
	VkiHrwCsitpzjXDwq3Rh13nE3WtHzdI2iz59UNniMqn2ei48gE8HlfdyznXPvqE9+qbTEWXHUqW
	ljLIQ/vyOxJvVwvAtb4YSrL58UTkE0/o/e0OFPMgCm7b05jLXXZB2QtT9zciYlmCNfX+3/6hY5r
	hpclIlj8u5YzjQy25nRw4ae0a7sUhi/Es1kQKoX3SA
X-Received: by 2002:a05:7300:fd02:b0:2ed:e14:42ea with SMTP id 5a478bee46e88-3044914c539mr8414989eec.35.1779807455719;
        Tue, 26 May 2026 07:57:35 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.183.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef4af0sm10441995eec.3.2026.05.26.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:57:35 -0700 (PDT)
Message-ID: <6a15b4df.4a342cbc.2250be.30d3@mx.google.com>
Date: Tue, 26 May 2026 07:57:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0796148588323243903=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, halves@igalia.com
Subject: RE: Bluetooth: hci_core: Refactor HCI reset functions
In-Reply-To: <20260526-hci_send-v2-1-596977a9a814@igalia.com>
References: <20260526-hci_send-v2-1-596977a9a814@igalia.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0796148588323243903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100995

---Test result---

Test Summary:
CheckPatch                    PASS      1.61 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       FAIL      0.65 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      27.79 seconds
CheckAllWarning               PASS      30.33 seconds
CheckSparse                   PASS      29.14 seconds
BuildKernel32                 PASS      26.84 seconds
TestRunnerSetup               PASS      583.48 seconds
TestRunner_l2cap-tester       PASS      59.20 seconds
TestRunner_iso-tester         PASS      81.41 seconds
TestRunner_bnep-tester        PASS      24.55 seconds
TestRunner_mgmt-tester        FAIL      215.80 seconds
TestRunner_rfcomm-tester      PASS      26.17 seconds
TestRunner_sco-tester         PASS      33.02 seconds
TestRunner_ioctl-tester       PASS      26.08 seconds
TestRunner_mesh-tester        FAIL      25.85 seconds
TestRunner_smp-tester         PASS      23.24 seconds
TestRunner_userchan-tester    PASS      20.11 seconds
TestRunner_6lowpan-tester     PASS      22.78 seconds
IncrementalBuild              PASS      30.90 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/3] Bluetooth: hci_core: Rework hci_dev_do_reset() to use hci_sync functions

1: T1 Title exceeds max length (81>80): "[v2,1/3] Bluetooth: hci_core: Rework hci_dev_do_reset() to use hci_sync functions"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.256 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.635 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/244

---
Regards,
Linux Bluetooth


--===============0796148588323243903==--
