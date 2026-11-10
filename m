Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309174;
	b=0Pt13/5suau6iOlwj1vpDQVtZ4prySgVoliG7PkRbtoY3jCzBAKUrKL0UlBH7fX5vROv
	 mPRGtQEcTiMSODSobOsqZCZNZ3HXU1UWy6UNqwB8bm93Qb6wp2MTsK1T6y/XiZOaA0ImI
	 tltiCIQMfr/TP7/J6HNu4WoTikVVA9jSasQO5ralGfCajr9Ybj/PpXXd5ylGg5xkKTLU/
	 JaGFDVE5FAddKzo7q0h8OxVY54Nf9uboZGAkdtHjxHJaocuJ0BFBu2/Ee6y5znQFx9pLQ
	 16KCfbsCWUqgJ+IHYVaJHGlJZeh8ABxL76h3IH92+gdMikr9D06k6BG5nQQIFIay+qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=8v0BUCWmA/IL2caTcqInIIIAoTr1kMPjQ+8LYQT6wNY=;
	b=pKmSKB+qpmZU/i2NPXgWxjrpq3hynApL8o+wxQxF8UjOaIOSEBRwchTAnQsSgLtMJEgz
	 cV2LJFmFxhgxBaesZShb0pIvB5tNcgetKdjaJLtAbKAMDC2nMqocfpqRbbBK7/JnLxQKz
	 KLIgYJ5yEPuTckKUTWtdGMtJ1zWwvNXQ6NFaAyVPekOlAu8xjnJXRd4tQndyNPNfbPr5O
	 gRGWIyXeglAc33bu5o6CPSu9R59V9xAvCJJsQnrt1qeH+BEe5KucvINuL7WU8iIM+bZh4
	 pc1bO/yTDiVN7tGA4C6LRJUbx1LwHXcYBGGrfWzFePrioVeiqWRKqvH1cRy53U+B9Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="EzFxT/IT";
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6A606A325
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 11:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70E6A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EzFxT/IT
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f84a55cc06so1083315a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 03:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309173; x=1794913973; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8v0BUCWmA/IL2caTcqInIIIAoTr1kMPjQ+8LYQT6wNY=;
        b=EzFxT/IT8TIGiuUrybzphRQJidkySRGvSsqsQRc+Q6JmObkD0mEgdg3AtmFNyDDZ1Z
         5ZRaXOox/FqRUsrKi5H1AEgWejQ9ZUkLCT+ajmf0ondzfPo82o0Ckv4PTJZt5vlJugZf
         KjKSfo0wjTt8H531ynz8OeIDN0HWIARKMyycIQR0qSI08HYbTtOSzRTfMBfSDIKG+YSG
         PJN23V6X0Ba2wvFaReiJGoR6uadBhg2sbSBhhHRJmvI7Xth3DD0J+G+mQsZcIdw7Oksp
         ysxCC8rniK6ZLI48QnKOOiJxggkP6UP+uZpliBDzGROtT4CNwF60S5D+CEwRafX/+AfX
         Lu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309173; x=1794913973;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8v0BUCWmA/IL2caTcqInIIIAoTr1kMPjQ+8LYQT6wNY=;
        b=t6ijlTKw50QP94CQyTZItkgfOI0n7ge4ZerFnSYx6VOBYzgPQ0pFwvXOgm8WYkGvUe
         2hh/HWES29d72Vv/NWnpODv6WZ26bz2shbooOd4qyWyNkOCTt4gk7D1IAz3qdLe4hFSi
         ZiqCOtJZUrx/jek3LoSN97KGFr0IMROM0JxUdMsZ4SxFplpbtNngKHPv60hrAtwy3Ulc
         oXvPxVy13oXa8iH1CXZZB2pGis4lgAL1cWuVkHWWeHV06cQp2OIDgd3FYyFqyLXbPNyC
         PjDAHBWSN1PymLUtRasO/rS1MLEbrWyYTAAkA7DnqxEvkEx/Wt02X1Z1wdW/1sz1apcj
         M3Bw==
X-Gm-Message-State: APuU4Z9bl62fdMDgdyu4kwZpoff+2x1lqzK4ZQwUwTzjxeYJ46Vp1Cjq
	mHhZeHZNU2q1/SWlwan8gLli46dYLxJK59OdygHpGoHXZZUYoPgpKO5WRgET9A==
X-Gm-Gg: AYBFou1+Dl9UwZMUmoMi/Xyh64wRP8WxAtvWzIaexcZ5XTEKiMs9OLv6+qeYG3JYoTf
	fS1est/DVHKb6Syolnq/4Kmk/5jo2+1IBLin0dgdtLgF0sm8hTwVTBgHa/te2GprJjK1SJYyRFt
	QUeKrKBOwSVUcrQvNTRkdBytetT7ncPtFkuvjLPRGe8eWN8dsYiEgrZZ2lEhMpR9Awxw8peeTbF
	48B0KVX6rqyoLV1t85FaS/ENFG5tkP90Leo6ir53+h0AKCpYmv2dHzJYf8ckOl8VX16FXUU87J7
	66xTulf2vv58bfeA0ELhu1Bc+8AeG6vM09SZeJpO3XcDXUE5ZxCwWoK5u82qnFG82hgCq0QowU/
	B02TpfWN5kNnc9HrkTfir9w9nhIwlhkAayAMURUCvMujKUi5qDDkIHkun2/VuvRE2N+PQac7Hls
	fZIhW76nwqXGUBPwQ2YN6nCK8jtFvpGaRirCAKMd0W25KLbLrQu2l3Zf+bC4Jmo83g9f5xzSI8x
	O5+M+brNlIMJTsZVXum/L8jdlQpuIR66FmA5AAwpmB9YxGdfCb9Yt7ymsMT3cxT
X-Received: by 2002:a05:6830:2e01:b0:822:b69c:ff69 with SMTP id 46e09a7af769-860dc7ce7d0mr1322074a34.21.1794309173239;
        Tue, 10 Nov 2026 03:12:53 -0800 (PST)
Received: from [172.17.0.2] ([132.196.19.236])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860e5978892sm552839a34.12.2026.11.10.03.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:12:52 -0800 (PST)
Message-ID: <6af2fc34.0f7f97e5.769f1.dc94@mx.google.com>
Date: Tue, 10 Nov 2026 03:12:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1529055453794787439=="
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
To: linux-bluetooth@vger.kernel.org, frederic.mahe@cirad.fr
Subject: RE: Bluetooth for the RTL8852BS on BPI-F3
In-Reply-To: <20261110074607.363918-2-frederic.mahe@cirad.fr>
References: <20261110074607.363918-2-frederic.mahe@cirad.fr>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1529055453794787439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1206953/

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.51 seconds
SubjectPrefix                 FAIL      0.21 seconds
BuildKernel                   PASS      17.46 seconds
CheckAllWarning               PASS      20.54 seconds
CheckSparse                   PASS      22.27 seconds
BuildKernel32                 PASS      18.16 seconds
CheckKernelLLVM               PASS      18.28 seconds
TestRunnerSetup               PASS      420.43 seconds
TestRunner_l2cap-tester       PASS      12.59 seconds
TestRunner_iso-tester         PASS      8.89 seconds
TestRunner_bnep-tester        PASS      2.75 seconds
TestRunner_mgmt-tester        PASS      81.37 seconds
TestRunner_rfcomm-tester      PASS      3.96 seconds
TestRunner_sco-tester         PASS      4.94 seconds
TestRunner_ioctl-tester       PASS      4.21 seconds
TestRunner_mesh-tester        PASS      5.13 seconds
TestRunner_smp-tester         PASS      3.91 seconds
TestRunner_userchan-tester    PASS      2.82 seconds
TestRunner_6lowpan-tester     PASS      3.94 seconds
IncrementalBuild              PASS      19.36 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/1102

---
Regards,
Linux Bluetooth


--===============1529055453794787439==--
