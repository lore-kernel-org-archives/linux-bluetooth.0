Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55518FDDE
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933044; cv=none; b=sQnsk8QmjFkeSgiw9c+WBkbyQRCZ+htj+RdVJr8nXDNltbU3BwymA2K7mrZyi7DF9CxzsLRrPgquSZkV4Z52V/gyEbSZJjHoEwJSXkqKHzKuz1GTY1knOFcCrIa//GgMuyCbDqZWhytzOCE8x2C7BY6MI3aGpzAYWO6Tx1IJsWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933044; c=relaxed/simple;
	bh=zMEsNEHEwLX8P0HtuQHYGBrd4HyKRbjfdb0oqlMWeSM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=czreF55uM8vdNLze+qgprtyDD4j+0o4znncU7vjpOeocSxU0hsUoDzO50GVqZzwoBo+JS36oxXcmlGG0efeFkZV91eFmcCR5sv+cT4hLkQjqQyN6XGTI3pzjgnCcv7TZ8GNipqhbxWt3bKZA1H9MW0r5b/v4cLwF9WN/e1k8XhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pif9vjqJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pif9vjqJ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc73e322dbso10561165ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2026 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785933043; x=1786537843; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W/aWle5s9PzCfI4STm0JyI3+qECbvWiq83ojbUqGOeE=;
        b=pif9vjqJQB/qzhfOGO6654A3htov/Q0xVuRr7uF+VLwl5IWB6bq8T5Xaq+AMp4M6j/
         r1Ebo58aGM6g/+zXtAgEU4LllS/a0c7rojl0fffgWNeG5FRnFs+VpV8EOMqJAYnZIjO/
         c6qESu3vWXtPaYmDC+bVQ1fSX96eB1ysze0NFnvw+sVxI+Hxv4O4N0BkcEcyCf0RCjjv
         QJ0BpihzV/seKvBmdFD9oJJCfza8PN7phZ/64ql0qqzNg7zWhBxB7Syi9cW5Sf5NWiYW
         Bs5roLzhDmnzCXJrNFDghMCee79A32JipgVVMUurZ4w2pyB6tvn359cU3L2pJbiTumOE
         gDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785933043; x=1786537843;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W/aWle5s9PzCfI4STm0JyI3+qECbvWiq83ojbUqGOeE=;
        b=nqMADWtvdWe1PQlTF3SfoqWDo+Uieq5NDE209JcsNcYumSsjQfbc6S4se8xgiM30Qf
         CqQ96DASpMBaKVvH1HV94njld02H0+1x7Vtex/7k2/quueW5EcAWCNwZirDW6Bmm30SO
         4a7XRrGcRFmZ0fWA/2xynd7RYKwUE3afnnkVR1X4cve7VMxCF/ZgIpZw9B8kJGP6+mVk
         2B0a7kQC+4cHuAEbuotTlBbKIIhZ0Hu/GQqanF+nhDjeiMwdgKYrzpSbpOkaCyO3d11N
         w2qxesCA04UqrsHXU7JxbIkY+yAl1YG/4PUHaPwGCsQP/wAONLaQdIA29BF17nPa/M2d
         Nt4g==
X-Gm-Message-State: AOJu0YyMiAixINNUQOEKuTjvJoSKtZIiOiem6T9RBHK2XhVGc3gIzDEX
	XZ/K/yAy+s6w0tGoJBYR9dFHxaBUsPcYz2uHmGPhVIZPX51mbo6LxoZEDfFWig==
X-Gm-Gg: AR+sD11eNam4Y3BmnGBdinLEz7uVtJl2wOESR3+8950Vae+HyOFUBUVUr0zS3uWsJtT
	m/e9nf77Q85wzmqr32sz7NiCtuTxmQ4pSJlXWy6DOUpNRDak+A9rQXNcD4In257rslITlhopOd6
	w/CVK0e6Y4St2QJod9ivf562jzmuUslH6QNeCVwpixjMQhNjM0vX6tXstiwkbYSzpOMdEtujOaQ
	0jFq8nbws4DSQVifmtUfiMT8ZNJ7WrH5O6avf+EBz6xG167MuQA2/KcogetAyT5fKTf5i6fJptJ
	1v2V/BA+M340MO2D+kPDb5xVc7DSh1oSlewaC9uon61tL64vAFYLr+NquVDrBfP8Usxxa++68Kv
	PVTBdfx3Kp9NLOIvhL1qrd+aHnRYP739/v6OLdFcQxJxrZSDeH2ABrvIBuiqMmAqr3ZpvHJA1z/
	67Dc1sbHRZAFMzavwtewNlh8jMlLKiPoIqbIcyGkcLOe2+DIHgtX/uqrVquzmqyBmN8ORJQYzbi
	ufql9k=
X-Received: by 2002:a05:6a20:d52a:b0:3c3:bbe6:95de with SMTP id adf61e73a8af0-3cb85e99237mr7988031637.6.1785933042799;
        Wed, 05 Aug 2026 05:30:42 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.195.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867bc341sm25721816eec.27.2026.08.05.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:30:42 -0700 (PDT)
Message-ID: <6a732cf2.507fc713.ac934.3ffd@mx.google.com>
Date: Wed, 05 Aug 2026 05:30:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6671737522956027486=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhaojinming@uniontech.com
Subject: RE: Bluetooth: hci_serdev: Fix use-after-free in hci_uart_unregister_device()
In-Reply-To: <0BDE51B0554940FB+20260805103612.916678-1-zhaojinming@uniontech.com>
References: <0BDE51B0554940FB+20260805103612.916678-1-zhaojinming@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6671737522956027486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1140705

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      27.41 seconds
CheckAllWarning               PASS      30.71 seconds
CheckSparse                   PASS      29.08 seconds
BuildKernel32                 PASS      27.16 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      496.65 seconds
IncrementalBuild              PASS      24.97 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/534

---
Regards,
Linux Bluetooth


--===============6671737522956027486==--
