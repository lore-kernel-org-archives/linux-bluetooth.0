Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476589;
	b=pXq1csDv4qtHs4NaETl7ts2q+jgZG8v20OsaQ4uXuwdRllekvlIUVJVozbKWJ++vtfZ+
	 hHQ2rjpTlx89xDXDrC7c4R5S6jRC2DZvQ+usKlYqnVndaPM/Ie5Eo8552GgQWc9TKi2Ji
	 C7zfFQeyshghCL5lZ/rQIF7FJGrXM9+wUtShBXeii9USSM6kqrI8s9/tFb9cywpwlRURZ
	 384F6to4Hvp29y+2TxZaDGuViuv2iiC9fGoQsT2qyYZF6KZnZJW9oD1v28O1y/jeujJ12
	 x4pLO0pdkW0j5BauBUnODBqpt8P5nTtf2UgilfWlpjfiTxT/kDcVbsEFWKJ63yl0toQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ae0VoxdJLVfgLHr2eSentc/Ji5LZk2zI5TNmaImICzQ=;
	b=yizG5qhxigeu2va6+t5Ym3ZX5I8Hx+FbEczei7VBixChr5uqhQY11r284lJ7GIOZlKBY
	 xNcNSICDd3bEgK6PzElgJgvU89dq6bolabj5e7WtuWDKdPFoGK8hCxcoOZHlDjyDM7+7A
	 cD5KbsBGSt+YsW6rGhJ/92lRFHYxO6h2j7UedLDjoYVM6wd8O6CFutD9vSUpOh3matOFx
	 tOVe0Qcqe0WKTYXj/jgm/X28lqvM4p+072I+uAgdiNjlat1bYWp3/AuNq50ywYVm5zS2j
	 5ylh+dsfVgXWv20DE2ZH/pgtv85jBYlTvMZjpK0x/HhjD0pbxxkIDjl7Xj/y5W1576Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZjWIyX7X;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA5606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 23:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28FA5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZjWIyX7X
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b531cd9bbaso28572237b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795476588; x=1796081388; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ae0VoxdJLVfgLHr2eSentc/Ji5LZk2zI5TNmaImICzQ=;
        b=ZjWIyX7XHs20JefJ10c0oRzeekENkTIC/dhWDMvnl5i2N6bkEPlYE0dyAd9xzuTIMf
         Pxccsok3cNAt9rCtbUDHpF+/n0y5IECXw5ZCxR8LOV5UG1IndxCLM+O2qRTLUd1XHZXK
         vfUaAaqZyo8O08pS39L29iGCqwYLGQdZxUbzwvMZXjNx84f4vVTT6iVPvy9IN+alQ3Bx
         /kD3QzCEEEMSjtwWuC1gcy4Et6f16NN4gpFFMKyy5oXtzCwthN0kpRlc+g108fpJ/uLa
         0XRl2NY2kg+5a1MQf+/AE8ciwgWBwGmpLtFy6pt5DhpMXBXZKCiXeg0W2JP6pcNRdSUH
         lAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476588; x=1796081388;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ae0VoxdJLVfgLHr2eSentc/Ji5LZk2zI5TNmaImICzQ=;
        b=Qd3vMVSJi5bYH+46mQ39OJHv0KM+DfEcKNBQina+7DNZ1avkq1W30f7e/niwAdd6yb
         025e1t5G8/hbx2ycQqnC6B/JdoVVsDnB73HD2O6Fjf8r2D1vw6NQ7DlRglmgxq1iPjNJ
         +7CwdfsPl7rj2u4Sv9SF6giZ3hYV/TycoGRzYf40uoLQxrbs+pPOz3B++L/dM3Ghowve
         Dsr87yNmbJCN72r0FpGTbDmZIqLXc+AhajXmVBqITKVuAIAs6qlXjHND3mej7fWAM3VP
         DSmGo8EYks57a7LMSPywHKB3FtGNQCwI8bDiGVwKbiS5lanDg+87rrCRXunnKqsodkIY
         M6Dw==
X-Gm-Message-State: APuU4Z+XU20LGg4Hfts5/2aac7ro0RLgCI3BkzXtKpVUfLKT+oO2SjhU
	IMmQOKO+e95U5OAaIu4k17gQPMie0+VXL9Lptgviu3G8xGf5ka8B6IdAVEUi9A==
X-Gm-Gg: AZFdTZehHVbGi8/ftHfGvIs+omhfkORCQzqIZG18RlXMbPsvDh2IJe3Tanpvo+QzknH
	8W40W93VEaRSvEweet2I+4HsiF0X8m4WL7DWqTfp8PVT7tdS5bGxwXKPDE3Tt5y0fVDoAP9htwf
	onaam6mVJBWYCJyM0Q7DUEnpsVraEudznNBgoCvZKuYudAHZugKwT2e/HR6N9DAY9NsIo2lersw
	gJm/H5i+dUf/M7areKU6/r3Snrk0y8fFWKu6H5o1wUiXFiNfFGURerwXdRHhM+7qErFFowrS3PP
	z25oqu8UEyAl8FyEyYScB0UK1bQM7TrE5w6OlpmXSgtyVGPRrhb2T9AUBq7pEcA8OaO3e1xib0c
	7ETxWxo0mfPOcGz6lTpK8JqrfsG7ucvF3H0kcfYTDyoroCxKe91dwxYItPokVLFxAvRxSfzI50X
	BD7nFFZ8oB9hxRBMOpsyH2nh435PBt2MZLtf8ZCOZFrlnSaj8BERM0edXfqK1ingnXS+Y5NOMgB
	JAzSgN/nbqp6ZddkVPrbV+BXHWwhWCpbX4g8vxLOd0T1kSW3+3FLNagLklFVgs=
X-Received: by 2002:a05:690c:6a86:b0:8b5:6e9:2175 with SMTP id 00721157ae682-8b5204de2e9mr64182887b3.33.1795476588119;
        Mon, 23 Nov 2026 15:29:48 -0800 (PST)
Received: from [172.17.0.2] ([51.57.153.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5201ba5absm52501617b3.4.2026.11.23.15.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:29:47 -0800 (PST)
Message-ID: <6b04cc6b.5c37d8d2.11861.e295@mx.google.com>
Date: Mon, 23 Nov 2026 15:29:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2310435556532596391=="
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
Subject: RE: [v2] Bluetooth: btintel_pcie: Add support for paging over DRAM
In-Reply-To: <20261123152504.3413550-1-chandrashekar.devegowda@intel.com>
References: <20261123152504.3413550-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2310435556532596391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1219772/

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.76 seconds
CheckAllWarning               PASS      33.44 seconds
CheckSparse                   PASS      35.77 seconds
BuildKernel32                 PASS      29.07 seconds
CheckKernelLLVM               PASS      31.42 seconds
TestRunnerSetup               PASS      685.07 seconds
IncrementalBuild              PASS      27.23 seconds



https://github.com/bluez/bluetooth-next/pull/1204

---
Regards,
Linux Bluetooth


--===============2310435556532596391==--
