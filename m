Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2A34751D
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240689; cv=pass; b=Nfvo7MyHbuiCEGmOhc+Yseb4+VaNznhqto2EF5vxN3CaSFMtGTUoSiTJC+LoKkcL/j5SCwiWxwaw1HJi8oMZ2hBuiOMrTD6MPsaEhkXuwyxtzOpCid4I8woBr+A+v+BnNT2/dC5xdJc4rf2O2UdVtB/FW3s3oFJCgmN4VaAEOOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240689; c=relaxed/simple;
	bh=Efr1OooVVeTRTisiJfG3vsg/+MXEtgRrVmeiLqYtGck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZ5W43UtN9yoL8zR9O1Z1vx1pa7SvBvHMS4+KhHtpR5SFuOQzilQnw+JQjErT9sTY+OIZd2LZA389QxU2LzAMyyux1v5r61fBMMWsCNB6JfC9SWbLrklDJ1bvN++tZHtfdwkcc4Nc5bEwqYJPQn9ynmOHSaVLgVy70oSE9PYFt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKg1qICd; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKg1qICd"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-662b95934dcso144588d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 11:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782240686; cv=none;
        d=google.com; s=arc-20240605;
        b=FhGzNGWennNbmFeZ2rgDn/QO5guu/vAS86XwrD37boVmbZlLu+CqlRlNaBld876yy9
         Gyy3RED3w13R1wMLapwKcnsrgDE0wXB5BvwWHel7lINtD7VGyR9AKXUxtVYTaFRHwLYV
         aNAYRFHcD/niHYrIv5vqgjhLxyeEMxt+QQ3a7CwuRbMQOWQbpnMnYtttKKcAX1hHrq6a
         PcWB6oiEzsZtkd/VS5AVmQn4akruRniMK8Gxv0Wcu3IoDE4a8z5w7nCtIGs4FTldZFlD
         2mJuG6wvRLXsTapfGrqpDYxsJFVHjWOG4O6L6kVhu8nvpriwABBCUAZrcDGeCgjpwA7h
         83sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QGHdQke52quudoElH5DIY+sbZKk9j5FB05lJCBdajHM=;
        fh=TlDJ33USkpEuRt8OZx2kDf4tSdwNMJkRTR8EsFl3dSg=;
        b=b5LIMKUw3eOvJIMemPRTzPrrlfUs/WvT8BK/pPcyfeINpm+/Dr6SP04vx0TwO9xAm9
         3VnSEpiqM9bxtgC11IAVqHKCixQ7E43Ex+01cyEuTxzyu1vCgiLiUKXMGPBMZTPJnOf4
         mz45o8Wtjo9kWhU3YlGcmV+wGk4GYunZ0sWCGiKtr3PU84pCTHrlGPNF7CJiLIPwUajp
         +C+6MK4sqDuADc09kiD0tMMcGrfNLUaEgqZTtRZmy1qvvjXKUQJxI2umNC1AItBcMNCz
         8XvB5mJHT5xDsMZ3sU4nXt7bkelbB6/c6ErF9bsh4oOtC2co285Sg6qRpLmsAw7Dia4V
         Gn5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782240686; x=1782845486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGHdQke52quudoElH5DIY+sbZKk9j5FB05lJCBdajHM=;
        b=VKg1qICdpjOxcsGBBOa4HZh/J0a1Gkb0EZzxvAidRzTC9Dgp3FVJETu+voTIFXZxS9
         UYFdLjMqUKDF0mxBrllAHICDgZD+qQSKxnSxU9nkMI+B/Hj3biuRvkqYLxfxBOmEFxsu
         Freiwsq4CyIepsrOIqLrOgA3rbH6vsfofjT1UFSLlkucOdTkw9LaTqURfGeZtbNV+WcJ
         ZCEVFbQktuN1ovYuqx4WIcWMn6WFtRBznePqU8AhkFJtqZ38FY3fPJJGTqE6+8tqtsQD
         TAw/ScKHLKE81rwrUg3cUbxtLBu60RT20g7JqkAs9dZa+SzGX0pB98TwZMYP37yMrdB+
         tcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240686; x=1782845486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QGHdQke52quudoElH5DIY+sbZKk9j5FB05lJCBdajHM=;
        b=YImDIo4FXOk4n/n+21chm/mYZdEql5nYBSc6dfjmFi18mAS20ncLo5iW65NDzLofVV
         h3Sar6ti8Qc8KM8413ToU6VAj8tip9jiLi4I8IMNZR91bdU06SVmfx3j/W05+KxnFRoY
         FoG/aZ+wRE+E+zTuNGghSLiQBl1SRa8LY8pmPu2W4fgFoVK/EOXMQnhPStquS4+ttmtO
         TvF4Gy2u4RSnX5MisexejGnOhR542ChZ2XJ1RH3sTr1lg4r3mxzse155Dc3oUGNlkkY1
         3UE/bWxFYGJZMZn7r7RC5NNa6PvPgnxJZuzBo8Duw1xH29xekPnN1/iBXvBxjASYza48
         zmnw==
X-Forwarded-Encrypted: i=1; AHgh+RqMzDacQz8ahAgfiH8z6hGZsMjOHpnR2X8Ej71H0/8N9mtWilQtOBW0/teFi/XC6dNNIkQ8YSnEPTSbvoQQJf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5qB3HHQOcvEJuqlugFXSKb31S/CQk0xDqA/z0Xl2k9iXN0Noi
	xk03R91CPwELwMtSYb74GMxzPuPdKjB4TZpX6b0T9wsgxqU80i0RA2JnH/k3a+cLX+jou79dLE/
	HPQPrD+xq5ibgdc+y7wtHWxI3te/FfKwwjcefTbOp/CE7
X-Gm-Gg: AfdE7cn5AZBLYQPEZT4ANgQAQfUFkIQRws6SmpVvV4nsbc554u0ccDUzbB7IjeY4txg
	mthmLsUn7N2reIFUuuZF46rEUROWORcyVYVHeoFOUe0l+zOe0gvYFRr7eWYmqml+wIlfBMXc7Wb
	zTc73Ea7YUIW+Xcl1F+7F4H6jrPod6BpFE4MlfIvF7zjs3An9X1Z5Kc3QzGt2su7EskOGsLLwqL
	gRXLN+b+84e+YJ3+IpBClNSPN7r3XjoC72G/KebjyVOj46XurBVHuNXoJFQPb1ZPCr59rrM01aj
	rUHqOOVZaJqKfmLU8Q/eXx8WErg+iJ7pG4XmSK0rTqvojfmGeRz+A24Thg4=
X-Received: by 2002:a05:690e:e87:b0:662:f2d1:f27 with SMTP id
 956f58d0204a3-66359ece524mr3827196d50.27.1782240686326; Tue, 23 Jun 2026
 11:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622234803.6982-1-ebiggers@kernel.org> <CABBYNZ+QLvkYkn_EcBZ4+GopyhKqJLcfCoABYcw1VamavbSvhg@mail.gmail.com>
 <20260623165208.GB1793@sol> <20260623180502.GC1850517@google.com>
In-Reply-To: <20260623180502.GC1850517@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Jun 2026 14:51:13 -0400
X-Gm-Features: AVVi8CfbI5Vx_0h2Ev3jl-1KL9OujVxy8AaPvUK9sScHwsY8ABVyPNIyPnDwcl8
Message-ID: <CABBYNZKdd2-S9C1z0vtUB5yMVTWxLHi+Ta0_aUrahDYAq5rpxg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, iwd@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Milan Broz <gmazyland@gmail.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, Jun 23, 2026 at 2:05=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Tue, Jun 23, 2026 at 09:52:08AM -0700, Eric Biggers wrote:
> > On Tue, Jun 23, 2026 at 11:04:14AM -0400, Luiz Augusto von Dentz wrote:
> > > > +=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +0    AF_ALG is unrestricted.
> > > > +
> > > > +1    AF_ALG is supported with a limited list of algorithms. The li=
st
> > > > +     is designed for compatibility with known users such as iwd an=
d
> > > > +     bluez that haven't yet been fixed to use userspace crypto cod=
e.
> > >
> > > Is the expectation that we go shopping for userspace crypto here?
> >
> > Yes, same as what 99% of userspace already does.  Probably you'll just
> > want to link to OpenSSL, but it could be something else if you want.
> >
> > - Eric
>
> By the way you do know that bluez already has a local implementation of
> ECDH, right?  See src/shared/ecc.c.

It's never been audited; it's only used for hardware emulation, I
didn't even remember we had that thingy. What we really use is
src/shared/crypto.c, and I'm not looking forward to having it changed.
With something like Zephyr, changing crypto libraries every so often
just because one didn't fit on a platform wasn't a great experience,
and that is a much bigger project. In the end it seems they are using
a forked mbedtls:

https://github.com/zephyrproject-rtos/mbedtls

I'm quite sure whatever choice we make will be the wrong choice for
someone. Then someone will have the brilliant idea to add some sort of
backend support to let everyone plug in their preferred crypto
library, possibly adding even more code to audit.

> - Eric



--=20
Luiz Augusto von Dentz
