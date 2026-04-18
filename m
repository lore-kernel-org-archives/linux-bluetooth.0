Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578A126AA91
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776527251; cv=none; b=CKP2AVv/5jSHrlSSgmQqbcAocz16PZSsupxPld/JkzcwpLk6bGVGYLf3IN1c9cndppWiYAkAYg4ObgNIMv8eYOF7J8BWUGTpwqQxPZGRexQxMjmP0IR5xIE3omDjq/NXC5tbaR+riAljIxdCLZQlm3cGTgfO9FLnKN++NnezC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776527251; c=relaxed/simple;
	bh=fkooYA84iAHO33mmGDGCH9fOoVrUIc4coDHinK+5BZg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Bc1snEAZgstodvlaVJLYXrb6sOtQg3ghgS824ZXxgCz/VBhmvfxDJyoS8dbA+ubYH3MHpPzjM5SZhmEtAKUvgDKeLWF1CF9lmv/UjOiSjIayAyL0LPYEAVhdf8Pu1r/sOuLFge57wuDyN3sHplNeThK/M6nWqlRjSaTXaVwzMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ksg0xoX9; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ksg0xoX9"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cfbbf35354so209907085a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 08:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776527249; x=1777132049; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DouZFKokfxZ8thybrnXS12N+UJh0OkVrzhmkWepULeQ=;
        b=Ksg0xoX9lvMNDFQ5q3nwue7PgfR/t4Ujo+6Ptwy8pPrBdVYq1hpvd/sHob8A11n3Dl
         vJ0bIt13vG32URgDaRtgGy4TIGuGGUpC1i5tnYhVM4fzLbnW9R6Ntt1rycKQB5vAJOQL
         7gpyqg3J/8A6pgLCTo9B6Bcev7Cy1SpW2QOqEDeG2hXKjCbHiuXvHVrT/xuprDEXJyy2
         y/IDs+dzvpWtC3QFTj/+P8JD9pjaOEj9rNSuA5WDfBMggT57mFJir/7A4METf+5C8aiN
         /7bpMV1B+TFStNsxhkasm+ugoeM7K0aK5UAxGRZNS4TWbV5j5tzu0txKI685WMxabYcE
         EfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776527249; x=1777132049;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DouZFKokfxZ8thybrnXS12N+UJh0OkVrzhmkWepULeQ=;
        b=CObclqhL44LzyWPTAt54syiztAIm28sCCTmRWEjr5mj+g+R63kr/zd6Nc5khju5/Tg
         R2HIQFHSPF7I/3IafX/XV8f9nqVNkQz0G34QnFqIeEHvy06vloyyc45mkpzovM/engI4
         UxRnhQeaI2/0pxhKFnLDTJuL1MD65JzXLkKLGP0tnlU1QWFUPDgF1ykNfmeuJPW83YX4
         wJ7W1AIIc63zj51HSmHOb8pnVSeHhHure4o4SU2WcwlJoB4Ycfq2brKqiXUtr/bmq90a
         Qz+9rCUnZJ8+2oOJKp0xHsps/Bilih+/s0QeNIWxKZeiGokYQ00olcB1Dfs35Z98jOef
         AqhQ==
X-Gm-Message-State: AOJu0Yzh6h4790RjV+LkDxpOMnGUOunv8lhpJx5NnVmDzL5X9TLnv+4x
	XAUtCGp99A+G5QoVAqISQptPjMGKx6NpeXLeyd0fHnG+LkiE6cyUta89LmTrdQ==
X-Gm-Gg: AeBDies8D3UJIGxGoMDa89QE0/XVeaBlJxa0IZYEURrQ4pkz5AWSjo+GcR4hmZTFYt9
	2iWxwAuF6E3+HvTFM+FrgeorFPu4FHPaYUy41zcEdcVhanX5FNxNqEAhfYKaBFOqp/jepoQA3/A
	LKuQOSRvKz3rNenZr4kkN31i+AEEmkS+JcUcbc8q+ooHZuzyV43pJJjx41lDXY3WwFvq+/HdewD
	WydD6XzoNV1atO9NYj7DgG77zzjqdZexQZMRlG33be3vqeg0fXBATKS3x7sdkzs4FjiD9yM2duj
	mkpLe4gHdtQCAz7Y4oLT5ZKenP3fOAbkLzYhfLZFEuU1kLVayUbkqUgnPbNMh6f8lIFRKNI3+tu
	gf80z3KI8wquaM1njVuZvezUMslQnEUQfoCRVYpNTww05fpD7Pmvrl/jgiSAJZcw0UlyCKtBgq2
	VHwRVdUWh5jmWnD31TF8xeCY9kzmlUg16j+WFQFy1r+A==
X-Received: by 2002:a05:620a:7107:b0:8cf:dd63:fae7 with SMTP id af79cd13be357-8e7913c1ff2mr1088525085a.34.1776527249042;
        Sat, 18 Apr 2026 08:47:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.45.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d3204cc6sm369530785a.0.2026.04.18.08.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 08:47:28 -0700 (PDT)
Message-ID: <69e3a790.050a0220.382ba.7d0f@mx.google.com>
Date: Sat, 18 Apr 2026 08:47:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7783463013003508815=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, condorachest@gmail.com
Subject: RE: adapter: add DisableDiscoveryOnConnect option for combo chip coexistence
In-Reply-To: <20260418141127.243863-1-condorachest@gmail.com>
References: <20260418141127.243863-1-condorachest@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7783463013003508815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082799

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      20.26 seconds
BluezMake                     PASS      609.83 seconds
MakeCheck                     PASS      19.27 seconds
MakeDistcheck                 PASS      236.90 seconds
CheckValgrind                 PASS      277.51 seconds
CheckSmatch                   WARNING   322.18 seconds
bluezmakeextell               PASS      166.35 seconds
IncrementalBuild              PASS      595.91 seconds
ScanBuild                     PASS      922.27 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2054

---
Regards,
Linux Bluetooth


--===============7783463013003508815==--
