Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C491AB538
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979293; cv=none; b=ZqRTHrDvh6ZCKnAV7uR+1/2CmLMbCNSHurtSlUOBsngptEwTSXv+lgNzZBWWeVMl+SeDxuho2BpL1wx0zP0vfhbo/Hj072AOB16jo8fvP0Ykcai1Ezw3EKd/0TIXfrSv9XUhbdM2VRFRwA68BEdHH9WNb4ie5ITLLvG6q47MFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979293; c=relaxed/simple;
	bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0WwuS4BjXK6sEieiq+aQPAtI3Z8WUsHNZv42v7kUg3XLOqY/2AUFpvkxpmuLRqHc6Yg6T3JF2zGMRWplraqILnnA4X4vdf8Rch90VQKIi7Yk640Co4Ab1xdau2khVEeaRZ7Sr0FXjD2+b3sBXS2ALu7c+MLdH4tnmWo+neips0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vdladWKj; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vdladWKj"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so13112281fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979289; x=1729584089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
        b=vdladWKjT8WI2KeXleLj+/RcHhaLevl3oykRwHEj/ZVgkBv+hL95RJrvL0saG80l/8
         hvx+1Bb1fYt8letMQFveFcCn/7Bv4jMkKa0GTSDnD3WgpUDQmfKAbHlR90919YTxYlWp
         /MKxgZxRQSW5cvW6EI7vce1MPENxpdKmJ6vR1xTOZ56Myl5y/gBhADKnF2ML2nSNJBuo
         0CKgDhB/60XRjW7udytqDzU1zPwXbgv1lbIUxq2RuRGLH7WPD8QszDkoRbRkvyjXEJKE
         TyOi2XajDVnvWzSjxTBBTQUyU6PTe4QPzhkBn9L++TPSKc9bEbq5VQX4T7pRQg6sYw9v
         cyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979289; x=1729584089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
        b=PGbgpt0D7kHGG0rk4InonpyGAcCRlrcuMJjaOTM6wdJU+dcQHHjBqxRj2fbY10Hv4K
         bywuTl1gA0ZggPAP9cE9nvTOXYZeXA5stkpgWjVyy0g6diWT5eM6FtJJ21aJkE19famB
         Td4+F4dHZ8zIm9v4GiFjeL7DhXRBQVWE0ptzDdghddl4vFIkdpSGXOwrOPtA2u9PFKQL
         g0U4Vsebkw/XQdIE0tRbgrva8rHoM9H5lTyWrU0eDCVmT5FwzV3GCJKcUpPB5Y/C+TDK
         qWyDOqd/V+ycnaczCUd01uUHUCI9lEUFnsamxfSObKjLH2E3W900U+Z1SqYAhZwzAP+t
         AJKw==
X-Forwarded-Encrypted: i=1; AJvYcCWUwdR9IS/OtasvytEQGaRLIUpQQ78ZU+gNdWYDvq7aj1jggdTBaef/5Zz9EV+xE27f6F5PSx7bbUKrZak9/Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNSI9y+qjX3/eCzgTCH7iVKCjlmVftY2vz8CRZGMSp1crZizB
	GjDv8wHdelUdob1gGbKLPQddT0wredu/Q9+pyt9PilMtyj3cxJJgdvQQt7gJQbt3HsDWYbX/fwa
	frOOsDIIImm9k+yajw81QVymtQ8LLemC1RFtl
X-Google-Smtp-Source: AGHT+IHxfKaPProiszu4hPKA2JsWyWKW8QC7WkdMfm3qCN+vO+7OHhDa8OoE6YIicZSOeQRLIab3tjlWn0zyThhZ2QU=
X-Received: by 2002:a05:651c:2120:b0:2fb:5d8a:4cd3 with SMTP id
 38308e7fff4ca-2fb5d8a4f7cmr6486501fa.0.1728979289048; Tue, 15 Oct 2024
 01:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-1-ignat@cloudflare.com> <20241014153808.51894-2-ignat@cloudflare.com>
In-Reply-To: <20241014153808.51894-2-ignat@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:01:17 +0200
Message-ID: <CANn89iJ0i+k_wHn-aoafY1V+mJ8TAS1DzQKnu1KkjusAWLNuyg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/9] af_packet: avoid erroring out after
 sock_init_data() in packet_create()
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Aring <alex.aring@gmail.com>, 
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-wpan@vger.kernel.org, kernel-team@cloudflare.com, kuniyu@amazon.com, 
	alibuda@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:38=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> After sock_init_data() the allocated sk object is attached to the provide=
d
> sock object. On error, packet_create() frees the sk object leaving the
> dangling pointer in the sock object on return. Some other code may try
> to use this pointer and cause use-after-free.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
