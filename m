Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534BD145A1F
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jun 2026 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782653227; cv=none; b=l66W6QYY7agxo7Mls+mjE6VFFAn+9oXbBtSh82HDdwZIpKu2L5ztvuJRSC4OishdRDHbCXnQ172ONPpp2RSUUuBtZrdpaCQ4Km1BCTHAziC3XJkPFa1gGOSmhDJjdqynpzvPAVViMOIgut46q2RCbT+Oo6pmtNqB5WRCNc/+mbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782653227; c=relaxed/simple;
	bh=a/XbCHF2AAz88WysMVW1UugYSK0mi+VU9gKcQS9j3jU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g8t23TWogljQ3VXNmf0EbINuw6I74JZrKbGpnkl7gzBwSyrf2ONt61bXdtk01u8Y0WG6wGyvQuKHotWl55oxhNsiLzs61/SgS9UrqoY0D3qEew7oLimE7Abtn+saygwv6+ItKWVZ/0o+OvtdWE1LBx/pVR0N3TjSFpFsS8NFSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKvgfESh; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKvgfESh"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8eff5ce3b95so1045336d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jun 2026 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782653225; x=1783258025; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w420jD5ZPWUcATG6mLlpc835Lf/eK7dMuTuNpa1Ty3M=;
        b=QKvgfEShAbp7PigoZxRQvoradqAUau7FuYfk0s465WsCnQr09y+ptRKSztTKZrgLK8
         F8AQQPm9BS9pMwz/XX5w/whzDen/gLJA7RTfEXf+qs5DTA7cbeELBQETEXCFp/MjWSKF
         k33PlgD8Ue1EnJWYLdNC+qPaPceHsw+ikSwP3xCYZ/V8WRxdO1PHfzmnRB4ACExVOniP
         v/WJp6caCvPkNGLoNHPTt8tnnWh6/RVjPS2oReYWg5y9dD3ehWlTnrEvGyLcnyE4qcGi
         PVI5JIUCR9KErqMknr+nHB2QzIGI8NIxvRug6jpajQ/io/xN/1mnUdTUAikIoQH3Blgv
         tzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782653225; x=1783258025;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w420jD5ZPWUcATG6mLlpc835Lf/eK7dMuTuNpa1Ty3M=;
        b=Y+7heG04764qHd+RoWN+dN0QIu4BuDB+Kn/hsBBojTj933LUHov6aGBNo63H4h/IWe
         HWggFGinVI849B1pTGaLamBW90IG2gnU9pdiGyEWYBYALzFispzWGVJBF70reifhbMcv
         LRlGim2nS42A25jQxAK0X5LZaC+impjOlRD3nHvLAe9CdUn58J5HfI7qRSjWQHojvlKN
         3d3Fg5llOs2UvwxYtFjbT/OSsXhAQUoNKmY8M1TBM94v2gq407JIynGa2b+Jq520+mZ1
         NUpg4o0lj9Zmq9CkIybdyBQRWWpNh0fT+MBmn5Y5/DX1HFfrn1KdNpTJ3TiJ9HvqISI+
         4O9g==
X-Gm-Message-State: AOJu0YyxDSaAOFe+gWRHG2BrJnmi/E7mSojWueVSYRB6DAjhwcdGC2Qg
	hONADCckP6PVt9RkuUQxxhJ44tXQsX7W/pIk34FQ19np4eQcyNdz8XhvrQMsgQ==
X-Gm-Gg: AfdE7cl0xxiArHEB/3CWlmdIfkHJO5fjbLbYpCL7eItvN4ElGhl5xD+pTNgbLdhzdvE
	MQEM2f3PkYnd3fXifk9SqWxFIRY91Noh8mrfbmEBgnHfVVCu87RC64qJo6gKugWSya1SOK4Yd66
	KWkoJmWPO0sCDmjXFEjlLNvwvXhJ8jWWN6KOMhpSM7VFkNSOfX5fxr0XYFhEdU0UANR32st1v+z
	8zWIXLs0+78C9Rt1rXZ5SyyotrX2fzhT5OgAW3J70538xdGIogYqFh1hDUFD5nNvmgTSAvnSNkE
	H6H4ojRCgKh6PBlSf14ippOj6xyWqGxcmEBQQIxqMH6VOXGKcEJvL0kqzaX0MNYwP5kyUtrgTQ3
	0EzigkGITWXejqHFX0vW70ZmEjgYWKB7020jKcyDPmdDJyc4xWe+bqgRdY6S0n9pkQsNsdOJxO0
	36jGJN5TRRm0JQ8W4skHOqbw==
X-Received: by 2002:a05:6214:1947:b0:8e6:3231:3d84 with SMTP id 6a1803df08f44-8e6d5fa1781mr226695586d6.7.1782653225194;
        Sun, 28 Jun 2026 06:27:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.221.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ea681172aasm60816976d6.40.2026.06.28.06.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 06:27:04 -0700 (PDT)
Message-ID: <6a412128.c76f1168.302ea5.c171@mx.google.com>
Date: Sun, 28 Jun 2026 06:27:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5817394279592380227=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v3,1/7] Bluetooth: hci_conn: hold conn reference in abort_conn_sync()
In-Reply-To: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782645211.git.pav@iki.fi>
References: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782645211.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5817394279592380227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1117668

---Test result---

Test Summary:
CheckPatch                    PASS      8.80 seconds
VerifyFixes                   PASS      0.28 seconds
VerifySignedoff               PASS      0.35 seconds
GitLint                       FAIL      5.42 seconds
SubjectPrefix                 PASS      2.39 seconds
BuildKernel                   PASS      27.39 seconds
CheckAllWarning               PASS      30.06 seconds
CheckSparse                   PASS      30.74 seconds
BuildKernel32                 PASS      26.80 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      496.49 seconds
TestRunner_l2cap-tester       PASS      58.05 seconds
TestRunner_iso-tester         PASS      86.54 seconds
TestRunner_bnep-tester        PASS      18.91 seconds
TestRunner_mgmt-tester        FAIL      210.32 seconds
TestRunner_rfcomm-tester      PASS      24.94 seconds
TestRunner_sco-tester         PASS      32.29 seconds
TestRunner_ioctl-tester       PASS      26.19 seconds
TestRunner_mesh-tester        FAIL      26.08 seconds
TestRunner_smp-tester         PASS      23.48 seconds
TestRunner_userchan-tester    PASS      19.80 seconds
TestRunner_6lowpan-tester     PASS      22.69 seconds
IncrementalBuild              PASS      48.62 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,2/7] Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks

14: B2 Line has trailing whitespace: "    "
[v3,7/7] Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync

1: T1 Title exceeds max length (81>80): "[v3,7/7] Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.234 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.555 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/363

---
Regards,
Linux Bluetooth


--===============5817394279592380227==--
