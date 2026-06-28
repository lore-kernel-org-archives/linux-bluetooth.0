Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4A1A6824
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jun 2026 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652609; cv=none; b=uZIaS7oMy2QypzecCwupd9SYHv8iTL2mPu/Bl4DOhEojTVt56wJJVCagyXGeSNm+FCpQBpg5IdPduQdUN5wdKBxvqXIna2nPmek+KpwULW3zE69ZkFVV8f2Dz55bBH1tNCDeA6AtvauNTvT8Ik8HwY3fmZ5j+Sb63w8LQoaQaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652609; c=relaxed/simple;
	bh=gg5NqPnGCma8YlphGQHMGDQAk7oN92rc3HLKlB5IlJQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZSNBwTSgV9Ko0QL5Pa+qHenyUO9zcWgj3t60irhmyGQnV4XyT5aqTab5d6r5Lu7leINeMxiWcdZ+Ee8MrjQdzpsuegFvVicXT6/D7sM5OdpEn5QITD2Wh+OZEsOBu1ZX1x/kGqytzHTkugmXQM9XnQWK77D2rwR7h36Ieq7Zd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuiWkG5W; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuiWkG5W"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e45d3658dso29389785a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jun 2026 06:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782652608; x=1783257408; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7xxzbOphSvTqbCA5Tya1A6rq9kQCOsAJmpoz0JMWrMA=;
        b=EuiWkG5WW3lPQj8vfMIIig1EDFgR15jOeIP2yNGvxqhnV56yUH81EgzJMf9eHi9IYr
         9ACZBsB01Tj8OYnUaFRU6cQF3GCyyIBvqP7QP3pGGwrfS7BMBCwtHIaQayDmw8fpgyHn
         Y4I8w89L55JAh4OOUGLIXMGe+mWkAaJtcRLCYC6ojHSUiJCjApSvBd8KxOEDlBLNf2Q5
         i4G+l8/xwF3J3+XRI9rBS+YtsumO33DmBPOL9085fYA0+jKVoTKL4z410xgYwQGG/pYS
         tkUINaf7+86AIM4QsTfQaf157mc0Iuh9aU4tRxiyCkQ0mCfKxojmmsFhnAUWIEOnPwY8
         tilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782652608; x=1783257408;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xxzbOphSvTqbCA5Tya1A6rq9kQCOsAJmpoz0JMWrMA=;
        b=imMaBEsQ7V+WtCF48a4fbDtrKU0M/J7ZXDfr13KpRqpetXfCT8VResCfQz+biiXfl1
         ENNzanvp3y4usB9c/DmCWXNuvyOZnnEZsSezvc9TcXls/pm61qXoOI8137jlAkN6l5/l
         N5lTfSg88BID4StoL0Q9FH81UnE6QHzx82yrqcvZHvm+TnuN7S6uGY6QS2+H6tWDi7OC
         +iOP8Kj00WfD5K5mppLdmdclAHZwMM4Soests3sVDwHwkDZIW4ydhsuJwlO5fesuKbZk
         Va9PJDBuQmfUt3BFTkXgBSeyilnUa85gu2IPE7un6m3bdQ+gDaWawVO6ap9K9f8RWkAl
         RchA==
X-Gm-Message-State: AOJu0YyNf6W/yrldztUVnIZNAs0RvsE5DT8kbVuwMzNM6FwtffQo1HlZ
	YX4IyjRSkZNNTQyn9txli++uw1H1o0jfMuL1MmBM2xjYf9lhy+i5cw+OqLMXkg==
X-Gm-Gg: AfdE7cnrlGfKxvIW6AMBhDC78VJDNpdkU6U5a7pgH3blmBM8hFzrZxw3bogA219ac8w
	PdkGPazf4tyLx/2n9NsfX1VTwEO2PY1PJgl7KVs2a1sr1DiWNulOvSx98P4A1DbdAWKk1UiAQjk
	nfNLNwF0DiIi/sHnyOmy3kApceGNhfyMoM2HPP7S+y97LKHcaEBk8teKOY+92Fvc7v6j06Ys2PM
	16U2kqv4MLzQv1fAJuSjlTuZt+0aby7/CXp0zDwXggZY6Aua1/TYz2qatFRC4VeiONpCm7rpCfH
	jX8AGGd8JKE1PV39RyYTwsM65o2WXmMdF/sLJC1Y42d9Netw01G7iu6+EHFKYfAweSFcNgFX2YP
	3BAGlmKe762e+lny/mAE87IobQaghBuqS+KyzVJF/wWsBnrc6IJmdOh/doLVFtOcEadwChG9BAg
	sHfTw3jUqd/wpZ7vU9+w==
X-Received: by 2002:a05:620a:2544:b0:915:f96b:8f5a with SMTP id af79cd13be357-9293d5b2184mr1938263185a.36.1782652607685;
        Sun, 28 Jun 2026 06:16:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.174.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fe235092sm1772036385a.21.2026.06.28.06.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 06:16:47 -0700 (PDT)
Message-ID: <6a411ebf.f14b93a6.36012d.5f3a@mx.google.com>
Date: Sun, 28 Jun 2026 06:16:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4545815938812805959=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vulab@iscas.ac.cn
Subject: RE: [v2] bluetooth: fix hci_dev registration leak in virtbt_probe
In-Reply-To: <20260628121610.44496-1-vulab@iscas.ac.cn>
References: <20260628121610.44496-1-vulab@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4545815938812805959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1117669

---Test result---

Test Summary:
CheckPatch                    PASS      1.22 seconds
VerifyFixes                   PASS      0.29 seconds
VerifySignedoff               PASS      0.35 seconds
GitLint                       PASS      0.65 seconds
SubjectPrefix                 FAIL      0.28 seconds
BuildKernel                   PASS      25.65 seconds
CheckAllWarning               PASS      28.26 seconds
CheckSparse                   PASS      27.19 seconds
BuildKernel32                 PASS      25.18 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      458.09 seconds
IncrementalBuild              PASS      24.98 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/364

---
Regards,
Linux Bluetooth


--===============4545815938812805959==--
