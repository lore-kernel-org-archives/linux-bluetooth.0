Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150273;
	b=AdSUwt1Vk80TPgt1tHEKiDAEZBvte6qcNqqhQUff+DyFO9LQdA1bQ0vHhqeKFQYs06QL
	 MmZGYLwys2d0Mz7xG6r4feFoN4iybHGCgwgQdEQl6SmonCn2mrcIznCgT5E0Aw1dzp/kM
	 23bGhfXkLbpAQbUIB4nZyu8WVC+HOhro4IEhxnk4hHkjdve2vC2SHQN9fLL6PqAuaFrnk
	 eLoeIUqPN4ClYoHdwgAoDLNqJHGvXApYqvkGdY2KRFBalBkrDt8IXDpHFtg0E+LQ1BUFO
	 iUmTeXdbEbaap320HQjtmPYyVnoN/cVJj0+wgS8/ezhIPXTtuWW5s0neM9Tu4P8PFSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Lle7pM8YZ0bwRDxOmfRn80pwIxp8VU+aNUwkQhPQ6VM=;
	b=A+DWbWKkmOPIDzuMRy1DlPyOokq/5gzli/mJPEAdIly7RdHkKYBbtgDenJDNhJT64KV7
	 osbvTOY/hEKvpNXd5ccveyzPZ8eq9X0mn2PrJUhaurzG1j/v3bTNC1XScO/uUijIvA8H6
	 yjnkkS28r+Rha2nArPTbRrabmY8qnrtLH+f0sHv8LfY/SsUPmU2FHqu6IeTZ2bLvvBVxE
	 FW57JDYAVpUSXJ+sY5a90cat7GQt180AIFRxbnt6TxnzKpMzeRRHkqPyqKSzmLi9tt9jg
	 o19MBcGuAeIbSZWm7Mbci63IgYi/T/EqGkPEpBWJysYAkVUPYpvsc48O4HcX2syP0aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yhgzI4vC;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3912260A2600
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 04:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3912260A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yhgzI4vC
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5430f70c827so7306451cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 20:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795150272; x=1795755072; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lle7pM8YZ0bwRDxOmfRn80pwIxp8VU+aNUwkQhPQ6VM=;
        b=yhgzI4vCPdJDM4xo3RIjFMkUV4hWQubK88kh5MYwA+e0yNPc3AVCnXprQGmh97kt0q
         WEYNIUWun/2qTljjs8YZ5B5MczgMp9z3T7YUhvPWUJmWAb58eFgQ4WFRA9HH8HQWCc1x
         WrQsrY3UXcgOjknVTQeZjn9Wj08m4AjO9cDQ1n2gdBV4a3OsFc0vBdrhXvpMMNtNhFKL
         h3K3QkrIojLtEHNZmajWFCxMn5q09gRqwHSe/Eer+zVZdzKlulJ/77qGm1lI4lN0j1jd
         Bl/cojVcQu30kHNlqbryIlgKSJ80b/GzOVLmkXA3yv+aLkF0Ote3CtJOwMQ0MTR1N+gE
         OAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795150272; x=1795755072;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lle7pM8YZ0bwRDxOmfRn80pwIxp8VU+aNUwkQhPQ6VM=;
        b=Nf0GmNwmCGZ/0YDJu9tqs5gFdOP9hJdGDNBX8Q9GMU0dr1qpoX43ga5mrAdCcpHdet
         7pw3pdj5lZi/yp7+mpO+oQLQMZ/X+g9cLc0WHLheNwVtQiPalJQClCz1XE1qqRJMRNbe
         TsD+L4iAS3QCvSxhyr1Gs3l68qXgbWyQ9eX0ZK8BZ0aNTMWoGB00mTTpjVWOfqtQ1QKR
         /s8s3CTI7US2F/w7rmslsWmh0qxAIpHT3fS/datEJW9HONgsoeeQGgAo8jNS1jIN5IN9
         NyMITcpsD0E8m1DofRLKdGq8B++3O3iCSIm1GsA8sp0srz7pdI4HxBLe0TaA9jwfjuqZ
         GOOw==
X-Gm-Message-State: APuU4Z/ls1VimjrbC/CyO439DQy32jTOFu/2rZtVEov1pRmqYO5beAIG
	c6UcVKvvGZZxfLezFG+Tnn+i+vK1BsvIxzpyWh8CRqsPt1tfS4jhtY3F+6RuxA==
X-Gm-Gg: AYBFou1jDYIG25n0iwVjNDYYdDAg7OIs0qk/4D7zLHyqfrFXetZsL+l2fsL+xfB2zWK
	G1fWXu/pza5m9bQdQZs9Oek4jWoYooZtqBf6SmzaZVyvc3LgVHre1Qd4cZjxVf8Rhi9yg7+jD5m
	rRwcR7rl/V8GhXL3D0puI/jVLU6TaVPG9xuilLKv2kOnW3FBDA5W4x+MQIwqdCPiiF73F+8KS3R
	O6EA8ZU4DXJSCJPlJmRIUQ3SjNLMGtK5SA2ouzrWAN6GTYN5MTc5hzLlRZqRI7Z6UWVGSe/51on
	IM8otuMDwrjlQPwEK9nNkmNI/rXKu6bz61I6VrICheCFynMMOm//SAq7sTjaryaMve+CiVevEsC
	b3m1hfkK98MoExo/RBjzRHy+g0jtoJCrpo8YYJF2H1NWXj4ZbcFOPv/57a8DrvVsk0bSVjYv/Ak
	JDpoOBZeG1uoQWX/DQA/RFJ3gdA6DviUMQJ9dLolVtfq7Kr9lnwH2Quuk1eQsON4DCb4q7g2FSe
	BRerl60juZW110kjCl+IBNfZdxBkAB4wq3PwaAEqqHgdoSdZC/ELU3VE2PM/A==
X-Received: by 2002:ac8:5d89:0:b0:54f:c347:91a8 with SMTP id d75a77b69052e-55d769e939dmr39435191cf.25.1795150271985;
        Thu, 19 Nov 2026 20:51:11 -0800 (PST)
Received: from [172.17.0.2] ([20.55.117.43])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78812968sm13257801cf.9.2026.11.19.20.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:51:11 -0800 (PST)
Message-ID: <6affd1bf.e5d8ea26.86636.d83b@mx.google.com>
Date: Thu, 19 Nov 2026 20:51:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3312692184365445294=="
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
To: linux-bluetooth@vger.kernel.org, thomasdegruijter@pm.me
Subject: RE: Bluetooth: MSFT: Only enable the advertisement filter with monitors
In-Reply-To: <20261120-msft-filter-monitors-v1-1-8192f0c0791a@pm.me>
References: <20261120-msft-filter-monitors-v1-1-8192f0c0791a@pm.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3312692184365445294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1216804/

---Test result---

Test Summary:
CheckPatch                    PASS      1.59 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      31.48 seconds
CheckAllWarning               PASS      34.70 seconds
CheckSparse                   PASS      37.94 seconds
BuildKernel32                 PASS      30.86 seconds
CheckKernelLLVM               PASS      34.09 seconds
TestRunnerSetup               PASS      749.60 seconds
TestRunner_l2cap-tester       PASS      14.73 seconds
TestRunner_iso-tester         PASS      13.14 seconds
TestRunner_bnep-tester        PASS      3.19 seconds
TestRunner_mgmt-tester        PASS      89.03 seconds
TestRunner_rfcomm-tester      PASS      4.52 seconds
TestRunner_sco-tester         PASS      5.62 seconds
TestRunner_ioctl-tester       PASS      4.68 seconds
TestRunner_mesh-tester        PASS      4.54 seconds
TestRunner_smp-tester         PASS      4.39 seconds
TestRunner_userchan-tester    PASS      3.26 seconds
TestRunner_6lowpan-tester     PASS      4.44 seconds
IncrementalBuild              PASS      31.35 seconds



https://github.com/bluez/bluetooth-next/pull/1163

---
Regards,
Linux Bluetooth


--===============3312692184365445294==--
