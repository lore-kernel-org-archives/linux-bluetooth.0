Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14E432D425
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607987; cv=none; b=cO5t+y9CAfCRdpbpXpREnA+fQYStLOje1ogrBA9dx0X4p/CVwDGiVxIT2ZO7SVhqe5QyUeOhDWF279ZRw+5wEI6J9YUCspTT9a+AiURFxmX5ydwBRQ9E1O80fU1trC+Ex9XExyLSbmsT4EtnfFyAOJy2r70yg7cBlu5t3kA+sec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607987; c=relaxed/simple;
	bh=Hg0MNOnAvaA6DaV51mppPM/SpET1NFR69Op2Y4uEWi0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CCyp9fshgUhVNtpL7LOaoYBJTqH3Nve9AywhVRISXzUkntAJpaW/S2tlKjVrrd8SDshQQM27AkTUT51eApeIB5k1xDQMp5hDfaOuH6Aa7h0AMdnK9l0Eu+e/rY3xZSF3KdhsXEjo2q+5Ad5lvUUA3xXU9mFrX4OoZ+zS6lhMDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfhYUKp4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfhYUKp4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C20FC4CEF1;
	Mon,  1 Dec 2025 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764607987;
	bh=Hg0MNOnAvaA6DaV51mppPM/SpET1NFR69Op2Y4uEWi0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IfhYUKp4u+ZHdy28WbHMdjgN5FpMTbd/sHOphHk5D8SVXSTPRQh9TgHJqudSxDEIr
	 4BJqt7Eu9d1EnlXIejcpDxCYdTHkX7S54zm4UuTcy7jKkIT9WDQDSs1yOayvwnhtc0
	 aLdAwjgB2Ys6txkcDjDK18jp9uKsHGnQcMeRvkbz6uL9GcR26c41nZkRbpn/y6Rs67
	 tqjJF80cryFUPEpX3uwDegDZ9rC4W1Vk5d7jV07OCqoqe3V6N5T+yZXPbOy5MFh/dL
	 gufVHYK9o/UUIhQsUQvYHrVVnCEeJTYBVdeTG1807Mnp+6H/OMi2btkWRwcIBz1X6i
	 R/N+uGObf7Nig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7894B3811966;
	Mon,  1 Dec 2025 16:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/9] Add TMAP & GMAP information services
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176460780729.2450868.4106997671033738357.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 16:50:07 +0000
References: <cover.1764360140.git.pav@iki.fi>
In-Reply-To: <cover.1764360140.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Nov 2025 22:02:19 +0200 you wrote:
> Add support for TMAP and GMAP services. They contain only device
> audio capability bitmasks.
> 
> v2:
> - Rework the service wait to be general mechanism that also determines
>   the service autoconnect order.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/9] shared/gmap: add GMAP Service
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f11433431e92
  - [BlueZ,v2,2/9] test-gmap: add test for GMAP Service
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5312066e67c8
  - [BlueZ,v2,3/9] gmap: Add GMAP profile
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c6b1aed97b6a
  - [BlueZ,v2,4/9] doc: org.bluez.MediaEndpoint: add SupportedFeatures
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d4332653009c
  - [BlueZ,v2,5/9] bap: add SupportedFeatures for MediaEndpoints
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=71a3aa554f4f
  - [BlueZ,v2,6/9] profile: add after_uuids for ordering profile startup
    (no matching commit)
  - [BlueZ,v2,7/9] device: use after_uuids in service autoconnect and sort also GATT
    (no matching commit)
  - [BlueZ,v2,8/9] service: add btd_profile::ready callback when after_uuids ready
    (no matching commit)
  - [BlueZ,v2,9/9] bap: have unicast client wait for VCS & TMAS & GMAP
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


