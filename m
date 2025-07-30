Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782666DCE1
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883391; cv=none; b=qLGwR6TkBsDz/iYWRrEmyWGDV+ezkNpx38iS0n6FIVmxk1C/mNqxgYB0OzjDp+5p0Opvala6+4gQ60e9Gk8DCxMv3sg10wm+H2nBO6x318/Rp+UvkweyTSZt5kHw2TFXeDm3j0oc4v94pKsZ60kvlpQd0jX/dTKyR0oBatUvCp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883391; c=relaxed/simple;
	bh=2OpzzyWD8sZJkMOHU4gM/5FODJF4h9Uo6ibkDvAPJ+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bpnY7Lv3KQ1AEM0peAC/h/fPELIKZQTVu+fhEexaRryAvB38y4Kjk7Z2LiNgwFDpW7VQHpmcLnRQe9Qo7g4WzuNXO4hIL7vdhexzs4k89xAvpcTVgvBGzCacOPGycLc9eqm9YVm7GhwGUPojnLipppQDbee9sc/i6vBJMxIbN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOMZBVZB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOMZBVZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC551C4CEE3;
	Wed, 30 Jul 2025 13:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753883391;
	bh=2OpzzyWD8sZJkMOHU4gM/5FODJF4h9Uo6ibkDvAPJ+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rOMZBVZBoLRnwhBQXmBBxZUb5GFsNp4m4FyUFsRlCDsiO/XpaRQ+UIwO+g2ekSRo3
	 Ush13U/hK6S1GjcluSrgrKgK6SngqstQexeFab8TFnE+4a9HHbmjw47HvsM3xmJDcW
	 8wmaRZl9tu1VNHo3zeS9gCQUaZlLlall0zEn6QaiD32ZFC91wN5mLeVdUbxY5zOmxI
	 Qesm8np60QPqJ2CCIQjPQTUyZDtm8gcDQgcT+jl3LbA6voOUlWzTby+u9frvlLVLGN
	 UklPh3Hfw94u1c4kpBzMzn97cPZCUjEOmWDpGLWM9HSR/ZY5sMM8LszCtIxyNKmCpB
	 t74rC4pR1SPmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE9383BF5F;
	Wed, 30 Jul 2025 13:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/5] btdev: Fix checking for PA on
 BT_HCI_CMD_LE_TERM_BIG
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175388340701.2311214.8432497909281492384.git-patchwork-notify@kernel.org>
Date: Wed, 30 Jul 2025 13:50:07 +0000
References: <20250729192206.272462-1-luiz.dentz@gmail.com>
In-Reply-To: <20250729192206.272462-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Jul 2025 15:22:02 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> BT_HCI_CMD_LE_TERM_BIG does not require PA to be enabled.
> ---
>  emulator/btdev.c | 8 --------
>  1 file changed, 8 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/5] btdev: Fix checking for PA on BT_HCI_CMD_LE_TERM_BIG
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=280c9523a490
  - [BlueZ,v2,2/5] bap: Fix crash when Broadcast endpoint exit
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=165e57e744e6
  - [BlueZ,v2,3/5] iso-tester: Add Reconnect test for Broadcaster
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=13e0776cef76
  - [BlueZ,v2,4/5] bap: Fix possible crash with Broadcast Sink
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=077de3f8639f
  - [BlueZ,v2,5/5] btdev: Fix sending BT_HCI_EVT_LE_BIG_SYNC_LOST with wrong BIG handle
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f086b3d27c41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


