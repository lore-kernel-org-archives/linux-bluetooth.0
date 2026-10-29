Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285568;
	b=yDIkHrL3EUev0BJyYmJnTOnGEc91ofLtXsehXHvxvA/4ro5ddxjzxBDyXogc1VAgxzsl
	 owpQvIpOsdCZGmRtGBKcdd4knEINRcdbHfwvkE6F3P3GDfoYbYxRzrKt0NojVkUyiWPXT
	 3ycLJFXLoju9K6qJfnmxMg2kG1yYjN68pCpkOkqdX7fuQh1KqNgEMlv+r1Uqilh9x3n/m
	 eNTR9HQqEqYFHAKU1gwssxnBHHZg+IxHcXx8XptyATr3gjffVJafpzcyb+zTCN4ecjeeB
	 evO59h4MEeulvWko1qQ5ekU8oaQuPkX+DoDhFz4ds1ql50lzsAjUjFfkYEMD9lAJdXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=OX92WSNaOncdt44l5564Ap02Lp0hKlFwPmcnuCVw5CI=;
	b=5qt5dYpEw9d1s3z303bAPiygBjda/sIyMBe94ysmRo/l+S4T7imzG3WSejVBdXPOVPCj
	 taMRoR23ih4RoujLSStTVBm4izrwH2BY0IG59d8mSIMW608yt1OV0RmNYyHZBZz3Z8kxi
	 5DLny+kgJWsHPCp3peBc+ZZ6wuq6mpMcxuXhR3rgXNdzD8PimHj0zOMqdurrJkEIsmRFo
	 GUVJiHxixQ0bLe8ANX3Kwm/v6SWO/+il0/M433FFFwEUsnEagXpRMmB9nDU/j84Dy4R1C
	 eFeLYnUDp2PdKOIbMH+jOpGqWx8QKWgxsYda0IEbcSWp+1DxApclvFpHUteFiXYn3xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxxyFjWy;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E995606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 14:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E995606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxxyFjWy
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535a54bed9so3205383eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793285568; x=1793890368; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OX92WSNaOncdt44l5564Ap02Lp0hKlFwPmcnuCVw5CI=;
        b=kxxyFjWy8W7LGCafbfZxFuELFFSeDCaIwRgPNNZWZEhD1WyTIj7QtoCCcKymp5Ue13
         emJmIf8sznKS2Q2r8TV9LrEhzJKTpQMzrvizsAO3zGUAgLnjZVEisGVSjp5CK3395jLT
         dVLQUPHnhxT3XAK/sVGEE6WVnM95wnFvivPp0oeEgT+FPWviHDM0Wdtv2vXXqJfCLgXA
         oTShulgBKqSJnOIxxAaOOMLrV60OJj/b2NNKB9/E9YoXbvGMdtgSjlZ5adtfQ6hRnBbW
         jSvF05+R49QR/Ef2EzWj/+kGwR8QtESp+ysVeuXJZ2DS2rOGZCbNLnlYGWA3yYImBhJz
         52Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285568; x=1793890368;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OX92WSNaOncdt44l5564Ap02Lp0hKlFwPmcnuCVw5CI=;
        b=bTlCWx4sMCXKJIW5HSF/omwfFb1mIR5wuEqf7bR5Dx4M/fXw14MC80l35uOmDtCRRK
         QzUMVHkjIO3Lv1gBD4x2+j6mhuU6R2v0+z9dg73zU2kFpgCN4hEkMDHV7h9r1wPMUYbq
         oaJih78P8k7R3DyKw4HQzUPX3FLQ19LYTBQSbtLuLKVe7pomoWk1IevKEhByPDlSSM5B
         jwdRUqAjzsNVucodcdvOesYYQZGno+kDaAyWkOgJY1U1OWUTokYEzsIvG2yrZYMJFkiN
         IEyNI3vx4DghdaS4LSFQd53bTnzd+1r7VosQU3JKx8xI+z1FoDyiIa8ytrxU10CjdcQt
         oh3w==
X-Gm-Message-State: AFq9FYJ0N163B9GzaKgwmmZPFuy8seumpqeAG7qB3QG5HMdisQBkvdyw
	0WHTymK9il0QYLkurlwhG7dF679FKg+0oqscRoqTlRawrlOkGJ6NWRL5ycLzVQ==
X-Gm-Gg: AYBFou3CL97Dt29UHgS/sqDCrnhU3q4eX9kpS5M0cqHqJBHWUdYX0/ggc2KgA9hhvnp
	l3c3VL1ZdC73RovJMpKCDsCagZ9HR1gQNlHnFA6vDeruExnAAKqHmSkZCfHR8o3EMZr86PMbPoD
	X9QNJiiGZ2H51qBZ8D0+rz54yipee4SKoVp/CotV2kBi2KFFXRIPA2qCuQdmGOmtvJojbZX703O
	JC85+1kIplk1QLzo+a3XX9EPq/+QvErpBSn/3/vvpBdyMJMYbrJeCZXOFmCuIP7sekfwjfIHqaa
	WbIbSErdUC82Wd1ItViPpU1xm0hqsg8in4hJwBr+319bF/3xoxHDet0rmbgg/gaXQV/OJ9lcnMi
	kqPkTZn3pCQVN6Z7ZeDPrSbCu47WlgjtTjTE31cwsKu13kgib7hy+LQjAo1h+tz79JedlDGFR17
	bqAl6draZ2cnub5g2hbnWbXI61eHZbycENahAuhMJJCDLEipSx03EV59KNR/IwPcH0zNKqsvwio
	VecencS8NYhq7FTHy+Da8MxAVKZ2WvoixZaGQFErHbaxn+e751THdY+Z1pbMIRL
X-Received: by 2002:a05:7301:f0e:b0:36a:1e9e:ae61 with SMTP id 5a478bee46e88-36a20428aeemr7451644eec.38.1793285567454;
        Thu, 29 Oct 2026 07:52:47 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.224.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238d9a21sm19080919eec.4.2026.10.29.07.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:52:47 -0700 (PDT)
Message-ID: <6ae35dbf.08597df2.57c29.820e@mx.google.com>
Date: Thu, 29 Oct 2026 07:52:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0103019592339209031=="
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
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/7] Bluetooth: btintel_pcie: Add LOG_MASK parsing from debug INI
In-Reply-To: <20261029095344.3989729-1-kiran.k@intel.com>
References: <20261029095344.3989729-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0103019592339209031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1196115/

---Test result---

Test Summary:
CheckPatch                    PASS      5.44 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      1.78 seconds
SubjectPrefix                 PASS      0.56 seconds
BuildKernel                   PASS      31.90 seconds
CheckAllWarning               PASS      35.92 seconds
CheckSparse                   PASS      38.88 seconds
BuildKernel32                 PASS      31.71 seconds
CheckKernelLLVM               PASS      35.43 seconds
TestRunnerSetup               PASS      763.75 seconds
IncrementalBuild              PASS      38.30 seconds



https://github.com/bluez/bluetooth-next/pull/1021

---
Regards,
Linux Bluetooth


--===============0103019592339209031==--
