Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D84D320A34;
	Mon,  3 Nov 2025 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189233; cv=none; b=cF6NIPgJET8PFalh7X7FCKB2MfBaZqT7HvY9E31gncfdKOLTjEcePa0eF4KBf+jDeg4CJPXk+7eTn8Cbg72uD/l20tbfYVs1LSpdfjnukAXNWvFo44/KDurFw3nJ0ai+EtrWpjcBhn3/SCIHzcvlxgeQOpHlu+4VS4lMaHwt104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189233; c=relaxed/simple;
	bh=0zXDVuJijPp6w4w94FBd2TR0wNVoB96mFqT35Z2X7Do=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DOwRpFHSGd5HziwjdVkNwHMpBxJgUjps241DqhAT30QRcy2JICM+TFQ6eOTqlCFvnQxVSjwTOm9jYuLS5PV+IoNxbcQi2gjkBQnk2bQscLkJNuhfL3tM4xTLZAZ55xndmqmfns1tMPN8OmeTsBPCNMhlhtMY/w5pyp0q9zxHFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5EascSt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5EascSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8475C113D0;
	Mon,  3 Nov 2025 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762189232;
	bh=0zXDVuJijPp6w4w94FBd2TR0wNVoB96mFqT35Z2X7Do=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k5EascStc+FTw/jdwEAOQKQdWBc0ndT70p2XoVgvIRWgPTcUB18oDKtXNfhY4mFih
	 KyZKVC6AArGwJoo8pkTWX4GzMR7WeE5lG5BWbCOSVPkwOxq9Ev/65Zs0xF+YwtZDT2
	 oRHOjt1Ze1uIwvr77wB9TrCCNtMaf2bW0hc9eIoZ5s97wL7Q83X1IzSYhtZo7u6u2t
	 89CfchbnkSnAS22VX3ajyZX/sJgvaQ1VZW0mPQYPlXcep/eIe6/OpXSIQdckLzrsHZ
	 URcGdosN6BoY40GP4r2lzK4aqfMi0M49PIg5fewCTmbgFJd9KxM2xggP+GEQrf0LRu
	 Z9Yhpc2RLEXDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF3173809A85;
	Mon,  3 Nov 2025 17:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: cancel mesh send timer when hdev removed
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176218920751.2128161.3685266924525568180.git-patchwork-notify@kernel.org>
Date: Mon, 03 Nov 2025 17:00:07 +0000
References: 
 <75b74d712d9eff4d79f05476973c004c226c08bc.1762107269.git.pav@iki.fi>
In-Reply-To: 
 <75b74d712d9eff4d79f05476973c004c226c08bc.1762107269.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com, brian.gix@intel.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  2 Nov 2025 20:16:12 +0200 you wrote:
> mesh_send_done timer is not canceled when hdev is removed, which causes
> crash if the timer triggers after hdev is gone.
> 
> Cancel the timer when MGMT removes the hdev, like other MGMT timers.
> 
> Should fix the BUG: sporadically seen by BlueZ test bot
> (in "Mesh - Send cancel - 1" test).
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: cancel mesh send timer when hdev removed
    https://git.kernel.org/bluetooth/bluetooth-next/c/2747d9296177

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


