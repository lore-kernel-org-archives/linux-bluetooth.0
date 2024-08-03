Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B6380;
	Sat,  3 Aug 2024 01:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722647065; cv=none; b=URekHMl0hvJ2ovkSlGpSOz3tz0hg2WNy/Y7hy9YJzg39pRLAkP6gFv16ODBm1lEcjZsVec3JRS/vhBm2Ea/dkBqX3QrHiQagdBqPAxfZouSwp4oMMMUtppAOTn0qgm8+LnrISrNVgvrBCGOQS2J0ZsBSYzBPfUpjRKL6rV/YOjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722647065; c=relaxed/simple;
	bh=o4qoXIl8hP6PXLbezXZCU7oESBWmoZAHNWU1VqWVoPI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=s3kSzJBvBh6vfOcNF6LATdHkkmVOvOQ60xvlZ8JzO1qU65bEIVKkv0xRU4x0E9/rKPHsdlqa7p8JfGfnaRCJy3CljmgQOuF1M9CmfERwoOT0MD6jx+23Eua6DFsqc2miaFYzXlXoREViXnsRnbH0AOwPPFev+uZeyTDpwJVwJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAofaV60; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAofaV60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914ACC32782;
	Sat,  3 Aug 2024 01:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722647064;
	bh=o4qoXIl8hP6PXLbezXZCU7oESBWmoZAHNWU1VqWVoPI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gAofaV60abe4akulSSdrBLcUmRozKJ7S522cOTHAEWUziciGY7WZx18NbNEtM5XA+
	 LMBr+QOmRxm26zoaLqlPrE6y++1yyO85bxTcMVpesWtKnVUOa2YfzLVu9middUyOM3
	 k+mJPwDX8qCJBXLvhqeMXLJvYK+e22fbR+3ldpguMtK2gwDQ3AltcX6cq9HpsXT3jM
	 KtBMXdyUUMUh7o9bAJOR7tLPOomOtkT59YYvHTzEBjFZt19eDY1tP3ITFXm6Qu888g
	 pxO2sGHVfZ42qBHtXIR4RG5mWgzZ9UxKLeqsTd1EdXvaI7NTi5XEPchfEzVuUxTWTz
	 KH/Ijv6a3bGqw==
Message-ID: <4b41be0c9874c5873c0cf4b6e210812d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240801-clk-new-helper-v1-1-81e9338b7b17@linaro.org>
References: <20240801-clk-new-helper-v1-0-81e9338b7b17@linaro.org> <20240801-clk-new-helper-v1-1-81e9338b7b17@linaro.org>
Subject: Re: [PATCH RFC 1/2] clk: provide devm_clk_get_optional_enabled_with_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Michael Turquette <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>
Date: Fri, 02 Aug 2024 18:04:22 -0700
User-Agent: alot/0.10

Quoting Bartosz Golaszewski (2024-08-01 08:58:49)
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index 90e6078fb6e1..34e800525e21 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -99,6 +99,34 @@ struct clk *devm_clk_get_optional_enabled(struct devic=
e *dev, const char *id)
>  }
>  EXPORT_SYMBOL_GPL(devm_clk_get_optional_enabled);
> =20
> +struct clk *devm_clk_get_optional_enabled_with_rate(struct device *dev,
> +                                                   const char *id,
> +                                                   unsigned long rate)
> +{
> +       struct clk *clk;
> +       int ret;
> +
> +       clk =3D __devm_clk_get(dev, id, clk_get_optional, NULL,
> +                            clk_disable_unprepare);
> +       if (IS_ERR(clk))
> +               return ERR_CAST(clk);
> +
> +       ret =3D clk_set_rate(clk, rate);
> +       if (ret)
> +               goto out_put_clk;
> +
> +       ret =3D clk_prepare_enable(clk);
> +       if (ret)
> +               goto out_put_clk;
> +
> +       return clk;
> +
> +out_put_clk:
> +       devm_clk_put(dev, clk);
> +       return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL(devm_clk_get_optional_enabled_with_rate);

GPL
