Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157F549364
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882894; cv=none; b=fpRQlMUWtF2adclbbJ+MAYX9Iv5oTr1d5f9n7RMPVTvGSpnVJ9UGIg+j0QdYqcl0+T/e0hCW/RsFRlw0mbUzxLF4IDUbUvb6AQ+cO/bbU/St55wSj8A/uuE+xJbqMj4soLXxRDnObWe7V43d9sNq10WVknJFIxmxp2NXeKlAPBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882894; c=relaxed/simple;
	bh=lbceTLnD5fBcm/k4qTREMuR/rgD6bWpT3IDJrz8HzfA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UBgJ3fceCTxRSuC3udxI/YnInHtPfR2LnxWH9CTJRVfNCOs1RaZ77CCKTILPC1+f+xZWJIw769inAVA/7aqotSiBf2rC74PCCBForsPfSSh0klpF/wn5HxGNiQVGYmuRIQIEHjKLS0vXmtgIup0Wrr6W6IsewGxem0jQarpCxSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpNLNPod; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpNLNPod"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-398b3c37877so4450533a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788882891; x=1789487691; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nc49H42PnhUUCPeSMC7ZEaT6dXPBaUtXYGvBFWEU7qE=;
        b=QpNLNPodVpL1HHeHeRQtShedjtqyKcmrq2DA3+uvqgvR6XQ9aaJ4VHyVqjH96LepF2
         tbi3mdZYc1ph61ua8rNmqwR2+zoA6TRzpQJXrOoPhNRfZOg1KtP5ItPpvsyvfJPirM+6
         fw5nijNMUlGqlrJBTDyZzHsdxdr5bfuW2Hyzp+fYmFJGTvTbjq09bl838L6LSy+8i3k5
         pD52V3/5Rrjp3oQ8726wvIsiMJVdhPJ/EqB2ICyt5EnFDxIIxUAV4F7DWUm4OBgifhnN
         zv9UHFY0u0vQStimHIVwIPoIGGc7gd2pVP5+cq78rhmtGzdZ541Hcfd/ekfz88tiRZWr
         E/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882891; x=1789487691;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nc49H42PnhUUCPeSMC7ZEaT6dXPBaUtXYGvBFWEU7qE=;
        b=qGOZDqTJ+GBeseyiZAR9eV3KURLDUhDv6brA5skRSXB9mcgNvY/v/ZwgXeWHpOjw/d
         VMqvWiMnaAHLpzM0M+iWt7qB3eT7yPpzIHw/ZdblGTgvp04c0ZSVjsL6JKEpSsJlO39k
         yVjohpoYT9+VPVzveLCzZ//aReJdwFpge3Fy0y/pCJF8jnh4sauCSBO3Np0tZ2qvL38l
         GSqv9EM3Rx4vob19lGgFm75xOHvvacFKlcRFrwNwADp3hkwFatY6Il9a+c1BkeSPd5Pt
         xlotjve392ngyRSdd11mC7XncuNoFtvAZbmzK5G/CaGwpqu3oT0PS7DhYcOgZLXNQ/t3
         3dvQ==
X-Gm-Message-State: AFuF++n6+BWobVl3GSTKDy6D+6/fNwZdW8IGQsIrMEUmApGGTTNZxkY4
	T0ODyjKAUtAMVfEt1BLKo+GSS4X4T3tJ9IBL/QocVtVaujfLp4mBXL0iXwSh9g==
X-Gm-Gg: AYBFou00vNl/SK6Rth8Pzq5Y/nzgkZLjjw3hRGzwH0rX51KByiX2Ml2h/8rLgCL79u2
	Sq+aUyxj6h9Q97qN99nshDhidkGZE9Zxox5dCbJKR4Y0Tq00VCxTgQQ9mfF4Y6PrqREc4i1w/Wu
	0SVb3C7wNUqb9OhIk+RaOBi/nOJOGGqycPKbdELPWRGvO7PonLnhaGPWApMesGPRYlYRlP8P7I2
	y8XPPQoJ+TXBMFPfQ5OyPn82835l1RixqegpabHUesV/3/2Qa7lT+USzHhK/zDW/kyI/0ST/o0A
	/OTg1tgER8sYffzroV7uzQHwGpk9WcxMuUePl2zYjVPiDJwTiZ+HuMa7pyG10zqcQEGMCvoz30+
	20sbjjvPyPOOhWeIWrmpDWRYlMvo30RWov/LDMm2h9kPPcrWODkcaNN01I3qcOC37Jnx7vp8HUC
	/p9v/01iAqV3Ufw5aOCtPaQW4nL69eTtxweOGLFLcq27yAA7dk3Jekp0QfzQgHCpql
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id 98e67ed59e1d1-39b26277b88mr44837893a91.24.1788882890624;
        Tue, 08 Sep 2026 08:54:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.93.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33688cfc714sm18895909eec.20.2026.09.08.08.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:54:50 -0700 (PDT)
Message-ID: <6aa02fca.87bacf88.39a8d.e926@mx.google.com>
Date: Tue, 08 Sep 2026 08:54:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0325199421973315568=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangxuhua@kylinsec.com.cn
Subject: RE: Bluetooth: hci_ll: Sleep while waiting for the controller to power up
In-Reply-To: <8A1A2E77C277A87D+20260907151245.13609-1-zhangxuhua@kylinsec.com.cn>
References: <8A1A2E77C277A87D+20260907151245.13609-1-zhangxuhua@kylinsec.com.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0325199421973315568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1160168/

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      22.12 seconds
CheckAllWarning               PASS      25.09 seconds
CheckSparse                   PASS      24.93 seconds
BuildKernel32                 PASS      20.96 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      385.23 seconds
IncrementalBuild              PASS      20.88 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/719

---
Regards,
Linux Bluetooth


--===============0325199421973315568==--
