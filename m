Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50690347C5
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783254288; cv=none; b=PTpG1EmDusykfsQZO8ApLIQsR2bfZUr0HsXMrs9qHJV9Zf1HUjU3uavBxtZGSUd27fRUhB5N7m7gADK29EpZLoSmU/cCmJmPVl1zXCZ/ExvAwI1jdQUEWE5dW05JNfT7WnCCPQkquqHmF6Lgmr5MRbqH6Cw/JcvuBB6B0tOoesU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783254288; c=relaxed/simple;
	bh=6VGv6evtIRXEsMIZCwAP8FxdPkwES22C02CPNow+CdU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MEqk9s5EebCTCdqynrmXo2/LofBE/3wY+O75H4dfxt/r7cH6qBz4Btt7zszx/S9q31+RR7NJIXCE7kQKYUf1iqBmcJyehBLTocrzbntQFuj9TEuGsaHZLX8fbzWwxlipHuYOwcyy2yuEfRIiSZwLuSmMz780wYOpCn4F4IBmFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UauY6NFV; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UauY6NFV"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so1761072a12.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jul 2026 05:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783254287; x=1783859087; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uGAuGTTpwCnXMNELtLsOt9mkN0D62XcESgLoiJvYK1c=;
        b=UauY6NFVSVoByyinMttuJaDb+k9/zImXFs+Z7t02mlbHWLAf7JFYCMlx0N7azRgtEb
         EhfdrDDOHUBuycjGbBJxMWNMO/MW+OaTjPp2HccusGnl+RAT1HuCGk27317vRtC+s1hd
         4m1RBR32IdVm+5lXjcVTS0a6yx/kRNe7oDQE9XuTlYuuFzqDXOP94OUfuGRa8V9JgTZ0
         LByRoDyqbS/b5+VEV2+Gc3yih6Q/XjRCVSMZbSyaDK/N66atOYTMOLR7LAX3gZHHlo17
         LCPsiOVRSiAAozEaSNygPbcqYJ3yMbSYmCmuUQUTQlKmiedvqiT6L8/wDJp8uGbttSIq
         wClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783254287; x=1783859087;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uGAuGTTpwCnXMNELtLsOt9mkN0D62XcESgLoiJvYK1c=;
        b=ZPm0nH1XRSgtw5owvTPo2HuXBLMziw9Hyz11LSLigcJX81oSiWiI8i2uexIjyUQOkj
         P5V3wEtnPE4ttm4jY9Ad08Fx+ibaOg8rZQmBvdWAJKGUvh6zKjUaPDgyMJmTUDLZ33M/
         FlzpVbcMwTsKa/ws456npH9NWePcxnw9I/DD1n5XADbwrdULxeb6/2yhnTsVxHZ7e11t
         nJeZcDEstGFMetW/PDyyO4pBavyrf62Hi6W8qRIsTAU6wFrZkGH2+ehCNOXLqreGcYkE
         wFwgt1Zkc0XdrT/QqyFfLtvss8dEpKBXbeLr5fm11R05hdnTGY6nxbbEPE6Inh8ODZcm
         mLdw==
X-Gm-Message-State: AOJu0YzMqUAC6d2lttJk5sXS45N5loHl3g/9KPH/wUl9KylSokD7O5Xr
	wBIyPvN+vlJAeraXZ6hqZrv/CCxejU18BzzV7pq2Cdj2UaY+TlcgQ9kFhGDQ7w==
X-Gm-Gg: AfdE7cka1B0riwukAprG6uZzXyNdERadn77/cie6JSs8BB+PRg3h2dNsL/yQlycX4GX
	FISssMkk2rzCKr05byN3amUZ+u1nUT+EO1+uQjoPvDsw0Qrh+o0gdQZL15AEk9iX9nE4O2fQ18h
	Q8osFKf6A27b/h4M/HcHjgM73o/gpwj0oCkl428nFopwCcgytO6Yy4FU9jNjFzPU+0Bvv9eBaPe
	B4Vt7+MtFRXZ0eT0f2t6hGgsIKE/PCMMKpi6X8VvmnYCvPW1xZVMZ9gH1aY6U/gExxQes7s3Tp7
	tDMYkC6bYAnmY7bqIGvYmO0Hy4XVwu3dyhrVIK0jVGpSZY++3ttgiqDVdspLOD1aGiAN6iOMsW1
	bRaxZwdaMFzG/dEYxB07A6gU+xMq9rQZJH0e4+/b2a9ITQnNUd5r1Z3m4X4L4t8vh/36KDDXF67
	QacdnSAQ3oWNfvoxnAyXv2nx6dWsW+bQ==
X-Received: by 2002:a05:6a21:48b:b0:3bf:db2a:d164 with SMTP id adf61e73a8af0-3c03e51e2demr6784908637.53.1783254286573;
        Sun, 05 Jul 2026 05:24:46 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.31.97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7682acsm38114675c88.0.2026.07.05.05.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 05:24:46 -0700 (PDT)
Message-ID: <6a4a4d0e.492e23e4.e71ca.2afc@mx.google.com>
Date: Sun, 05 Jul 2026 05:24:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0882489324321647824=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, doruk@0sec.ai
Subject: RE: Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v1()
In-Reply-To: <20260705115650.81724-1-doruk@0sec.ai>
References: <20260705115650.81724-1-doruk@0sec.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0882489324321647824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1121769

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
VerifyFixes                   PASS      0.44 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.62 seconds
CheckAllWarning               PASS      29.78 seconds
CheckSparse                   PASS      28.33 seconds
BuildKernel32                 PASS      26.47 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      509.22 seconds
IncrementalBuild              PASS      25.23 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/399

---
Regards,
Linux Bluetooth


--===============0882489324321647824==--
