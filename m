Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7404182BD
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485226; cv=none; b=guvD5JsHGweUWd48iOwtJTw22gl+CnI+LCFTxCJ0Y+Vcv8Isp7j1zqi/u+zoDQirt8eTbugKG72HwuVOy7BUR/aXTngSz9MIqp0pknbPBPEFA0iELMfXdRHDTrk2W6BhRHlHY2cYk5eIMnizcPiNoOkjJNyPZx4XBdDju+ci43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485226; c=relaxed/simple;
	bh=KbbC37IMFdi165DYe0QHm27VNQY/4lcQ6eMbG2xFg8s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IhvLO5WdI0O8wlBas0E2v4GKsHUg/GbuT1HdWC3oXt71GbBYDxG0ZysJVvBIqKZ2FmuZhXj3NF7OhcphSmU0Acc4DMtHP7DRIfdyEr2PvO1fRGC3gdScVEHaGlwRUGzlKP7EV9IfP3X9wOVdZU7XTjojo5UH+t+YylIzf/PSAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+h26Uzd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+h26Uzd"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d38d1eae03so137389685a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749485223; x=1750090023; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5RrQW6Xrp1JCuI9vGwLDU4ZAo4NrlCvZFOPE+VCSakA=;
        b=A+h26Uzd6M7kU0RtENWJYtCGNr5SwDgPuvHpEtlRNosNaaX5F/7doqbL+7p6TrYuN1
         opaC1BJnpzXAlneiEwuxn8PuN+yrVRUtOniHCMvPo82vqhcbA9LpcjXkVLdGXdLdV9vy
         d9YKP5nCffUnH4VVcfCsJAOAuAmGOO5VKSt9KhUB1C7ZD5pG/e0qPj0GdBCDAf3R/xV3
         Foaur2qe/AFDFcSBmqXv4L2othyHGkqtrnG8w5U+6AT1nTUQzwSG08ZilBqKr+KZHWSq
         yHNlgxZ2XugoRTNvhOs/EcSeM3v8gzEI7ZywM/bEueDRM4lC3knXO7KiFI/TtZJQOzr7
         KABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749485223; x=1750090023;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RrQW6Xrp1JCuI9vGwLDU4ZAo4NrlCvZFOPE+VCSakA=;
        b=bfHcnTK6os25spIcZZaVg8Qixq8JsGX/LS7L+BYLfUf/U2ABGraWnaMzAgXdvwuIRV
         kJIBswZXrKcsyMm7Iu3jmnbiSGVx0TK9KUOdGftns9YvwyE+4iWpEEErD6IhLXNJ19Rr
         6gUw5y2/vKZYzBhTPOgtf/mf3AVQkDt+MBRg1ww6fU3A6uUOl5xkHE/Mg7b018LPHbtI
         jK4PERGRBp6gBGKNBIUvrmjg2g0u8etGTCGK9HSGn7F7Kb7RXN0VFfJ3Z8oIWvAy/Pno
         s+a+3GMd4kmCgQlbUTNnNArOzPg/f0S0bjslbmT2tyE05smu5Eg11o+ZxEOKL40UWVgZ
         mG0w==
X-Gm-Message-State: AOJu0YxuzRTeOv15db/H2XCK195sqaXOp5HysT0pI8RNwGoedKFZX2Ku
	egvnD4/Oz0lOrK2xxKOmQaNpCx/Kh/CmiLX2B1FJhwl3cAYi0Df+nZ+D11d+3paC
X-Gm-Gg: ASbGncvVMvnvNsw2Ep1/XitV2e7j/pPIYhjJ5+vp1YILWvEHqdTYpJCnSh53Wc7gN7u
	fmXyf5HDj5o0aFeyETIF11joAVS42loD8Muw/GfJAPClHglA7oz5ajhw22i6VaMxttA08pNqHsM
	RnhLpx+7jZGAxNRVFPYjC7j60/b5Pl0EJq6yRrqzoijIPOBn0uAxZPSjUy1RC9QGClMGp0U/GZQ
	/whST/EThqTqthWabYho91zaTKfzi1G3ZUGA3Aoayv9vuiP0IONO+fYsmtOYfkY3lPD4krCGc4x
	vMSdO/si8djVQ+DPk3lzMLhEn5eUETmv4ztV0TKKSR9c9buWowviCdiily3DJ+w6FzA=
X-Google-Smtp-Source: AGHT+IFTKVWWy2CFXG4KUK0ZARjXUaCe3IltVssCLD7ujngpeXXBtBlv/S9FMnlpA+PleGibg3dqLA==
X-Received: by 2002:a05:620a:1a05:b0:7d0:96e8:478d with SMTP id af79cd13be357-7d2298ec3eemr1815356085a.39.1749485223383;
        Mon, 09 Jun 2025 09:07:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.44.105.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a61a889sm562914885a.83.2025.06.09.09.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 09:07:02 -0700 (PDT)
Message-ID: <684706a6.050a0220.2ed797.a81c@mx.google.com>
Date: Mon, 09 Jun 2025 09:07:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8119712203222303647=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, d3dx12.xx@gmail.com
Subject: RE: btvirt improvements for LE Audio
In-Reply-To: <20250609143811.566331-2-d3dx12.xx@gmail.com>
References: <20250609143811.566331-2-d3dx12.xx@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8119712203222303647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=969870

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   1.29 seconds
BuildEll                      PASS      20.47 seconds
BluezMake                     PASS      2720.79 seconds
MakeCheck                     PASS      20.21 seconds
MakeDistcheck                 PASS      201.55 seconds
CheckValgrind                 PASS      276.85 seconds
CheckSmatch                   WARNING   304.40 seconds
bluezmakeextell               PASS      129.18 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      922.29 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:456:29: warning: Variable length array is used.emulator/btdev.c:456:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8119712203222303647==--
