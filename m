Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875FB37A4AF;
	Thu,  5 Mar 2026 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725809; cv=none; b=O7zS+dJwVx18nYZjnrSFnTn85YaXgQ+sKUzY8hO8bPTmGHHkAB1SUNxI7xBIseVFuBxkMiEYqrUFpFZBlGYbllygWToa3FFIqTggaJYsyjpwx0AEwrG6BJgUZwbtk+GxhEMk7INncuM1LswxIhsd/ruAMuHtUlKkQsDfpYeKW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725809; c=relaxed/simple;
	bh=9mPXOMZ8gUvtm4GZ7537sXnHPKYvfvOJbAetu6/MRi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a9sHqLn2hABjSx2PlzizfyzdjjKUjbnG8h8GFTG5rughHiXoTGpS9mF/51+tnOzWsGjHq+b84YOPXCAGkqBR2sCMt9u7h1hyrizsdHaiZqdhwb3KhKrPQbCZb3N1rlYRjSh7QGVC2mdHxxBh5lMFrw7X+ZGdO/F+teqHGn4pAg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REafT+Oc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REafT+Oc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04995C116C6;
	Thu,  5 Mar 2026 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772725809;
	bh=9mPXOMZ8gUvtm4GZ7537sXnHPKYvfvOJbAetu6/MRi4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=REafT+Ocv2SC4BXHQMe8uA4F0DnDFk+fTCnPgu9fs8xQ2FX4PoqUKeuGa/NNQmy7B
	 Gj8SopKHyCxTXQLGaZDOpziAVf6KMTCVAnZbtj5UiUdiyT3OSd8chVH6tOfzsY+SS/
	 J4LlMbHGscxHmaF/G9Yn06ijj8HqnQps7d6Ia2eRt/TxBbcc9vYbEWcN+0I6zTgNi2
	 Cf2p19hvpGZOf9x9cMWElgD5SNRuqiUAOoPLxNKSjEEFKkfZRb3NpjCCeGCPSR/BnP
	 wx83TLoi2Ahzr5Y83eEYo+OX7BYBcVK38RgmeTGeaLNpqArjzbH5LL2i78XWbwhCJz
	 vGcLZ8xAImWvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE963808200;
	Thu,  5 Mar 2026 15:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: bluetooth: hci_sync: fix hci_le_create_conn_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177272580905.3180764.3868114143946058226.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 15:50:09 +0000
References: <20260305-bluetooth-fixes-v1-1-43effb810fba@pengutronix.de>
In-Reply-To: <20260305-bluetooth-fixes-v1-1-43effb810fba@pengutronix.de>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 05 Mar 2026 14:50:52 +0100 you wrote:
> While introducing hci_le_create_conn_sync the functionality
> of hci_connect_le was ported to hci_le_create_conn_sync including
> the disable of the scan before starting the connection.
> 
> When this code was run non synchronously the immediate call that was
> setting the flag HCI_LE_SCAN_INTERRUPTED had an impact. Since the
> completion handler for the LE_SCAN_DISABLE was not immediately called.
> In the completion handler of the LE_SCAN_DISABLE event, this flag is
> checked to set the state of the hdev to DISCOVERY_STOPPED.
> 
> [...]

Here is the summary with links:
  - net: bluetooth: hci_sync: fix hci_le_create_conn_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/ae93951e4081

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


