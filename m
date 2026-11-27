Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818736;
	b=QBHOm4Ei3zdBq0BLO6mPfmUCHPiAU3J8knQoEbAk9I5D+54sDl3xE5VEmRX3M0OeG8go
	 t4XA1sjuVM27Bzry1MEtXvlYgVZQY3pCBCQnpJtS5c8OhoLXKiaVchCUvrsjkc+4QEUt1
	 rmcTpYPV9l4M3zg6BkXDrHTYh/vuC2Jxfw7UGa55Hf2mLZH1sMwpVeTYitDz/R38RoI91
	 wnpPQglRpPyYv5FjuuKZAiSyf+PY20ijNKSvN6PSo2QvqWMFddx7QEHXRiYxBTpE/5bPc
	 MN1peIom2J55CH/x2GEiYoxtfF5ONX2+cEmuFGA8+OVkmx0JqmwA/EK/e0y64+BxC1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=w+KeghXN8tPfAca0Ucbn418At9q9nqvkF31vD+6TRzs=;
	b=1s9V691GtB3E+hzQWbHj1no4iUUOU8hO7cXLYzMgokIGKjqCJUE5mGS2CkGJZdtgpoU1
	 bQhqHmazAljvAYtpzEkssMZJowWhEF062r0p1XXBWhFsH6TV0FCzoJJur0GrLWGxvCGay
	 PxIQ9sBS39cqHZ936T3XE2YiW08QQefkCqqisclm4rwyNIkxP2VdZR5SczqpPlKDg+8ph
	 dHHIEoXnye8O+49YE4Q7LvP9saKAMPGCLvYmAQdQ14cD7P8mkwOTzfXYyOyKwIUplUfWN
	 ma3vBi6v9K/KnMm6mZNIEsfu9DauVhWFRAVLRMlJueAdiI+NXvgRyr1ylQvRzOfiqQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wg6siIFE;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D75606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 22:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D75606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wg6siIFE
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-862d919fb1cso4117496a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 14:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795818734; x=1796423534; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w+KeghXN8tPfAca0Ucbn418At9q9nqvkF31vD+6TRzs=;
        b=Wg6siIFEwCsKnYPIH2N/j/QclhXw3CS5EP9USAHEHsByKVOuG0xAe8ryhbuGhf9hpA
         rJCcX2k4nYfgvfWjpDcPBZcmLyNbP4nWAOKX8sQeOPjHk3klOjcQjvL1+hU83QSMzzTD
         itaomCGmzA5cBT5WmZg3+KWnGpeXcpuBTZ3akWN8Gzz2AFNZBCXvDzo3sOnM4gRBoxDU
         FUpIxCMa01W9y0NzAfXVfR0VUGvaVbq7ztQmw2OFl7CPmCtxADoXRUr4wzoAOzGdxhUy
         4FfKoBDpRFU9KFs5Cfkd0AjY2gONqAqjxbaU0REIWrcozsp/U22QJfLAOFl6KKSFPoe9
         3TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795818734; x=1796423534;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w+KeghXN8tPfAca0Ucbn418At9q9nqvkF31vD+6TRzs=;
        b=I0Mc44k60YAUYU9+AfBfkGWi4ef46xljj0IofKovq03mhYfxa+9kKMZ1qNdbc3tZqq
         BQSseTD8l9v0UZytPPQCj2XHKck9crGyFY7wRHnRCqm1dmitm3TaRGA02IOLqiOM/zB+
         ONiy1EYTljvYvIWJNqo4+UFR6ibrYySF9eOVv1zkBlTACYNigl5muYr5ZDfvPBPFbSqr
         QBDhNwJOy5AL5DJPrnP3QRtYGP2aEilutS0O7Vt1X6UAgXc1re05IZ3yRtZRqjw18S9N
         wleVxN+t+S/xa6Zk5xEMQHyq8k3b8oD9j+7VOW1WoXFHSzsRd2JlfZujcYwmdayGlkUA
         YfWA==
X-Gm-Message-State: APuU4Z/pnx0Jy+nICAAp4rrmZIOFrhm2h6QcwbT3RMQBvN7JsO5FG2eL
	yvuUnBgju86KeMd4ClRbIcSudFYJ218LJ9DuN7V0tGISuZgmoXe7/CsFBcfU4g==
X-Gm-Gg: AZFdTZfFpFxxuqz0xdjpFw++8sXVrGYXFjopK9M8YyUGomnCtU7/Ifhr88djO8VkInJ
	Tvjhp2iAH7yNBenb00IY9IJbyKruWdQ9CDBexRBvpaQ3p8sV/Qr1siwpiau6MRxsY7/talv/hfB
	drmt9yCfdsz9UqZKgJd3B2WgLm+Ct6uePaNkCQEltf9IzTiFL+rfMgM0td81SYUobM084pxW2UA
	nyhU4Tr2DEkTzvtvrLXFt4GU2rh6y7NSQ/nr5qHHD6O8M8m4E39Oea7x7ymPNu5UL6jq/gTreO7
	f3VLAxuB+T6AR4HMQ2b7XqriTp+rhlkskr4Fx6yQVr1kf/72uW3mphpHqWnGUT0Y7NZEUXvhaRy
	gNOc39hUmPfOlUOkwLiEZPGMfYkXwmMjjOpjKFuVwMMKZi8nqXNJ9sKMbfW5gjXEsCl2rZ6Ivko
	wvZqbycvk+qW2vK148h1W7ffVzbp/E8f1zs7pnCbhtjzKw7w7fN21nngMc2unCsxIWV9240VtFU
	H+PStXOawbEhBuSaHpmLQXnZHhFOBh8bBu2/QUMUir+HnUYyyGvG2O0mWLHslo=
X-Received: by 2002:a05:6820:f033:b0:6de:66e3:a1e6 with SMTP id 006d021491bc7-71b3e71b5d7mr19468204eaf.11.1795818734439;
        Fri, 27 Nov 2026 14:32:14 -0800 (PST)
Received: from [172.17.0.2] ([172.171.13.57])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b8345e1f1sm5835085eaf.5.2026.11.27.14.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 14:32:13 -0800 (PST)
Message-ID: <6b0a04ed.3bc24583.2d383f.d49d@mx.google.com>
Date: Fri, 27 Nov 2026 14:32:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7564258347276552611=="
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
To: linux-bluetooth@vger.kernel.org, dev@deq.rocks
Subject: RE: Bluetooth: Broadcom controllers of the Apple T2 Macs
In-Reply-To: <20261127132513.262754-2-dev@deq.rocks>
References: <20261127132513.262754-2-dev@deq.rocks>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7564258347276552611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1224493/

---Test result---

Test Summary:
CheckPatch                    PASS      1.77 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      18.95 seconds
CheckAllWarning               PASS      22.13 seconds
CheckSparse                   PASS      23.76 seconds
BuildKernel32                 PASS      19.05 seconds
CheckKernelLLVM               PASS      19.24 seconds
TestRunnerSetup               PASS      432.23 seconds
IncrementalBuild              PASS      18.87 seconds



https://github.com/bluez/bluetooth-next/pull/1246

---
Regards,
Linux Bluetooth


--===============7564258347276552611==--
