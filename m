Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF51DE896;
	Wed, 21 May 2025 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840975; cv=none; b=scjpzgwKxJxYkXQ8svvu9MS7HwOSKt2BhKK0yvaaso7hh0QoJy2X8CpYAblcBZbtAXAiYkh+icP4p0+6sZhKAA+jhBZO3JWlZctFOdezNnt58sFoP7Upkpa4LFshsMjZkR9MVJ56rmZU2/rASCOmA9m8SMuZxU8exTenGd9P+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840975; c=relaxed/simple;
	bh=0YkU9yBX6AgOPZ0Q3G1oIsGva2J1rIZ+xv0Abib7XUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tW1TLWyEoXnXCFgrpUqD5iiSVtbqv8u2Toy11Wikj7lINdPjnd68LawVUXkpJh/SwpUkF81oRKPw1kKVJ5PS9EMCY0kRdfJ6eAHbdwqOkO/0OJ+lfnzGc6qBeBb6hMY8tf4aO179iruP7zirkdLzsbDyITH9kUv9zDkiXeEqcX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpSmW5Pz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpSmW5Pz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07533C4CEE4;
	Wed, 21 May 2025 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747840975;
	bh=0YkU9yBX6AgOPZ0Q3G1oIsGva2J1rIZ+xv0Abib7XUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LpSmW5PzppS0+oUOdkAxjwbHcHslytnqF7fAp2wxDBaSKWM+r/in36Mm2TAlWUpos
	 FxakUGCGY+8Ge42bQMEmNglcaiZ7UtHsuOrD4yzHsA5CuJ1D1626ghUtRIAh7YjSOn
	 UU2lOAdcMrMk/tSsLoknSm5MHdgkq7sxw0Mrlwbvu/g1OiCiL6/UyDwcKsmiMEYIdt
	 3UYDPKTUC2nV5iesVd0nKbzehKD1ut+lDAOmVu5+4gSxfhpI73uZGb9VgJ0YFzezM4
	 zk4bZgzJqyrE14FZu3qRsIj8OhHzkd2o32pNZSl3AiUGySAfvAwo+SywyS/KgP7ov9
	 SgGCguBOCi40g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB115380CEEF;
	Wed, 21 May 2025 15:23:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Bluetooth: btmtksdio: ensure btmtksdio_close is
 executed before btmtksdio_remove
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174784101076.2084440.12163879869679696734.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 15:23:30 +0000
References: <20250422012156.586600-1-chris.lu@mediatek.com>
In-Reply-To: <20250422012156.586600-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, jiande.lu@mediatek.com, will-cy.lee@mediatek.com,
 ss.wu@mediatek.com, steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Apr 2025 09:21:54 +0800 you wrote:
> If Bluetooth SDIO card is unexpectedly removed due to hardware removal
> or SDIO issue, it is possible for remove to be called before close.
> If an interrupt occurs during this process, it may cause kernel panic.
> Therefore, it is necessary to ensure that close is executed before
> remove to stop interrupts and cancel txrx workqueue.
> 
> Chris Lu (2):
>   Bluetooth: btmtksdio: Check function enabled before doing close
>   Bluetooth: btmtksdio: Do close if SDIO card removed without close
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: btmtksdio: Check function enabled before doing close
    https://git.kernel.org/bluetooth/bluetooth-next/c/07e90048e356
  - [v2,2/2] Bluetooth: btmtksdio: Do close if SDIO card removed without close
    https://git.kernel.org/bluetooth/bluetooth-next/c/0b6d58bc6ea8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


