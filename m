Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674788;
	b=dm/2jOyc5O8+sWsto0c94k0IQ4hJ+OZiLxOZ57FQbXsC4yFiAnLLM8ByaxBjm/uOHgnf
	 rN21eKcyeQGTSNpRR8nLldkQlzH7nSySuUxFM1h7WS/98MfpR+bHsHjMGww1iOcJkQYOl
	 t72tAyffEvN4JmpAVdBsVubX/46Lh05S1gz5zr8S9lhTqdmtIO1pXpkXm+fF8g8zSbW/U
	 rT6JMizB0HIzAvFX12FcHw7pRPEjpsnRNnHiZGsVoyiKwXFrY/x9THN0YXYmWRf45zMLm
	 ykGIc4z5D4BnM7jS2pVMPGob8mnJTcbZmIOPbtvQGucR1qiBCEQho2b6wRWlNc3ZuJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=YTM/2qOFeI/YfBCTXaEZScRymrxrsedyFaap3PC9nLI=;
	b=5bE0XloJdH4XB19sght23i1x4DGsv630er0kF4CfNfjA/5SsBh8GTv+EOOf/jDL5Hil5
	 5F6O+idEG2eiMmFfiAoPgM8kCInYOS6eaNCtMggOVZU17MfbgYl/8TklVlar1xlaEJiMW
	 GyGZ6eKDjS65V2z0Hg3RTRaSOJnbnD0CnhFn5GxLoVaZfdT20kOD80jRxX1+ZlYTJo9G5
	 SW+BVsxwkKZlAZMiaYUIuX+k+7OlKZmxe2N9d0xHXO0XkImfQpbqk3Th0glC2KLTzv/+f
	 mkHv0+wNuBMgvyXq0we9LuwvjRZTZADBqxyE5K8dpNpANSrIaXjk8obrfBNagB+gv4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mXt8yue+;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B57606A319
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 13:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86B57606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mXt8yue+
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3080393eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674787; x=1793279587; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YTM/2qOFeI/YfBCTXaEZScRymrxrsedyFaap3PC9nLI=;
        b=mXt8yue+jQbOiUUc8Vlzu0CVS0phxhs/HocftnUmj6bVCZTtEWacLA0PGW9Fzfjq5H
         VG2Fm9S/xy1Az/WlNkNhwldqvFG6Gq/kSETMNZasm5/RK7uD/AYytoGIuRE82D+oSMr4
         9r851bnUFcny5DB4Kohj0+7VFx2qEW8MZ8iTjeAz1AIKUB+VmhBzgSUZWNNppojWDC/z
         AHZmzCaEcZIosNLF2rw683lmigtEZxSZhWf4VQblZvGNAnwDoUV2vK0jH3Ycnb88MX5l
         8UDXnbZbdilPzWrEbfzWVv7BjqBYRnUJK6C+G/UQuT3Tu7GJ48+cBuhf0FR5i0YGY1Gg
         fJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674787; x=1793279587;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YTM/2qOFeI/YfBCTXaEZScRymrxrsedyFaap3PC9nLI=;
        b=SK54iGnqQkTTP7BjME94hWi/BdmzhUZLcKHFTlFUxdoR0yL4G5haeDugmZpqYxT2O2
         /5wofEMz+V/mtFOb6AtO2MOwgzxZCln1epx1fqUsmUeMffG3z1AViixm1TZKLpINqtEI
         fyiP9/EKSbGAWS+otL10udx231CWC14W5/WiDt8nyKWFDq6UEjskrbZ4ut+bO4aGlX3Z
         X3LThruXzVgrtlIHyJOoKg6vtM3lQunxzGlPZK4Sp1cz3+oS7ka38CsKGARa4X6+k9T/
         aR5HGSxqmxLkjleii3RcE4Vzdj1TmY6PQaDP4Inb6qM4eLkV3mXMCDlr3XKg6lFskal4
         /ARA==
X-Gm-Message-State: AFq9FYKjSfgKHjjhw1tb89jJ7IJ7A1civXnJ3SZwbqsetwVskMWVWaL7
	AmS9xVgZV9+cv3cuRUY9piV0Uwx1768BH7FUrPK43t35dWIxZ/1ik2Uf4ifZCw==
X-Gm-Gg: AYBFou15K6OsGqILPezM2mezCuehOFiTCFace0UNk8z7Fkmf+IZveF0eUBn56XvI+VS
	/SoOVGHs0ACWXhNQldtHLlsOuCxmB36H7qzTRQGEjqpK7iPM6htf73R5kcmrgGrCABZDcIooge6
	sN5OjBRn4Vfni9Alpiowrcxnd2HVaVc2q3EA6F6xJFCWtMsnYD4UCpjqVSqIIuqPocz+G9jIe7B
	yUIrb0q8OKU/dgW9IJ6Zv1GLSX9dGsqqgXdD/+QM3ITLYym2bbhprh/uNipa0Mqe41eX3AJMlJW
	cXfuG/KK+mQTdKXAS+VH7zhBlYUUNLlmfQCqQdKd57Dq3Kvhd+LytTpPwrcmZYjgvYlTxpiR4Am
	QO7vlOFS0Gq2+qSVEknvHvRWLGxSbZEAHvJKADTa2WfbxIFVwBzDSoBIF4WlgP+zknPdDg4GCKj
	ksmdYVerC8wqSK9VZpgHH35Z/ZleqRJ1ygkRwojuXZjOSXX5pmwE7dce/zyJjz+8Ut151jpSbnP
	ikg/q95Ufj7DxWmOmK5YFQx9jjtd1WkIO4LFiBnFVXuiWQF0DF1mcNVpHk=
X-Received: by 2002:a05:7301:619a:20b0:35d:ddf2:e986 with SMTP id 5a478bee46e88-3674ce2f66emr6902827eec.11.1792674786330;
        Thu, 22 Oct 2026 06:13:06 -0700 (PDT)
Received: from [172.17.0.2] ([4.249.19.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1cdsm18739740eec.25.2026.10.22.06.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:13:05 -0700 (PDT)
Message-ID: <6ada0be1.4b6e150d.1d9d6b.c35c@mx.google.com>
Date: Thu, 22 Oct 2026 06:13:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1020966930353042392=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: [v3] Bluetooth: MGMT: Serialize power-on with power-off completion
In-Reply-To: <pm-bluetooth-objects-candidate-0063-v15-e728a3f8014489975c69@gmail.com>
References: <pm-bluetooth-objects-candidate-0063-v15-e728a3f8014489975c69@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1020966930353042392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1191273/

---Test result---

Test Summary:
CheckPatch                    PASS      5.70 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      28.86 seconds
CheckAllWarning               PASS      33.45 seconds
CheckSparse                   PASS      35.24 seconds
BuildKernel32                 PASS      29.26 seconds
CheckKernelLLVM               PASS      29.80 seconds
TestRunnerSetup               PASS      679.97 seconds
TestRunner_mgmt-tester        PASS      87.48 seconds
TestRunner_mesh-tester        PASS      5.25 seconds
IncrementalBuild              PASS      27.19 seconds



https://github.com/bluez/bluetooth-next/pull/979

---
Regards,
Linux Bluetooth


--===============1020966930353042392==--
