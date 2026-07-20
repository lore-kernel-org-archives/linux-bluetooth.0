Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2923C199A
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579264; cv=none; b=KBtesLbf13BhZKfIkFkC5vw4ygvukaY3zx8h3X+VZ0d4YNyAIjGTAANZOfbkOSZUmRa/RwsqgGxVNn6NtV38v4P12FzcbsWapwKajQ+SFhEFcuvYaJ9ylrx3nf1rFhngb6GX5YFGgQH0ucTxq6FbSH8uw4xe5hcb3X5fJvtsD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579264; c=relaxed/simple;
	bh=3vWRgICfr5/gAXmmQ+urGJSR2dHXlt3i/JuOrsaF0io=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MJI4cwTls8QTjbkZPevMHpvCK8TDhTLJJDAJZ+hUMDqW4U+JvW7p6C+IcArXJMLrz9tgvDPZDsEnT1QHkWhDTNyNMp0mU7+K4qiQSdL4fyRDMaKmevGEQ6O8lK+iPaq9b/sMf3RmimyiOSacC+Uhy6jxHky6+w0c4AS34jB6z5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM9y+AnA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM9y+AnA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf50c6f235so24711715ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579260; x=1785184060; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S+jKIufWltCAvyAdODHWXxApoaOSkMUwzm+74L2EY8s=;
        b=PM9y+AnAdt3daO6ULpf53p0WCW00WoDtQM4CEpmaROmVra04d3kdJP22rCIGejZ256
         71+WIumyI0okMxQ5WVsWpmw9I7GemXiU1H6xoZnz2FzbpjdzT9OYs7UlzGRFC5zInQYY
         Ze9O7pG4F6vaFXDw4fBKBCwByvZ8ieHS4WKDOrJFdhtI6jK3Z6x/DfQ0blTbIjw4l83O
         b7FPq7e+KtTIiqa8VKKo+CzoOImw93T0KmlWHnEGB+VpfrrtM7nanBkzYFfRfRh26Hql
         pUzxiLYr/eNSKo0j+S4vg5s83NuMuSk2YCopzsyGJc/kcWU+IJ1TFyyI1N/UqU0VLjXX
         aurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579260; x=1785184060;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S+jKIufWltCAvyAdODHWXxApoaOSkMUwzm+74L2EY8s=;
        b=m0ZH52zRz77DinRFW2ILSQ3hh8MkRqzeMQqCrw6jiZKX4bXBRj5RNip7I/aoXQabbT
         IMYqF5cMCgQ8DAIZkoDh80p9FhUjqjKYo7N9M65DAyw1b1DNdddwvMK9eJbNV0EwoqR3
         lrbUuFrc7ff54AqvVdzMtFZhqYlBf09AxvjfxgPvvvdScb7vot2+z7J7GoMi+4ivZLQQ
         BWETL8iXjvZ95zP6ZRBp2dVg5IGVyTa29p7z8JB/TGHMVJXLNYaRGp8b1G6aO2xGZt6m
         O02FKztvr5e7LrtrHH7OaWPw3TnassD5xqTL94SiiS4IZn7a7LU3VlvSDMSy3j8clr5a
         6zSw==
X-Gm-Message-State: AOJu0Yx23n32CHJQIxw4KPAR9Zh1WVeXUVLqWq4TvCmJT/GauH89/jxi
	roiyvFsh1Y5IvHCqmXro6gnDx7/kpD/T5RdupbUt4LMST95IQIDACL8ffbgizA==
X-Gm-Gg: AfdE7cnhH+/T3PMLIrPm+p7D3PB3sK5gCGWanxnWlMn4PJV46XywcWlIftc3/L3ezdl
	SgwCGwow4kOsuifpT5ytF9j46JEnWX2VZY3iWi/k+a4NNiG/yU/QOxnJezpv+gIbN6s93gPKZo7
	LoDmXSGiqpwd/lmWQoKjbGLZuU72+Uw8EewhmCWfAmME9PW6cFGA+H7ALmPAT1NibxTBS1G2J8h
	LS40ugqXErbXIDCBHn+pdPoozWCyxPLAq/c/IFbi97BdIoylOLXowbs6aQhwft1yjGGyENFbdBj
	V4AXiDX84sRR+Qwz9BP79Lhk1mq6DHjjpY7LOdFD2Yr8g7+IwmDfagKo21kPrPTyq4FmZ3wTtWH
	pZtAR7wRwpujx1ScUv92Crcz1fxfbaNRwJsSnYKaBulJKZfo824j4vBDc+xBtnrdQ2VEomi+GF2
	MySf9+miWX8jJyAa3Du54=
X-Received: by 2002:a05:6a20:d52b:b0:3bf:e66f:2656 with SMTP id adf61e73a8af0-3c3ad9c717amr15709087637.55.1784579260166;
        Mon, 20 Jul 2026 13:27:40 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb7c5sm33349324c88.10.2026.07.20.13.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:27:39 -0700 (PDT)
Message-ID: <6a5e84bb.d2cb4adc.ccd80.33a3@mx.google.com>
Date: Mon, 20 Jul 2026 13:27:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8272079015865563103=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, doruk@0sec.ai
Subject: RE: [v2] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v1()
In-Reply-To: <20260720191322.14432-1-doruk@0sec.ai>
References: <20260720191322.14432-1-doruk@0sec.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8272079015865563103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1131114

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.54 seconds
CheckAllWarning               PASS      27.46 seconds
CheckSparse                   PASS      26.13 seconds
BuildKernel32                 PASS      24.39 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      451.97 seconds
IncrementalBuild              PASS      24.16 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v1()

1: T1 Title exceeds max length (82>80): "[v2] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v1()"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/466

---
Regards,
Linux Bluetooth


--===============8272079015865563103==--
