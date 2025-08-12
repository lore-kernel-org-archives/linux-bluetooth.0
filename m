Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B52DE6E9
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022193; cv=none; b=PkOp6P1L4LN++o+ehWQx3Rp0b9OXPmJ9GExt4BTqvcCL5n2VpdsH4IRfBZC9OZRIgbt4En8MUps4u7b5wyZmg5MmlPbaXDUo216DasbvsuJh8JJhl+Vaz7uSyx2FfbEmcIpPi7xRG2xUJwVmrkIKJ7Xe0+1NbhJ/+kyERLjDq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022193; c=relaxed/simple;
	bh=miuRpH+oFV8dqBCgd2JxBefsAnPAIkt9v3/oU9ZoNhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JDIkAqxRabxcG3YhPDtFkWxy+Ouj82yPRScPvIEhaskaN4kESLCNPPuoJycLYbGKtfs1/R/zVgasJEzC5X5BmqXPboD7HEzl4HLZj08oC59qCiqSncTNe3gK9vuvTeQc7fJRDVRCs7Nz4vDlD7ZdpugCxokIkBvZbmLe9mKAHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wvxan44V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wvxan44V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABED3C4CEF7;
	Tue, 12 Aug 2025 18:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755022193;
	bh=miuRpH+oFV8dqBCgd2JxBefsAnPAIkt9v3/oU9ZoNhU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wvxan44VUtBwDNN+oODX7AiPi5yAI2lm977X96NGWMjZNktp/zKhVWkMEqPr02WML
	 ZA1eAh8o7+PHMIRF96VfeP77VuFmdqHHT2PQNKx6FKS6c0AztMUccyHkhogkn9veE/
	 uuDJJUbsUTFLQ612F3OFIJuLfQfSBFDMwOmpGGYuEFDDcOtEJhmw3chhWIikhxGvCx
	 AMmkofgp3bypjEPhN5go8Ty6Z2ShznzMo7JjdkYc+ElNTEbNzuOTcXDihp8WjeuGWU
	 mzKzZXEPGdIJU4MNPiOt6rsjJiwqhkG2PqCXSyrXdDkVc0sln5jkVFvpqqA4a47X38
	 dp6QNF8//wIHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFEB383BF51;
	Tue, 12 Aug 2025 18:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluez] audio: Don't initialize device volume from media
 player
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175502220575.2767383.5429223419974091860.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 18:10:05 +0000
References: 
 <20250805-audio-no-reuse-media-player-volume-v1-1-c9fdfaf74a71@qtmlabs.xyz>
In-Reply-To: 
 <20250805-audio-no-reuse-media-player-volume-v1-1-c9fdfaf74a71@qtmlabs.xyz>
To: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 05 Aug 2025 17:21:28 +0700 you wrote:
> Media player objects may be shared between devices. As a result,
> a device without support for hardware volume that is connected after one
> that does may end up being erroneously considered hardware
> volume-capable.
> 
> fa7828bdd ("transport: Fix not being able to initialize volume properly")
> introduced btd_device_{get,set}_volume that is used as an alternative in
> case no media player objects are present. Therefore, we can remove
> media_player_get_device_volume and instead use btd_device_get_volume to
> determine the initial volume.
> 
> [...]

Here is the summary with links:
  - [bluez] audio: Don't initialize device volume from media player
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5db6d2fef66f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


