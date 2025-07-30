Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8726DCE1
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883392; cv=none; b=iLew0pPwbOHDSYtbi6FnEO6mqfuj3lOqBfQbGoKQUDid3wq7dN3Ji5ahf0PkaiDAPoFVk3O6oZNmG74vMzmRU2bQPf+EEvCu+pBAkLvEvYB8sgyqqkevoQMPTJkjGLdIR/ads9qJ9+9ZxK1dIw5UIZDKdYXinKlxuzAqboLW/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883392; c=relaxed/simple;
	bh=gkmotywlljGtsO6m3w2+WkJV9PSrdrlvbwAqXzMVTIs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sCoD2wPnyuQGofIpMVocAwrr8OaeigHNcNc04S18AaRY3oTxJzDXQwr9IJJ8i0vNr5NXC/mrTbvB8yAgDxp09bQ2UXlfJF07+rGK+4dTmuZFgfQ0U8gz2Mv+FOqV3DO25SZAGOAh6X9XAt01TBaOWQ/eZDiHL4OOqnOiOMsIcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2PjxYyu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2PjxYyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFBEC4CEE3;
	Wed, 30 Jul 2025 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753883392;
	bh=gkmotywlljGtsO6m3w2+WkJV9PSrdrlvbwAqXzMVTIs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G2PjxYyuNyaxFZEY5Hzyip2h/AazAbUksEtTl33fXx4jLvw3PEsMMdqDxj8/cVeIH
	 31a2fAzjQrc4miZZBKOEVx6QWdOfb5ZRrK/keH/NRPtKne524/Mky/vt2ZGzBQlZ7U
	 JhTwp14pYBg7ollpg4q8SigOhqI6z2iMPyohU6XoTzed+YsAsQGnFXn799c2ceTbtk
	 lTGDBH933loro0TxH8aOuCXF0gtP++hzPC5cFtYnnFlPeHuzd8IFvSSsPCvetyavf4
	 3fBgzfPDqtpYkmsTDPk5rJ1K0X+XZOeYTRedprBfboHeGhUMGxdbH4e9UhCayAMKAp
	 xT6xsZlc4U9AA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C83383BF5F;
	Wed, 30 Jul 2025 13:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ RESEND] profiles/battery: handle reversed ordering
 of
 CCC and value
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175388340824.2311214.10480265808122323295.git-patchwork-notify@kernel.org>
Date: Wed, 30 Jul 2025 13:50:08 +0000
References: 
 <ccfa6652c4391fbc7d403f3e5208fa1cdfe983e3.1753814700.git.pav@iki.fi>
In-Reply-To: 
 <ccfa6652c4391fbc7d403f3e5208fa1cdfe983e3.1753814700.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Jul 2025 21:46:41 +0300 you wrote:
> Order of batt_io_value_cb() and batt_io_ccc_written_cb() may be reverse.
> This causes device to appear with 0% or missing battery percentage,
> because batt->percentage is set on the ignored update so the initial
> update is lost.
> 
> Fix by saving new initial value, if battery is not registered.  Also
> downgrade warning to debug message.
> 
> [...]

Here is the summary with links:
  - [BlueZ,RESEND] profiles/battery: handle reversed ordering of CCC and value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2c0c323d0835

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


