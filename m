Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703409;
	b=QSVuiVdQgMqCaFes75I6+U2ZSyOWUhJf+e5FOCiH9GpnfR1nzXn/5PBvFD7xr7anBjfg
	 VsuulA2fSm9PKTmWN5rDMDqfPhoC4aAljTbaZahaCw+PbCu12fDMywNjeFsoEWhRpsPy7
	 70ftjLsKLQ90qqZAvvBeglwWtSWPdi/GUi7yWZuLpevUmZeuyXXrONnlhWGD/19hZ05p8
	 u8fdamBm/LuvVBrPgtlezJL2gxpKxsoFjfxOhJRXtA5hxSqQDe3U+cOHK/cvVL+6RfZ0T
	 ye8HuTAheCxV21wGjbFNOjDBQAEBLvl6P2L7QcgnchFJjCQrqHljWDgTlraWde5tisg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=iIXTQP74i3KrMG50VfAAbfJDnXDTdpDRXmDewPE7DSA=;
	b=paxiiHKERKjfsITE0C/9EkVnLdpT4vCsZYQiGImw4tJAHr+uLU8L0Hy7Ys1JQDiUNk4N
	 ofREXPXxA3htWVE8zjhezYLSK7GYyr4CGgaVqMOOtqn7OvC4e27oO+FN0OfMruhHat7cd
	 Mi01BAL7lYG99HtyXbX1puPyCHeHsQXRI5DtqmYdADzW53Tq5fH3FDtAJo36Pyljs50R3
	 TOoCQXHxh8CA4JdC0/wDqTwl3qfNnIs05YyrRJxoTI7b/Mr7axe8v/tzuLMigqGOKohVZ
	 aSTOBQFNsDKEjxWu6A55O1F7/sg/cKcmYgwpTS9RdllRjF4bVSQ15U0t4HNp2ZJVgMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xvuo0hfw;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B639606A33D
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 00:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B639606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xvuo0hfw
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3704d30b84fso2807666eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 16:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794703408; x=1795308208; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iIXTQP74i3KrMG50VfAAbfJDnXDTdpDRXmDewPE7DSA=;
        b=Xvuo0hfw/QMZlArtGtfZIq8XftUTf03OET0Fjra3ppSUy9Y8rmEk8+KdattDL10DQ0
         CpfBRsZz+Wnk7jkTncs28q0Jnm6f7TvwrzvklGuwhjgYu+ioeTss1JEXqha0Knh5UHKv
         wk9gkt2q843B54bjYwwoTgY4vydYKVH6I31Q3omx8voAax4DTcwkeH4I//4rDBmha34H
         5g1mxWhHTisckyTE7YEZyDnTXLocxSkmFlfYFjoSB6JGNJ4I2l2i23jQSvA3fItENLhv
         Wtvr7lTd3/LACRRKOUBFykqxe7P9oHmHIG1SwRwl9R9ypY2KLnIyo3KsstPZcCI26KsM
         l3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794703408; x=1795308208;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iIXTQP74i3KrMG50VfAAbfJDnXDTdpDRXmDewPE7DSA=;
        b=qyHXgCfEE9+pfsl1I/JW9M59Zj6FlZdsjSDxm7ExXrKvhfzgiPluLHxOTM/K2ZAUPl
         tHJaE4M8ncxpnV+zsOiscoNMeSpaIbMvkidJb3xuD0xPZPYOSS2ey3228RDsSZuO+GS+
         MCowuzBjq4TbJ04Xg3OeW4wS8CBcza+faTTFTMcuQiJ73LzrszY5SlvfcvrGObXFsFbr
         hlLf3aSTma/uTk6z1QMFJWxzfeBOiHmpANdPsqYeRw6AVHIdhrdMsVxeq7yJFU3YI9Me
         7oNmpK0QsHv2D+E5TA3zsK9CVJD3fl24cJqlpcTHgBEoDUADwUTGFCfBK5tdktEWDOF2
         U0fw==
X-Gm-Message-State: APuU4Z/kyOAlYUHDypwMc6xjysv3Rs7D1oEEbQc1wr8o3yfYCigKs/rV
	9pMtc1o446ffCkE07w3aO0nW2rokFrAZJGWlB8zhxeRL0ZbPGJTdbvyCPIKfPA==
X-Gm-Gg: AYBFou3NCNQ9hMqontCpSMF1XwW2vY49TnUns+Ss4VkjJSxh4eCDAkmcTV/2xeBrKea
	DTdFaOoltMdpJtU8VO/+nuOWPtrQfloXerH9zrJbVcV729OldUfhzVoXK5D/+k2Ho68yaakk6dn
	F4gSqYxrYn7Rv22awtpLV9fPbyr9xcFZc9b032Go3N1QY1CYItcTQ7a16xRN6BpF5fMt5z8dYVz
	VPqp2GgxZO7eYpkWa7ZeozCDxfxTt517Ak1o05UKfciIyRAN8YvK9lDE0k/PnjVhb/wLPkCeeDv
	dSvpdeev36tZi7ePENZBNhvuY3An75Fd5ASWei6dZsp2Rw2vj83dNaiv33MlD36i+HWy4FueS1f
	zRXZiJxxwCTE0MJYgJBYNwidjFscl0c23ygmPsW50zomjq885KlZRhus+8u+QopeXrYn/ZmBb34
	EsCsTsLncpJEyldDYqnYir4lqNQjT5pmsvzZrZ4abl4kkiBKmqq+S7iTh5Gn+hg4t78tVltqYZz
	V6iLTNdK3MM2TaS1x2NLrONmyEuefkW+vRKzluWSKrKDY+MERNoAW4NbF3iIGBX
X-Received: by 2002:a05:693c:66cd:20b0:36c:9af3:2309 with SMTP id 5a478bee46e88-3796047bba6mr5819190eec.0.1794703408030;
        Sat, 14 Nov 2026 16:43:28 -0800 (PST)
Received: from [172.17.0.2] ([172.215.211.62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0919sm20062535eec.29.2026.11.14.16.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:43:27 -0800 (PST)
Message-ID: <6af9002f.fc76328d.377715.22c5@mx.google.com>
Date: Sat, 14 Nov 2026 16:43:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6881095407736223350=="
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
To: linux-bluetooth@vger.kernel.org, rdunlap@infradead.org
Subject: RE: docs: ioctl-number: update entries
In-Reply-To: <20261114202653.3113381-2-rdunlap@infradead.org>
References: <20261114202653.3113381-2-rdunlap@infradead.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6881095407736223350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1211568/

---Test result---

Test Summary:
CheckPatch                    PASS      6.47 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      3.15 seconds
SubjectPrefix                 FAIL      1.04 seconds
BuildKernel                   PASS      28.24 seconds
CheckAllWarning               PASS      32.10 seconds
CheckSparse                   PASS      34.64 seconds
BuildKernel32                 PASS      28.08 seconds
CheckKernelLLVM               PASS      28.06 seconds
TestRunnerSetup               PASS      661.82 seconds
TestRunner_l2cap-tester       PASS      15.75 seconds
TestRunner_iso-tester         PASS      12.64 seconds
TestRunner_bnep-tester        PASS      3.08 seconds
TestRunner_mgmt-tester        PASS      86.15 seconds
TestRunner_rfcomm-tester      PASS      4.35 seconds
TestRunner_sco-tester         PASS      5.45 seconds
TestRunner_ioctl-tester       PASS      4.50 seconds
TestRunner_mesh-tester        PASS      5.37 seconds
TestRunner_smp-tester         PASS      4.23 seconds
TestRunner_userchan-tester    PASS      3.12 seconds
TestRunner_6lowpan-tester     PASS      4.34 seconds
IncrementalBuild              PASS      36.52 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/1136

---
Regards,
Linux Bluetooth


--===============6881095407736223350==--
