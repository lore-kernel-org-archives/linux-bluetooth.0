Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471C3FD4
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130354; cv=none; b=O+B4e04bFKEn4/aM9nB6zW1mKN2T3oNs2MVMZiFNeZwOp3I3QYsWl2gthyYsPP7y/W9oAbEuKxMT6Q41Gv6yD/m8Z7Shn3fv31Tgm2KNXQY46jKlhGe4A8LmuQul8wXQvSb4EOoYkQFJKA8+cg08v+CWJRAlSDS7+EiRd91Qs3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130354; c=relaxed/simple;
	bh=WnRTQfr9c5z21D9kvT0kKaRGDf8vE9zST3JBQS/Z5XA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SyzNj7mDSv4ySY1ZHOf4apfjlmxZjow7XUC/dJw9cnyl532XU7h1lfNuuubk61F9hrFmf3T2T7Wl9/Z8kAhDOhORPeaqshobY4qi2C6Tgp9MqzzcAoaOLV5fsUChgV9tIiyG0EkkyrRowBVOqWZ5iUPOPwAnQoJDNJ97tnay9Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQvcql9a; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQvcql9a"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22100006bc8so32820415ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 01:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740130352; x=1740735152; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=48lp2iSzLCkVRd8DOl9gr/DfobaZ9GOdKyRQ8MPNrrI=;
        b=IQvcql9aZqFY9m70uvfCEYmYOao41MM+RzSVlAr1BwfqMsvzqv8brjOKBG8msPpwvB
         YRH/WyW9QrOzgOCtkq2p2CExn9ZUSU5y0YgF3Pn7C1AnVkj7USDj6j574mzDBeVXJywg
         1dpFUj7s194Csh+4+sX8DPx22rFj1OtFOPs37/P6Qmz7XL7jMHCZd25nRlXDT6zPvbtG
         mQx61wRAH9CiMdol4saaOZgiRaiD2r5qf00P+EGidy1hP4ymBBGERF2MBvsN1b39nPOe
         Uz9QsNWTCsMG70iVG4CcEHXOjssKVa4IKepWRyMHbf+Lt9EMoFY5BVLyrjc0budwqK5e
         Qc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130352; x=1740735152;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48lp2iSzLCkVRd8DOl9gr/DfobaZ9GOdKyRQ8MPNrrI=;
        b=lWspTiHGGwTZftdyAWYdyDcg+suaFMqswbQ+1a57A89U0Ku0oO0LDsOZOHNqMw3XR8
         eUk6/YnCCBBKhk3TjBIk8GE+lmTLTOYXI5EhGjbo646oJhGcuFkWw53RrwD1rM4vPTNS
         8hQeDB2fUJ6sRFM4nQoc7pLmJzLAajCCdN7GdlS+mRE3PwmfQFjd2r27YWCHiPSEVb5+
         H6wJEW44tU/wMWauuJ/OEv58azr8hkENxERsb+mLSKqCf2yxKUJK0VtTXPRa0un5cuW6
         mLCmp2WXM8mB6cFaWdXrg5h4XWubquuLKp134q6YfGV6MB8bqWJbh6bR8x7ear4bCvYH
         JlQw==
X-Gm-Message-State: AOJu0YyaQJV/D0kFtviq5RgLFQ21AIrTDrsHd4FTpm2EQW7kyERn3vKT
	6dOhh6CjWQwqVw5mtq6+BTZcaB2SS5kWfqi6h7WW8CZtejNg+Yb5pqSY2Q==
X-Gm-Gg: ASbGncvq6IRyjq9FvutxPOhipE84R22K8ra9ZO/q/0yUYf1ik7Fs3OF3QBjmUGik/uL
	QR9/iYXWvbPpj1T09n+TB39L1T0bU7CWDr+rlM+JF9L4yZRRQONVGA+4BxkchWVXoTxIwLqGeJT
	MvW2U7dff4vQl5DUzHExxb2f27KtkRHu0oREzrbNbfgteuh9ZLnWg8SAx5Dd8VHOyEf7BtVXXSe
	5Q+ovm6NFru8ix5tsfV/8DHHdcpQYrDE/PeBNBjL8uuvUGaxPiu76+lwk+DJ+/6CDM15tZnk0lV
	ZzLZmvhkQWWJBgz8Q6vhFrUxmlSf5BfP
X-Google-Smtp-Source: AGHT+IGA5SQsavI70LvlKh3vpFWAwody8VjNdWYChnKZ/jj/285rGyXRUwBjYykpJ4i0tsu9mQIAeA==
X-Received: by 2002:a05:6a00:1812:b0:732:6223:552 with SMTP id d2e1a72fcca58-73426c9006amr3531201b3a.1.1740130352091;
        Fri, 21 Feb 2025 01:32:32 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326a38ff76sm10982956b3a.160.2025.02.21.01.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:32:31 -0800 (PST)
Message-ID: <67b8482f.050a0220.d90d6.6b9f@mx.google.com>
Date: Fri, 21 Feb 2025 01:32:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0346997098808600106=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, haoxiang_li2024@163.com
Subject: RE: [v2] Bluetooth: Add check for mgmt_alloc_skb() in mgmt_device_connected()
In-Reply-To: <20250221085801.2760571-1-haoxiang_li2024@163.com>
References: <20250221085801.2760571-1-haoxiang_li2024@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0346997098808600106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=936340

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.40 seconds
CheckAllWarning               PASS      26.55 seconds
CheckSparse                   PASS      29.84 seconds
BuildKernel32                 PASS      23.79 seconds
TestRunnerSetup               PASS      425.25 seconds
TestRunner_l2cap-tester       PASS      20.78 seconds
TestRunner_iso-tester         PASS      33.50 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        FAIL      122.81 seconds
TestRunner_rfcomm-tester      PASS      7.79 seconds
TestRunner_sco-tester         PASS      11.93 seconds
TestRunner_ioctl-tester       PASS      8.25 seconds
TestRunner_mesh-tester        PASS      6.08 seconds
TestRunner_smp-tester         PASS      7.16 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PENDING   0.85 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.183 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.158 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0346997098808600106==--
