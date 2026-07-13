Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088833E6DC9
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938414; cv=none; b=NzJ54h8XbVz4c2f17Mwb3CTjTfW9IllqqNMcubHT7rrALn6qrc48L+rtkuG8LH6C+IOZGLvAIGSdxJqAIzqNMCgcmdn35C7r+GsCJOQzEk5CyTXsE3Q4qKpTyjnF2si14oYFCib98Le8rcxiYGGTAaw1pAbNMQO7x5qK+zlm5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938414; c=relaxed/simple;
	bh=TqlhwixCxhB/45gORdtNn3QtJv3AJHhncYUA+zFC4PU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MrK4M7ALY8c+xvKKYrKMR/0ZHSbYfBty+bjmMr51x2pshpGZAC6ELtWMoLJH01oCfH9XGtvzt1wodP2aLv9KPyWGY/lJWgfcR26ojAiuofP+PqMMd1YPio8dKZQXYen8n09gdCMyhAA99BUbgwnD1SY+CtZXI1WrsK7/lCRqoNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsS04N3g; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsS04N3g"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f186025973so31351286d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783938405; x=1784543205; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N6PdRzuZsgNjCszOLLYUGM2V5y6V8a5M9YCCa6khq4g=;
        b=jsS04N3gvYvhM3bYMOkxY3vU8NJsDIxgXo6Ze4ex9+9jVG7nCG5Pn49cTm58PSHac7
         XBYtQjmXRaj+boyqNiRyipDStz6y4h9ksWcpxrxsQM/ApnoLJ2tzbeyeJGpObAmtTphI
         nSRPFbFH9wKadKwzyOME+Y5wLBKuinapoBJ/ZjlV5x+alk8n4K5o4TO0ZNhpqQGnYmvV
         Isv7fUc6Ng8uZo/L/zbcDqIh4/5n98CVDINvHBHSXAqJ83ZHqJA4WwKk89CVJd42hc2o
         8dOHwK/SdOcAF8AYWXxCOSlTkjPOKOfx/xFX4Jh67/+AJXRdzEkoHkRw23LHI3uevQ+P
         lDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783938405; x=1784543205;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N6PdRzuZsgNjCszOLLYUGM2V5y6V8a5M9YCCa6khq4g=;
        b=lVktDpOmxREVC0yhpWNRWISgxenwYrZ2abKWNZFJsclmM/SOGM7UuYVMn12FNjFVm3
         OCxoyc9UtrqQThu6jMuCZfKhZ9Cj6F1dIrZO0aiHtgTtFnsSYxoKETr1aOZhQJaJR4HO
         lb7jNyQ8V5jsD60hVyMcLN18sJg+uHVUt/fwUEiG43WpCUdZhoxodlPDzsGSLeYZcVHy
         F9e2ReYjrr9jEnssL4ji5oEU/1PDUNZSLEOsmMBPPF4XjtDZcKswWHIX9xpuTcwDVKjL
         jZX175hRQy5A7ol3V9BrMoEoTb5snLnFxmOBMUL9+FIpHQWuyafP9sNX9+MCKEKW0Bax
         mKeA==
X-Gm-Message-State: AOJu0YxYRZhjQvWd3NQFl0YelmXlWvnBP4Dwwh7arJsKvdNrP2U+npgy
	rkmHy0jkkyWDMl6EX4M6oyQno0dl2TWMi9jFPqUUMiGwr3fjxnDhPwruBDgmWg==
X-Gm-Gg: AfdE7cn+zUFUbTAyIHwvPV4qkm9NzRNAh7I9b7iZ0IIVPHtHCtMHxRT9ho6L5ZOnvXd
	n7LXWhU+JY9Vx/Dh5SMiukWUibjLGUckj+c6uy8kfIu+xBiAGg2H3jItydFRN7Lc3J+7YiIJpZF
	yxePe56J2xI8hsXnQL58ebH86ZmX/FKNDJNqJqsbg4mN1zG6ebbPYdQEEbtAAoqmNefEwA9mUwl
	DfUAjnOY94j4Gy6lmDhLVlWho2sQU138x94rBKejdzShQvZCuz5P9SwlUBvV1vDMihRG+4XdCg3
	gxZwlAEQbzBW5nYD5+b0NdHFOR0gs/1y+X2N48XD8OUZio8bLS2EoGkO5uV2lOtA0XkN+Tn+Zgs
	0V/WR+IS+xuY6PNsZi8Md8x/WB/zJFffZVZAV4P8JOl9jhXuhkcIdicTFE4NS4agazQrkGNRKxM
	Zc6yAPCwBROdxkdrlGv2TPEw==
X-Received: by 2002:a05:6214:21eb:b0:8f2:306e:87d8 with SMTP id 6a1803df08f44-90401f71296mr91427116d6.32.1783938405470;
        Mon, 13 Jul 2026 03:26:45 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.221.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e0347sm126560266d6.2.2026.07.13.03.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:26:45 -0700 (PDT)
Message-ID: <6a54bd65.406b8c64.22aed2.ae98@mx.google.com>
Date: Mon, 13 Jul 2026 03:26:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6792728976324819925=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: Bluetooth: btintel_pcie: Fix DMA memory leak on probe failure
In-Reply-To: <tencent_44ED865C14DA3D3823CA85AE1DF2CEBC1805@qq.com>
References: <tencent_44ED865C14DA3D3823CA85AE1DF2CEBC1805@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6792728976324819925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1126490

---Test result---

Test Summary:
CheckPatch                    PASS      1.41 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.21 seconds
CheckAllWarning               PASS      30.04 seconds
CheckSparse                   PASS      28.04 seconds
BuildKernel32                 PASS      25.64 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      495.76 seconds
IncrementalBuild              PASS      24.87 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/429

---
Regards,
Linux Bluetooth


--===============6792728976324819925==--
