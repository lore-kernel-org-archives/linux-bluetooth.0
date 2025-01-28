Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790EB1BFE10
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078207; cv=none; b=FRA6WsDaSF6NyMOCcW7Rv9x9GONhOE4nCOytJpf0M/PF7RYnkgZpukwnIz7sNj4PtOjRsj47qshHYTBe/yx7xNLLO1xBgnG0f6bmpcIrawXbwOsjmswG9thp5Lxjad1BrztE+O2NDC8jjfua27X+GYBQnnqLIImWuEm799R68HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078207; c=relaxed/simple;
	bh=ByUyKO0iYbj6sXFMot12pZ42MVLWtHK/Rmjw3BKhcZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DxEKDOqg5R5rWgpZuL98mI9176Z+Ypkkh4LhqRtMyJuIPDUX2srRsmM8XOGuzdlk3LdOTXEpw8Ym5bdb0KgKvfhta6N49NBse++aiXB9U2LYSvdXmZoVP6mqG2k9msu0qEYMxdJeH4DRcYzhvuHhe+FjDAmwrLTW8bpJv2wv0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg+9ibaK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg+9ibaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7457C4CED3;
	Tue, 28 Jan 2025 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738078206;
	bh=ByUyKO0iYbj6sXFMot12pZ42MVLWtHK/Rmjw3BKhcZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qg+9ibaKm854yCnS0kukuXNSgSAytvoD092W1SpGkc47nWYblXhIlK/K/2osMeENY
	 LF7UYi41cTAixQ9hS+TpiabKxk911j/wQiSmmSetnYc44JCkETPoQn/5ECWoPNMu3g
	 jdAWvftfK+c+cXwBWP5tGm/MMHt7JVPtxjEFjlMW3+G0tC9R152Jgz2qdiq6m18vyz
	 v7EjBV30RpOyo812edLRLwIvVcqN67/x49D6iD1sJWJu3YGfnUxnrbxBjQuFBh9/iz
	 jlz6/aQQeKT+xOkHHidCHH7oSiFbfCE3WtuHa/dfdsd6GTVEdNwQ/YMmtOQTrYvLwz
	 QqiIGvQRhUfJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECE70380AA66;
	Tue, 28 Jan 2025 15:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/2] client/player: Rework transport.select
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173807823275.3823183.6077030194795089397.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jan 2025 15:30:32 +0000
References: <20250127093004.19268-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20250127093004.19268-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Jan 2025 11:30:02 +0200 you wrote:
> This reworks transport.select not to require a local bluetoothctl endpoint
> in order to work, since the user should be able to use the command to
> select transports created by PipeWire, meaning that the audio server
> registers the broadcast sink endpoint, and no local endpoints are
> available.
> 
> Iulia Tanasescu (2):
>   client/player: Rework transport.select
>   client: Update transport.select documentation
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] client/player: Rework transport.select
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f284a920bcd
  - [BlueZ,v2,2/2] client: Update transport.select documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=46fbbd600578

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


