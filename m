Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6638DCC
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967581; cv=none; b=nKNoLTmMiDp0Qloce/+iaG7yXT+XUFgG+9iv3Yz2+LyjpxwIaQWkFqoXO5go5foSB0KYdLC9O8A2Mo5NYt76KcD97YDQ+zxFQ4BODhB4qkDvfbAoTFjhpbRlqqgDv1BXFG0kCYAJsBPsInPykQwWGHlExPGeT7Exz+u8U2gL54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967581; c=relaxed/simple;
	bh=bUZ6z0CBiAwP1i5Cr25xmev1V77zk92wfZMgB4+U6cQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cxJpBKSckiqTmOhc5vZeTaTXZVsQuf0U1VKxwxHev1oWx9tFKxUXhM7+6ZfXZU+Qhn3sQEdpS+GFa+WcPB3Zqykx3Ixqy6D3LMyy7IhoDkIK8fs2/w9YIsgdG43pSKdNPhJTyiTEkZGsupVugarHzBtaK/tQxSP/eCwlD/x/ix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlvadxme; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlvadxme"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72386C433B1;
	Mon, 22 Jan 2024 23:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705967581;
	bh=bUZ6z0CBiAwP1i5Cr25xmev1V77zk92wfZMgB4+U6cQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rlvadxmeVEld9ughvUZIflSzJ6K/wcaneBq0f6VXgTWGuwvV/paDp0WbbitiSxc/6
	 yBJvoVuRzy0do8zcZAkTGzMr2BqlDvcypqH+W1Hpg2Kl4b4L4vrioe7rbSoL7jSbQ2
	 e3Zy3unJP5Ug2qq6yM+a56csplOEcn1B2Mp6+5dyVJAbIGItdHS6u1Eu4mFZ4iwz3I
	 jZNIPNNIumzm1dKpvYhfcKCa3P8/NUvrVW1gwsCw4SQak2fQDLuuJqnBTfscpfNGyn
	 /tzp2SBIyDWn3c50hVHfRZLr+Hk1miUlsLsdHKsmv57wmv2muzW8dIYzLexMS39QOc
	 XHn8Z/dEDVEEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58EEAE0B616;
	Mon, 22 Jan 2024 23:53:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] bap: register all endpoints before starting config
 select
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170596758136.31397.10468517279033282903.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jan 2024 23:53:01 +0000
References: <447a1b2f472b1c0c83de357e1c8094eec73308f0.1705868192.git.pav@iki.fi>
In-Reply-To: <447a1b2f472b1c0c83de357e1c8094eec73308f0.1705868192.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 21 Jan 2024 22:27:06 +0200 you wrote:
> Register all BAP endpoints first, so that they all become visible in
> DBus before we start calling SelectProperties() on them.
> 
> This allows sound servers to know ahead of time what capabilities the
> device has, and plan the configuration.
> 
> For example, a sound server might select different configuration for
> sink+source configurations as opposed to sink or source only, due to
> bandwidth etc. concerns.
> 
> [...]

Here is the summary with links:
  - [BlueZ] bap: register all endpoints before starting config select
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a9d1f6f6a625

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


