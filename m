Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503015;
	b=K6pA9j59neEOXOYNajVRJSliSYKg7+WoXrPbJxy6jGJotf5bDOnfzek0pPGP8VOJ9u8B
	 GsH9gxblVQsrolJBQObjMkq/K/HJgAfcqyFnoppNgdCoAV8HfMOnTCB53+gEWJEd2PShZ
	 hmtxGhsLytW0w1y+CPQ4njki3EGcrAkq+ZFb+Ph+aHO3ayPESxivYS26bOqPDOdkMyW/s
	 cJ7xmk3+q7Y6uQeWYhy1zGVmiWyhzKqr2yC3GLErNv019HObjGibGvlniwdJ9IAnHIuZm
	 9agYKmQ7wg7SW4YY287ezNdKDVdjTfkreEWjXTc+YQGRJKZmGNH5fX8S0/+RBjVAXNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503015;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=DefFAm/OeUtOy9ld2YsOjBh1UV/+iMLMrn5SPZ2TKKU=;
	b=LfvsPGW/438m3webxY5D4iCCOySsCVn3Vakr74vsSEZ3XxB2VepiKjN3OwndgqlVZnp5
	 OSYlZ2YOPnFA3Ln+VF8tFOCflOkHY/DyxdGVkZwCUM3wkOMjdl5kchakNF0pkbrlrQhGJ
	 YonmWI7t8DrnMxjPWbIpUpB+lZL16IfZf7hc5tsck8BJNIJs97wTtzq6GqIlRlqlD63KI
	 5zhgGAebIBQ/R+lwLLbgc7WoSv/oIVpk8p7XtvHnNncmiRKn2eL1r25mrX6m9Kzh539ER
	 PzGeW90L0ppzmrKzcNYW09VYIwhwqrBEovGgMByj25+5trjk6RaPnwLY8e71Z+4mZUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anBEKw0f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29AA60A2620
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anBEKw0f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDE81F000C8;
	Tue, 20 Oct 2026 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503014;
	bh=DefFAm/OeUtOy9ld2YsOjBh1UV/+iMLMrn5SPZ2TKKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=anBEKw0fYm6rVzqtUozs7+UTUyod6HGMVZ4NbtvuZvwdy+UshGijMRAAmNMQ3NnaG
	 2egqJFx7YcrkxULY6ueAalvlBuKRhIaqkuo5Pe3uKoWmPBL2uluuz0mmE0aWMEMlPG
	 oZahAoEIuDyGh4PRYE6GdrhMeDgDW/fwdM2feqgfmUySHtvNS9d0iSiH2ykncMScEO
	 jHhzOtZQ4OTKmtY/xoaiiNlNGvPrkwR9fPiPUm4cLvze/QQBfEkAkCljcAcyuBwmW3
	 MhVYl137Hw4k/beIryCns9xgyOwbapmwyw36tvBHEXOnOTgx1+w0BtCXykgPzoyOLe
	 AmFue45YAQoXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43853808209;
	Tue, 20 Oct 2026 13:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] a2dp: Remove duplicate check in transport_cb
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179250301327.3738467.14591299268160844343.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 13:30:13 +0000
References: <20261018043903.1756818-1-yaroslav.voytovych@gmail.com>
In-Reply-To: <20261018043903.1756818-1-yaroslav.voytovych@gmail.com>
To: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 18 Oct 2026 06:39:02 +0200 you wrote:
> transport_cb() checks setup->stream twice in a row: commit
> 0bed9886cff3 ("a2dp: Fix crash on NULL stream in transport_cb") and
> commit d84171e6cd68 ("a2dp: Fix crash on NULL stream in transport_cb")
> add the same check. Remove the second copy.
> ---
>  profiles/audio/a2dp.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> [...]

Here is the summary with links:
  - [BlueZ] a2dp: Remove duplicate check in transport_cb
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b79d4a88705f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


