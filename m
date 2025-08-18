Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0CD2185A8
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755553195; cv=none; b=B/euRe6aSLRqabgdn9+WjiKCYUGyJDRAwUnKlpxXyZNQyLUnOGDiTaV9J0+lsPjJVGc9K8pm8oK0DDgmhiFv/v09OVFJscDzcsSj4xdfifyHywK1AMxJ9oCCdkzal2C6QaFt/EERYNYScG95BTNBXWQzw6RTxzRR+f4WgiJdTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755553195; c=relaxed/simple;
	bh=yvujlWpOzZbdobptaucQekDK5fM0qb+iQRjSXwwqelQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=amchV4fOB4i5+IhueHKma6wBfwr0OuVMI7+Jg1KOLcfOKySOva32d/MjzfCjlVhGRR2NdijgvG1/wMNvNu9p20Q3m2lQkLsiyis0iyfKgaYFBewV8HMZMzfLpy/Qmt8jgvhmJh87W67uqznMwuSyWfW7rQdkhBqQan0tZ8Rcs24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzYZI6KG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzYZI6KG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60982C4CEEB;
	Mon, 18 Aug 2025 21:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755553195;
	bh=yvujlWpOzZbdobptaucQekDK5fM0qb+iQRjSXwwqelQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SzYZI6KG/NQomorjfrD2l6oxaw8x2r67Zu2rAi7JZAyK0sigCfwcCzLGFEb58s0Yt
	 YazBbXx0guII4Q65Ez7DMU0euOM48pHu5xCBwMXIcQ7dSMa4kAao003idAZyG1/nOa
	 eHqG50VWi/l4/3p7700OoNev2nvCcte1RF9A5lRT70vKMDiih465eFFOG8pqvN77d6
	 QKUJZyPh0V8Zpzmw2dWqiMVUFp0P6HVYPkNhDrakGaOwn8ADJaDm+2SeZ51Ixc8iHk
	 5BB3yEKrPVzMwSBUjhqEV3/OU7CtwcQU0BDBiz24cN87rcE47bg3ZR7pl2yRbuKrLF
	 opGsSaYpVrqEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF33383BF4E;
	Mon, 18 Aug 2025 21:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] transport: fix A2DP Delay values missing from DBus
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175555320551.2921497.4085203346902965611.git-patchwork-notify@kernel.org>
Date: Mon, 18 Aug 2025 21:40:05 +0000
References: 
 <b2fba95d658c75135f0ee7b4bc11e193be126622.1755334561.git.pav@iki.fi>
In-Reply-To: 
 <b2fba95d658c75135f0ee7b4bc11e193be126622.1755334561.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 16 Aug 2025 11:56:53 +0300 you wrote:
> With headsets, a2dp_transport::session == NULL usually until stream
> resumes. During this time, delay_reporting_exists() incorrectly returns
> FALSE, because streams corresponding to NULL session cannot be found.
> As no further "Delay" property updates will usually arrive, the property
> remains missing even though delay reports have been received.
> 
> Fix by setting a2dp->session when processing a delay report, if missing.
> 
> [...]

Here is the summary with links:
  - [BlueZ] transport: fix A2DP Delay values missing from DBus
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0bb66d3d1abd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


