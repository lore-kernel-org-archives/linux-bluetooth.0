Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1539FE4
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794831; cv=none; b=ft6UTvZ3J+LFYfcgA328TmhfZf3IBbbkAzrpi8VJBu7c73GtoJxi1ITP0qSe7uM6a7tQ1C4Lh6r1Kn+q/9iNp6Ked9DFGQ65bjWrL5ZwkpZmCRa+lpfbdArHWmC6XW8Yj11IYZY1jNSOFk+yKMf6jLxEgFYKjEMRb7QsVzOW77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794831; c=relaxed/simple;
	bh=ji3GukNQQz0dB95Uiq4mWoMo2QPzkQnvI2lWvl8o/70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nKlxn7np+5TKrxw8cjMoRqY5Uy0hBSIKCUURKipOH1AcPveu5OiyGuFkYxqCTGXZ7c9hlRrkmG30PSUPhkEikP2SmSqxGhPb2o0/vXX7n1LK7i6NRQoe+rYxhAjAapma6ohyckLyOXh1+WUmG0K7Vp/bCgXdNTs8wnrVWPNE1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMpQW8Q9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMpQW8Q9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FB27C32781;
	Wed, 15 May 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715794831;
	bh=ji3GukNQQz0dB95Uiq4mWoMo2QPzkQnvI2lWvl8o/70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AMpQW8Q9Ffj9SSBg9vi7aim8LFam5kgg7FLZVmgKrosPUM/ny5K26lS6K/tkLHXMA
	 le9XuyhQyRoPwx37OytiSta+GP2/zQmKuv8/YrMb7dwSi2vGleWHuos41wDvSoSDp7
	 wsMKpcEQ5zvABdGE473zeb/zk45eFtSjxAZeZSrMNic7wkpyf4hNuw66rK2zEHWOMW
	 vL2cFaicvBjOjtu6OWUbEGA4m2wcej6u1TzwYo7bra11IhGEudiX1XMnB7uau5BRuV
	 u3RVJblYHCv942edfRZMq5VJVcGHgZXWPKE2nxjHeBwVFVArvGC8MZT/C8ovlArgTz
	 pnlyqFj/d7Ydw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08963C43336;
	Wed, 15 May 2024 17:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] shared/ad: Add bt_ad_length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171579483103.13625.11595016065783571034.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 17:40:31 +0000
References: <20240515161250.1714375-1-luiz.dentz@gmail.com>
In-Reply-To: <20240515161250.1714375-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 May 2024 12:12:49 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds bt_ad_length which can be used to return the current size of
> the bt_ad data.
> ---
>  src/shared/ad.c | 11 ++++++++---
>  src/shared/ad.h |  2 ++
>  2 files changed, 10 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/2] shared/ad: Add bt_ad_length
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=263d6f7da564
  - [BlueZ,v1,2/2] advertising: Detect when EA needs to be used
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ea242fbf8602

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


