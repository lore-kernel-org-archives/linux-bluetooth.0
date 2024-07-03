Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA117DA3F
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019433; cv=none; b=ATsTIx83Uo3CBmNr6Ok/DqE30C7r+wp78JongWSIjg1nb/YFNpbI0H6fMSGUe3gHRBMUVUdtjhHPNXztxPtuTMPgnZbe2HBcE98Q8vYiJ/CIIt6ZrZQ7v56xhsrju2URsFFRTrkbiQQ7q4wm7k9AgzNDrCygEE1EaomgTkWc9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019433; c=relaxed/simple;
	bh=bJoqrIf1lIZGghgL7xmEerWrQD2j1E2fYyZnoSJgn+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JoC1CNkX71cSMd+QIWMBdMhttmWVJxRq6yT/pD6YVJ8uT6ZX8K5O6ifwZ2Kg1roqwwQAWeOAbRbeS2KQmuiiC8fJCRkjZnSjQtWZTZEOfCDdYz2PupX8BrDJl0jIQZdvwXbI5wGqLmcIE5CcPCDeeQjZ6WxQqfcKfHU7t5cT6uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSlLjaTE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSlLjaTE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 150A8C3277B;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019433;
	bh=bJoqrIf1lIZGghgL7xmEerWrQD2j1E2fYyZnoSJgn+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jSlLjaTEhkZkZPZB0YlFzJeVA6QTWKQm9MgKGDKROMd7UUMF4Q8x8waT5qzD7LG1a
	 3yEGO7VexQ+a0fuUUxrdfo3zYjxKnIvCkc31QDPq5lSCDxtLqGKLfn/CrRvQmbWXeE
	 KohanfF39Zs8genOLpxB5IbEkgcmahfKm/yJ8nhGM4tthO0U9Hw01Y3V8pUwlH26/6
	 b1CDh9p82D7PV9zDhYhMUXHAJIjIBu6dOYJGSeKOOKbKyFyHAqJKnjZAQyZQfV0cnF
	 9L8uuMeSqR7IUzRebP6dt65Hyfbc2b1MatajqH4Pqnginay3H05qgLP0DUx68AYZEi
	 zHRZVC4VCXELA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F33B1C43446;
	Wed,  3 Jul 2024 15:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] gatt: add return value check of io_get_fd() to
 sock_io_read()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172001943299.18626.4427747354401755294.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 15:10:32 +0000
References: <20240702131506.91493-1-r.smirnov@omp.ru>
In-Reply-To: <20240702131506.91493-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 2 Jul 2024 16:15:06 +0300 you wrote:
> It is necessary to add a return value check.
> 
> Found with the SVACE static analysis tool.
> ---
>  src/gatt-database.c | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] gatt: add return value check of io_get_fd() to sock_io_read()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d36983e032e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


