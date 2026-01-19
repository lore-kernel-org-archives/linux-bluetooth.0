Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100A31690D
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823264; cv=none; b=Qo6+RSzI2LLMTzaCvTCT+s1eu72Jc83x/I7BFwc6Mer1pjfhi1BYRJYGtoeWQRtkNCIyKM453fQKX15TxuFoY5h6ouViYsyYx4B3JFWAJGAbbnJp7DxkJkFVJboaZi7J3teo8jsvKRhVKy7t7M08k0Pa76G/FZUDlbL16uHRdy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823264; c=relaxed/simple;
	bh=M+rjsAQOdaKcxSdbA+BvwcR7Z8ZBwJ4QE4tzTV83Dpw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AQj3XBHv5NgcHtqJzV8OZeHnm29awj+O/jHBJRKr2hDWX65P3LJk0j0zx5gtcG3FJHlMjUKcPHZUDsa3YbWQ8f7ysRPOa96HTFNZ9xbZbEhF6dQlNc3SCJ2BQi4a7CM/5gKMw18VkEAo09Ok2ldyt26YsPfb4jvJMyTQQk8eK+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EF5243285
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 11:47:34 +0000 (UTC)
Message-ID: <b8ccd4861df2ff984d5483355e2ce7945a71c885.camel@hadess.net>
Subject: Re: More CONFIG_PM* simplifications
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 19 Jan 2026 12:47:33 +0100
In-Reply-To: <696e0dd7.050a0220.3af2be.a5db@mx.google.com>
References: <20260119102911.2465464-2-hadess@hadess.net>
	 <696e0dd7.050a0220.3af2be.a5db@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejgeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepfeelfeekjefhkeffledtteehkeekleehhfdtffekgfejffduleegudfgleffhfdunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeeigffhhedvgeefvdekhedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

A similar patch is already in bluetooth-next:
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3Dfd52b1d0ad7de69b1266c2efa7065e1d2f8acb49

So this patch can be dropped.

On Mon, 2026-01-19 at 02:56 -0800, bluez.test.bot@gmail.com wrote:
> This is an automated email and please do not reply to this email.
>=20
> Dear Submitter,
>=20
> Thank you for submitting the patches to the linux bluetooth mailing
> list.
> While preparing the CI tests, the patches you submitted couldn't be
> applied to the current HEAD of the repository.
>=20
> ----- Output -----
>=20
> error: patch failed: drivers/bluetooth/btmtksdio.c:1472
> error: drivers/bluetooth/btmtksdio.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
>=20
> Please resolve the issue and submit the patches again.
>=20
>=20
> ---
> Regards,
> Linux Bluetooth
