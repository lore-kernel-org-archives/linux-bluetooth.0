Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA939A046
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128027; cv=none; b=ultoABVVQA7Fk57fqySBRBGti+/UwzPpt8bULXipLwmYGb7aUp0zAoe8gs8KWa622vmEORgEKzGD7xAHs0ViYbXTZhJB4B7/u7EsrmU4ewZdvI/h6pEaud9KgQio+FB0DPE/eCvTa4qXcA1g1edEcWNMso7gvexddxbJksm7szA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128027; c=relaxed/simple;
	bh=yFbP9UQ+MaryJmNRF+JQY85aEef2+AV7SkLCjsihFTA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bsI4ngblyZLE4gMFT0XqAtscO5jL0qLUMc8KlSaX+zFIgArHjsN5HQRpLnfdEhJealAjGfVmAkfKL8kplFh7KzU0WP5XRjw2DaqGXUC9elGIeroFLzpI91hvEb2NPqsgkz/DpGIqYRIPTxt4fd6iCD4kBaKUjmFZEfeijT1HYx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb5y0zHl; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb5y0zHl"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8f186025973so56858286d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128025; x=1784732825; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yFbP9UQ+MaryJmNRF+JQY85aEef2+AV7SkLCjsihFTA=;
        b=Qb5y0zHlcgVFgxqkWfLPckPNRnlH3lgtAxs64ILUk7w+l8PiRoAKewOXgAighgO2xx
         UE/WZTtVEqImQGHKqw8dQ3fr2LWwWi1BfM0FYv0GsCKmYV665l3Wwlq2LroZUaWAqhzh
         9XsRDyJJ5HKlslqgrSJiF4Fx/eenBDzfb2xlf1qDtw5W5GyjSGfBE3ya6dsiFOwP3hwe
         HR6JvQ51rhj4KgLt5dLmoX+iXFKUAWKaZ4k7qFBsQatb34Vh+iDygJdMkSHtyAqWrTnS
         fIDWnHPLOSY6YqsWg/i7oG7RX2UqbAfZ6AqFdHBalHWvqYkMxdrdb/6FgktaywQW+RO0
         vOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128025; x=1784732825;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yFbP9UQ+MaryJmNRF+JQY85aEef2+AV7SkLCjsihFTA=;
        b=mcyquY4VOC327+h2v50iK/9MwsrP765nOL3LlRvP4S7FXLlonZwDyuGptU3z7z7vYf
         rWjRcwnn1TxKkoNB0atHJQgDTcoqW5kTABOr+31DZkRn1s34EHTkkQezesEmJWcQn1JD
         2bvpVJyI4lTZn+ph4KkCK/DtImstgJQs1Qeeo8M4+zI2bmV01gvIg4EpJ67nuCqUG2vt
         fIb03Zby7JEYYo0ZAk9bVUqGi+uz9DjJEV1uPrSJHKp87yQvz638etEuoWI78ctHKwtk
         blWfAMUQ7fFuZMIBqw1KeI+V3hG366UHibY50nBFUTn5ehOhb42VQ8yIARAgq2IAc1IH
         cwWA==
X-Gm-Message-State: AOJu0YxfUJXV1Gkmtc6Zvm8f4vHS8GWHQNg43KTIGnJMNIxnceRMFOl0
	iihgTcoB0cNtLOibrM9kjrncK4sWpvis6J88za3HhH6/kOiK2kv6Fap12wcTLg==
X-Gm-Gg: AfdE7cn1SCDAgUKTscNBpVP3YAqdyhoHkLOJiHeyoXHtLzEsDTxpHWOhsgFFmaQe3m9
	w7HPba1ME8KbHWgemLWTB1pEBjnsYMbCtIzx1pJDVk1dCN/Y4iGOML4Zz+cDmO3Da/+ek8Sr3Km
	qrVG2HTbiDkP3D+qjQRIqlQx1ilIlSczsVQsGLQk7y1ph1ub9Ky7XgYgWROG2IN6eA4Bo0wQKHN
	4mWjt+VrUqb3f9Ms0WOczmNM7Xk4T/P+Zdb8IQPJLCCtdh2hkzG0OY2CCk0dBve++pIsK2gHg3e
	eqTgMm85LGHxlcWYRRNJklY8pJjoNYQ+pwJdERJeXOPE1dZkBWj0a4kSp7N81xQoH6BNTmbn0a2
	JpRhWnnxYaTB15SRSLFxeYyhU0thbdYvsuWE4pBFYY2Uq0CsKK3pIvzv4WHuAWefHJa5oFvHZZd
	29PswZMi2yE9z7/5um9s8=
X-Received: by 2002:a05:6214:5a0a:b0:8ca:f47:25ea with SMTP id 6a1803df08f44-90758afcd4cmr40110296d6.0.1784128024422;
        Wed, 15 Jul 2026 08:07:04 -0700 (PDT)
Received: from [172.17.0.2] ([9.234.151.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e081dsm196696686d6.9.2026.07.15.08.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:07:04 -0700 (PDT)
Message-ID: <6a57a218.36695ec4.1015c5.311d@mx.google.com>
Date: Wed, 15 Jul 2026 08:07:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1904756265629048316=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gg582@proton.me
Subject: RE: bluetooth: hci_bcm4377: Implement Runtime PM support
In-Reply-To: <rX-ROplxh8z512Ho1P39IUwYIX8jXZU9cCqJwnV84ijwUmpANNB65FFXqYqhYPi4FJFRsjSHTgZ-LdGtvLZh5OdJBy08KXtOWr5z09Lw5lQ=@proton.me>
References: <rX-ROplxh8z512Ho1P39IUwYIX8jXZU9cCqJwnV84ijwUmpANNB65FFXqYqhYPi4FJFRsjSHTgZ-LdGtvLZh5OdJBy08KXtOWr5z09Lw5lQ=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1904756265629048316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1904756265629048316==--
