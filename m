Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF41D1534F1
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800038; cv=none; b=MqvXKXLtdYJaEjRFmVYzjqXxl/Z7qbjtcCj40CtTTa/DOyFumM8pbRulwpDDTZMruXxF0aSAP4uTceU2IJ7XHqNrtgw5CsH4BRrUnqB4YzEGxthzWDm/BdVsfxaspa68xuY4/WTaJFyszF5sKB+U0EQLNNzFywJ/PHGAUBiNDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800038; c=relaxed/simple;
	bh=n2Wb8fhzjHRp/7M3OVvYHQX7/C+xXHkAb71S/LWUdEk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bAV0Jzh6i+gc6D7FVjzrD4yRdmw4TTGXI8iqRFHAR/RLyoBFLcZahFeFmWx6CEfYvtZ6cDa8TYwTjSJ8wS+CajpzOzoDd8VeXxImDR2uHmwEz3ZyqCTLkADNAxX2eZ+k2XQfwpGmzS1Jq/ORWvCwqEWfesqAY/9Dq5yacsmsajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7AIvNh2; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7AIvNh2"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6eb86aeeb2cso2881440a34.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713800035; x=1714404835; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XV4eU7YFeKPrZW/78bHwfiS4B/bgk78K3EFLyjFPsjg=;
        b=g7AIvNh2FRZV52QoEJevtGPIa+3P0nzw4rKUdlQgkB9xXYUZsdh/6K9rAzF3m+0piv
         UhJb4aaugVGJMi3kPL8E7fLYZLkSQVaGcwruuHOlXOm2nWjrQTPrJKe9yQRqtOHZT0EO
         gJuxa+0PgRVNKz8xxcKbXu3k65GuBFXc+V+qBGHBXQaC5CzaoRd0YTXZjt0ACLseNqJk
         AlPRzgoCdeR4nPAs2/APsSudOaCeWh8Rhmg/kqjK3U7P8F06OnNhW8YfkCvtJsdOOgsD
         UMLBPM0Rle4IDTfonHn19y2xuREgivcO8oBDbPtJCMqiuZO9A5t/CHVjJF3bWaos7j9j
         skKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800035; x=1714404835;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XV4eU7YFeKPrZW/78bHwfiS4B/bgk78K3EFLyjFPsjg=;
        b=DCHZqh/mtiBMNImcvVxyB9L/kX6/ukVHnXX6iyEQ2PZoFW9ss5ezEphClWcM/R7YBX
         5PLeGZyxC9ohdVZIL2cLQCEKLbk1ypCptpjUgqe/RuVK8WOtBjfxsh1vKoV5UkKfcxqB
         T1C+q6PIcjwdBvzWT5rgPEq6+bRUj3XKL29yBEUJNHi58vx4Urhm1OfYnTRwkcEgCSUx
         MmaZh3l3IHIr3aIUff0lRBa66Q4Nw0QdxTUAMmRzqgVWWf4q6tz2bMvYt84m7gu9j9m/
         LthobcbjtmR6FM+PB2fQw8CybEKJrG1qSyhS2+GLuAo5XStX/YdWI2YCajZ3bQCkaWUy
         8EMA==
X-Gm-Message-State: AOJu0Yx2n6WMr1W3MrpRm3JYlEnBgxEQQgIZy4WL45cAJ+U7ZBQzEUKA
	C5zkIIHv0dWQnYIDZs6UF+e4lWjhmxnkvfUlqGsOBURzu3NcUhcjHofLxg==
X-Google-Smtp-Source: AGHT+IHkFXS+6D379vW9BuZpwY/1RuS1R0BxrTIeU9c51a3e7ADwSbbMmxyrE6JkdTs/Iw/gxVM8uA==
X-Received: by 2002:a05:6830:447:b0:6eb:7b6f:150d with SMTP id d7-20020a056830044700b006eb7b6f150dmr12636422otc.8.1713800035610;
        Mon, 22 Apr 2024 08:33:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.252])
        by smtp.gmail.com with ESMTPSA id y10-20020a37e30a000000b007907319aa02sm1182744qki.67.2024.04.22.08.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:33:55 -0700 (PDT)
Message-ID: <66268363.370a0220.179eb.3dd3@mx.google.com>
Date: Mon, 22 Apr 2024 08:33:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8442252087634458270=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1,RESEND] Bluetooth: Remove 3 repeated macro definitions
In-Reply-To: <1713797510-24495-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713797510-24495-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8442252087634458270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846708

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.73 seconds
CheckAllWarning               PASS      32.96 seconds
CheckSparse                   PASS      38.75 seconds
CheckSmatch                   FAIL      36.48 seconds
BuildKernel32                 PASS      29.29 seconds
TestRunnerSetup               PASS      529.07 seconds
TestRunner_l2cap-tester       PASS      18.29 seconds
TestRunner_iso-tester         PASS      31.04 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        PASS      108.50 seconds
TestRunner_rfcomm-tester      PASS      7.23 seconds
TestRunner_sco-tester         PASS      14.93 seconds
TestRunner_ioctl-tester       PASS      7.63 seconds
TestRunner_mesh-tester        PASS      5.76 seconds
TestRunner_smp-tester         PASS      6.75 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      28.11 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============8442252087634458270==--
