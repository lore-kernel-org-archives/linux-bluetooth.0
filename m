Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212AB34A78F
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787631219; cv=none; b=d/QJVd9kW/PreAcsSTBizAIdt2FWVhceo5HINLmIsM+xSSKruDedn10XT8ZNX6JTxQM+sOzKE2RE5gbO+dcrUqNMhUTw7O27XHdBjP+Oj4y199x7zF2Awhel2mj8G8UduYK9YOcgsGpr4PjCq7zV15XZ7FbXxJef+VAjJHGnP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787631219; c=relaxed/simple;
	bh=Mp43KPsHyv4kCXU/AaoauZ77mjSl4bDOAsYqer61UHg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VeQF5QVpYa3izVIbk30FDpz2VQQ8JCHIqseGPwjrB7FteePGDcp22Lcbl5DVlBhelA1CbXiZE8cnIMhBnbvVM0LhMpDjs6yDk1ENfp3+tb9EqdEet/gi+l1E4WsKL1tJn0M3wW/xD6px39KPdT2vdPq6+eFgInKKtEzmEVfQEEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg4pm0ul; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg4pm0ul"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3964e76d0f4so366239a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 21:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787631217; x=1788236017; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kMdCepn7BrMDCo/VRop5ONhnYLOGC98EI6OK5oqAPjk=;
        b=fg4pm0ul2Ww4SJZ8x3p9xWHcW2x91tvlDB9HqMrYvsdhCXbXIB9iDo/ddtjuLz8Hfd
         7t1sMbpZ4POuQi8Ewxk0rnvQ1yZLR0rNbO/l9QuqxuUFpvg3kVQIYza/sF4rg5lDi1HC
         eMm5AqcIj68vfZjOW7eFVUCOkZ1bMUV9r2++QU0wM+rEEc0KNDE6OlTTS+8kOOZfKnl2
         KOgMocuTXXYisxpkIbmtb+uyVwlDoh3KiieUNNq4zfXpAOdkRBWg245IBSuEQ87VYm42
         jZrscv+7YWt8J6hXAMcWCPK+pkcKo0bzq0TEAq80TD/7mQmqYV02aAlVxdRcu0sQKc1p
         ePzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787631217; x=1788236017;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kMdCepn7BrMDCo/VRop5ONhnYLOGC98EI6OK5oqAPjk=;
        b=E0mEUFBBWvboQ3Wt7lSWzFWEVQu4uy6T7GSPjqY44rFc8nkjlV16omKrAwXnLXBXo0
         QM3gBgaPlms4GRWwSXSforK80EjzGFovjHbsiDPty5Sbk5rFLNVMiaaPn2lJe+EV4/89
         HYpNvDWBpnkldkBcTWWMc/Xu4x0QI/i5EB/p2tZmX33QFTBBrcZ5tjvXQBj0fSHPBEWx
         s3i855Y4fNoAf8Y0G5EQl33YjmRHxxrvCQBNqgJPovHkken3MrZnaaEj4+8zYSflGIsL
         rP+l7ossS16YAK1vvlnViu43mj4b625TOLEpuyoHPxeh+iDxkhnELRmOa/goiGnhDkPJ
         /K4w==
X-Gm-Message-State: AFuF++nD24vfYDkWNORxYaneBvlOOyziKnIoGWmS1Tivu5tQIl7F0mWd
	6m3UigowLbFOlUF4xR7FEg7oil5hDc031I0Ump9Ti+Ns0wtYTbE/7jQzC7hZDA==
X-Gm-Gg: AR+sD112L0ZLDgBJdHjgYhKd74gPtMAMnVUhddK3UTyFJsNkY2GiuK9wTw1+GaaSm5b
	I/wZ3ISua+PW7bkof6UgVk0SoyV3NBjv4pWx5WcLG9EEa6fW+qkFLZOFuQdqGBLjq5KEcICr6rZ
	IkQ4SUGbynKzF6OPAE8f7o5VIJAGu/f6f+l3TQMYYOGnB8XKxCgiqGLU69o5lAKjbWTj6N9qzu0
	2w/fxSj99ZB5mO4vG/37+2FevQl7yHaqPq3GgVP1K29jm1pzE+4URT/09dWKxE8pONXit2KQyyd
	y/aHrq7W6nySPCWNbw0ZFtI9diF/asczY3ktrohMCPR0a1F11ZMxiO8EsojS8CmVIm7RCp8s6Hw
	k93SimF770yCx3O80AnGXTOme5caDwqXBxdgA7ORxMmfZ+wlC4jRk0C/4Z0CYZk+yC1CEYgDbkI
	kOPjcNG66yss+wJQASj++UIwJm9YLwQe1mXfEDxAMj5cKjVDgwOJM+ZAfLMjPwSTaFRGw3kA==
X-Received: by 2002:a17:90b:1d50:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-395df29b3c5mr48026705a91.12.1787631217441;
        Mon, 24 Aug 2026 21:13:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.209.246])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860df25csm28759541c88.5.2026.08.24.21.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 21:13:36 -0700 (PDT)
Message-ID: <6a8d1670.4987c784.28b677.6659@mx.google.com>
Date: Mon, 24 Aug 2026 21:13:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0983082415048280444=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, deaner92@yahoo.com
Subject: RE: [v2] Bluetooth: Fix code style error
In-Reply-To: <20260825024148.101643-1-deaner92@yahoo.com>
References: <20260825024148.101643-1-deaner92@yahoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0983082415048280444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1151226

---Test result---

Test Summary:
CheckPatch                    FAIL      0.59 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      27.21 seconds
CheckAllWarning               PASS      30.52 seconds
CheckSparse                   PASS      28.82 seconds
BuildKernel32                 PASS      26.40 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      501.38 seconds
IncrementalBuild              PASS      26.29 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: Fix code style error
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#103: 
    ERROR: Use C99 flexible arrays - see https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays

WARNING: Possible repeated word: 'them'
#107: 
Replace them them with DECLARE_FLEX_ARRAY(), since C99 flexible array

total: 0 errors, 2 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14766286.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/649

---
Regards,
Linux Bluetooth


--===============0983082415048280444==--
