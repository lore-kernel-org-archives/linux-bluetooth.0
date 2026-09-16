Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F74DAF9F
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583696; cv=pass; b=lGabU1JialWwsJiVXorQmDc38sdUOt1qne8R3Wi2SP/VcLKV1xtE5m3ZmeGY61QzcqIlbSCumcr49m7A/krVrhKXR8e/PU5gezfB5kPuwd2x1R/aF4s6SaOimXdR1MmxLVXRckQelVZPNU4o2ZKcN4XZ1qjL8O9vmWmnENjIbEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583696; c=relaxed/simple;
	bh=WX++E5xEJeqIDSZWEklAf/DjrawPVs82hVtYOhoGZ1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYK5DIohbtwhu/+XBSPeJq3T1stfZHoxkmcJ1vDtLW9d7y6V9khzCY6sG+Bw96H68mqtmcftG6/4ido+TYNS5faH1e8xgPPs1kSzjcoVUVzmS/0VKCD3EcHy0c/+nve9Bj26RHfJ58BVfpNxTp5Gu4a49tOsnyFNQ8cBWkBN+Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/YIQ2d/; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/YIQ2d/"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab22370so1182468d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 11:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789583670; cv=none;
        d=google.com; s=arc-20260327;
        b=Jo4peVGmt/xGVHVxPjDbqqGiq07Ad5U5YfE6zNI/ixw7TSgrMlobjPhD1mlriVb8V6
         W5Xd7mJSKLsVqCJ0Tmm8Zn+yW30TOOYxkYD5O6OYwmMff6TaEL8VU7Y69EgRSResbf6t
         5mD1lj+uBFxzYHIVmib35BEF3fH9jGRhYdYgYdwPcvT2xWH5xUaV7JjdNsx8X7L+GivI
         mMXygeUPVpXerYlSbSv+1yV2SRUpCIUrbssYxY2GDmcMsFbPemfGCmn7NIQRK9ZUA3cd
         zvWSl/oEuSn9FlRWqv+md9IKwlO+ob1xWV8uYByyzXT6l+zQNyzjOnr1ix/LWO3KQoX0
         jFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XUCrJE9F2Ij1zpRepMcZoDkpmDPAIlT3nX+Tr0opt+A=;
        fh=BTXnLgY9oEIV/+QJE7MzoKlsFLlupMiwI1vys+87Mqw=;
        b=gOsH38l5Codchi43D1fGbkW2xYgZGHlkR74mZ4P+8Z/MkYsppyFBp96ynZlSAUfG2D
         Vs7lOq864kZndpSswDbyTD3eAFmR6EqWyb0fPM30TIUF5EJQTMpy8zquqXb1SIArGVhO
         VJd6d1/QevwxSl9oKpNUTC2sL8WmWKlONT+WC8ySD5+2crgQZLrfTl3VecdKxb1Enz15
         pJY2YqWqHbxBuL9QYWtPsNjBgIIlORCHcEmm9OgVb2wAA2WDPBCt5EH9sO9xNpAeEFw4
         jaXXe0UW7bRq0poSVSNqO7Hu3PbNVFQ97s0XubVzE1F9tXOzRgQlRZvRmmllcsJ07Xeb
         MQ3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789583670; x=1790188470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XUCrJE9F2Ij1zpRepMcZoDkpmDPAIlT3nX+Tr0opt+A=;
        b=c/YIQ2d/49UNIy/fXV+7kX9r537D6c1u/WRbRDuRTvOMPdbZm2xOF+mixkZLxgz4p1
         hr54B/J0iGBdXQIi+wO68IzWxwAcH5LL7y0kudQWavGJ4hNs9BnFCSVDhQy5RnqHvtqc
         9VMi0NnIQ1GehF8eYK4I4JvbMBz8iRTyQL2Um4nZ2Ya80ru/r1hBj7i6HMAe6M1WESZV
         UXe7p0RRvlbcFIdfBwxvtPYQb7/u2o4npUehNLUzqDYw8gYVGHCiufyCHbkYCZHi3t/E
         od9r1QJjcmtgxe0M0zl8ViJthZ7biWzy6TS51DsoSY2ivC4qcF9NxEnhDo7ajjNE20dk
         cdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583670; x=1790188470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUCrJE9F2Ij1zpRepMcZoDkpmDPAIlT3nX+Tr0opt+A=;
        b=d706Z1bsLKcg9lc09DR72ur0IMaClPJu9Ay87flF3PNwIkXbSw2k+rm233t7NF+8J2
         8r1qxfyrMYtjwkOr3DDfAKw8v2Xptt1mNvSZj0YdARTiPmPk4h+7q3lf/1U8aJYaBk/G
         yIzZqYD7AsmhkFFDpQvxkpmbUYmg6AOcDuXc5y5kRnIqSshXfA1U0bqXKtGHm5SXFrI9
         9Cmyt+Uuv6A69UHsguJ+sBMILOZnxEgzJd10Zx/5S8CEi2XCYwHryhXCkvCUIQowmAcf
         EbKe5TntqdlKYGb6uMnpNLXdSMh/auogpfIHEVEx6BUPGsrFKem/yxeKMQzCyicrDKea
         2Gfg==
X-Forwarded-Encrypted: i=1; AKwUvBzyNo6MoM9qj5lBsw0JVGSCy8LaTidaT80F311mSDuL/kwDG7mRT8t6toW4t1IEDRzaxZEDfa2S5h/UvgjHI1M=@vger.kernel.org
X-Gm-Message-State: AFuF++mfYZYxGxBVY7IyZ2H+STjOgMsZbHjuW4P07iDQAN3pgBY/BbWu
	c4ujdyw+kXJqwloqXmZVh+FcPYs7ee3pzej5zS5CeKK+tH7zutw2SbdOts0R1HStg0wG4Qz0s4P
	vMA0nmXRA28JWMvK6QyIvxyPHT1lfUBqNDNNF
X-Gm-Gg: AYBFou0svd2BoGVyCk2QTaH+8K3hCy5J8j1p05q2f2u3q6RJgHUlIetKxczqDk7CXHL
	kJ29z1asKp3b6mnTz9EyTWsrXMl2C6bBIZ/hCMaNLt3XBm1iFljfvpIVdxpofEN7fOqz76ybRtj
	iewA1dECfCoKwxlMV7jKk9d80HBMIklf92X069XWHvcMwJ9WVc7ZdPZG/qL++IyHVom5Cu3Da94
	p5Jxno4XAr1YSGGaW3OHHYAnkL961Ky1nECiggHefD35WPWSkZtnXNgcZ7+v76al+so+Cn9EmX4
	4greWzRvjNNlqii+doH4WpJ5aXLrMqXxywUCsj/cILVrW/WC78kuI/3ZmafIu8rTXw9XkZ+uQ8+
	g1wVTxXUINDa46S6LHLoco8i5i6QyylVzTr9XIhIdGHqBkZDIUfghEA==
X-Received: by 2002:a05:690e:11c2:b0:671:1ae9:f20e with SMTP id
 956f58d0204a3-671631e2319mr1501968d50.27.1789583670174; Wed, 16 Sep 2026
 11:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5676b70-f60b-4ce6-b6e6-de564d5c0a29@sirena.org.uk>
 <CABBYNZLKnQsypBR8Kbx4QFL9KfnVXRhO9_d5BHYQCabVZSY34g@mail.gmail.com>
 <064ec40d-66bb-4f69-ae1c-65cfed3581b4@sirena.org.uk> <CABBYNZJWcrvkx=6DekHxZzcrGjHwiqmSuwXqzHNV1=7BctThGA@mail.gmail.com>
 <aqnMueXiCztLUn-w@sirena.org.uk> <CABBYNZ+A+bNZ0THj0EZ4KfMj6wPMhD6hvbt5FP-exZnqxb4E-Q@mail.gmail.com>
 <6ce3c671-12e3-4057-9610-23efe14832cf@sirena.org.uk> <CABBYNZKiy+t_GC9dL6nraiH26m+2U=kuAF8NMAPNW-BhtOSovA@mail.gmail.com>
 <1add998c-b408-45cf-9442-0fda2674fe32@sirena.org.uk> <CABBYNZJn-ZYkX1DrOg9QWQHLWP_Pzh62M__X_jd0eXrKQx-K_Q@mail.gmail.com>
 <6b74cabb-daa9-4598-b118-6874f7993dd7@sirena.org.uk>
In-Reply-To: <6b74cabb-daa9-4598-b118-6874f7993dd7@sirena.org.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Sep 2026 14:34:18 -0400
X-Gm-Features: AcwNN1WC3qEsPe9p-Vk0Sh3LOaPi39FeqRP44hCRDvkWBIOIU7sipBOD2cP8HTk
Message-ID: <CABBYNZ+Nj3x9K1AC0FtcSAG8OaM7tND8+E5UkDzvshVNrRMYRw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Sep 16, 2026 at 2:33=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Sep 16, 2026 at 02:30:30PM -0400, Luiz Augusto von Dentz wrote:
>
> > Fixes tree is in:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
>
> The master branch?  There's also a for-upstream branch, though I see
> it's very old.

We only really use the master nowadays.

--=20
Luiz Augusto von Dentz
