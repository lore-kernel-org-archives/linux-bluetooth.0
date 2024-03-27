Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7504A35
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 05:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515618; cv=none; b=X2LnwazQCw8f9EW3nNrqcM+6gcNQPrpZd+bgECK2TUmtndTL36tPYshM1+r1UDeFARO8iQ7ix/vcKNvUqc18eu+3vfKTDe+J6W8bjnCm9pjmwYCZ+8VMhFuifmAzU55kEFoEsgT00BJgb9hb3Qsf04dtG79hMq7vchGnxCwlSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515618; c=relaxed/simple;
	bh=J16gKWok0Z0lZu65ivKb3MrfBVLY7N+Pavxeeqjyv1k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jMWrrEyKT1Qv1LnSgCIR8g22tqD203Cfl2xrYlE42axwX1T3TTwLIw4+MH/l6V+FrxjjxkPp4WU1kQWwNbHyz6pebKxSo7jbO/4QHIXq5yooV6Z0k9hmC32KPKvP9hcQLk1z1GML+g+Ct8fO1C7Oa26VVb39MrAjYK94Y892uTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPCHcdFI; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPCHcdFI"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69675e3be15so28978666d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 22:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711515615; x=1712120415; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jzzcjuG3zKzb86Q4u3uq08tGq9rxGAw8G+GDn3NmsJE=;
        b=gPCHcdFIo75AJmmDeAVif8NfdtNIwR9DYcbklgU8/rFgHl+e5D0BBUwQVcbspYATsc
         HSzkYhe7YN+XaD4I8pEnzXg7VBsfDgRWRDqBHX4G/9Q+1UBKsS/YWEWXVJV6Z1gWAAUZ
         RSnGnvm4qZJ2lF1OCWqU4GMa3pe5P6iTiVOe7oHBj7JZ/yD0wdLR9Hnf4kLxHy1C40MK
         M85o3T+x0PDO+8iDlQuzMrr/D4eib/wHSXdxmpAn2VE4gJlxWcg/bJuTVUp1SHLFHWrA
         YpWIzlG0HMWAQR8zSvAeEi4IrraRQEc5jd1SN+ATOnORioy2zl+Z8yFz4Z8pkZZI6h7k
         7zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515615; x=1712120415;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzzcjuG3zKzb86Q4u3uq08tGq9rxGAw8G+GDn3NmsJE=;
        b=rRQCSgSrJ0z0qfhl6jL20A9hTpf70T973DfDcLF0/rFKX9QbrjtVKnl/63opqz5a2G
         jTZkuy9rK8UuJhwmvOYHwPyF61fGfu1tPFGDUywEHjwrciuKG+mRVdT2ezoQp5KsupqA
         TALLuWd/lSKaRaXywp4g5/bhzfAzrLauzs6k7IJNhnd6B9kDCWYMztDiAY6jT/7PMciC
         lf/IlwYYKK92xB02npY+BylxunB1Jb4EM7DHOOcMb21XsDOZpEdf+9JwkL4VL2FeoyzC
         Y+Em0JX+8+YdoFW7dRSXvb7KnjLw7YHdN6csAvx+meaSoayKBEbI7J7yC5wd7acKn+3K
         DSmw==
X-Gm-Message-State: AOJu0YzEcK7Crxp3uvmyd5me+oQ40ANDzXmFXL8/Iy5HzNsvU/1hKpwS
	MtQLKSMlsfEhpp8i8HRZGO7rV3ulWT/e0rwBhZQ0UdqPg75d4s4G546XQCjM
X-Google-Smtp-Source: AGHT+IFaJLY2qVGqKXgZZlNmsOXmuT8j4RFtlhihbj5zgzbOxqgb/HiqDzg1b0WuzLZ+3sHF/s44VA==
X-Received: by 2002:a05:6214:19e6:b0:696:93c9:7ec4 with SMTP id q6-20020a05621419e600b0069693c97ec4mr2090992qvc.32.1711515615299;
        Tue, 26 Mar 2024 22:00:15 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.14.191])
        by smtp.gmail.com with ESMTPSA id gw2-20020a0562140f0200b00690cd39da04sm5960969qvb.32.2024.03.26.22.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 22:00:15 -0700 (PDT)
Message-ID: <6603a7df.050a0220.ed7ff.0307@mx.google.com>
Date: Tue, 26 Mar 2024 22:00:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1583038831194279394=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hui.wang@canonical.com
Subject: RE: [v2] Bluetooth: hci_event: set the conn encrypted before conn establishes
In-Reply-To: <20240327043030.243737-1-hui.wang@canonical.com>
References: <20240327043030.243737-1-hui.wang@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1583038831194279394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=838690

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.14 seconds
CheckAllWarning               PASS      33.06 seconds
CheckSparse                   WARNING   38.86 seconds
CheckSmatch                   WARNING   104.11 seconds
BuildKernel32                 PASS      29.43 seconds
TestRunnerSetup               PASS      548.90 seconds
TestRunner_l2cap-tester       PASS      19.01 seconds
TestRunner_iso-tester         FAIL      33.95 seconds
TestRunner_bnep-tester        PASS      4.93 seconds
TestRunner_mgmt-tester        PASS      117.65 seconds
TestRunner_rfcomm-tester      PASS      7.62 seconds
TestRunner_sco-tester         PASS      15.28 seconds
TestRunner_ioctl-tester       PASS      8.21 seconds
TestRunner_mesh-tester        PASS      6.21 seconds
TestRunner_smp-tester         PASS      7.03 seconds
TestRunner_userchan-tester    PASS      5.16 seconds
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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.178 seconds


---
Regards,
Linux Bluetooth


--===============1583038831194279394==--
