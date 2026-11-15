Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794782699;
	b=Z7aiTK1ioba1IuyWUWNW26F3TibrVSnIlDbYCqd2w1frBlBS5TILMKwLSQCrLZMrus5H
	 6ALe+Osdl/56dagUvGpDx4uT+PI8yW/Ier5vNegJfuCFexEkAEpejIRj4cg7ruC3VHWlo
	 LRLpqGS/dOuy4EdKMF5WYS7HyIl36LtjUPCVxBHbYqbJKJL0jtGjsM+Qni36avnCCfMNF
	 x7/lLmtaOyS9nCS475vWsqanGeoRRbPi8uV49+oDYRMEfU1rrUXQYWT1VsJw1nDf9J3R/
	 pKGf36SOK5nMSeyQi0NgyL51G06PWu2wk1AcQMXk7U2y57KxCggh51DpJtNP/9TX5uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794782699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ptlHatGzvBR9NxjcZBUH+TVJKaHFvhcnzAoIVdCtHVk=;
	b=zD57j9xl/+DC0nBK8ZYw8Gdv82A9jJfL5fM1g8/gS3EAF6Wcsb9zJB64G/N8bTtNWoP5
	 v7uqxVvXohHwNOD2B2552sp5tQzygN1dsTxkEA6P4iEa/yplT6bGaPP6EQ/2smsPLpVmf
	 Zgu6uXqQKzQzu4mNh0ryVcYADz3eIvecWOoCp/B7fGIRQZmro2Tdzxk3jnbiLgPwJaPGO
	 X6qV6uJ77SXhbg2eyychVsq3WPHsjRKoc14OnEO6vyAqNq6xKyfowSnoJXdflF33ZAUyF
	 blLQKVlHdmdrFlr1BnHcbz8BpAbJ/yCFFQ4L0Kd9xrplu27+EAQ26vHj2nCbAkM6Kiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L4QSf2z0;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC2606A31F
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 22:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84EC2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L4QSf2z0
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdb9d5c1c8eso1978180a12.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 14:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794782699; x=1795387499; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ptlHatGzvBR9NxjcZBUH+TVJKaHFvhcnzAoIVdCtHVk=;
        b=L4QSf2z0/xTdWK0dfHZQWXskhYhWbxmips9UYIuzx1ym8nkhVSTL4ENvGx+B3TlkA/
         /P7beCv7Bxmb+OG8eGdCQwuMMQ0BXrpjK3zromi5+LOYz5chBE+16NqdMWqTuRuq5aBk
         bKqjjwImnrdbQQwtOHPL/j14AtG71kuDPrxfwUboNzCnM6M+SRBGcybEtBsoZDUL34ZA
         X8S68qDIKb4Qvtiz83N1HWVWEiDaKf6DnE7Vk/CRGpu7XbGs5h9WEMEYBli0zULIb4Ko
         eKLkWJzUqxcNdcmqiPd+r56flH6Ss4gOGq6IB/FeYdAHasInAOvNl9L4tWGKrTHlq93l
         YZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794782699; x=1795387499;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ptlHatGzvBR9NxjcZBUH+TVJKaHFvhcnzAoIVdCtHVk=;
        b=rQY8ab6OQi1NlDpQVBlk7EKVV/QntX7Tzd12bJuGeMO03RX4v7n4O5y+cnOQCDLaFL
         uHQSaT1qhmk7urXuVgb/gHExdeh8HSHQEbhMqXQ8mlthey0T1FGCa4e6mby3x2zRHBVA
         +oRdG3NSCqYHu7m+ZVSRX0wvczSql2eYVDKOHpJMYldGxxWnIoiKbjwPEGm0umtAAI1M
         0rf1FD9mqt5orGBtZZPdcoqsvzm9Wk+qL6iLSaD3ZgRp8eHsRfKcVbKzux6Mygea7D5s
         /B7/O1pxghOrYcums5O8CvFMTwIAXqFOymYlLwwGDsKt/YVqb+G7bVjVQAtZaqFN+5y0
         lmBw==
X-Gm-Message-State: APuU4Z/1P4LdasO9g8fSekHHB4cnDPioNLPuObkHKG4GhijmyKZEx05b
	+qZqbYy2aweqIj+UfZmOMande8+elNiKS3I/PTXELl9W5xVkvWJI4HRgdiHiKw==
X-Gm-Gg: AYBFou3fqQa6EmF77uMuPdwJos5cAkHlXHC0wkwPC5KZRu/w1FeQemteQ5Im7SavClH
	k/JM45wdbDb9Ipmeq9UVNPtaQkGdO2Hkk8l9BO2dYqcrW/lJxfY43v/bRSRakLGEqtrul61Lppq
	mgKXwXrKu2VgdIQzbxjgmmhU76ILwbH+60fnCUykhIye4IAl5TWHPw3qM2AJhvdEXdul4cn7SrZ
	DLVTDz8iRNmPK4T6WReN8jXmjW+gjCi7VsdW2XZ5UMI8sVV5txeLNSHycLj3nGH2zaXPcygN64k
	oGnEIVkrCjxaxuagZAAMfnmA8MvD9xsS5pqVDlb05ybV782JQ0A99lDdTnDn7exNyw24bszMG5+
	wQhWgOfe/o9/yu+htJIwDH6GwETkRTgKhsx3n8DQQVm+6aRizPFH/Cg5xYF1izhfH7IXY949qzi
	FP7PxWZBstcGBOkos2/s7y3eHyCEoHlVojWe7IpKI9CayVsFw71pN0GVdPdl6WhHuMyctdpfgvG
	WEc/8C8EWvoZCMWeW3+DJJ03eY4Lw5ZbDgStG3SHUKLASJS4fdRLMMamRPKGeU=
X-Received: by 2002:a17:90b:4ccc:b0:3b0:97b8:d6b7 with SMTP id 98e67ed59e1d1-3b1b0cc971fmr7401731a91.42.1794782698792;
        Sun, 15 Nov 2026 14:44:58 -0800 (PST)
Received: from [172.17.0.2] ([20.120.158.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce460csm18671056a91.5.2026.11.15.14.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 14:44:58 -0800 (PST)
Message-ID: <6afa35ea.488c8742.26003.7cd7@mx.google.com>
Date: Sun, 15 Nov 2026 14:44:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5666450092269110301=="
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
To: linux-bluetooth@vger.kernel.org, arturfaleiros1254@gmail.com
Subject: RE: Bluetooth: btrtl: Don't return NULL from btrtl_initialize()
In-Reply-To: <20261115195313.20809-2-arturfaleiros1254@gmail.com>
References: <20261115195313.20809-2-arturfaleiros1254@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5666450092269110301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1211959/

---Test result---

Test Summary:
CheckPatch                    PASS      0.98 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      0.40 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.45 seconds
CheckAllWarning               PASS      27.78 seconds
CheckSparse                   PASS      30.40 seconds
BuildKernel32                 PASS      24.44 seconds
CheckKernelLLVM               PASS      24.65 seconds
TestRunnerSetup               PASS      564.82 seconds
IncrementalBuild              PASS      25.32 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] Bluetooth: btrtl: Return an error when reading the key id fails

26: B1 Line exceeds max length (83>80): "  drivers/bluetooth/btrtl.c:1253 btrtl_initialize() warn: passing zero to 'ERR_PTR'"
[2/2] Bluetooth: btrtl: Set an error code when skb allocation fails

21: B1 Line exceeds max length (83>80): "  drivers/bluetooth/btrtl.c:1252 btrtl_initialize() warn: passing zero to 'ERR_PTR'"


https://github.com/bluez/bluetooth-next/pull/1138

---
Regards,
Linux Bluetooth


--===============5666450092269110301==--
