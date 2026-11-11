Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428407;
	b=totIh/wACaN+iE2hY58viwR6YO8mspd6F6s81ABKFiJ5Mq7OgB3488in1AtM6no5ZQXg
	 vzW9l76rGdfY7VPVK95bn5qmzhFgUEWaX/GdxJwhT570UOZjqTGv/DB4t2GB495SqxtRb
	 ndczCLve/6e+v0Y3NDU7/G2aAAnZKsQGeKXQl2WHu0oJbfK86hNYFXPktitFR0N6G69my
	 Q4GB/TvaMmhgUCLIa6cBRFIa6LGdaMMUXe7vo+9lKemlCvLhfXCcVjmSHCIaZcDW7Su4A
	 2jrYM2Uw3FDHdI/+moj0fhVfgi807PpKLbYj3MV08Jord/a67hefQ9J6lzYcbnBB01w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=aX4gwEArZ60d4CC3bqrIN5KrQn5OQnZdBI64gQBjRI8=;
	b=pJUK4QkPo8nYfVFmR3Vv4maNZWuQzjSzpFxGAcVobTuS53i/7YudBgmc9fVfEGSGZ1S2
	 jhJXq1J3xvRn16UUNLRy6jriwVibg02EPhzKlr1wjgNJ5ehRQeYmyCuxtlc4/jy5s8kQB
	 zJ39Mt3g7SdyUR9gwf2LaKhNXr8MfcXuqP0gjGyyNWeNGQZQepLzsRj0flx56HxK8WJhc
	 TeXQNOCV5rvtyQ6CAMQ44zE3L2DYWNOHEu1sr7dlGQPxG4m2wkp8iE/MmTUQgiilBWkzf
	 UQfH6dC3OSEqazvOLJ98SiXep8z1WUOaQZdbqz779UHtq1Gy+qj3Gj9JWv2bPDIja+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X29/cvvK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD40D606A324
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X29/cvvK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E871F00A05;
	Wed, 11 Nov 2026 20:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428407;
	bh=aX4gwEArZ60d4CC3bqrIN5KrQn5OQnZdBI64gQBjRI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X29/cvvKJ6iPRrwoM8b8Y8l3rJZM8IAxKSAoLz4X+qBGY8xgHnuDg0WCeSutywRqv
	 /awuBrxNwFZfZkGYcqrLqUag2P2r+8Aw5EAb/KohJWE4+qjmArbRDGxxq9dB4Sq0yK
	 0te2Q3qoTnPCQs21UUZFHosM3cH6RDx0KtlRjX7BRPaoHQd6I6pULwACz5KgH8Us/s
	 YSm4Qq7/rt4OuNFL69sZgcomWZrCWFz9pqqTwrk+E9Ok8EYhJGOZstAmwJaUKmJf0C
	 Q27ISUM8plUrCkRSnN6UuUtPCqgI50FlsMndko+ntc2DBo5vU7tLqHb+FHo8mNwQqZ
	 lrTU3dBIPfhkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E303391AF9B;
	Wed, 11 Nov 2026 20:20:07 +0000 (UTC)
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
Subject: Re: [PATCH v3 0/4] Bluetooth: Advertising sets on a single-set
 controller
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179442840618.1623293.5450112377472954815.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 20:20:06 +0000
References: <20261111165133.827594-1-weihong.guan@gmail.com>
In-Reply-To: <20261111165133.827594-1-weihong.guan@gmail.com>
To: Weihong Guan <weihong.guan@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 16:51:29 +0000 you wrote:
> When the controller supports a single advertising set,
> hci_add_adv_instance() gives instance 1 handle 0x00, the handle Global
> Advertising uses too. The parameters, data and enable commands already
> use adv->handle; these patches cover what still takes the instance
> number for the handle: setting the set's random address, removing the
> set, and the Advertising Set Terminated event (with a helper to free an
> instance already found).
> 
> [...]

Here is the summary with links:
  - [v3,1/4] Bluetooth: hci_sync: Set random address on the set's handle
    https://git.kernel.org/bluetooth/bluetooth-next/c/daf949c968d4
  - [v3,2/4] Bluetooth: hci_sync: Remove an advertising set by its handle
    https://git.kernel.org/bluetooth/bluetooth-next/c/e7e877bf658a
  - [v3,3/4] Bluetooth: hci_core: Add hci_free_adv_instance()
    https://git.kernel.org/bluetooth/bluetooth-next/c/8b1eff978e66
  - [v3,4/4] Bluetooth: hci_event: Find the owner of a terminated adv set
    https://git.kernel.org/bluetooth/bluetooth-next/c/4dce35adafb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


