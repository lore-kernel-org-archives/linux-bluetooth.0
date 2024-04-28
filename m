Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E5823BB
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Apr 2024 03:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714276117; cv=none; b=rjMoAbIBAuvjOtCDzK7GoY5Wy0PQDX+nbrz08w5hoiW2bmQQspmidNVC+oaSub2Oq7XlwpSfQ2SGX+pHRm66qj5Ykcj3Ho+zeKyORVcx9fQfYzDPjp893kRfX6v/jPdZ+fZmXNzo6D19EQgeaGxvWvRBlc51Cl2KQ8JLwjUh4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714276117; c=relaxed/simple;
	bh=T9aAS6gjprJFrjRsVKMX+gzE3b6ZZkshttqPSxfH9OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=NQm8e6QJlo4OiMua8IJHc5TN4gp1Mf5F2m+/c3mI14xDdzEoP9PzzJaMfmpXVBBM7eln+6RUhPPAHa8QEIs0UnsTCPd4ogAb8wuidwiUDcnnMi655wxRBgr9Ub76GXG+aUeUBXwKdQ1wR2PiLE3w6mMPvlM5wLekVM/kljVLbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dd041acff1so38641251fa.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Apr 2024 20:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714276113; x=1714880913;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYPrh4DHdmH+zyt0A/i+XtVcAopST5l2VEcQ5Ak5hpQ=;
        b=jv8BjnbaaxlViQbAU1+Rp+RjDT96tZUsLKQqckp+xVlaDn90zT7aGj59l9gYEwjLRi
         deqNHgm2/I9drnKYDEVG0GRanpbo8GqmuTfoP+dMKM5vxif+d6ltP2osGoTcOd6rB3gR
         EVb4bx6KwdSb1SDBRlqKgmVfIHvFJK4dJtTpEvsg49AuYehVbC8BY2ku2hEfHOLK16m7
         eDbFCfSbYj8XnizHGrLSC3X6zAZfSmt2C5nmwj8GjWM+OkhTlVLK4K72QbXK9bZNqE+j
         AEKHkXJ5vfLobHnhHxFceT7UXuDVpcDQizWBrztqLCoyUGf/W4d/oedTlcdC4ekNRidR
         a+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYCa1cNtJ8sLGcbcdcyEkSuO+HKHKqedhbYmdcYj41O7B4wzmEeJ34JcPqwFsNwC6LBFq2UVOwXEgnPZ9ZVTuGS6j26vF0xKjh3str4XXE
X-Gm-Message-State: AOJu0YxOShrzbTrUFVvHIlf9n80fMdcpp6b81RUm7vYs/1Ijl82drzak
	mx19iHxSt9pjnyyEVna6bVa3q+DTQq4KNiKdQfGI7yYLICRrK0Zr/EqECbVqIsY=
X-Google-Smtp-Source: AGHT+IHAJ4CcFlc6B3zFNGjXiAt9raTf+WBLe7uUgiwmroMPATGXkx9BOBkS44xrW1eZkTBYZd+oPg==
X-Received: by 2002:a2e:8703:0:b0:2dd:1802:a1ee with SMTP id m3-20020a2e8703000000b002dd1802a1eemr3748803lji.0.1714276113187;
        Sat, 27 Apr 2024 20:48:33 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id d5-20020a2e96c5000000b002df6de7283asm647378ljj.126.2024.04.27.20.48.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 20:48:33 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso4001080e87.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Apr 2024 20:48:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkCMKAjRS4Y368wuJmkbUguaYTrDckSGIEKOSeotWEiDtlEc61m8F9jtAZiaSEJdZQdgZv5LpLs9HES/VofMJmNuqToPh/aawgIPQ2OrPY
X-Received: by 2002:a19:7708:0:b0:51b:d3a2:9d85 with SMTP id
 s8-20020a197708000000b0051bd3a29d85mt3212757lfc.9.1714276112649; Sat, 27 Apr
 2024 20:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427051934.879051-1-iam@sung-woo.kim>
In-Reply-To: <20240427051934.879051-1-iam@sung-woo.kim>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Sat, 27 Apr 2024 23:47:53 -0400
X-Gmail-Original-Message-ID: <CAJNyHpJjRoJNUY25MrsAhxdsCVZJVu2AXcstO_t31_xtLWFGJw@mail.gmail.com>
Message-ID: <CAJNyHpJjRoJNUY25MrsAhxdsCVZJVu2AXcstO_t31_xtLWFGJw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: msft: fix slab-use-after-free in msft_do_close()
Cc: daveti@purdue.edu, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Could you not apply this? I found an error.

On Sat, Apr 27, 2024 at 1:19=E2=80=AFAM Sungwoo Kim <iam@sung-woo.kim> wrot=
e:
>
> +
> +static struct msft_data *msft_data_hold_unless_zero(struct msft_data *ms=
ft)
> +{
> +       BT_DBG("msft %p orig refcnt %u", msft, kref_read(&msft->kref));

Here, msft could be NULL. &msft->kref causes a null-ptr-deref error.
I already sent a v2 patch fixing this.

> +
> +       if (!msft)
> +               return NULL;
> +
> +       if (!kref_get_unless_zero(&msft->kref))
> +               return NULL;
> +
> +       return msft;
> +}
> +

Thanks,
Sungwoo.
