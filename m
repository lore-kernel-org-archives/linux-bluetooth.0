Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6324015B55A
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964750; cv=none; b=eD3WeW3e+AglfWAneLEfAyGZjBzQC9EG9XjErO4XdIYjTJRrDPR0GNNy/58JIk4iw1+0F3tTWiv2U+NQff48V97BL9uULvc3J27O3jcT7MdwwMdDVjOX9lmn8710eF9S0RtsUWCiXt29P6e5WE3Egm+SZVcFlj0tzI0RlIsZuXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964750; c=relaxed/simple;
	bh=ZtIbeYyi0OmMU+AkQPw6JSmB4tNWWwldPoSlN6WAmOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcJR2U1DtLqTjg2b67L/vse5huMuuHruqsX+xCp9fJ6lsrIwOHUBMOEKo913FIq06lbfySWm5BVx1pDQgXRGK6iXBMZvdnp4HsGoRzx2PqMZNofqsn3D2gPszSyxWNbI3my3eCSjEAmTcnA4ExXz5Gs1TKAdOFb0j8g9rBZusO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XHCuy3KY; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHCuy3KY"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de54b28c41eso2276998276.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713964748; x=1714569548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtIbeYyi0OmMU+AkQPw6JSmB4tNWWwldPoSlN6WAmOI=;
        b=XHCuy3KYvxu87WoMrzjYcjkhc74rAORwdFQ6ZMD2J+wm+lhNvxvKSD1GCTXx39WryT
         oWiizPcNysL2hr3XkRYYSokmDRdI0U2mfBpmZYeeDXWJtNNslk2Lmgn/4Cva8073OC7R
         /FY4qDAokN8JqacrdXxigZdv1r9t8XVEHO3sYkDo3eQiKBTrrSRSAZZ1UTlx9IeSUIeX
         ZUXsnAhN2akzT5LF3ouJb3Rq4KK9sK+MZ4Bn9SRg+LYjlTUgHZcvoDxzTiyfJ5WyDyY1
         a87Ki0lieBiSwqWtijKTQiLQMpXyqpqLXL29fh+TYEIVQP4686TO9QhGC9hqlQV8dQhx
         4a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964748; x=1714569548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtIbeYyi0OmMU+AkQPw6JSmB4tNWWwldPoSlN6WAmOI=;
        b=JqvlzHuifHcXzOvE1C6dQKJiy0xV6BMia0vAEzhU4oD7E0SSQJucCObWAQwL2rmoRg
         m+iNnyZOGkc70I0MIf6SiX7z52vMVCPzw/Nh0bMPr2v9kdMLLYs+OVAgUhZnr/aZudyO
         bLihoPxA986ZhrH0wope8teUtARPD6UzKQVqethJxqYmspYqmUFJyXjxSipASe9RZmxs
         AgzUZwbguFsX8gespu6C2dNNSnglGVYp0qVVfrJlBNtCJUHUVJQqcZr68rZ7HPIhfJ8M
         cJNwXG7AsE7JRsRAPZI+hDII12z4GoesJg/BHVMduqNt86H3aHAmD9W5E1yNT8S24wlF
         VpIg==
X-Forwarded-Encrypted: i=1; AJvYcCUv65Q8QZ5k5Sp1tbJvlggGc/GmqHt5+JhlHDh6ivj2mGz/w047AOEWuO6blobaLZ11YVO2MCgYBfO1uqw1fiVT0iiLTVqxGKG9/2q+cFBl
X-Gm-Message-State: AOJu0YyjRsPDU4ofXrSkHu3hL7qrMfzvUnbZjCsV29OhavgBdJxLHYa5
	e0pjMEXEV2tlb+ZVRQuUsQnNFfyvAWfpMMh+FjgP3SE9iiLqZxmFF+tf8B2+793QfgVSBlOUzbc
	kktLcXZZ1OZ449IQQt8tBBH0KyGXQx4mCmkLieckhFwarBIM6vSU=
X-Google-Smtp-Source: AGHT+IGWxg7YpP/AXugHPkwzaw5BeM12hpdBMcNOlY6L4gYSvrWbhTAMlLpFe4wfQwN3T31LeiVie/izT+xuY+/yXQU=
X-Received: by 2002:a25:d354:0:b0:de4:27f:e335 with SMTP id
 e81-20020a25d354000000b00de4027fe335mr2481953ybf.64.1713964748546; Wed, 24
 Apr 2024 06:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424122932.79120-1-brgl@bgdev.pl> <ba9b0e6e-3601-4460-ab5c-a02eb7708a4f@penguintechs.org>
In-Reply-To: <ba9b0e6e-3601-4460-ab5c-a02eb7708a4f@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 24 Apr 2024 15:18:57 +0200
Message-ID: <CACMJSesZqCG=fdWe5C31a0iOFJ-ZpPRr70T_1TNLn7xqChZ4Sg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Wren Turkal <wt@penguintechs.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 15:10, Wren Turkal <wt@penguintechs.org> wrote:
>
> On 4/24/24 5:29 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
> >
> > Any return value from gpiod_get_optional() other than a pointer to a
> > GPIO descriptor or a NULL-pointer is an error and the driver should
> > abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
> > don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
> > power_ctrl_enabled on NULL-pointer returned by
> > devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
> > While at it: also bail-out on error returned when trying to get the
> > "swctrl" GPIO.
> >
> > Reported-by: Wren Turkal<wt@penguintechs.org>
> > Reported-by: Zijun Hu<quic_zijuhu@quicinc.com>
> > Closes:https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
> > Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> > Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>
> Tested-by: "Wren Turkal" <wt@penguintechs.org>
>
>
> Like this?

Yes, awesome, thanks.

This is how reviewing works too in the kernel, look at what Krzysztof
did under v1, he just wrote:

Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>

And mailing list tools will pick it up.

Bartosz
