Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F32ECD1D
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292466; cv=none; b=JgT+Lloz6cgElgpck+7RWFVWtQyif3wuUuZ/ADuAvBkpDYiiazZhrMJhgDTxo1deUbigDWkSIHQU+0g2Wc7MReVwcpZpFslZXsK7OqLP+FUfOsjNT89gHwjqh1K/N6pf7s1lQxjjXqmDTjHuTf00MMYjE2nStMQ2Ne5vsT7JmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292466; c=relaxed/simple;
	bh=jUalWZhKDMeUB2JzgIi3wz06FrevWvtfzSo5dbw8rtA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XurwM+Eb59RysNBge7ntbY9/jEjMmQ0EUT9HJfEM7rJ6kgjsOSu7UFyzos/8Kv8XRccU5et0IIpqvEb7OoXQx7wH+LWqf8bAqmkmSAFYqZyZZjhJVB8GSkTksMuUC+gA1DDU49JX7g2DTVS+K4W+TQgIgmQZdx4328kZ04297VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLrVyAiM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLrVyAiM"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51a116f468bso5598511cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 02:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782292464; x=1782897264; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aWfXGZqEvR14Ne559zgNQbcnCw2ECVYdN+VwIhdVx7U=;
        b=PLrVyAiMiN1Tu23Fl2zlP0HGc9p/UisuoMwXDh78mvYW4/MS1jqTqxE6U/u8EUfkV5
         nrfGpQBWDjLw+BqYKcxxhJVDFL71nKYLsUcj6EmadrtAVL0xGQ3uiaF0XAovFK32eED7
         vik4GjU/mph/iSt70+6UQott7gYXxHxNe/96q+ljMDn92TftLI+b+Bc9M5hHARrqtVXJ
         2tjaeu+aqiC6f7rw9tqQa3eXE4e6h3t+OPwI+OtxATdj80rrcs/lElWHRTMGO8MEiNoL
         a05osJT4kcaj4H/drJQL7j7uYNo4/xgp4H80iXgZ+pBfCyIOBQ4TYzPadoEcIPu9zIfe
         tW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782292464; x=1782897264;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWfXGZqEvR14Ne559zgNQbcnCw2ECVYdN+VwIhdVx7U=;
        b=mur4ycapgKZhrllT4zmXSITTk0G0MsJ9RMhtbKML0oTGddRZ4biAMVepB0T2n0vpaL
         cHi/bF8WeS2/ZQMkDF6fZr588ddA+IuEV5CpojYs8mgIaT1pEvmHkMZFekdf0+vsdvqN
         a5qrxvJzwLsO/WWUZBxFuA6eOvmJKkW51mIJyAAHyiynCGtgYwLr5D7+EMhxj47490vN
         RaLH4SGhFeVGWb2tqfJPercb+iHgWWp8IWmQblokYcdOmOs0KMRdg+x7SEJ9ZhGz6zFp
         YPMzzTLi5mXlZaH/Q7d/Oy6GwE1sHiLbKeGty5vBCcoeD6/Kb5DOULnnmNqIKxf6G8Ql
         Gjqg==
X-Gm-Message-State: AOJu0YzYpMvgxFLrLwUkEF2aaEvP5XtCa820ZTqknDd9I8rnKKgKGOOd
	8JX7m5ikebAW9X6Kq0asOqUnz1nN0NUI6PedsldAIOru8pv5U99iBkx2aGBOEQ==
X-Gm-Gg: AfdE7ckU0j6Lx22w40BcJJkBUjFM4ZRmqnU8HI5GXSkrM2vZx8bTWqkA4TP+ughWpgK
	NP7F59LsM7GKZ0LJpj66UKACkUcfbgm3jEImb0Ihpk+Y8O57KCFHgCggC2ygNDpvvSBGKJIsfFk
	20Lglb9/nmDxbRF2jmCyQwlm7404p1OwjzTKbOXTDp0CNn+MuvZmmIOG6talphYPtJUyqwEcVa4
	cLzSxfb/+Mgdh0JZuqtQiBX3xqfC1cRvc3ndMPva7RIX9QzMBVxPM3Hyio/+ANLeelxzDsIiIm+
	s13NcvKkAjHaM0lOUZMtab7pO99NCtLw2JBS98hr7Rn+4uApWHhZOYDXbsKcmVu5zOq85LkWBtG
	FaUwcVTzzr0dWKtVdvKzdKUptVL1xaaH7BcpBYw/zZ4xnyDsdMMX2E24sao4UlwjaSOpogcxgIf
	cjh/zyng+EZJToSSP3K2/CvA==
X-Received: by 2002:a05:622a:155:b0:517:8fb6:56ba with SMTP id d75a77b69052e-51a61d8d02dmr36754701cf.24.1782292464062;
        Wed, 24 Jun 2026 02:14:24 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.221.229])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde303sm150103176d6.25.2026.06.24.02.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:14:23 -0700 (PDT)
Message-ID: <6a3b9fef.7f7f1747.43943.5520@mx.google.com>
Date: Wed, 24 Jun 2026 02:14:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6618160824234574904=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaihsin.chung@synaptics.corp-partner.google.com
Subject: RE: [v8] Bluetooth: btbcm: Add Synaptics 4384 chip support
In-Reply-To: <20260624081947.2495351-1-kaihsin.chung@synaptics.com>
References: <20260624081947.2495351-1-kaihsin.chung@synaptics.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6618160824234574904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1115763

---Test result---

Test Summary:
CheckPatch                    FAIL      1.82 seconds
VerifyFixes                   PASS      0.26 seconds
VerifySignedoff               PASS      0.34 seconds
GitLint                       PASS      0.55 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      27.26 seconds
CheckAllWarning               PASS      30.15 seconds
CheckSparse                   PASS      29.67 seconds
BuildKernel32                 PASS      27.48 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      574.79 seconds
IncrementalBuild              PASS      26.11 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v8] Bluetooth: btbcm: Add Synaptics 4384 chip support
WARNING: DT compatible string "brcm,bcm4384-bt" appears un-documented -- check ./Documentation/devicetree/bindings/
#154: FILE: drivers/bluetooth/hci_bcm.c:1597:
+	{ .compatible = "brcm,bcm4384-bt" },

ERROR: Missing Signed-off-by: line by nominal patch author 'kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>'

total: 1 errors, 1 warnings, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14642410.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/345

---
Regards,
Linux Bluetooth


--===============6618160824234574904==--
