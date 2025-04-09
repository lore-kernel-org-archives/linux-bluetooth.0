Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874B69D2B
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208404; cv=none; b=tC9EjnbI9LqGfrKB634e3bkKTd4BVgQUo6RpB0x1NtI3MJha9ClbEc6gLsn+Rp0Cz++HopgEZTalikNI/HwGmb+OMnTNvRWSiqth7fDPD3YAzOjPwE3KWPs5sRXVwmWrn0/TPI2rXNWWZ2xrVquK0r0OHytDfyZdy7SyJGNXOR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208404; c=relaxed/simple;
	bh=HPXsT0h4BxK7WflUoAy/NxOpTKiRh7fOxx0OMp9O+Ps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZD0l3XcqSnnCWQVLNHcuWIZUcoFdlSeh8tz/Us7gzg5gKuUbHaKevsgBcGkQA+KMBCPAtUlw0qlBdLG2+5pf1yAXruFPCYukedtvKK1lQAea6iCzYALOta86YDZdkb4RZdDEFYM1Y3qSilmQ7vlU21o8cavRdpJxfO13dyYXgJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvOLLQxw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvOLLQxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2AAC4CEE3;
	Wed,  9 Apr 2025 14:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744208404;
	bh=HPXsT0h4BxK7WflUoAy/NxOpTKiRh7fOxx0OMp9O+Ps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OvOLLQxwyxZJf99eMTm8NPNqfCBt/ORgBbdhSFXaZ/2u9LZ++EWQUh/ELBcJ3ExOX
	 lIYrSejpXAXb3h1CLwLh2idtI1GdMKrz51CCDbHG7FPFpFjTwPAmtmi5lMaUoXyQ3r
	 8HbwAkqbGIG67aqSjmTqpFdFmFIARd5DS4pL8rGhP3kYkVzg5MleKiWCiPBTe/3inu
	 6qVaTRObvCh2sC3bo1bZOiw9vnZplcgsoxj+y5opMXp78KECliRwSbOniLkRdprv5h
	 LzulgC1O0/fXTFUp6mq6DGXnkZ8M00dMQhCVzWzFOnkRSClVCBIXQrEFLcBj6Rc7mG
	 h+W7GIX5B1UzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BC787380CEF0;
	Wed,  9 Apr 2025 14:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] doc: Fix various typos in D-Bus interface documentation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174420844173.2837833.15510798366137599927.git-patchwork-notify@kernel.org>
Date: Wed, 09 Apr 2025 14:20:41 +0000
References: <20250408101243.6010-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250408101243.6010-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Apr 2025 12:12:43 +0200 you wrote:
> ---
>  doc/org.bluez.AdvertisementMonitorManager.rst | 6 +++---
>  doc/org.bluez.Agent.rst                       | 2 +-
>  doc/org.bluez.AgentManager.rst                | 3 +--
>  doc/org.bluez.GattCharacteristic.rst          | 4 ++--
>  doc/org.bluez.GattDescriptor.rst              | 2 +-
>  doc/org.bluez.LEAdvertisement.rst             | 4 ++--
>  doc/org.bluez.LEAdvertisingManager.rst        | 2 +-
>  doc/org.bluez.Media.rst                       | 6 +++---
>  doc/org.bluez.obex.Agent.rst                  | 2 +-
>  doc/org.bluez.obex.AgentManager.rst           | 2 +-
>  doc/org.bluez.obex.FileTransfer.rst           | 2 +-
>  11 files changed, 17 insertions(+), 18 deletions(-)

Here is the summary with links:
  - doc: Fix various typos in D-Bus interface documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1288facd5548

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


