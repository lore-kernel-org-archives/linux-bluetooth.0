Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143412737E7
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988612; cv=none; b=KHr6BReX/nVFlhc6wvYO9CvPfFkwkLp1YzUwxHvjUzJTqta962bTBlaaI7x2tRUNTvRvsGtijPfiKS2eROVcgdEBXuLZJFvew20DnpP248F6C0pizQMCSntbCdSZzO9bGrxganamaB8C7CD7fedR2iSpMNLPCHsrIAMzI3x+0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988612; c=relaxed/simple;
	bh=+rikfsRhiqfyKJ1OuxWr1JNMsUZvlphh3SihqZaWqeI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CGsggZNlkroPkeMAFrMaJpjvIdqJPIFdjKVutusUN1SXS1r6Rmswmcg2uFnjxdgjH4rIr8VXoIjEwvFxWEnNOBXCXMbq2Jzg55a51CX7Z8Qu6JvZq2mAbSjTdRpPsTi+24bzQlmwbeuEXFszAeEllRW9ztX65RRYbBdpK1aCD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUV1i+3j; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUV1i+3j"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c03eb31db80so4280671a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 08:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765988610; x=1766593410; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+rikfsRhiqfyKJ1OuxWr1JNMsUZvlphh3SihqZaWqeI=;
        b=iUV1i+3jNPsCX6c7qCAfBTJJ8konCW8Dj7HIAhcdkJmmw1F7YSw0tNblw0DQn3Ghw0
         qT1UIiUMW6GaFO+8mvo0+D7c4wyspPtY0OURzFcP0ACkXXyPNZ+snFaVwaor4aqsFWA+
         q+CKtIpG4DQwlhdrEo2Q+zLuyNQhv8Y2oO6qUPhlTK5p6wRnYuHyg2LRj1ovOQdA/ukk
         cvHW/sjBy3x6MhuRKSBBjL8BRRC3ApHXlVQJaLKfKjRU74tOzpzPaemXY7Hd3r+BedUw
         9UCqAr1v3vY6tzIIucbR0QXj9kLIar5NLC/XS0GxJJlrtRJ0xRSLRZemEU/UeTjuXLcf
         uy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988610; x=1766593410;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rikfsRhiqfyKJ1OuxWr1JNMsUZvlphh3SihqZaWqeI=;
        b=xTgCjftFyx7hkETDaZje/7mIBwJCvy6wHe/qaykTOWao4gH145ISaMo3w98z9TnGKs
         Hhz2h2gf2fpl1Wk1kRXesCub6Ol93hXd75vmwFxDu6SNQ0O7UJ3EUItrNSyc+u5G6JzG
         l1uh89RPCkoTvDAVZ0V4ETbyhZfa4xMStLh+op/tlFy8rkekZqGWlsYJaHeo5i532fY2
         wiYV3zM8VbcM5UTkMDIJ1sX0taLnvACIfPmUCFQXKHD7h0olv/UonsQID/UW1UroF7WE
         rp8Mr8JnR+1Q04nLsiqygl5cdmNHYZx/0JG6XbmtzeU7gGRBkInpVkEDrknySz0c+6V6
         5qAw==
X-Gm-Message-State: AOJu0Yz9+Fz+GeFO7NgrRRTcamMyUoll62Rxv9/axA2xYid2g/ZhRJlx
	82t7vPhBh5nV5tDjUrHqvaxd0rhoMJ4yy+G9qi0w2R+bdipCHuc1n3uuPM6I3yZ6
X-Gm-Gg: AY/fxX4jEhJdcRcHCpPPI64ApyGOJpHV0LEhylwASa3L0seuk40uv6/CJmvQY0NJsaz
	yZj6PpVkKzJ6VrtztYR1pvweQk6oZC1eA7Jl/b30ICYVzOPabKlHvLMYIfiUXcu7jmDHJSb0hl0
	i6Qfm3EMPbu6Rn3jTLocF3IuYt8PLi5HrAaxPAia+SkOlwh+bbMpBrjsPiFszLYpxbNK0Mi6i6M
	PQMidG0Ti53TG5jT756AhQxc3zX/AcG+6hyZtVnWbSlodYmuzU02JdphrVgQEsjzoEjMQXD2ZVs
	cDvpc8u/1fa6tBO9Lifjyw0NaJmjJSJR/sl54cNiL6oCrlFgKBDm5bOfcU3HmIZ/+ck0Gwd+1QF
	z2l6ca9sGBwzMbW5U9uGOxxhh/IgO0em5/GOIBpOxfvL5yVqK6Hs0Q6iIGlHIKGIKSAWUOHpmCT
	KkTdiSIw2tlSbJVmFsTnE=
X-Google-Smtp-Source: AGHT+IHwAXEh0rKUYNmahZhMEAiZVvUpLlm6FuM9Ig9GFu/i4zSowCERMWF9QPg1y2QT8OOq/fsYBQ==
X-Received: by 2002:a05:7301:6404:b0:2ae:5bd8:1dc9 with SMTP id 5a478bee46e88-2ae5bd81fddmr1770619eec.14.1765988609649;
        Wed, 17 Dec 2025 08:23:29 -0800 (PST)
Received: from [172.17.0.2] ([172.182.226.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac190acd01sm41886396eec.1.2025.12.17.08.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:23:29 -0800 (PST)
Message-ID: <6942d901.050a0220.2eb103.58aa@mx.google.com>
Date: Wed, 17 Dec 2025 08:23:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1906387311625791452=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com
Subject: RE: Bluetooth: dt-bindings: qualcomm: Split binding
In-Reply-To: <20251217-dt-bindings-qcom-bluetooth-v3-1-ced8c85f5e21@oss.qualcomm.com>
References: <20251217-dt-bindings-qcom-bluetooth-v3-1-ced8c85f5e21@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1906387311625791452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: MAINTAINERS:21364
error: MAINTAINERS: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1906387311625791452==--
