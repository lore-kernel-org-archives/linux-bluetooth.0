Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3794749D1
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197466; cv=none; b=V9AU5Q5ON1mB+TgKdYlvZNPTvgY5JpsJUihjUju5ufas7ArFpIIi2c99pffHejFFBIuNRPmfNM7JzOiIKjD71HaBHAh8jGAj5V0qlYj5v9ktSz3nlNSnGh93BxGNl12BEVbPfqUxyhODNq9R9e4Gsa70nl70erFkL5wSmGZIQVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197466; c=relaxed/simple;
	bh=EvgamTSQb5g7GVjBpmUbAon6IV0/zm+RLA3Ghs38vaA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=elKQIpZwxHkKlA8JD1eRfO0AYL8VMaJl4gDJffg/UUJaKZTtHq5v4a9tgU6hN65RFkD6qQBZmrGGvAPzsDtXmgtN+Ba3dB1sXg2G1gqn/b4WnKiol2On8xaH9/OvqlGSXe3dueQcOScqtMfdXF4NEHvt2bC/QT6/0znij9tAilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv6/mPpX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv6/mPpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCFB1F000E9;
	Mon, 31 Aug 2026 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788197465;
	bh=KiQ9InI0jiWsVThduKxpOEOyTwl03V6Yx6dba9WAhxo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Cv6/mPpXz431YeICLj8xHpJFg6pCIownnyEka/e+1bFGN6RpH9V35YewXVx7oWB9q
	 BcJAuTclskt7ZA4X49f4nkWcdbzmpiNjfZWyvITrZcxnsVm1FbnJtC3ybItlp1zHYI
	 w2/76y9v/hDfLhIknUQJus1IigyeH0+RJnq/l3esq1oEL6MFlVlEfNXOiqSo5olivV
	 CJNieWLyofeI6uWlZ5xby3HdIT+h1yml/bmJNGSajymkxcV+IudtQRSLHgPyelBlSS
	 OIhmoSsxY1kHR6aujXMNhfQJpOh52qbfyuu6rd6Kf9o7NF7WqiCqrO0+rNKd9YRWKn
	 Jm9/UlT94nnSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B353924458;
	Mon, 31 Aug 2026 17:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] emulator: bthost: add function for sending
 raw
 L2CAP sig commands
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178819740813.676143.7012117251766286263.git-patchwork-notify@kernel.org>
Date: Mon, 31 Aug 2026 17:30:08 +0000
References: 
 <66d2971217dc632b10049fef7a5e9e735715bca2.1788119838.git.pav@iki.fi>
In-Reply-To: 
 <66d2971217dc632b10049fef7a5e9e735715bca2.1788119838.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 30 Aug 2026 22:57:22 +0300 you wrote:
> Add bthost_l2cap_sig_raw() that tests can use to send raw L2CAP
> signaling commands.
> ---
> 
> Notes:
>     v2:
>     - no changes
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] emulator: bthost: add function for sending raw L2CAP sig commands
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d52d9a173a5f
  - [BlueZ,v2,2/3] tools/l2cap-server: add test for invalid Conn Req on Ext-Flowctl server
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3a2d543c4c21
  - [BlueZ,v2,3/3] tools/l2cap-tester: test closing sockets with ECRED defer
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


