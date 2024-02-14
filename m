Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391C7250F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951028; cv=none; b=epKgaZ5ueLynHyyonYFk+WP4eZLPNAF7mBiDa76RRkyNezWo+xyzcwCUFbldcTMFSO6YkQL5X8iKXyvyeLL75rbDwTBh7Bl/xhGZ155PIpWMe4dWeUUB2AKueeYnuLAKJcJUq3M+Cqws+DKu/GXrvvY6GHvibshlqquv6l0UeKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951028; c=relaxed/simple;
	bh=Ib3H6XeBf06GgbKtBdlPoQPElryPrReiMckkqPen1QI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gBB2+2+oUfroS/kbQ7ZPHf50p5aKMq/putNuITumEXUGwOF2REpsAwRSGjlCiawOOdOGlpXlcSfqN9taCESJfcVsW5rFnRCURuszyZE86HRkCa32wJmxhhPYv9lChrk8s0l+kS6Ae/MKfFlD5gMG8AHmMcZlbPhdr/xRN4J9IjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ3apngt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ3apngt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B88D1C43390;
	Wed, 14 Feb 2024 22:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707951027;
	bh=Ib3H6XeBf06GgbKtBdlPoQPElryPrReiMckkqPen1QI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eJ3apngtzef84BgD7ecnz+XbXmdQUozyru0RxPgJ2IAbfalU1iiim2/5AW8IW2g9H
	 CXOoVSsoWNUyabgQ7TWOnkkgdiYzMEqvy7lJZMjq/dA/ofj8kil6D3Yt0Z2NvaMgWq
	 u4Uyj50/yIgDHtGxMppyNkjERIFv1YHvWjyfCjFH8Q75CzT0j7dvY7Wf1K4c9HlMqT
	 m7Ja+7CrBtvF6Iy0px5f4HMG0E+Cu0IuKrQyKDEZGRhmETSVVHpt93L5QX4IItiHL4
	 4xSac8tdwDIjANXDGr3n9JFUSWV5SaS/wzPIX3xicKc1eboS1p73tvsN7RPLRnT8kn
	 wM86KtoBxclNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2431D8C97E;
	Wed, 14 Feb 2024 22:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 1/3] hog-lib: Don't destroy UHID device on detach
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170795102766.1654.13661249574019506055.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 22:50:27 +0000
References: <20240214185718.536748-1-luiz.dentz@gmail.com>
In-Reply-To: <20240214185718.536748-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 14 Feb 2024 13:57:16 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes bt_hog_detach not to destroy UHID device which means the
> device node don't need to be recreated in case of reconnections which
> speeds up the process.
> 
> Fixes: https://github.com/bluez/bluez/issues/737
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/3] hog-lib: Don't destroy UHID device on detach
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=247ae8524888
  - [BlueZ,v5,2/3] input.conf: Make UserspaceHID defaults to true
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9698870015b0
  - [BlueZ,v5,3/3] input/device: Don't destroy UHID device on disconnect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ee880bee8586

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


