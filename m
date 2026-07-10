Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5905040B384
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690013; cv=none; b=oOk/FQU/WJCOklybWiDvJEOTBNxcS5n4Spz4tMHEfiXbZO7M2vXW3aYhR9tzlzdGCDWmAAq8PvoPlWWdiCf+EuCjLIOmGYVZFsxs94bx8l88X/W1tJvlon7Xr000LD71VH7oSWQyfK7L7nw/tJDX9/xTNuFpn14VIiN6mrEQJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690013; c=relaxed/simple;
	bh=eWmsioBjudbSsu0pvggmry0Eja5H4KIXLdlg7lpiSJo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nCzIjfJ+8hcYWLzb3AUbAMNYVKMRPKwPpBH5vS9UmKpvVK/oPFG0KNRZc2c1RGUoYAW1uQ07RQlf4ng8meTbA1Gh+cU/U2qf5lKhxYN0z7o6Gzale3EX5IVZ3zSgnw1fbn7PL2quglHtq26fWRg+fHmkrVmz4MovSQ8j4D80IYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aB7mcuFA; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB7mcuFA"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e512a9a6bso40578585a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 06:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783690011; x=1784294811; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5z8pBunoSAV7ljS+GBmmkt7U77exXsjnQ/i3v9TWRGc=;
        b=aB7mcuFAb8iwnqyns24VjqRHxNeU3UOQToLYEsXT9wXFu/hVYIEOi93VnUBqLoxxKl
         R3JT6DyAA5EZs19G8MGewfDk2afQPE4f4mJ6+w3M5TEBVEFlKFiilAxJec5y90iSIOkq
         P7I0fr+emm41WoKsbuExbkdxzVipIewz6+Vi/zZYQsFZyVd44xoyUvwjO6EqdoSsLUvW
         zCb/sSmSItrpLBRenhnXPG7vP5KvLX1ZGXq830Xwj9GzCsFUurILYAm+PkIFP33BadMY
         fNwzUeCNCIYP8/Uz4pNRHPxt7ne/URPvfwe/727kcNQEuDPOGFNyyhbMAmU+MAjkNBph
         Edrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783690011; x=1784294811;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5z8pBunoSAV7ljS+GBmmkt7U77exXsjnQ/i3v9TWRGc=;
        b=ou47X8pI2k5FIOuZAFDlL4Fqz4gChOyFznZpEXdoDfcXTFUysE6cmVWrC6mBPa5gon
         mlG3olHAkl+oCogd+rXiKz9aofBPzp2DYa3QuXFSNUuepptoFESyZoGAVvm/ivNf0Gnd
         CgYUBRh4lm9LbL/43shNEnY6OhSgS1OtI+iKdxMZNp43u/sYm4x5jQ4railOGDNwWTGb
         LalXddjR3l+T2kskTH8HCMzaZpcHF+y8ZiLJxJ9QU1aTBzr+I9TOu2TtSRGVD3TAJoUz
         xhhz++ne8tO1l5uiEXmtmWYEoL45bllVYn2uTu3p1+xdlVlwr8jiNVsthQxMNHQDwRei
         1B7w==
X-Gm-Message-State: AOJu0Yw36s9rKoXCahbC9xX7cKT4VzqfrgZEgjXDEFn2AytRW9fX2EJ8
	pvioM3567IlPkTuok+p6pJTWHKiwZnZefZc+LeIu/Jc7uaCXOKct5ZMULSiP6ctw
X-Gm-Gg: AfdE7clCiPleYsGpHr+NgB4V0ivB08hnd/IS4zxYbAWhXF0Bitjxq2bpH3ZbrQTGPnm
	e+WhWsd7mfsxr4Ep9Ei6HVs/ryTIxuhPSR16cQXnzWluKJ0hNL+p32Sl7uXy+bX1JkR8qumofhJ
	Fkp2Rg+f/ET/tcctFfgtGYW0UIyTw7GmLuuI1EZxsBxMWEJlE2B95QIHg0N6jknYExdBpL1ZD96
	YA9Dlh3IjfcuDLLDKlnYuXh+nGj1PQtMxLVPY+fnsXzIpXfTjk6WGPNYOeZ22DMe19zGzQBbHvr
	FZjctIlSU7E2UPntAxj3y3MpuD8k4PBmltpjNoX8hl43wrf6Y3qEyD231ilh4WAsnafQOgYPY/h
	WXk+iGz/T2puFuo6Bupq665VliQpAwn3yqzuByfNSLyo0ziScXxSWXwuhoIVOJxn6qAgOtg3c4Y
	u3iPgFxzHz2yGV5f04
X-Received: by 2002:a05:620a:46ac:b0:915:7e22:6f1f with SMTP id af79cd13be357-92ecf5ab8edmr1179795885a.22.1783690010675;
        Fri, 10 Jul 2026 06:26:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.9.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfdf6fsm197170885a.24.2026.07.10.06.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 06:26:50 -0700 (PDT)
Message-ID: <6a50f31a.4567b959.2b1d38.ad02@mx.google.com>
Date: Fri, 10 Jul 2026 06:26:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4999334582801917002=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, panchuang@vivo.com
Subject: RE: Bluetooth: Remove redundant dev_err()
In-Reply-To: <20260710110651.448373-1-panchuang@vivo.com>
References: <20260710110651.448373-1-panchuang@vivo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4999334582801917002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1125351

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.56 seconds
CheckAllWarning               PASS      29.84 seconds
CheckSparse                   PASS      27.89 seconds
BuildKernel32                 PASS      25.87 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      493.05 seconds
IncrementalBuild              PASS      25.19 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/422

---
Regards,
Linux Bluetooth


--===============4999334582801917002==--
