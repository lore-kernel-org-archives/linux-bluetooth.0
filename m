Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309706;
	b=gjTwUPbwu34OfUSQ1UWs/9rAwc50ByMJwwMmvLvpgqJvZ/sl8f9BC1ECM+Jw2MQgaLoz
	 E9ja3uJgweqGwQhpVotWXwUB/T1+lZCZWlYr7ayqhrFh4S22Aj27h3IcRJpQyqmGaIpnX
	 NCluYRpT+r5MhW9niPW+2jl2rRYoypJRVJVKSR/3FDGhNr/EDl+qWQPQmOU2LNVQxpQqV
	 Dsyb01hVpeeIfVe62SveGoZzvZZ0hqdtlMIIvkcZUJraHbP4Jl6lFF2KnSbRvkWjV5Z2C
	 az9rROcfmZDsxQOCkNlue2TUoPrUrobubO0u7JNE8Br2yAa7sivRlwDH9Z0+bGE5Z5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=lJh+U3NL+S8jV7EM59gWsAVuQbFlFquZhjRlOzcTnrI=;
	b=tbYczx439VpyKYFI1fMJ8QCQAY3MjXh93EYqKeqhOwYSDbcLf5IfJiwJ8EDy5z5JFVVX
	 hKq2OylF7bzYo0jhKTquv5bloPFbmg5cZIWt8OQUn/Mb9LBYDzliDI90HllXGZkOBMt+x
	 BwH6L3a2MNSvVMHIQatI+qxBLyzGj0EdN9T/adHbY7Jz29L7Vo+xZkBzBu4kpJepuiwZb
	 G55j35rfR9hmwVgBXkEY198bxPFGnGDW41T8uVkJ6YiOZIHDqsowqj/5LsZ+E2+czesBS
	 LEizuJnr52fVlLhSGBdUPJuQtPtTgpEVTolfe4Whol3MRFWDHS5iz7Es9euQOaEgHHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A6ETsLbe;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A813F606A325
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 11:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A813F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A6ETsLbe
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36f6295304dso2492314eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 03:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309705; x=1794914505; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lJh+U3NL+S8jV7EM59gWsAVuQbFlFquZhjRlOzcTnrI=;
        b=A6ETsLbeqUTdSPI+Hrb+Tdymx/rTmVoxJJFPdrpOTtySvP/ktjqaVuuvvfuRtgPjqv
         agdSw3B2DbCIGZoKo4QMbfzF0wQ6HiOskmKDI9AV2RPeJCHoPenwQaYo240qODfOQhsG
         QxWZCL7sOqJfZNrpWlrRhFNF0wBiKD78tQPaw2YFWPtYU4iaVQl/SGIVGJvZaqW1CoC3
         KvHwSSMeAh2zDx5nyOh2bpZZSdzgpKZO0cVxEJmoKBN1wevNoLAWJ91Msrx3z8kSU5L+
         quJOjCAzhBnS5bjJsEcAoeeMBq0tivywXiu8i2AkyCZzCSlskCUC6kDd+l6MRU7dHcK4
         e/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309705; x=1794914505;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lJh+U3NL+S8jV7EM59gWsAVuQbFlFquZhjRlOzcTnrI=;
        b=KgLyTlFCePxIGgVwPS7NT+5znQqCwHSvxSQ+JSAQ2MMCjkXLrB+RU/+fV3CYEYHs4G
         ssSPjCJm1NNEAhfimKiOA3EhSKii+8l97y0xUZQj1KPCSTQVnG/w6fLVkhdLGahDbciK
         I1cYUjtZFd3Yey+Ir3DNup8/T6c9QEZ+EQoG1D+NEWJbprsNMF7EewfjBGuhkkIDfq4E
         gyuT/CH03KH75PAoT3AnSv6vqf8FW7Urqrxb+gqotTpEPYVcWNgXE+htnSZPPHY/qnCU
         jOhUfF0cwP7jKXp8lVLYKE/8N8HuPJWS3ruPmJgMcBgpp/TgVvxjVcIAiWKdfOR/xkH8
         AKMA==
X-Gm-Message-State: APuU4Z+lsO7RLmgygXoIFcms/zkoWSVuksQmFXa1aizrGwQ26TLDwlAq
	QQRI4jaVWE8C8B+ACaVGNzj5kBgwCOYK0yrnGFSXJ/zd6Hngo+KO6GhtAiOQlA==
X-Gm-Gg: AYBFou2koVfInTKIdcq9eqxSWPT+Jx+bSZ4q8Frns9UnbsHJ4hL5zQPGvlciLH6mqD0
	hdXRtRMNNkgIY6IQBDJa9/5Qd7mZzWoNk78dPtYd1ws+/ak2wHqr8TYzXZX8+05Bwpj9C5zXL7H
	otumMMK01M/EDNzmLVB8qC09Lr5TSFPPbr1IKyaxTXaXCgPn+HRkYkzrIP6t1k4f7y5vVhWLLhz
	QnPkttSLfHqmPXPfjRrmC4yk8ne5XkRn6sWWHG/oOo/l0OrcqCQGCoeYHCFHN3GKQtFCioaMSk2
	zGmd7MZ6tGW3/qKQNGwYYjJJwSly502nDsFdAOQRT5NigNd7uM1FmRl1+tXPf89xeMjNKaJ0gMK
	P0jBvqK+ApSP4h7SSKmnylMalM2f5VVUIab9qVfN20qiAiR19Z2ZnDOsb0RjtR9XjCeBKDDCIHm
	9Uj/Zjjje3SJAzGc/Hj4QyQfi7IFuwBeG1KcE++IkQsrahZ0mzHxfwsCLX8I3tsI+0mbwikvj0L
	MO/jxcsxFENbgjJlP/bmfHNZ+gXxFtpek/l8unPXjt6QdEJkdh/6x3Sp8lrsrQ=
X-Received: by 2002:a05:693c:808e:b0:369:f18f:3492 with SMTP id 5a478bee46e88-3751fc3a3b9mr2980293eec.35.1794309704562;
        Tue, 10 Nov 2026 03:21:44 -0800 (PST)
Received: from [172.17.0.2] ([52.241.147.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm6148952eec.28.2026.11.10.03.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:21:44 -0800 (PST)
Message-ID: <6af2fe48.f6a0bafc.33b108.bde5@mx.google.com>
Date: Tue, 10 Nov 2026 03:21:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1576722139431947719=="
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
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: [v2,1/3] Bluetooth: btintel_pcie: Add yoyo support for config set TLV
In-Reply-To: <20261110051051.7800-1-ajay.k.v@intel.com>
References: <20261110051051.7800-1-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1576722139431947719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1206766/

---Test result---

Test Summary:
CheckPatch                    PASS      3.92 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.70 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      35.09 seconds
CheckAllWarning               PASS      34.77 seconds
CheckSparse                   PASS      37.57 seconds
BuildKernel32                 PASS      30.82 seconds
CheckKernelLLVM               PASS      32.18 seconds
TestRunnerSetup               PASS      766.71 seconds
IncrementalBuild              PASS      41.43 seconds



https://github.com/bluez/bluetooth-next/pull/1100

---
Regards,
Linux Bluetooth


--===============1576722139431947719==--
