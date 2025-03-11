Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB5C25F78A
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708203; cv=none; b=o7Q0zFF97zkAqeNo0trWjR0p5SSojHZo4P1AqxYbQYwjycEuon6rsyLexCPlqAzsHHF2aMn1oSxHNpe4/k4lXgxjeJypy504QA7lVXniiOzolHGFMei6ZjPPEyoihCAY5bfHNZxBSQdNnFaKfoPkDNMzSvceQIMlNHCMmDZaUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708203; c=relaxed/simple;
	bh=3C/1jVoJx95kmRZus6DMOfYGPqhjVJ72w1ZNpCMCnx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L2lRlSN/AZ37qfP36B/ruioRD0zwUHmLmzgOgGtaKXql8//MZXWmNXzEYC3NzmN+oDuB+5SHf4+iLyZRD+oQrBE3qdmpyblWcsp8UgQ2IsVZUtGcTuPBY0kUbBNOq/jgdstBbuNCSpzzhM4QOQGArM7mIMDe2SeVxS2+y4ioC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6csJw7h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6csJw7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC51C4CEEC;
	Tue, 11 Mar 2025 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708203;
	bh=3C/1jVoJx95kmRZus6DMOfYGPqhjVJ72w1ZNpCMCnx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B6csJw7h0H/M8hIlcCMaS7xdsHPaWPm5B/3C6/5nVpn7cWJXM5PJDEGrTU0O6lRST
	 65VxvWasl0E7HNBhGyosp1ijkM491z7tB7yKHv1VHl1Nmg+vl+Fs8/UO8zGita4vGt
	 QwD6o2FaqyQF9txZ0ZfoSZwKHb0gW5ooq7MAHU1Lk64IyNhCrWNLznGvqopAcxcgxx
	 Wa2PT77xZ+DTv+kalxPnR9/OwLGyq9pyf0O8SwZpta73kchN1ipcfFBOc306GJs6Tf
	 3l3xcY5DG2zsRdIvEh0yg3Vd5lXmvcBCyT8gulMs8iZX6Vp4CF2EhF01VqVerEI/7P
	 sF5Gu2EA2YJ7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B7D380AC1C;
	Tue, 11 Mar 2025 15:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] btdev: Add support for Sync Flow Control
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174170823699.132061.2325462012863032111.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 15:50:36 +0000
References: <20250305182538.409019-1-luiz.dentz@gmail.com>
In-Reply-To: <20250305182538.409019-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  5 Mar 2025 13:25:38 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for Sync Flow Control by supporting command
> Write Sync Flow Control Enable:
> 
> < HCI Command: Write Sync Fl.. (0x03|0x002f) plen 1
>         Flow control: Enabled (0x01)
> > HCI Event: Command Complete (0x0e) plen 4
>         Write Sync Flow Control Enable (0x03|0x002f) ncmd 1
>         Status: Success (0x00)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] btdev: Add support for Sync Flow Control
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=86d6b74ff002

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


