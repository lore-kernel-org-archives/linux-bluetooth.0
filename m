Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284963;
	b=KLUUGCvOYpBjJCqTPgVpxsULXdhxdMf20+tfoyPqYCrrcrxaGf930iec2mX6emDo0Lhf
	 E8ioqMmtnIeI/XMzT+z05twtmNeI3xrmbWlpzmjGAWQtXRSyiOv1+WBDg6Pzd0Erx+0EM
	 /idCkB+sDttJQ60mvIl3qs1gIa52olACjaVX5ekhog6uS7iMbDSJf2R2/yXx65+uRo8J2
	 K3Mv+Mla0BDTRNrcPFAZ2rIQLpjHz4JFl+2/W+PBRUxOoaLaFV9sCviLSr4ldumI4ZGR0
	 I0VSU2bqE8Ats9VL15M6aaKVk3bCqp4BOV6qPaSDkP1bp0UJeQ8FXd5SPDZzi4Y/y2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=mv5l2EP8xpEovSb/eWTVqzVwMOOSnw7R2FdCmLbmsdU=;
	b=iRxX9cRQLxRwmgNxPKN8n/wxpQZK6Kq4PsVejQEfIHAqsveYvrV1P0+Z3SI7igHLRxD7
	 XM5J7aqi57m2rnyWJrv45+gjK4uZc+891U4JyPSHYs3/aL1N9VJe+N7l18Xzl211MLJKG
	 xjbskrzU1vw0cDKSdnwXjeWoStC0LnZSx5BJotlRmSZ8AwaYl0iqb1/se9N4eLvdCYBix
	 vz9ewoRwYYsf6nNOtAfM9HimJ4CEdBv7mmD6YqnEYDWHVw0f/jQA4qB8Nb3YW8VEnEqYv
	 LIdlQREprCMSmb02y2CKOdA76+pv0sz4KfmAVN/tWbgmJh8XJeiHeX0o/JPSPEhsUZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="gdb2c/pq";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8791606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 14:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8791606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gdb2c/pq
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14fc585291cso1996620c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793284962; x=1793889762; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mv5l2EP8xpEovSb/eWTVqzVwMOOSnw7R2FdCmLbmsdU=;
        b=gdb2c/pq6ArjJb8uBbqGhCTpBpGTmoFqRxBXEkwSENiV8J4eeh9gkCXTPesSSd5GCt
         WxM8PIlbck1YjISNMvcNlhFSF+p0pm35jPD3CXFreEvgCUFsWHYkc7y7GyDdtKwNt5WV
         Rb2Zut6iEr/GsipAw9lIHGMfNIGDt4LF3mLiDHXzVRVg6xxPBCQUdcPu8IHGRF9NG3n0
         tehjLmNtPebIyB0nMV6fvEYdoa4Y9EcWMp3qlCE4yxH7CGYoqMpRrYR499hh8JCnrEDi
         KFU7sHPuYfWDfPfSPEdwDCrYSE8Kh8NBHtNySLpoVq4JhQidb7X48mr2gH1iCsWhomam
         Hj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284962; x=1793889762;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mv5l2EP8xpEovSb/eWTVqzVwMOOSnw7R2FdCmLbmsdU=;
        b=UJWZPQ4zP9W4J5hDRkCaLx8GIMPA7f6CpjZKgO//Gst98zFt4FLrvRQr8zT6VKWOx+
         /EcwacO9Px8jW1NgmBRlQK/w9d0rWlK0/6ghZHXBebNNkPivJYLV89laKm9L3Zjqdsf0
         5hXLb3TK6j5YMEXYitffurPUrgAokDNUA5NdfJsAMsZRdbCtTJfTPrHJT5aKXEaTYqYo
         AIjUJXnq4pmoB662CE6469+uENAplcvLrDZXWhpie5ESLlgAAlZnRX3SvFtC0fN/DYzF
         BWRkFCqp7GwRAdXT+XybR6ltwTQe4XJxYtHiFIwdGHHNmKk3GXicRRzNApXraYqzLXke
         WcwA==
X-Gm-Message-State: AFq9FYL5f8TVtxnhSie+v1Go5GMV8h07iEK+f9a+4qgB9/vqo4G1WNrJ
	nWTw+nLAiZobUdlpGVSeZD763aQAbt6zef5QbegvBOADmOBRylQT2ppcegMefw==
X-Gm-Gg: AYBFou1aM01+1bmRYNpbteAMXOPyX5bqVCKQDcHg/vZNpHO8VNx+T41acg+LrEjYAnZ
	K23HyjV8rsSI/diiGjGUhZgx9ChW0l4mOvNb+P0XNK4Zwaju3shXX4jUrNl6AIJbmIzDpBeqgDL
	G2HMxCUudarzlmtwgV9dFF7xVlwTMTaSqyjiOEkoCJNVdYqR6L8zSAN84gXraxY976H5Kw9ajO/
	w7JDXwepCBsSONxDBVRMxYypjJoatl9Jdubue3qbwV3jpqHMcb2w/cU8umdpUgHO27SpbbEfwIb
	JTIS34zdoLBWYSdHN9SOxHaNBCR6Eq1gYRCCRhoZ5Ir0h40qxPgkLwDcO6ivbEzJFYisVXwUOtW
	oPlhEvLAJkx3mWHhQu3dAs1P6fZCJgX5BpYKA1bNHXB8kqwCcy0imuPopz5oUheT05GvMNmeLkK
	+W1xBnZ4En74gIR0UvUH+DdFvZBZCOxy5enuDOp3gvaDI9JdAYdmomcsNZPNhPzwPZOLkoMKjDh
	z3+5rKT4bNWMMtlZNTNgJWOrZgi3Xit9/yZbAjmQ0CmO5Yh4OEbC/Jc9Dnf
X-Received: by 2002:a05:7022:3713:b0:148:302e:1bed with SMTP id a92af1059eb24-1a6cf72b288mr6106782c88.38.1793284957634;
        Thu, 29 Oct 2026 07:42:37 -0700 (PDT)
Received: from [172.17.0.2] ([134.33.71.78])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75cdd21c3sm15418769c88.4.2026.10.29.07.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:42:37 -0700 (PDT)
Message-ID: <6ae35b5d.1b11e1d6.3630f9.74b5@mx.google.com>
Date: Thu, 29 Oct 2026 07:42:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5788694357610363743=="
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
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v1] Bluetooth: L2CAP: Ignore connection responses with wrong ident
In-Reply-To: <20261029094104.2952304-1-jinwang.li@oss.qualcomm.com>
References: <20261029094104.2952304-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5788694357610363743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1196120/

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      1.52 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.48 seconds
CheckAllWarning               PASS      28.59 seconds
CheckSparse                   PASS      30.97 seconds
BuildKernel32                 PASS      24.99 seconds
CheckKernelLLVM               PASS      25.47 seconds
TestRunnerSetup               PASS      559.10 seconds
TestRunner_l2cap-tester       PASS      14.57 seconds
IncrementalBuild              PASS      24.24 seconds



https://github.com/bluez/bluetooth-next/pull/1022

---
Regards,
Linux Bluetooth


--===============5788694357610363743==--
