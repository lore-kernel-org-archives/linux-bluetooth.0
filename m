Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470506;
	b=VMlOYo11Wb0FMEQJyXBpz/iFQpJjlVH1ZP6geRu/pjPZCun9QKR/JP8tGp24IiCzDZOS
	 pA7tF61/P9c2t/59ISl9EaAd1dzxl+/A5rXnEVamkPHhhHE138tDNZZIg4tKCioI/QbqB
	 IxZ2aE4zEDKYRtQ3x+motEdB/dQO1JuPUqcgep6suTGTD9/wvQNhYNr3+xqoAdJURoIff
	 TpZeeDJOVS/IG7+OlWZr5BhFlEGSo45jkm9j8cSRkyUrAB+VhG7yWT6K1GG1Hc+cna/lD
	 Wv6nFeiU4wisjC/OHmkxrHPfBhvC5mWPTMXZ9jDUYo8n6m5xCxG0cG1/tZJFsutBr+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470506;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=N4/Q9i30PANFpu1ntETkNyxR1OQabpbwcRRhnMpD4xA=;
	b=zAe7ALhg5syOCgVd2Fc4MBTjEi2dbn+T1KIo9zJZFLdihAJhv8+QH9UyOQQQLUMrf+Pv
	 8CTyEXg6BxiLczHpz60uTqi4QnuAqXo9MG2hIETuNOfRNSji6GpY8tKC09UCrSGxN7wu+
	 BMqrpENwEsnqTYGJqEomZMpSWzPUB+TwS+d3uNsPRnZZB/HeXRuWzy1FE+MP+JB2Qh4o4
	 59oxco1xXmV3wVe0gn2sIhmM5wOGrARS5EzL9ljFoW5bvyHftOPlgkmHqaVKjpucaOICS
	 po13cZg3OQDd0lnvFwmVKFoPv0KBd36CQ4VAJbKbny6cbRowRNyrLkhFj8DYnDkc++Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEyiBpHU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7532606A31E;
	Mon, 23 Nov 2026 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEyiBpHU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF93C1F000C6;
	Mon, 23 Nov 2026 21:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795470506;
	bh=N4/Q9i30PANFpu1ntETkNyxR1OQabpbwcRRhnMpD4xA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kEyiBpHUi9g0XyijgV+xgy89AzyiskQ7ogX4RgaG/vT/tSLQL3Oglc4/TbC0+mPAD
	 HsqtOs07FargyY2e/Y7TSGLw3Qt31qxc9o9EJ6G8TQuo5wghs4crUYoRuzUanubCqg
	 fZBe9jpJc6gbUUD1qBdjlV+wylf38PkUcZlLHOL4gcQZ5LXyaR8Ogld45Zs8rWy0SS
	 PcNgXggdLT3rpbTdwU/SnrrKYLbIm8F26/Yjtgwo29LvMMJCWmNDbCMCtMP/zJO8uD
	 kSiLz+9SV5A+yGszT4rrUjlr6bb+DNVFmXLnnat1BU8U+5ScSzOQ5D8oqQm/TnJ8qO
	 oieRJIO5FbnmA==
Date: Mon, 23 Nov 2026 13:48:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-11-23
Message-ID: <20261123134825.018af270@kernel.org>
In-Reply-To: <20261123173408.3632176-1-luiz.dentz@gmail.com>
References: <20261123173408.3632176-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Nov 2026 12:34:08 -0500 Luiz Augusto von Dentz wrote:
>  14 files changed, 861 insertions(+), 274 deletions(-)

Luiz, you know best what's urgent but please keep in mind that we are
getting close to the end of the release cycle and Linus is not happy
with the size of our PRs.
