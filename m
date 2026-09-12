Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103A33FE0A
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789252953; cv=none; b=leA8AJTviF+J4NQMB8Y0V2zw9ckouGvmsqC4dkim5BvgpIgVcrsIfmOpqnS4POMu5uMITPvZjzzRJgPEW5qvkfa8TkeGHxPER9knMQjkblFjaPG5qHWNE/SsrOUkEjNJQVpp/FPQlqr5Qj71pHJziaNXmUavLyhTQqq8qYLY1sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789252953; c=relaxed/simple;
	bh=ozckt6zf6fptEP7qjgKhzesa/SdLAZcmLwO8CBxVpUc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=i7Gq8FJPnRAbfF2a67enlRzJ6ERoZxXAUceRYcxIhlJX6wE6a0/jBEOuR2wYNlms0K+DqvRmIBoxgxBxfurkjQw3/QdAldPGaDLZuv8/aU9pZNQQ8mykq8orymC8N+jBwIknwFcR4yS7iKI3hIit9KLLeMDg97QCNsbhGq+WKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLc475D3; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLc475D3"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so525244a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 15:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789252951; x=1789857751; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XXqjLt1SFfHWVZ1BNsY2COsFkGoS5zqxgMrK+70FjCk=;
        b=rLc475D388ekYrHgMkWhrbKrgiVJHpuc0JjzBj/cZ8k25kPxdCoOPFhW4gd5zolYxy
         u0EefHYLMxC29uFxsYZhQbnfLScXtzOmi2E/HqZbP0NEDl2goUtmvxdu/FYkIe80VG/f
         GZBNur+9wUv6XpE9IraVFoqgxY7lDtS6gvfeGXKc+2FLg/V6YnVdKVNW+W2Ut57qpdma
         nMfCeC7/LByDbbVis2sYpkggMsmKCMmiXqYZBmuMDWRb6/2yjD99NEtkCzziXQpvMFZB
         V3ZLEG7kIIq3wzYF8ncV8vHORuHzYQOOPnQ50uyJyk3frLN0vX6Kngn3DW35fEOTc2fk
         T/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789252951; x=1789857751;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XXqjLt1SFfHWVZ1BNsY2COsFkGoS5zqxgMrK+70FjCk=;
        b=WRhf8Aym9mz6NvidSGR2ShIHyUJYJLDK66lThGT6p+ebHvoRj1Es5+3F6FRx/oRH/s
         PLB5+n5RkbzJtCwQLXYDbIT96QGmtFHQwjEwEfKXuhskRwsERu9PlsvZxDFpwQzQyhgV
         RLAlJ6XgduiFT2Kjzd1XRAOdhQtJOWTPp74Azg4arCQVRB3N+cPNp+YKBsBlkKmezv7a
         TYaSw/boQzo70yX7ysJzO6Glp7z7WVdTqrI3aT47YS9ECVRWe4+fdUn0dv9385cAjtSY
         R/2hmg1/RlOurfbetY41ihG7FN4kHe3lvQnqGaH74rzHic1HxlMMPor95uRncHrdWV/M
         1ZIg==
X-Gm-Message-State: AFuF++kyFqa8qoOHZpUh7Br2/jzqJOMlPt10C+UfOGlWbVH0X4mzXDTX
	42CVUWtIg/uBtmHyfEYhkJMrYNXrVwG/47Kzd1y6/7jbNr5xOGaCp+1a/86gKijN
X-Gm-Gg: AYBFou1aGKXtJK1Wea2x76GWtnF5OBitO8+MQohB+d/XFVDUizXkKjHT09ZaIhLVH+2
	Tc33fdaQ17v5CD6B2KyBiDV1SVY8Fk05HW/fz67ap/+1rr7c/mM2kfouQ3P8DF3G4FvmbKh8Ns+
	STdeCOWMdC9BpY2XS7Wu2vISbYTCEizpWQImyenArppe+0ByU8HuDQ5SQLkAmlTVLQ8YM5hpm35
	hBNIDXqCVS18ZmWAfp0mdXdc9kQT1pCrarje+1+7J71GGecQ7eiJ6FIPjTmjVdHtY4/vFQ105iX
	8mF57D0WPO8TWrdyJuHXs/Ze2Jyi4YCl/9cTMDkl5d6rrxlIPrAqTmP2MdWwG0jYmYYBSmvTqCX
	G4l1c2JFdmkRKJoS1wSFrGWcsu/02GAj2jfmoKgs7/TK30th0IRtr3czzqxaZtQE2Fk6rs5MK1W
	u7qocHecmXa764oJ1jShKc7jC9780thYI1rWAYtz7f4WsnA6O0WP3tjQg6TsMlRKombPHQot0xm
	X2e
X-Received: by 2002:a17:90b:574c:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-39dbbe8b90bmr8239196a91.1.1789252951290;
        Sat, 12 Sep 2026 15:42:31 -0700 (PDT)
Received: from [172.17.0.2] ([4.155.69.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95092c06sm12481087a91.4.2026.09.12.15.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 15:42:30 -0700 (PDT)
Message-ID: <6aa5d556.62a8d9ec.1f05c0.c733@mx.google.com>
Date: Sat, 12 Sep 2026 15:42:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6290448129053341736=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, agenttimblog@gmail.com
Subject: RE: [BlueZ] client: Handle system bus setup failure
In-Reply-To: <20260828-master-v1-1-4810753bb693@gmail.com>
References: <20260828-master-v1-1-4810753bb693@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6290448129053341736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] client: Handle system bus setup failure
   Pull Request: https://github.com/bluez/bluez/pull/2449
   Created:      2026-08-28 21:30:31+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============6290448129053341736==--
