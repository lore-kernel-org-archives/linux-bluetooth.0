Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF703F44E6
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975042; cv=pass; b=Iv1kyng0J1jREkuKck2OXKZzKdhyx4nyBTF+09rDpWKI3kBP1irChYx3xrj8OpK26hpx7Ek/VjbC+G5cLRuiwM6AfX77LMFbL9erk9HbQkJPuw475JC6ljNI9jBsH9mPToQD9YGUt5i8A7doRCTyT+h8dTX0KWQ2hrL/qHNoyAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975042; c=relaxed/simple;
	bh=MTqGDmWW7VJK+3lTKhYkYs7s3m0u1BykiAdxynY5q4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1azdBUYjnUEvy9v9SDwWg8M9XaxgLxVI9na+PYtWGlaI+VwUk4Dn+HXRQiPA8TeDZaOHVJQ0H0uokHhoJyB3s9IvTLfXwym8WxdyXpFQ9rqsYnZJQpDR5gcJuK5N+cFT+zRXLTBL/784UsSP1i0ANwXxyfB7QHUQNBymGezVcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXn13eh1; arc=pass smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXn13eh1"
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-395f24a5f2cso51439131fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 06:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975039; cv=none;
        d=google.com; s=arc-20240605;
        b=ayWKehh/+Igp2sNBJEgrL3kIuoyxT6Uh0/LmVS+vfC3TKSjPMXbPvMGqM7y65lUyAH
         BdAhZhB6ZuRxyc2EC7kL0UgdB7CkNww5jBiq9VXrAtQzFMoX/4l9hEJA8d7Wm2QMZnKS
         doQ+HpXipGtAYulKpsuFjRNDsoB5GsH2Th6FlLtDd3CzRYjGurbfMtr1ZXEKov6sMkHk
         n9ugbgWftFyJQ0ZeKfW7obPERTpTRSEIjGqG9Onzpi+/mcgZH2iuSP/Zs5BUHW+LGdqC
         eeOZJuNl6P3Zc0H2/koqRXsa+rXfcNt/FHgNyMjtqiV10mHLs28MMQ96CnjfpMGkV1t9
         BNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/Zt39kO0g+oUR2CQKMq/24dOSlbnY0z8aGn8Aqweae8=;
        fh=+MYF5W70GLFt4zZ7QnTEE731DdSe61fKuXp1xyPPNbs=;
        b=RsnaVuQMl9jOI5rKdYVGMXuGlYnjy0YpmK8Lm5BSx7+1hLV3e0grC5nfCtKDpYea13
         ZRB5s2THwIg/eBdKdd991l4xMnxlbFAC+FOYNuyMNYFLFGg2isIBuB1qAQVOyxX+sGW0
         rUpBMdiCAIKxd8iX8As+UAdg1GHlIrRfwKK24Rb3FiDx/Qyqey1g3FWGAxDPsof5WN8m
         ZgjU1mixpDMgyxiNk+PoNG6pbwKwHHKzt1AHQoclTEaqIdEYmv+fzrhwfRP82AJJhfqJ
         owfRzSg/81dkpWiMX8An6zp8jB66Du0/QWVKpBzYBiKwC9jfj9ispOXLh6Mw0TzmSzkE
         X6Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779975039; x=1780579839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Zt39kO0g+oUR2CQKMq/24dOSlbnY0z8aGn8Aqweae8=;
        b=qXn13eh1sKHrYK+HVX2qRabaWDLThWs8QP+XDPafpWyEc3kQQaczURlMgh3Oz4aEZI
         Rl3QekZUfXGI2gIlnny2Q+KI3pCRtl+U23IJOLTCUL+mKTKXfGmRWwRmeLRjYITqayL1
         OfxuVJlaTkBckcV8Xq2khdu3P+C9BtP/MLEvkdr9ooRPvkZ+7yd9ktB5XwFqguKhV8Mb
         rEaKhYzsGYJmbEzXeITXZppp/6ZNUyYOty0Pc58OGkN/CakYQkxIrseqWJVSHfWaOYwp
         2ShG0MW9pUKmmmeQgKDnizmtevEfRz/F8zq4kXJUjzwzdne5JQrNvTDp0DumftXMdGqU
         gvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779975039; x=1780579839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Zt39kO0g+oUR2CQKMq/24dOSlbnY0z8aGn8Aqweae8=;
        b=Cg+8pag1IjVOdv2rv/aN3SIPUQMI89N7qDvqIqM4rtaCJdtadtnA++CQk9OCYWyI8Z
         phcT+0YV+8kwBWN+GIVreQhWD1bAPlTmiDiOXtZLugKNqKlK+pC6ES/XnOEs/LnWuEq5
         UZKq2L4cV6wwqjotH4BNCkXCSkLcHQAjLl5JSYJA+kXSQFG8uabX1e9wprbRCwaavQ8m
         qaoTwTBKMIggOyJ9TdzHWsQfAo7NE3BjqSIcyIUkJI0WhNwUFx66qe0gJ7fSc0KnFtaj
         jiNDYlqrgr94c3aHW+82VPKLPKP76uTaAj7P5z/awJFekYkqq91lyQzlysyx3oyuJZjK
         6+NA==
X-Forwarded-Encrypted: i=1; AFNElJ/X2oiPfJEp5w65fgius8pY1UN+r/KBLj5S0roMcvYfJ9hoch9ovsA/9qDAbtt19c2SC2HMMvLEP4b6Bh4CTrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5bxqOPQ8nteCE71mmEtO9R/hk3soKjmlSPwvrnbgLP2HXLKw
	+qb9wHaADRhYJ0MOAjjUmVfay4/tzivkVAk3Hruz7Ac8Lg6njZXQEGZakOiITaEGBQt5hITs+WP
	W6UX1bLRbTE6Wm1V8DpjgnARxRdfwDXalrmGTUIIUx0B46IP9mQ==
X-Gm-Gg: Acq92OHyS1CLCvf+5SBEPu7yAhuNUS3+OTizq0ylhMpzdBJxX/a2C7XanYBNdeyFQ8e
	hF0dkyktIWg4Vtti2qUhBEOdGKUhBoc6lhpDW679O4vVRYWjwIq+/29JN1sAzlDxqCqG+jBCU0V
	ci3nuUTvDfQKRKV0E9eMUUHPoFcl5ihvRBgpI4L2bDuLJswMbBwvhEp3E+CY9PweE/3aXlUqrCB
	KDc4gOmiyxEqYABDEON7JKVy2/f83dCJBjdqJAY1I+zk2t1KhtDZqC1GH9A7XVqDox67yb1RgBn
	gRIZiXhYIFERatpO7lxlB3XLV8begow=
X-Received: by 2002:a05:651c:154a:b0:394:2b8a:2348 with SMTP id
 38308e7fff4ca-395d8d73015mr96124541fa.20.1779975038277; Thu, 28 May 2026
 06:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521052611.1815693-1-rollkingzzc@gmail.com> <CABBYNZJ7aETr9KdUFdU5uVkcr8RMzOyBS5xv4vpb7ij6Di7FOA@mail.gmail.com>
In-Reply-To: <CABBYNZJ7aETr9KdUFdU5uVkcr8RMzOyBS5xv4vpb7ij6Di7FOA@mail.gmail.com>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Thu, 28 May 2026 21:30:24 +0800
X-Gm-Features: AVHnY4IXl80xbMZErpeYbZ-onHhhJ6JrflbBDY6MbReitxQyuqkvB4gdAqjY2Og
Message-ID: <CAB7XQsF72-2zPMKFjko5pKvR-scqyOCT3463cghQBY4G5O4arw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: bnep: reject short frames before parsing
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

Thanks for taking another look.

> This still looks incorrect to me, why should we do * 2? If look at
> BNEP_FILTER_NET_TYPE_SET it just use the header to pull using
> get_unaligned, I know this is an existing problem but except if the
> BNEP_SETUP_CONN_REQ header length works on a multiple of 2 this makes
> no sense to me.

The reason I used `* 2` there is that I read that byte as the UUID size,
not as a total payload length.

For BNEP_SETUP_CONN_REQ, the byte after the control type is the UUID
Size field.  The setup request then carries two UUIDs of that size: the
destination service UUID and the source service UUID.  So the intended
skip was:

  UUID Size field itself
  destination service UUID, uuid_size bytes
  source service UUID, uuid_size bytes

That is different from BNEP_FILTER_NET_TYPE_SET, where the header has a
16-bit length field and the value from get_unaligned_be16() is already
the total filter-list payload length.

That said, I agree the patch makes this much less clear than it should.
The comment says "data (len * 2 bytes)", which makes it look like a
generic length field, and the raw `* 2` is too opaque.

I can send a v5 that names the byte `uuid_size` and uses
`uuid_size + uuid_size` with a comment explaining that the two parts are
the destination and source service UUIDs.If I have misunderstood anything
here, sorry for the confusion. I would be happy to help with any
further changes
or testing.

Thanks,
Zhang Cen
