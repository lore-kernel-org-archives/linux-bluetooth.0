Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941415;
	b=AMOfxqod9wAEO2x1CeA+QNw6V48xYgsVAwSZw1iCr/ZXNAqkRweKm+KgvRA6y1bmUhT/
	 c6eutop/xe39TtYW0/z4KWF8eChM+e9SrAFkKl0Tzqsh6cCpbKFsoYBqHL+IhYOf78qQL
	 9/7kiAAsBXn99X/iZBX8VzgF9vb3w2E6VwTRw02Gog5AJCzZ/T6MqlFxHA1k32gKmsw4l
	 ht35CQsjwsw5q/Z1vFdX2EQaWVl9RYa7JDLAN3nEHF/AiX2aFCdXBCYqrBimn8fqDifxk
	 0mw6qZEQMcv+7ievVsmfsj3Mx8FWyD8g+PC5YoXtmoInXKgjdEw8GKgTJqwGvAojiJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941415;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=vvkpdhsm5tPTWkh49V+/y5Fhff280Shcoe+LvIm2ScQ=;
	b=gZ3Dn6xOzN7ffmNHzDRg28d/m3uv4E+74Q9qDR7cIBb5nGa0M28lmK4zdy86o8cr60eu
	 8Saszgj8AP8Jz4QLuGqa4AWwZxjUFInPEyB/l7jD/UObiwQZxFVE22SMJUArHaXbPNhyy
	 wzWM20ZpE0PoGUMCj4cjeghyCmVXzUzFiZ98scuGMXjF2QmimF95gV9FUNRzLEEns4MsB
	 lDQ6WPBqbhdLjKC4hx06btL0WyB48G94tJV4EBXxVRMPUIl7Vhw0CeVKco0GIy/lEyPnl
	 2jA3Qir3lNdnaNqZ6ZKivQQlhzdOiB3RHsE+xZfTofAYolXDTQsk+z3UkLISztLLoyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRr3Qyt2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D6606A338;
	Tue, 17 Nov 2026 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRr3Qyt2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445E81F000C4;
	Tue, 17 Nov 2026 18:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941415;
	bh=vvkpdhsm5tPTWkh49V+/y5Fhff280Shcoe+LvIm2ScQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eRr3Qyt2x5oY5PgAr+kIsZVyTGkatQLAPrINh4DZgN4fYlpvLt40T6lbCbHO5AZ7b
	 Wy/H5YVYXbZNyJMg1coEC0HHqNdDxfbRGfXLLayjlAhA8LzOppsQrdispOMQpKgG6W
	 BcQ/qo71QEkN6S4mzWEhztW/zAh0K4KGLd0Y4PeAsCDWw9wm9rJuScRLYgkoaJUNjl
	 TFTXsH/RiF6rbQCoSsobVQBTj/xtrd66zaIJs03siPMFIhq9lE2UY5lV+NBtcGyG+7
	 kQ3o9b4W7S/YnFt9rS6rQESxkjjVwUadvYgz1O5FEr5YPrQDFtvZewfDDujgJ5o0ca
	 3b8XLLNR1xV5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2C6392B1C5;
	Tue, 17 Nov 2026 18:50:15 +0000 (UTC)
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
Subject: Re: [PATCH 0/1] Bluetooth: hci_mrvl: Fix duplicate serdev open/close
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179494141377.761488.13075669936833601821.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 18:50:13 +0000
References: 
 <179467295518.97469.12346516231160594592.marvell-serdev-v1-0@michaelmcallister.org>
In-Reply-To: 
 <179467295518.97469.12346516231160594592.marvell-serdev-v1-0@michaelmcallister.org>
To: Michael McAllister <me@michaelmcallister.org>
Cc: markus.probst@posteo.de, luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 14 Nov 2026 16:15:55 +0000 you wrote:
> Hi Markus, thanks for flagging this!
> 
> You're right, hci_serdev already opens and closes the port, so the extra
> calls in the Marvell driver aren't needed. This removes them as a
> separate fix.
> 
> I've build-tested it and checked that the duplicate-open reproducer
> passes with the fix, but I don't have Marvell hardware to test on.
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: hci_mrvl: Leave the serdev port lifetime to hci_serdev
    https://git.kernel.org/bluetooth/bluetooth-next/c/c9eb955c4fe2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


