Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781317;
	b=nC1VV/8ipvuSclzjciYgpEeOEvvABQp9ZFDqSpnZ6TDGt48G0fcyzykDZok0qM4IOczu
	 uiyKGjk57Kgj81mG2hOvOW0KLW05E9N7gRhTP3iP/YmgQwp+7O/ylAwxTQpZ9b55tOlfb
	 0K3HTrzoPZ/6AUkj8Cj8WNQOk46O0StSHHbMWaAorXNOARnBKjhGR6xjuI90SD45O08su
	 gPYre4czVQsb3UKR/hpaphwid42yMXfLX6Uy7tT3KKtZlmVFTJjRNuGJ2rnc8W7tjpkkD
	 7GyshJUZRyF/7snGfq+fTjnS+beu1Ih2ojxnoI7H9akEMYrZ/+vXbw0xSBqiylkwckg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=J4CWmIWA2TE8HaW3jW8adsuOx5HELpaJt6ojCDQZ2eI=;
	b=pdjmaANNFHsq9FleVZ+fohhlSgUI9PUF+kVjTtdYY8u+YvEXYhraCGOogHOdkzOFWRiV
	 fa+0iu/Fac5w0OPd5U+tnnu5fTBDlqySx3n0Egfhi3/2qVUkl8EuGS8MTYR9HWYQaUM8Y
	 XeNyR0DorcaZ85ciYqrTiiq5W2vh98EQ6cK2h2gSo1BQNA4Nn1/ZgGx78Wy7U5uduOSak
	 9uyHNeWhnDdGCklCi2OrnLQZNi8zi3q7oing6KHU7/kLgiS6YSCSlIQ8Cy56/PSN28Ox3
	 tsu9OUWfNETAjjXi+STGt6VK7HJazOT9Zg+r1XXKJbIrfJ8+mjsedJ2ZbHhX2h4qnQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bcrweSZG;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74832606A328
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74832606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bcrweSZG
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso210280a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 00:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793781317; x=1794386117; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J4CWmIWA2TE8HaW3jW8adsuOx5HELpaJt6ojCDQZ2eI=;
        b=bcrweSZG2l6GLthaM16+cmkh5f7HzjVZTx32so+WOW40ew8ynX9Bc+76g/GSMCUCcq
         9TNJ1FWGlDdR1x5dXcXTnWowYuL62HFB6p4BQzDwHFzkM9FgbOR+pF+mWZk/SD6MHbs9
         rRI/kexG/SxJ4zl/tGd28+xprqH9DF6ZGvEcfOP7905UHDlQDBGuECmRL5vJNokG0gmN
         VQhGVPly7Q0lTLmmSiOlFFA1gqamaDgwY/Ps4T3S0Yyu0foGt/hB7o1ig6mFhofpavqC
         MQb9YciKPhWvFVEQ9XliV4ttesZBWcso9pAqOn70wyy3NQVENWjBb7OD3mjR+NbqIZnc
         Q9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793781317; x=1794386117;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J4CWmIWA2TE8HaW3jW8adsuOx5HELpaJt6ojCDQZ2eI=;
        b=2Cekjuc3SLNPm9irMKVi2kaDyh9dsd7VMO5Sw/sc/+1xaIb4ItxQo69+gtGWeTxwup
         HeDG03t9J/RJ+wBFTg/1o2CbZg6ci0Gy0yT82bjsB9B0jNjE+ndgjq/OfwyO+R12f/aY
         g8PBln3n0Txylx9HyBa+t77isN/xt8d0zBsof6aSkMasGp5FnoqSP9FkFVKMPjtqLWvy
         JlAqecZwzjJUv4v5Pb/7P0r9tuDEsdqJMSJcDA36mcIJ+LNj9J5DSAm14nnSKgnnnF6O
         qcOjPBoptkfi9zx3caKu7gi3m45TrIUik0aGi3ex0MT9OqQeGUeNNg025paZOyXsxTxB
         +BGA==
X-Gm-Message-State: APuU4Z8U505cVr7g6CYffEdbfZcfDXxkVVlxhti2zrKrMzFtHx1zGGVR
	I/oVvi526MhTb7ELua3LT8otL0cJ32hJ/xNz5O0lecLZ6fJ+nDGpmXz0U1nd4g==
X-Gm-Gg: AYBFou1vlVfje7e5fse3OJACqq9rPyvE/AOX8mpnixNrRoiZcmt7sKEEu4WlcxoFCyr
	5pEXR7fKy2kJcdJ+KUoLIN4lhkSDHlWkenHIggUWG4K0DD7k/UzcCXjr5LsPwymVespszmlH4uY
	nDHnx8ucgBP/HhnzcIQlqCQDjVKbBUaywDW5RaMT5HYVuX2luqGA9FDeU0wW5rZYYcIfsDhxQlF
	l3DkAHVsbEwYm66VJdSfbnbnmgxmlKWmPKKA5I+9M74usmkslauCJTdFppSp01djfKlZYPKGttC
	DeFdvga5GsAix4orRsHGoCV9o0vk6F1K2IXeHC2FGhuKLlu5HH7bfYi74Ww4um/W9Pte6lYcsf7
	gKxTuPutWlr9wXUMqPLW19nvyo7BZDgnEN5BPAqsXsaaQzW5ZZ/eD+PhE3FkLZevSy+nvfMf7Bj
	C2miZJGJIp4SOmgaSYiY8KSHnqUz0vMv8IOHFfxbpgvADhG/MsMaSCu2pDPOvUvuNq4YDcV3sD+
	PBtPDaRMPdsS1WCtWJX/A25gWvSR9tTj+1vLKpxptqqRrGyDczkypgWNoGJnTDlvsQII4cN6N6R
	E/cqmJkMMsxT5Vbyx4TewqKeC5px5wQtYPOS4g==
X-Received: by 2002:a17:90b:1a8b:b0:3ac:9e76:aa76 with SMTP id 98e67ed59e1d1-3ae8970fd9dmr13506759a91.13.1793781316499;
        Wed, 04 Nov 2026 00:35:16 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-23.us-west-2.compute.amazonaws.com. [3.42.157.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094ce9f65sm1603149a91.1.2026.11.04.00.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 00:35:15 -0800 (PST)
Message-ID: <6aeaee43.a20bb0e4.fb6fe.f6c7@mx.google.com>
Date: Wed, 04 Nov 2026 00:35:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3195344252257223326=="
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
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Fix SCP DBGC base address
In-Reply-To: <20261104064507.2600483-1-chandrashekar.devegowda@intel.com>
References: <20261104064507.2600483-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3195344252257223326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1201364/

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.05 seconds
GitLint                       PASS      0.15 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      20.39 seconds
CheckAllWarning               PASS      23.01 seconds
CheckSparse                   PASS      24.60 seconds
BuildKernel32                 PASS      20.47 seconds
CheckKernelLLVM               PASS      22.36 seconds
TestRunnerSetup               PASS      475.52 seconds
IncrementalBuild              PASS      18.85 seconds



https://github.com/bluez/bluetooth-next/pull/1060

---
Regards,
Linux Bluetooth


--===============3195344252257223326==--
