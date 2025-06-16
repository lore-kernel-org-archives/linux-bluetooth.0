Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1455522171D
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111816; cv=none; b=rsS+sB1R8TMhbUQFvXRSjaOYxx5LA7yqVOiIwZUmSTv/Jk66hH5vEEhymGIQRqDMT7JpmpH65LQ4NUg4rHO8U4A3jRloLQVrLkJMTTBgH9G2GeLk81fUyehNUdWUlgA+4bqUJaern2aOciOf1HzvT7If5K+5kjqvyIuXW6KPVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111816; c=relaxed/simple;
	bh=IFylPicRqWQTmYjL2HCdip8QSypJXdiUOvZPC5QidfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JDN4m+EIBvTlX0uJFwZxhYovJBedbjrWHuSvUKex2HRGtumEyRbRWd/ph3FbJD+Z5Boa6Fsg4eaPNuhQtLIrzKrJFAF4TMrPXvvR20QLDff2FZbu+D1F1WXA/QqEvrXukShg9iiXOKA53H9gY+zMDDSvD0p5wrSY2SiCrHYX0bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUOnViEb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUOnViEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D107C4CEEA;
	Mon, 16 Jun 2025 22:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750111815;
	bh=IFylPicRqWQTmYjL2HCdip8QSypJXdiUOvZPC5QidfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DUOnViEbI9g3n6uezqXecCuJcl3jdohFq5yyMaMfFJhb+ViNZNsOsgRrhN3gvLZGY
	 36LzEc4MmZ3ZUgPiiNnwwQ3+C4lSIczmfDAYXYWNNdzzzbHRUWxE2GbQEoZgCuW66y
	 Z20ASwSGQvRuyoIyDN6iz7HdnBJMEYEgqgudw1YahNQ8LJ4Kv8k/jvtoXv13xj1GOO
	 a4Efq1hVPMgJWOipTqYSVydUeBhVlXzYJQ3ajDip1nsbvWrHIKBjebOmb3EYZqpMzc
	 rpekOzMOJ+UHFDwNnIjs1PmWEzBYuGWYHQ7qzhqzaRxmMR2LMMAbTocmK3VvwuuqCk
	 k0UH3pCotIxXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3D38111D8;
	Mon, 16 Jun 2025 22:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/gatt-client: Make bt_gatt_client_read use
 bt_gatt_client_read_long
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175011184449.2530350.6408558984832521309.git-patchwork-notify@kernel.org>
Date: Mon, 16 Jun 2025 22:10:44 +0000
References: <20250613140445.1997694-1-luiz.dentz@gmail.com>
In-Reply-To: <20250613140445.1997694-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Jun 2025 10:04:45 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes bt_gatt_client_read use bt_gatt_client_read_long since the
> later does use BT_ATT_OP_READ_REQ for reading the first chunk, so they
> are actually equivalent in this respect, but bt_gatt_client_read_long
> detects when the data returned maybe truncated due to MTU and then
> proceed to use BT_ATT_OP_READ_BLOB_REQ to read the remaining chunks
> which is a disarable behavior since there is no property indicating
> when an attribute would require long read procedure.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/gatt-client: Make bt_gatt_client_read use bt_gatt_client_read_long
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=be36a9c9d3af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


