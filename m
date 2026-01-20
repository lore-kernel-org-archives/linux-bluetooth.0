Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C223336ED1
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926612; cv=none; b=d18c9bhLdgdIixNWL20p5BxfyHG7j5BHuV0A+D/HBH5567+BwoVys61SHPQTnKxKzClol9bZ30W2PH3CZ/uyahhQiXoPI5f2XmBFtRCmzyf0SGNzcwNvRh3kMzhu2bFajdu0kDQpPPu9bsJ4aYqNQcF71XBLjvVXmdd/XDx6e4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926612; c=relaxed/simple;
	bh=Cm35LSw5OqFmrTTk2G4En4PdmrtnTFMjuqbfpoEwOQs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oRL01fPSJNxOAYyJ/2+OI/ueOtdi9v6fbrpw2WkQ6naOV/fXbzv3f5qJqpAM2azaa4uizVgRqXvfurds94rXGPee/VYSV6YEIFag9ldOdhCoVAheaCGJ9AWwlFhqLoo6i0e2zZlP7pazUuYzMBGzmqfEux7BVbTfvLZKgLWyKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdqUWUKm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdqUWUKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079C8C16AAE;
	Tue, 20 Jan 2026 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768926612;
	bh=Cm35LSw5OqFmrTTk2G4En4PdmrtnTFMjuqbfpoEwOQs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fdqUWUKmdJ74JxPCIYGC1mkDGsJ1h8J2nmzTs0tBQhT80lmAbxZGApxImbNcltSJc
	 GrK6FGD2f8DFXuvuHTNHeHT3grhgWFONnLc34DVFpxUayjtrkuLJhU2aeJ5h8C3jSz
	 B3OjTRfWwQlMgu4Kz0lUiuUw8O1TzMPXrEFn/xhWuQNy2jSGTXqPK4+0JkKh8H1uXG
	 QOqIqL9aFvwG7bZ+8Amouhpy2U/XbUiXl7PUk1iYcYwdM3OOlzfFbJdz0E4P6Ez0Dz
	 TqlSjGAd8EeELITRUCW6gG4u61qGjYwFjdE/7h+VlP9dvwVZjxoL9AMMIHL82aCSlG
	 wEoppqqyzsUiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C89C73806671;
	Tue, 20 Jan 2026 16:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ 0/4] API fixes to make better bindings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176892660934.117222.16357560256198589969.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jan 2026 16:30:09 +0000
References: <20260119141239.2683954-1-hadess@hadess.net>
In-Reply-To: <20260119141239.2683954-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Jan 2026 14:27:08 +0100 you wrote:
> Those changes will make using the internal bluez API easier to access
> from Rust.
> 
> Bastien Nocera (4):
>   src: Turn available priority macros into an enum
>   src: Prefix plugin-accessible adapter_set_name() function
>   adapter: Fix const'ness of struct btd_adapter_driver
>   src: Prefix plugin-accessible adapter_foreach() function
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] src: Turn available priority macros into an enum
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a1f2e53de4e9
  - [BlueZ,2/4] src: Prefix plugin-accessible adapter_set_name() function
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=69fd644df0a2
  - [BlueZ,3/4] adapter: Fix const'ness of struct btd_adapter_driver
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=80828d5ff016
  - [BlueZ,4/4] src: Prefix plugin-accessible adapter_foreach() function
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c24f0b487ca3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


