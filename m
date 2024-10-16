Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA90B156E4
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 06:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060177; cv=none; b=t33HnFetRyJrhJfxzRQz7dcntv/nou90S4hvPs9EPLgnWoIKqUcyY5n6pzYvY18R1+iJE5Vb3qvXC0ERXqKz5GBnI7GeYCSHdQ4mBFlU6SBHVMFDdGc3tgs6SnBt65jB2dvUS1iAZ81zOpqvWTAIx2hKtl7/PkKbIhFFGPEOcEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060177; c=relaxed/simple;
	bh=yJKVsQRDJtl6XBL+CR8mTLNgyYKrP+4OlrT5ybFnjRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6ul0wkuLw+x3xpSg8P6qv1vdVjJacTuh5fuc6LNbgzV8i++f9m06JaaiAiRqvMPfSBGjF66A9kNBc85cin6O86YihEAsW2LA5ZDufJdTVDIOMmf5A/j+g4+Zxv05zKKvsIUcSr0GQKt1nTnHbQ7973YJmth0SpyOItOiZpEdqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=1hBf5p7r; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="1hBf5p7r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=V/lYB7MrHF4/KzNDsdlwcW1YhATYk4GSc1xA28UVXu0=; t=1729060175;
	x=1729492175; b=1hBf5p7r4wbk0JrhT5D7l7w4jxmcESs9S+GMde8e8ZC2fO9HPXLYIIQNWr96o
	yUB4O3QCidOI5dVolU6Z2OtYzuGlceFOau8NcjtTZ4Lwr9nPqVAfd/othk8EOfDAaLfMkt0P1v7Dp
	9GKJKXV3XU3PWOeKxWkbw7nhIpcBfVseXAeY4wrI1xRSCjrckK3DdF5wZmXWPoouyc6KOVdlhSgZM
	BN4aXGmjrkvd0dsx7W3NjfWmG1nr/SqhVL3Gbmr1SgRX/qXq7OmwU+N3qPn2NyK9jrO8HFQyNbJL7
	wbDE7OrmT+BnUWDyBFgumsnk53L+1k1sdpHYIinHUtX8gzLGbQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t0xXH-0006ve-TC; Wed, 16 Oct 2024 08:29:31 +0200
Message-ID: <cdc7072b-239b-491b-a1c5-ff9eaf4d5222@leemhuis.info>
Date: Wed, 16 Oct 2024 08:29:31 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: dedicated -fixes branch in the bt tree (was: Re: [PATCH v1]
 Bluetooth: btusb: Fix not being able to reconnect after suspend)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Kenneth Crudup <kenny@panix.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20241014202326.381559-1-luiz.dentz@gmail.com>
 <36e9550a-3b45-4489-8370-afdc4f2fa6b5@molgen.mpg.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <36e9550a-3b45-4489-8370-afdc4f2fa6b5@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729060175;b0e8b21a;
X-HE-SMSGID: 1t0xXH-0006ve-TC

[CCing Stephen JFYI]

On 16.10.24 07:12, Paul Menzel wrote:
>
> Thank you for the patch.

+1

>> Fixes: 81b3e33bb054 ("Bluetooth: btusb: Don't fail external suspend
>> requests")
> 
> That commit is not in the master branch,
> 610712298b11b2914be00b35abe9326b5dbb62c8 is.

Luiz, please allow me to ask: is there a reason why the bluetooth tree
does not use a dedicated "-fixes" branch like many other subsystems do?
That would avoid mishaps like the one above and all those "duplicate
patches in the bluetooth tree" messages Stephen has to sent every few
weeks
(https://lore.kernel.org/all/?q=f%3Astephen+duplicate+%22bluetooth+tree%22
); reminder, you can have both your -fixes and your -for-next branch in
linux-next for test coverage.

Ciao, Thorsten
