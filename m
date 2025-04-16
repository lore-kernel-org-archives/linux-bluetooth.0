Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD9149C4D
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744835995; cv=none; b=l9yHEg6ttmw0AgQl7RqjMZ33H1azrfyIbonVn/D41DMVIxLEf8Ujhz56RXEN6QyffBwfIqDDzja0KMevbfEzL20oDEu61aFkIcLYB8YSdJm7jB8Z7aaxTu2nEf3p6XjjC6l3XS6dw8MJfmEyvwuNvFfD2AeOsCtydAnBnKGqz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744835995; c=relaxed/simple;
	bh=TD4oXbZM4BZVrRN935GCShDY224HGwoOMufKVblli4k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VYcNugyoUBW5wkzLWYN7OerwztKMr8KRzze48vOivxrdMnms7ipawx3Sf8RPT0mJOSldUOoQSQnK2pYWCRGkyHaZGzTfoWBwC5JC/B2cwSJuJcsA1daR3efN34jc6CfFDEP5E6aI0HI2ZVBR370gxAMlf2UcWc5jLBrnE06N4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruB55qty; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruB55qty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB89BC4CEE2;
	Wed, 16 Apr 2025 20:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744835995;
	bh=TD4oXbZM4BZVrRN935GCShDY224HGwoOMufKVblli4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ruB55qtyyTDANYiNGfkaDTT9T9kRuU8m7E88/bBbpgwnuJtlyIPSUon2MadTMF4mp
	 imghbFnSFOAEAqDYQWASndJ+A0HQIfu7o6/WuJhPGd2fR6ZW7aJJupx0AQGrlVWU7b
	 jMMiOPQfUkC+cYTRrRNkV8k1iYCdM/n4OsRcJPI1eJ3Ve8dIFa2K5kEzcp15r8aQzN
	 EylhUtTUgtiveE336mTTSOR1tzos0BbwHtFwFqDVQ+5aHVrkA/lVLeCUkh6JldJ3SY
	 djZVvg4RkF9+nj8SuQqwaRXJNp31T6XX1dKP35K5DeoTnHQ+Fa5GIjnRBPhQCvP1+y
	 5nMxSqNRmZS5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340F23822D59;
	Wed, 16 Apr 2025 20:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/3] Bluetooth: hci_conn: Fix not setting conn_timeout for
 Broadcast Receiver
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174483603303.3492169.11744384254919286251.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 20:40:33 +0000
References: <20250415214835.1678138-1-luiz.dentz@gmail.com>
In-Reply-To: <20250415214835.1678138-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Apr 2025 17:48:33 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Broadcast Receiver requires creating PA sync but the command just
> generates a status so this makes use of __hci_cmd_sync_status_sk to wait
> for HCI_EV_LE_PA_SYNC_ESTABLISHED, also because of this chance it is not
> longer necessary to use a custom method to serialize the process of
> creating the PA sync since the cmd_work_sync itself ensures only one
> command would be pending which now awaits for
> HCI_EV_LE_PA_SYNC_ESTABLISHED before proceeding to next connection.
> 
> [...]

Here is the summary with links:
  - [v4,1/3] Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver
    https://git.kernel.org/bluetooth/bluetooth-next/c/58ddd115fe06
  - [v4,2/3] Bluetooth: ISO: Fix not using SID from adv report
    (no matching commit)
  - [v4,3/3] Bluetooth: ISO: Fix getpeername not returning sockaddr_iso_bc fields
    https://git.kernel.org/bluetooth/bluetooth-next/c/ffd068349018

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


