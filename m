Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCC823DE;
	Thu,  5 Sep 2024 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725572567; cv=none; b=PEbJVZGxfQ2z8TyTRu1Jyzzz3AMGs3cU9+J2sxYeXXVe2XkuGCakuiEoT1V8/a6rL3Hi25n2/I+tNuP9zlGJ8c1n340LPu7VWVxMe+ojUFiCXcHEsODpKMWcTbjrw6hvSOISNCavyrU7PuYTnuqQf0d6Y2EGoPW1qFiz3i+b/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725572567; c=relaxed/simple;
	bh=0X9ovGL1bPiVMErLIUVjlhSlP6NAWKa6SGZnK6fQyxA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=FdErMHNkYsBofkaBkTzT3gWws+ofr8hCUfW6DqFQMlx1DW6PR6jOOc9u+8hyOddmQywmLn/LDtutB+CztsttKeo8csRYHBo0BnsIoVJ5nbeHzl4W9xYkUSRP82IaYNx9AGi94Af6ABaH89HrVj/eH2Yq8aIdXSB++7uKT7RkDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2ootA+r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2ootA+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B91C4CEC3;
	Thu,  5 Sep 2024 21:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725572566;
	bh=0X9ovGL1bPiVMErLIUVjlhSlP6NAWKa6SGZnK6fQyxA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=E2ootA+r2Jzcgf/NmNy+AJzniX/8/qwwz88HEwzDL5SE/yZfLg7IciHSckm2v/uUH
	 XVODWkzdY3MYX/Lgl+ehEJAW29AzuALvCb322qUElHRCaCvp6X4oP17R9YdXXTKkz3
	 W9TMmE7jKLSrq1jQKSkF1AsxPfw9TZByIdV5KED9ETytIzKoibrkImI7icxg85tKjf
	 oT0wtqU7gpMbFxneaLxxD66Vy4FuXVSw3011NWTs3w0m0xe8swVxK5P/L3SPrzK53G
	 rX/y97OBU+0pzPY6c59Y9paGXnkat2aXaF+2NA3h1CB+Jjwq45FtsB9wZXWaDePJNd
	 cWlgANhUFUnRQ==
Message-ID: <220024b46504658718c21c5f0c221007.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240805-clk-new-helper-v2-1-e5fdd1e1d729@linaro.org>
References: <20240805-clk-new-helper-v2-0-e5fdd1e1d729@linaro.org> <20240805-clk-new-helper-v2-1-e5fdd1e1d729@linaro.org>
Subject: Re: [PATCH v2 1/2] clk: provide devm_clk_get_optional_enabled_with_rate()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Michael Turquette <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>
Date: Thu, 05 Sep 2024 14:42:44 -0700
User-Agent: alot/0.10

Quoting Bartosz Golaszewski (2024-08-05 01:57:31)
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> There are clock users in the kernel that can't use
> devm_clk_get_optional_enabled() as they need to set rate after getting
> the clock and before enabling it. Provide a managed helper that wraps
> these operations in the correct order.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Applied to clk-next
