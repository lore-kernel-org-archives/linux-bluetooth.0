Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3080B3002B4
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474432; cv=none; b=U57oiSvx8ceFJTH1SJ5nn24NvzriqHFKYUkyu7L3HLErbQoyHVeOcDBMDLeJez9RwKxTNXJ9XycvSpDwZNV/8SAaY1vKEqvI+BcOg/ckbMl6appny16wXisM7daMl6GgIlGldNB0+/eNkKc7VUUEEHoJgYIF+f4hDsv5CgtDosk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474432; c=relaxed/simple;
	bh=+L41MMJ8taBdR9X1x2XG3VrLA8N2Yt6JcFonFxAaeak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZR6E18QzfRD71RrziezKcXQiZVzD+mz5lcVpBVs7N+CoSbimUneGz55ERuwvd2SicZ798aV19mPnOzGeg073D2pNs7uBaSdDY5C34Jh+OnMAg0k4e4Kk+n+LV9dVb01OWdauUdqbkSOJWKrrtgAyuol+FlCC53LepKGW228ZhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaMv5NZp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaMv5NZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07851C4CEE7;
	Tue, 14 Oct 2025 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760474432;
	bh=+L41MMJ8taBdR9X1x2XG3VrLA8N2Yt6JcFonFxAaeak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UaMv5NZp2uLWDBjEbfR62Ok0635SPKDKeCCbY6XjSVUXB00I7+iQ7VVOuVxd1e9fj
	 6T6+FCmsdsIi/gOe7hP5bMxgDEh7PD79RGP0gL0Cc7gJG1PKRCsR0GW+k3LznSZ13a
	 TmZspshhViOcYPLtEdeWBFQO5x6U0/26RV93OdQzjh6BAvRY4qUU/9CEohuFLkQXH9
	 QOVfh4Dov5fQ3sKCbdd9uozPYQkOL2Xmm3VB9Hf11HkZcjTX370x5pyBbYGtuTmY7c
	 AYqOq4gUzn7bzhQPuCatsE62pFDdqZ2yOkrplxcUd1fWtYxpPPgI4b1cwsv8mXNHMd
	 ieys1j3Utu9rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72FCE380AAF2;
	Tue, 14 Oct 2025 20:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/8] Bluetooth: HCI: Add initial support for PAST
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176047441699.88862.3293407258426025596.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 20:40:16 +0000
References: <20251014013308.174151-1-luiz.dentz@gmail.com>
In-Reply-To: <20251014013308.174151-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Oct 2025 21:33:01 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds PAST related commands (HCI_OP_LE_PAST,
> HCI_OP_LE_PAST_SET_INFO and HCI_OP_LE_PAST_PARAMS) and events
> (HCI_EV_LE_PAST_RECEIVED) along with handling of PAST sender and
> receiver features bits including new MGMG settings (
> HCI_EV_LE_PAST_RECEIVED and MGMT_SETTING_PAST_RECEIVER) which
> userspace can use to determine if PAST is supported by the
> controller.
> 
> [...]

Here is the summary with links:
  - [v4,1/8] Bluetooth: HCI: Add initial support for PAST
    https://git.kernel.org/bluetooth/bluetooth-next/c/9694b70e91bc
  - [v4,2/8] Bluetooth: hci_core: Introduce HCI_CONN_FLAG_PAST
    https://git.kernel.org/bluetooth/bluetooth-next/c/5518b6d3b39f
  - [v4,3/8] Bluetooth: ISO: Add support to bind to trigger PAST
    https://git.kernel.org/bluetooth/bluetooth-next/c/bac683543e72
  - [v4,4/8] Bluetooth: HCI: Always use the identity address when initializing a connection
    https://git.kernel.org/bluetooth/bluetooth-next/c/65a0aadac242
  - [v4,5/8] Bluetooth: ISO: Attempt to resolve broadcast address
    https://git.kernel.org/bluetooth/bluetooth-next/c/18339e7d7e44
  - [v4,6/8] Bluetooth: MGMT: Allow use of Set Device Flags without Add Device
    https://git.kernel.org/bluetooth/bluetooth-next/c/12de14315ad7
  - [v4,7/8] Bluetooth: ISO: Fix not updating BIS sender source address
    https://git.kernel.org/bluetooth/bluetooth-next/c/e7dbb54d27b2
  - [v4,8/8] Bluetooth: ISO: Fix another instance of dst_type handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/19c922bc098a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


