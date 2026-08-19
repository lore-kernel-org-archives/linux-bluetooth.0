Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7B3C1404;
	Wed, 19 Aug 2026 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159461; cv=none; b=GwERS0ZiDl9vi7fT2NbZG1cGgU1CfgkFWjKJzWV4LS5T0Vq1rsXD1ytZHL7MTXNyE7j4ABMzGUPBz6Y1Z/Luxs1wv4d8vwei0Sh+lxbq8Jpu5L/v18+yDBnPqvt+k4izop4GcouD2AQuLJ3gn6NwbpBHbxLerF/guDiWHPuxE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159461; c=relaxed/simple;
	bh=iLbI3QijcHKkXbRi4avfgCSEnjANT32Ti5jZdb+2TzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TAVqWdNsClhKDCTRCKSH2l9RV+RMoEKiz0PRNFtK8V5vgL1B8aIso8JF9KBe0Mf0XTPTCRDLxRbRf9547167Qhe9vCqF0DOEjqXs+7IriAZomAgyuPRWcVVf7+HP+7Fy5W0L8Jm0l2WWjMclDXOZ9Z8olveFfk/otjqUtjpSTHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJL4+lZe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJL4+lZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DA51F000E9;
	Wed, 19 Aug 2026 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787159460;
	bh=h2oyX3WPE5uMHsL3+BTFRCLi+4A/xt7zJ6mPExdIv7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZJL4+lZeAg0LpMrd0hAqBFoz4Kttg4aNtlplR5/4v0wmJRjzrocO2S8LcJy4PaxP5
	 WN8096I7h0yegGNyKXZNYI6uRUGHifqM62lSitpm6MCGER4f9Foz5QTbqvEscssDEn
	 1LCz17cMg1CEBi3LgiLp+quiAuD7Z/1v7da8w5P6ZHhfTv8Y8WJ9PADpPES6ZXq38I
	 2oCuCJep4rMZ9GpgSCQZtW9/fo2c3IY8J1e/6Ox9g4oLh5p5y6xowYqe1nRITHlllI
	 8Wi2qPOUjEj0ZDua0lVJRjbTvPWgpubNC+hJpH7nR7R4SfYrliHk33PzjLj5kqyUOJ
	 ohJ1weztyPWAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5682538119E6;
	Wed, 19 Aug 2026 17:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] Bluetooth: fix endless adv params retry after a
 cancelled connection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178715941088.3583745.7496147705308493580.git-patchwork-notify@kernel.org>
Date: Wed, 19 Aug 2026 17:10:10 +0000
References: <20260818132935.1083808-1-valentin.kindschi@fiveco.ch>
In-Reply-To: <20260818132935.1083808-1-valentin.kindschi@fiveco.ch>
To: Valentin Kindschi <valentin.kindschi@fiveco.ch>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Aug 2026 15:29:33 +0200 you wrote:
> A gateway device that advertises as a peripheral while also making
> outgoing central connections gets stuck logging
> 
>   Bluetooth: hci0: Opcode 0x2006 failed: -16
> 
> every 2 s indefinitely, starting seconds after an outgoing connection
> attempt times out and is cancelled. Measured on one unit: 5326
> occurrences over 3 hours, ending only when bluetoothd was restarted,
> which resets the controller.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] Bluetooth: hci_conn: re-enable advertising only for peripheral role
    (no matching commit)
  - [v4,2/2] Bluetooth: hci_event: clear HCI_LE_ADV only on a created connection
    https://git.kernel.org/bluetooth/bluetooth-next/c/e4d6d16f1be1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


