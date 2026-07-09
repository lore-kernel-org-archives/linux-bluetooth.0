Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCAB3AA9CA
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 05:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783576296; cv=none; b=Rt7Eoo1OccqXMsl4GX4kcKlEzdACKmi/JcTyKEW1TdHYqXIFWbNO03BRsIgvQUVPbIdzQllgzP2uHcxf5hFH4zdB9zba3gh1Mkc5/RW2kuzSMNB31weGFRzgDnJvynP7fIAyaeiiSiDphK515Nj3WQgL8CQzouwnFgpSTGRFEM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783576296; c=relaxed/simple;
	bh=ybB2OKmcMn7TmbCwyQeugGUV4ujzxq/Kx9k3ZG4YBeQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aUxe9NMuLVYnJyudhgOWJMZQAv6DpQoOYEv3liRqrwzavpjmwxat68sqdLA5D6lkG/trTF58fWvnp93GIWPOhuANP8w6jaFBzz0hs/yuFq2GCq2U3EE6UUm4+rOrOZwc54fCv7hzr3y0onHp9aF1kuewQZseIR8iCX/+/7FsH58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bn6DD/er; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn6DD/er"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c999f162c9aso841665a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 22:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783576294; x=1784181094; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h+cKe9kxqqLJxwo73OfK3V1DB2UotO5Xwljk3WlPyyM=;
        b=bn6DD/er+D/ZQf7C6GuYyq7dY2fXvKqavuoS7X3J7rb5tWiSCEJ1FjTrBzHn7QWdB9
         FpIDsVfAhP/3Qy1dz6BpPeHl3KyxiwxPfXigB1JnwxjV7lAuPCPBWQ9nD/TD7IpN6UBg
         NL9agoORnPLd/GJNX2Krf+DCfndKs6gmAMYkEX5WaCHu2vTRgImoFCm91urTQkBuP5br
         8rDjuMfV5sl/ow3tyBYh2NdIF9CDBUEazie+VqzVJTlO5Cu0jUAsLm0w9Np8KDo+UJy6
         864aH+yCsQ6iYAQDG+oPA+W9hqJhQbbp4gS3Q2phsNSTxPfzUHnC6AzwwWaJodt4Vj0I
         sMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783576294; x=1784181094;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h+cKe9kxqqLJxwo73OfK3V1DB2UotO5Xwljk3WlPyyM=;
        b=EsXde6HpIDSmwrfM1bfTrkJe/DXHWkN1EAUe2uNKujSm38I2M7g6S0CZZre6Apnkhx
         XbfAn3T08iW2PqvBLCvF8KFU08xl2wL4f0AXsTcKPZAyASb6iLgUpDYAi8l1SVkvHZdF
         F/fSf2NzHAwciOi393Rsr+0PxdTAOjAVhrLFhGCTQCjRs9vi4kIcfKrG5RbZfSSZVcEe
         4sT9DQjbk9nuiXy9qKiKmfft+ywzOG0xkMIgNwAY0n8Agmj7tg5/G7x1jfJbt55vl+96
         YV9FjfnSpp89qBSA4Me9LFypUWSr5KBmBN4u9QSwRU4qGFE+DgovcwxKC2kP/mL3o6bj
         dG0w==
X-Gm-Message-State: AOJu0YzjDKoPm5Z+kwbRVdWy08Bs4b0HYCaUUXVlkrmU+9oajK0yLArb
	oqmxvT7TuTs+GMng6rk863q1ujLENGzmx755ovstRQ/Im+N1udfppp88AfNwkQ==
X-Gm-Gg: AfdE7cm3w+MYtEw7v8bZGnzN5ON83xfA9JlXG/8Ci9xgE496IR9toFp+1CWiXJ1IyLp
	OwgLbSVSQVg20Yij0cWzS4gkLzwu3PMUbMLQGq7dOB2BinszfTLyNZ6aswgiHsX3tTJqFL0gYyJ
	6miw5x1AFok92gEui9CGLQh42X169IWcW3HInnkfdwckJjOk15+4XN/AxSJchytvX6GXCYAWzMW
	Dpvo3t3hNMNYuRP3xtSL0nsbUMN8RsH/zTUNhDidcW7kEHoKTQMQ7PXkWd3qFmS8UKeh0OZB2N0
	hLycZRxL+IMAsDDiZlJry6zRsDvWUzeP77yu2/GAwqxX3aMKEOPznkmXdGn3dJLVfLkMh3MiNON
	bbEPJxLJHyleaWISX1ZzkaKad96xGb1zpAVtG8ZImGj9qx2otNjpu4e2Nch4jIxvnXd8uP9o/iB
	CF8ndG8/OadKJgJRhfi7o=
X-Received: by 2002:a05:6a21:4e02:b0:3c0:9c1a:8941 with SMTP id adf61e73a8af0-3c0bcd20057mr6516617637.73.1783576294428;
        Wed, 08 Jul 2026 22:51:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.241.147.96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm24210110eec.18.2026.07.08.22.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 22:51:34 -0700 (PDT)
Message-ID: <6a4f36e6.eb165e5c.1817a5.7224@mx.google.com>
Date: Wed, 08 Jul 2026 22:51:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7528715869050000351=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: coredump: Do not export hci_devcd_rx() and hci_devcd_timeout()
In-Reply-To: <20260708-unexport_symbol-v1-1-25c0f602a92b@oss.qualcomm.com>
References: <20260708-unexport_symbol-v1-1-25c0f602a92b@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7528715869050000351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1124277

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.74 seconds
CheckAllWarning               PASS      29.65 seconds
CheckSparse                   PASS      31.39 seconds
BuildKernel32                 PASS      26.32 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      503.52 seconds
TestRunner_l2cap-tester       PASS      58.07 seconds
TestRunner_iso-tester         PASS      76.38 seconds
TestRunner_bnep-tester        PASS      18.74 seconds
TestRunner_mgmt-tester        FAIL      208.50 seconds
TestRunner_rfcomm-tester      PASS      24.68 seconds
TestRunner_sco-tester         PASS      32.02 seconds
TestRunner_ioctl-tester       PASS      25.30 seconds
TestRunner_mesh-tester        FAIL      25.82 seconds
TestRunner_smp-tester         PASS      26.82 seconds
TestRunner_userchan-tester    PASS      19.93 seconds
TestRunner_6lowpan-tester     PASS      22.47 seconds
IncrementalBuild              PASS      25.13 seconds

Details
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
Read Exp Feature - Success                           Failed       0.228 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.647 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds


https://github.com/bluez/bluetooth-next/pull/413

---
Regards,
Linux Bluetooth


--===============7528715869050000351==--
