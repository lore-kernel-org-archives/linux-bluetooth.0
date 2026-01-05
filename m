Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEC9331213
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624127; cv=none; b=cl8B7mFgYjii91MBj9LVuanosl7zLVYZV0dYxpZSGSSAZM71sVEYg4+T+0aQD0gDYaa8BXKjQy+TZbtjFylCcP10utsIBxeRrU/cLYdy3zrZ3gqshw1r3Spklg3X+YaG37S/uN1ujPEWy0y0qU5rULgsTFxbCfQ644+PtaHFS/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624127; c=relaxed/simple;
	bh=eDzJslPJQLB38C386Zdg/VKXqwfV+GK7ei25/DUhq9E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JRXvFiMHT52jsV0JRFtC0PFIYr8DMFFQLnjpaRfsZUz4IFGfqXvRgfZrVppKO/jINLuUpZSg9Tzi4B5aYvCpNQInxgMNIu8cq0XCEr6oDuO6qB0fcrP1efjkHiv375FMBg6Nw30oZmLfFYf1t9Yn82XkpbrF+1N4r5YAsugUPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibwRBjLK; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibwRBjLK"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8b2ed01b95dso1457061685a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 06:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767624124; x=1768228924; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtbcRxztnxBKbsgMTtScWxtbgywEMDN4kxWjIvmC6HU=;
        b=ibwRBjLKrEaS2uXKzFaXDUdhqzxG9MQV286SOwFSPPOOiSNeNeu3VQwwOmLhD+NEFt
         Ciw3sazWbtZnixJUh7jNsaNErnDtuj0PDvuJvzmsQLnnCLit7ZBAq8XJCz/fltke3pzc
         W4yVK7qeKWixJtKIE7o6YgXJGE8LViXyq8pTEX20VevPDND9iBfykWj63jsxTHzp5Z//
         Ch74+efe8Q/wpbNp4N8gzt3iUcmT+E8AuF+BIBJhO+x6gGnsgFL/AmKcrxgbalp3Tw0y
         43Qw3WTc4F+mHaNBEL8xJER4nWdYbvOXMw8kxSfHgcgDD5F02HF/nI8y1O7TsD/1GYqk
         9GSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767624124; x=1768228924;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtbcRxztnxBKbsgMTtScWxtbgywEMDN4kxWjIvmC6HU=;
        b=TQVcjqfoVwSOAQoelP8afxDl7pIXlFrsnukDeNjbPmwyfdX25xEoHKD7enYaomQYgy
         PcJLgiQABJE5XHYnz8JAgeMrwBPfjU5UsQ7LxPUe0GO8YdL5q8ntwwLPdL1len9Cbh8j
         jqfbOTzM6OvKYwpqUQ4sF4sH0nPnzfTZOgVukhaFP9O/SEb7w3/VLK7ICtt6p7RZnjFV
         8e74CQjo71DgVw5qz8/Lfaa+GyBzz/ijeKypWjHBV/qQLzc7B3FrFIY/zP/+Jb6rTx/Q
         RXAaKBKKf2NAQfJns32fDdJfuqN2nA3j6fwcgL1Rf07G3eZEaT0rUHLHRF02GKZNbZy5
         0FHA==
X-Gm-Message-State: AOJu0YyDNF2Y471hN8FQ9+CXDt4fUrlvyJMMJFLqxB2IRPbUdrOsEw4g
	jUy6ne/hK79AwfEazBh9JAHj7V8EwWT1655ERZcIkRn/1WkTc284sccCBULJ5vE6
X-Gm-Gg: AY/fxX42U8bZ3f4Uj26NwHy/Sv/3gH2NyeVAx0KAo8RjeBPKCUjAFdBe6RIt0KWI6Wx
	TJ+9gcXotZ3YTkFYTNDeaowBaIHFy6x6/iqpg4ubkjJLB/MSKzCwrcOVwbwyGtbodbeicJaNjE0
	5J7AmQT2BQHacMDMBrom+yQvsniyyI3YF6WCzDqDIzL7ZYtPy1E8qlu1OT4uLGGHdYAgAhF743t
	sXJ82x3g1AedwaifWAy41In59ZBZN7nzWDJeDyofuVFgWaV4e/NDJL5K5UVhExlEQfLoBRQ7oVc
	nY8KfEdkFPx/oC0bzDILmsn349Pwa9qcJwWQwsAM7xDU6dCTVzYk4ZhhAXCHOqg4+ErnH4mflLd
	aolQblj9FrG/BbsoRGGbdZh1Vzgr3ocz0ZbUe6/NGFrULcY7FuftvOLksvfuYAYxC3U2lrlLzNi
	8R54Ukr8RiPXj7FP3w
X-Google-Smtp-Source: AGHT+IHWMpKJwMgu700IkOGIxKkZ8vNR3xaoQuSxQfROMiZvsKXOKm72OlIOIfFgbcnaQN7qhYmRJQ==
X-Received: by 2002:a05:620a:4620:b0:8b2:ec00:7846 with SMTP id af79cd13be357-8c08fd02fdcmr6753582785a.28.1767624124205;
        Mon, 05 Jan 2026 06:42:04 -0800 (PST)
Received: from [172.17.0.2] ([4.227.135.147])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89075557d23sm211386d6.41.2026.01.05.06.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:42:03 -0800 (PST)
Message-ID: <695bcdbb.050a0220.33cd64.4a6d@mx.google.com>
Date: Mon, 05 Jan 2026 06:42:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3866313721443140191=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: Cleanup on all setup failures
In-Reply-To: <20260105141427.196411-2-jinwang.li@oss.qualcomm.com>
References: <20260105141427.196411-2-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3866313721443140191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1038549

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.99 seconds
CheckAllWarning               PASS      27.39 seconds
CheckSparse                   PASS      31.13 seconds
BuildKernel32                 PASS      24.95 seconds
TestRunnerSetup               PASS      550.94 seconds
TestRunner_l2cap-tester       PASS      28.24 seconds
TestRunner_iso-tester         PASS      81.62 seconds
TestRunner_bnep-tester        PASS      6.22 seconds
TestRunner_mgmt-tester        FAIL      114.29 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.86 seconds
TestRunner_ioctl-tester       PASS      10.12 seconds
TestRunner_mesh-tester        FAIL      11.51 seconds
TestRunner_smp-tester         PASS      8.59 seconds
TestRunner_userchan-tester    PASS      6.49 seconds
IncrementalBuild              PENDING   0.65 seconds

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
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.205 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.160 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.900 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3866313721443140191==--
