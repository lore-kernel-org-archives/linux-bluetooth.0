Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0032E3389
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Mar 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975796; cv=none; b=Y5J4CDPXFoZys3SfJLXUlowvtn8E3t5013LoUJEy1S1memh+KS4bUEswu0yTCbc0Z4x2cXRO36P4YmQtxDVFkm4/nLgpEdujWlzLZdnyIc9+eXTVFU58IzNUjuEkUEIflxRFA3WPfkv1DqWZNrLo4pPCu6BleP7z5EkpxmD0bO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975796; c=relaxed/simple;
	bh=vlmG2adgKg0cTn3C8eFA92pk3b/NXu8ESB9VpFDXZgA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ar14UtymdoJqyLRE7c29WhTgbbvrVCKD37gVjfltmJFQ5/fk/3beO8WowguKTeMZ8+71J0n23NbN9xN4zhWRjS55eE98523/eezKrltDQN0TqO++0BSqX5n45zrf5GwbZ6vbZUkmHxc56jW5G1GFtD5M5VXU5WvENL1VVW2JD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vC635Og0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC635Og0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1813C4CEE3;
	Fri, 14 Mar 2025 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741975795;
	bh=vlmG2adgKg0cTn3C8eFA92pk3b/NXu8ESB9VpFDXZgA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vC635Og0kKUmZRTX9sLT5UJ6BOMtLlDLnwLhhUVoyBQ9eqzJAp/V3TOnE7dMzuxmg
	 v1hiN6643W8ZRaqo69kqeUes+yh8VPFJ+i8qW2LmgYZXsjUSOKY6Cu8M9Ql7QWJCxg
	 FdAYXYoUUb6DnO29VBlHcW/OmrvuV2HO1cNxsuZuGtlly2OVTlmoRJjZ8tNX/KNyRA
	 QvlA+749WZn4xLxgPlJ/fo5iu6vnPGZJgNWvLMnV2FSXe8zlxOOG/1UNSKNSe7+zCB
	 5KZK4PwKhoPc8OQDXZqbUxPTts7W/zS7S44zBj65eyvBnMUbSa5IAHuVTu1DBAcCa1
	 SPqg0D/XQ0Ngw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBB9E380CEE2;
	Fri, 14 Mar 2025 18:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] gatt-client: Fix Handle property of descriptors
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174197582977.2338125.12765962680485705473.git-patchwork-notify@kernel.org>
Date: Fri, 14 Mar 2025 18:10:29 +0000
References: <20250313205404.534383-1-luiz.dentz@gmail.com>
In-Reply-To: <20250313205404.534383-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 13 Mar 2025 16:54:04 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Patch cda5549f2475 ("gatt-client: Add read-only handles to dbus")
> introduced support for Handle properties to GATT attributes but the
> function descriptor_get_handle do access the user_pointer as it was a
> service not a descriptor.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] gatt-client: Fix Handle property of descriptors
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=21d45dda01da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


