Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212F4766AC
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093207; cv=none; b=cAYSM2zenZ8G56kIG3cCqJo7z1Gornp3SKPqssIaPplrZl7Kr9NpLYhegT42yy3k2+TkXA3XTOCjRJRZ3/PPyH28gui3d665kQdyZ1w2qFE4ArWgcCe9prvnG3yQ5yqEWRMHMVd3FQJqWtaS74uMwg2znPscUk1bY/VS3THs4Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093207; c=relaxed/simple;
	bh=Uv7c0qoSPP5a2bReHy9HVKjpqBDdbqfDjSdI7WEG1OM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j3wWiu+YnnXP12mjdv1stDOKw/9XysoXXnOKIHH2sOY2c0FCfpdtjNP2hfjE3TVLwbxRLNak+qGdUzTDWlaV2oqFftkfRfYlzULgx18hUddnN8h9Hfx2cmBkfPU46i+3TK9EU+FFJRasvpWYiupjd69AVEuQD4cQpIZI2yBnHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jot2t2Mr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jot2t2Mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803121F000C4;
	Thu, 15 Oct 2026 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792093206;
	bh=h01gsCQsl9RsLC1hj8/RDAikxasFmeubtdR4i0uLC5E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jot2t2MrTiAuULpiE5Exq5NjVVoA6WracTCnPExrVyUM0YzpJWrB1raNR9Qkgv8EW
	 1Z+qk0LwlLOhTfjQItbNeTW6Eb+crLPNVLFT/vG6vMozAxMp2wQoL5RNpxTtKMODUJ
	 duytk7+sRvXdPT0cigZHABPc6Kpq7ikhw0sIgV+HhZBhAglf/in4mT+sX/QmYl8yNY
	 zT975I32iZ7Rla7LPemNn4dKp+hPyOMxAMo6RIs6W3YHbO1MpviKcKq7od9ZbzGFpI
	 h/SK+S+efc1Z7ZaSyZ/haLiohcU8r0iy9cAgm6kUkdg7ISiA0jGdCa3ItVhorfvTeT
	 nWBSj+2nbH1bQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773683808209;
	Thu, 15 Oct 2026 19:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluetooth-next] Bluetooth: hci_event: strip Broadcom
 vendor
 bits from legacy adv report type
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179209320528.4073732.6498666167619250326.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 19:40:05 +0000
References: <20261015114903.784731-1-66ton99@gmail.com>
In-Reply-To: <20261015114903.784731-1-66ton99@gmail.com>
To: Ton Sharp <66ton99@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, josemiguelo.ochoa@gmail.com,
 gargaditya08@live.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 Oct 2026 14:49:01 +0300 you wrote:
> Broadcom controllers running ROM firmware on Apple T2 Macs (where no
> RAM patchram exists, e.g. BCM4364B3 on MacBookPro16,1) set vendor bits
> 0x10/0x20/0x80 in the legacy LE Advertising Report Event_Type.
> 
> As a result, directed advertisements (ADV_DIRECT_IND) arrive as
> 0x81/0x91/0xa1 instead of 0x01. Because process_adv_report() drops any
> legacy report with type > LE_ADV_SCAN_RSP (0x04) as an unknown advertising
> packet type, bonded LE peripherals (such as Apple Magic Mouse/Keyboard)
> and Chrome passkey proximity scans fail to discover or reliably reconnect
> to the host.
> 
> [...]

Here is the summary with links:
  - [bluetooth-next] Bluetooth: hci_event: strip Broadcom vendor bits from legacy adv report type
    https://git.kernel.org/bluetooth/bluetooth-next/c/e3bb245b2daf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


