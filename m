Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0912E54A2
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773259813; cv=none; b=TdgUx5XwDAsvB1CHJwy0pY1HXPpbl3zwSY5PmD8GWlrGhUYmO+QbIoBvWZfMLpr0iif5QfC41S5adITJo2v8yz3LVBWmFeGujZREjH7sFV/uJVe98IVu8w7MH1s0ajdqfj94j8QhNTEyJySctCm4UMExRVM+IG4GfpDeGVW2kNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773259813; c=relaxed/simple;
	bh=FCar5xDDnAoIQVD8XRxHs9YbHrZimymOB5nLpWjbIgQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QAyG2p9+aRnjTF26PdC44enmKUV6yliHeq86HwLkgsRB/HnA9SRTpYEvU/a+qg+2NpvW0wX7EQ4TvdwAL8FSFXZzVR9xEQG9d0E78XzFMgXIns3N+ddZPpy/Ho3uzETu9tqrgz284kKBbMcgXvg/qLKlI14DCKy6KG3MDT8/hdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRqxN0h7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRqxN0h7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4B2C4CEF7;
	Wed, 11 Mar 2026 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773259813;
	bh=FCar5xDDnAoIQVD8XRxHs9YbHrZimymOB5nLpWjbIgQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lRqxN0h7s4OqccgX8H44EqZ2SOj19IuaPQqmu9rwlQN0FbYieejSxii0zv9dWqBBC
	 bM8fepPy6c01DpuEkTAfsJ5IfRIHKyBEWqkKgWx1Q1e7wiEglRT/eph4Z4H8mlu+YR
	 HnzcQm/pyGealUii5bxojdJ0/a42L2QenM6+JZ548aI5NjJV9u1pEyR/cOzt6Nqf0R
	 CPQiYFZnQ9VoWqonDXUSVsXdGDrWFd6B/PC2Mt6VWPfAzWUAly0nhlMyZ3OmZzuiLH
	 Zk/NdSMKc6Lj17c5jDKMA07hexDONGknUfrOEHxk30LzVzKR6x25z9hDTKNqxV5qo8
	 vZGKOK933DC1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F223808200;
	Wed, 11 Mar 2026 20:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/7] doc/btmon: Add GATT database reconstruction
 guide
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177325980934.3817440.17208334986003909651.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 20:10:09 +0000
References: <20260310213314.729718-1-luiz.dentz@gmail.com>
In-Reply-To: <20260310213314.729718-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Mar 2026 17:33:07 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Add a comprehensive section explaining how to reconstruct a remote
> device's GATT database from btsnoop traces. Documents all six phases
> of GATT discovery:
> 
> - Primary/Secondary Service Discovery (Read By Group Type)
> - Included Service Discovery (Read By Type with Include UUID)
> - Characteristic Discovery (Read By Type with Characteristic UUID)
> - Descriptor Discovery (Find Information)
> - Characteristic Value Reading (Read Request/Response)
> - Targeted Service Search (Find By Type Value)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/7] doc/btmon: Add GATT database reconstruction guide
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1d4e2532d4c3
  - [BlueZ,v2,2/7] doc/btmon: Add SMP pairing flow documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f247395a18d5
  - [BlueZ,v2,3/7] doc/btmon: Add L2CAP channel tracking documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fa9eed625ad3
  - [BlueZ,v2,4/7] doc/btmon: Add LE Audio protocol flow documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a0e1d0b5b49c
  - [BlueZ,v2,5/7] doc/btmon: Add protocol error codes documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=587f94f9170f
  - [BlueZ,v2,6/7] doc/btmon: Add advertising and scanning documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=83f55cc4ad49
  - [BlueZ,v2,7/7] doc/btmon: Add BIG Sync flow documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=948d90c274a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


