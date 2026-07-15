Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721352F3C3E
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122998; cv=none; b=n0OLNEjuR7Oh06k2vixdcU17Tcw/1UtU/RwhKsGmatXXbCjrN9cD5BsLKrYc4eykNLVgL7flbxLzZu4QjRLXoQZDx9uhQo9kM8QTiFbrR8fP7iizQVyCiaChHa4jpMJji2KbHR/XkOLMxJ4f/0mq8SgnFiNP2PfJT+v1+YmEi+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122998; c=relaxed/simple;
	bh=LFDZbMYmv6aFMWlhksfbkxx0H9NQtdqbd8diwHoUFPs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DvWOQhLJ87yXL0L6zNMF1nQRkDbRpUL94RRkGeFCJxeF7SFmjbf0O4Hbe4CFynu6FVZU+h+myb3eaNOHMogCgkPnKARYuoDLZ8KDqz0pbfCnyJgdwbR/G1w6GBGo2jbxMAIHCGfkaNG6/7cMMHwLUXZ0QtP/DjQSZnX8qWQgNWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9iZ6nX3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9iZ6nX3"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38759bcd877so4753642a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122997; x=1784727797; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+ejShf/orR1tpK68ogL2BKTZqYG73hBGqEz/RRksMdo=;
        b=j9iZ6nX3kXCaPcdXaclt4Nqnv4XRNZIOO2/RIr5RCgld3hrQjcpGIL3ctOB5JvoP6L
         ueH+AoHsPqlWVMT0cn6d6o6yBYk9S5Z/VR6Vqn+EYGVUzR0uXPEDECgP4rXjsqfbZrW/
         AQCt19XQOTwUCLF49CmLs8fIT+0PMYTgfAcHIYgbkHaZfXTMc3UiPH9q7u4IXsKtu/QI
         8NVaabyx6WSy3L1ej41kXa+fXsMGOiqqQbichaSoSuCEQjs8I68cf0Q2rbCBWOl6SexT
         w1mi4YEP7LUYzFtEUfJlYfWGEmHIxVJM/e46to9S4+TGVLW3UMacThrd5ThFgq0XpxmS
         71HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122997; x=1784727797;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+ejShf/orR1tpK68ogL2BKTZqYG73hBGqEz/RRksMdo=;
        b=XccW2nJWztxTW0kgP4f8DctDGtc4aOgvKR7e5xK8AnPm2vc3UF0ywMIVgKpk8I6gir
         wdPU/LSzOYBw+7gqgvUxygzskvidyXsiVn6rr7jqPCdZ9MMrmAFgpmzNTEFrlThE+vKP
         hkKsoEqDdjV1kGirPZBN//A/qG/NdBWrv0yq6ftHBuyYg/oeVwEuWK7qGszw4M10OeQ+
         1go/5sDuo5Y0rHpE/GlL210uRpwSYIKzic1cJJs4WcpmyqRqR5H9j55RLzgtgIhUV6SH
         AbDvjLjX3/87EAngCh9pEif6m3Z88jBTdc7+lynNsnw4qc8zS1DJvReTtdnXokbywM95
         GUMw==
X-Gm-Message-State: AOJu0Yy05OADkxVrx1DKVqff++64RLwLmIwt0YnNUcYvny1ySuLfFnFb
	L7eiJMVwynhfM9R/IVFrkZJI6E4aYirQ2nbE8UTylgJBo/okObqCC9/U8GBqdQ==
X-Gm-Gg: AfdE7cleoeN5lWm4D2hGFNZ2YintclrXuMCkWiGYzKDnmfFNMxRRC1wvuQwOOHq5/d3
	V1NZY218nHWudSPJvmlxkSqkA/rXaC4PZFzV2vYxSoj6ykknkhNoeNtH4qgSQrdkaddzFdDShWq
	rUgTS4oDD8H2qex2rc9E4mYusmUi5BIV0S37lxacNrql5Ov0z8ih9bjxIScPoYZQ7KheQzIgEH0
	Vb7EfEGO1LKkjAZq3SLHL7MXZZLn7n6WDQRVayoDN7YYmj0WnQU8rwYa970rwn5f7Qxg+GFHvce
	tqmH7HU894TgCtYRcfnq3JbSR7ivqzvWfCN2mZdNOJLmC/Ddqt4CGwdePOeGaXIj1Bi4hNHloC8
	u5Rr8QQ7dL5+Ip+/Aiey1Q8xgC8+mS4RWtg3rMCqjU1nlabcwkj2Vm538NPf8Ar/Bkf41B1d3jd
	EEjS18d7f2byXV36n+2qGW2GqM0Shf
X-Received: by 2002:a17:90b:4f8a:b0:38e:e9b:ffa7 with SMTP id 98e67ed59e1d1-38e2a0cbae2mr2414446a91.28.1784122996743;
        Wed, 15 Jul 2026 06:43:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.47.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6c2b17sm2689403eec.25.2026.07.15.06.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:43:16 -0700 (PDT)
Message-ID: <6a578e74.bd93e731.18e8ee.4c49@mx.google.com>
Date: Wed, 15 Jul 2026 06:43:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6922974079321863224=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sammiee5311@gmail.com
Subject: RE: Bluetooth: virtio_bt: avoid OOB read of build info string in virtbt_setup_zephyr()
In-Reply-To: <20260715121628.1590321-1-sammiee5311@gmail.com>
References: <20260715121628.1590321-1-sammiee5311@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6922974079321863224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1128120

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      20.76 seconds
CheckAllWarning               PASS      23.23 seconds
CheckSparse                   PASS      22.23 seconds
BuildKernel32                 PASS      21.30 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      381.35 seconds
IncrementalBuild              PASS      19.67 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: virtio_bt: avoid OOB read of build info string in virtbt_setup_zephyr()

1: T1 Title exceeds max length (82>80): "Bluetooth: virtio_bt: avoid OOB read of build info string in virtbt_setup_zephyr()"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/444

---
Regards,
Linux Bluetooth


--===============6922974079321863224==--
