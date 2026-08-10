Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D034BA42
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Aug 2026 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351185; cv=none; b=OdxRkq7XQDqpZ7OGqlmgbBa+x2utykWjl+cPke8ZHh/gUdlRhmHLro0HhjSLUspviz5Rhlkn3sQadH/OfSe0qMMZBiYT5cgJAzvXBPl3KrIaPxxG9KCRv5RNbfEHfFkAYAka547KslRK5qiKd9RFCaCo9XGwwiGCNSEGsUa54Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351185; c=relaxed/simple;
	bh=bfrJjmidVZxc+LOKtaD9YNkibODHyHRWbgwifnGqwtM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DVYIV5Kn047z0y5j64dJyEx4YCWzwF0v+IHQhh/4jfWTTMltjAV+LlqADTyjOATsBjVsQ4Q4l2vEKXtv8+8ARjmWQZFy0a9h2nZji4WP8tQPagtqnGjBNhD5kHQx3NnoWrsCm9JFlZMLw+SeN82ZOSp8TnJKpzOBtB0GUELSvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qv4MAv80; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qv4MAv80"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c0006ea8eso12200451cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Aug 2026 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786351183; x=1786955983; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=da6XakjfjjxvUYZjKDtoYynr+LMmv7uS6tITLx7T0BY=;
        b=qv4MAv80OTbRrGPZR/BoU6Dwz3d1Rk51QKOIowwa/nA2tU+jPAv5DO2TBtMi3bH9GO
         NguQXkG2pGB0uknX6dyEZrjXj6ph1sM1QKI0IMy4bVHFI/Z+FsFN9+EQRhoXbFkZB0aq
         qJzUT9h+k3EqEEwIwsbl1pVscHUknlLPbQiXw3IaFCqhWVxyPBsvH6GEWrJuhGJXb6hQ
         C+fm3hNePfF57Y0Akl6lGtGYBH4YadHoDSvBCAcZ09coD9aX0yK8ziHq+/EoqXq6AQ56
         begfPBeSbbnk7wpcfbHdgBTVUkPQ++vyGsFB1TYuOErmRi62tNPldECHLvItGFx7qzgx
         KLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786351183; x=1786955983;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=da6XakjfjjxvUYZjKDtoYynr+LMmv7uS6tITLx7T0BY=;
        b=OwAh0jXTYR/MLN4ljKwL3+9VidrmBdW3Q9KVVJhGvwUW5La2AUtMZHu6DP/dKwqp53
         HHy9c/ejLLZtLjQL++OoMZUV+bHV+kH2JfZYg9DfqXvFjQ3H6c067sSg7XVBaoXWUFcP
         IQSW3/y/36xWs02JoF5ei9EkVKBJfJfC3DD2Mp3VbqrJtmoKxkuFVz0qYulb+2JM7jvl
         t9Mgui/j/HWQTRUK604rzXoLaB0tYsZkWiQxrbTBvufm7otx8J1U+WEV+wNGDv/Ye/HE
         p+2VCHlTLIc5ayL4Prwldd5tXQohUGofwejCBfCCvO0oqcmvy3ih2INngF4r8WyYBpAk
         m6Bg==
X-Gm-Message-State: AOJu0YyaW4ozXKQHaZyZWW3AgAjcj9ZqB9SzxcNDXhf4R3hh6v7n3nxa
	RCC76lv58ysNkkyRI3u4iTeWYonBNqIqpBltcTXHD1qCBn64ng4+C6hL1JsawQ==
X-Gm-Gg: AR+sD11K6yyDeXK1BuyMSga2Mxh1n0+oieE8w4KZjh5TlP2WfjAT/R0xCDV8DLgEDL6
	XeqRUkOv9cfwUoKAT+4JHhsmAg/lTZ1JgHIQYZu2ZuZtONflw2rLgjDi8XSCwnaJ4ZPPps+uYQI
	AjlhBa5tEn8jkfZyMy9vhATQbiLL8U7J/pNgpbXTWr4UTnd/M5aQzwgBEzjwq1DObGpW9n20Q7d
	wWGSuXJ1TNyQfgb+poQCxcPaCLNst8fc1eBPxWs66o5bcJvKY1vvIcT4um+wltseUCBj9Z/fU+Q
	RGHg/p1Dq1AK/xf7/wACD52Q52F1OQItwB34MSMHakzgiHmZRXGPL/p7IxdZfKmCRUVvQZ8SgXJ
	COpX1z39cDIZZET5REC8sgRqry2zZfmgBRSQUFTSdSvpSzAhmUywTLYLgWjIgg74g5WAqe/n5AG
	EdqdUJfCjRiZgOwhy6mzI1rkIwuq85NmUSeqE9NBaM3qjuJOHQbf9oBdgFBUDfWs8hD4DtlFGV7
	ZIFUS8=
X-Received: by 2002:a05:622a:903:b0:51c:63d:fc10 with SMTP id d75a77b69052e-52ce6114126mr501297201cf.25.1786351182935;
        Mon, 10 Aug 2026 01:39:42 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.127.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm67643951cf.24.2026.08.10.01.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 01:39:42 -0700 (PDT)
Message-ID: <6a798e4e.043ad0dd.b01cf.5236@mx.google.com>
Date: Mon, 10 Aug 2026 01:39:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0546760307029894054=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhaojinming@uniontech.com
Subject: RE: [v2] Bluetooth: hci_serdev: Fix use-after-free in hci_uart_unregister_device()
In-Reply-To: <D747A53C08BD2456+20260810-bluetooth-hci-serdev-uart-unregister-v2-1-690493a6ab95@uniontech.com>
References: <D747A53C08BD2456+20260810-bluetooth-hci-serdev-uart-unregister-v2-1-690493a6ab95@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0546760307029894054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1143156

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.67 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.33 seconds
CheckAllWarning               PASS      29.56 seconds
CheckSparse                   PASS      28.05 seconds
BuildKernel32                 PASS      28.68 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      497.18 seconds
IncrementalBuild              PASS      25.38 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/565

---
Regards,
Linux Bluetooth


--===============0546760307029894054==--
