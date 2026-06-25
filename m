Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FF34F27B
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355271; cv=none; b=u0jfINDAGhAh9gWmthRO3FpaCI5v/CRCAezWK0Qk3O2UJfClHLminwZxkWCaQ0p2a8cdg8+wKHKIYl99GYTt4ctMARAjngmzVqZVBTASiou/gDz4AMBLUZHzDjUYVTWrUetxaM9Y1tBB09llYfQdGXqvdmCkmtAsVH7KlgDmFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355271; c=relaxed/simple;
	bh=/zgtOu6mrltOZW5Lx2zx+GtBftswD3mwUQSXOYleDnE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iFKuf0VBDGUM9GoRXDZWPDofIpDerCBOdTufSMmj7c7DHak2Bu6/FBN1Tjob5Z7anGXmxxURIXmpjsIz7/wGaQeaS3oOEb+w4Ad93LveaNQwzaapr6mjn8PsLdleNAtOivjD20at3uQLGjfTl7Yh4ii/13sxfeRY9d5/AWzZ550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4SAhtsY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4SAhtsY"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9217d13c276so128836485a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 19:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782355269; x=1782960069; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SznMTw17y4CuhDjDMcovAlZBjQzkKUiesxW6ceuNQHo=;
        b=r4SAhtsYZHRjOQQUse5aOo/jgaPu5BQRmCYX+4WllmSoBjHrRi78VOBC3eNzVw6Ihy
         lIJ6SjhRxrhg2fHjA4gGv1EY0pOKqHXuUgjKQljfQyWyy1pkNaStVPc/vNnkzMWgSN2A
         wttcPdIH63dqDEtYpsFmlFL5fZnp90PxkkuQdpqoLvteYljmEAycwOJ9uB1swotO0cLM
         3ctQfEAgmJmo+PllnDLIPuTQokjrLZA3SqORmgo94mUva+XqrMLeIXwniepkqWtqDcaL
         lMAXjRZUWk/RtTf4jMYesJhqmkyuDZxIrccTyDfxXk+m6i2PTkztq8ktSG7rDfXMJBrU
         y0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782355269; x=1782960069;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SznMTw17y4CuhDjDMcovAlZBjQzkKUiesxW6ceuNQHo=;
        b=Kf7ypuCY7g0JsF0IkLpEkQr204/hjEY0FBzKHFi5cl7xRh+kAOfMQk7HyY7ByituVe
         CqDcxeWe7uIB3Dez1yFwHiujsTkXBeQ15mNB9aQlgG2gtmgdcaxM5uOTlarbheQXIfE4
         rGUVk0N0A/Or4KrMEcqtcorAUqdNJptupZZixaihgdIP5Lq5SN4Qlo4fQ/FZHWfe8cPw
         0RH+OKUkLlswjGn8TReuM4tmRlOXv7NyDOZq2fUXanxf+cBaHTmqMoB3EYFLKe7D97AT
         5QHWdvktlryqe9w28kMKF51yxcXpm5lPFfgJrWVPUn17F0nZ9PdpbaIcO1vwZBVZOFTP
         GPOw==
X-Gm-Message-State: AOJu0YyiFNmWP+V0Inx5ZJYbEMbCieXyPlqC78P9gs7cj4Q3M7sbtSt7
	De/3nZw9B0pZDpe+6/qaaEW/zNZvM58HHEpmdbfdGvI4SUEaRZwY4+g1/0xLnw==
X-Gm-Gg: AfdE7cmE8fMXS+fTk5QWvmVfWJsb1d8nzJfvK2gHm557szHNqu0LgwYszzuPZ94w3/E
	rRo4i2XHYyFgwE4jh6WR94ewIMQTL1joRPGvdi7Eis2+Z1pEgftv2gElS44OdOTTLksZC45gZot
	/lmUbsElBzfRBHzsb/7xf7jwZJ2brBHC1Wyz0nseffTX6debgpEzKdfRblZZjGxEguujF8KvCyB
	txzmzPBeNV0Vnz54Uwwcy43ec92gMxFcf+luky4lb1WCDL5K0WpQ0l8iB9CV7NIXH28xbLiyeZn
	6RgHWi1dcULVzUz0xlYSVSK2DmmkjTgwsCOWMja3nVihIviqnvFyj74e2PW+ZwGPtB/aHEeAOX7
	MwIxZpeVyWWh+RRqCSZWh9HSNWZNQIZDRUowfp24N+03qMcx4EH3z7HSNb9CV0wicSw3uVH5b9j
	3g7piMmnCEhIChsjDg4Qw8
X-Received: by 2002:a05:620a:2b4c:b0:915:d5cd:8cda with SMTP id af79cd13be357-9293bc3fba5mr73344585a.21.1782355268686;
        Wed, 24 Jun 2026 19:41:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.126.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82692bddsm167779706d6.43.2026.06.24.19.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 19:41:08 -0700 (PDT)
Message-ID: <6a3c9544.dbc9d64a.1f945a.6bd2@mx.google.com>
Date: Wed, 24 Jun 2026 19:41:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2934208856000966628=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, haoxiang_li2024@163.com
Subject: RE: [v2] Bluetooth: virtio_bt: fix cleanup paths
In-Reply-To: <20260625020159.3446736-1-haoxiang_li2024@163.com>
References: <20260625020159.3446736-1-haoxiang_li2024@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2934208856000966628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1116220

---Test result---

Test Summary:
CheckPatch                    PASS      1.39 seconds
VerifyFixes                   PASS      0.34 seconds
VerifySignedoff               PASS      0.27 seconds
GitLint                       PASS      0.57 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      25.78 seconds
CheckAllWarning               PASS      28.53 seconds
CheckSparse                   PASS      27.60 seconds
BuildKernel32                 PASS      25.17 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      458.20 seconds
IncrementalBuild              PASS      25.61 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/350

---
Regards,
Linux Bluetooth


--===============2934208856000966628==--
