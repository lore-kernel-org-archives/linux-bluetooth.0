Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCCF1B372E
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158789; cv=none; b=haS9Pntuz75sOHhpsyH0rfidoDh+4Ts0Pc6btc/SwIR8U7JnRgACoeiMhCQlunUZus2phQ/ATkFkDz/cE3atPcMsrhyllk7qL/ysizFygIR2bTDS/bAfiZV6vUZZtfHw0x/uD+dF4rTbZbssz+eFPWdaCdlGYckDAEWVgWK2E+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158789; c=relaxed/simple;
	bh=rvmfAXue9XEPexrmFiuqA6PS0v9n2A3fUJ+HdrtGdyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eH50TewHCAIHLXhdF/P0Vocv0vMsJdEo3l2QJN62s5mcDV8OOfF4CP+w50xjU2NrsZhAVuB1nUltmMnjDhipMlU7mTACwOT830P1b9ADeLpwuIShtYVjZASfZTypxZ5gnIkgxgjihDjiYGlFajNjgWKTMsKPPNevCdlGHvOxSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNc76YrT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNc76YrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D7FC4CEC4;
	Thu, 12 Sep 2024 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726158789;
	bh=rvmfAXue9XEPexrmFiuqA6PS0v9n2A3fUJ+HdrtGdyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UNc76YrTxkyIsYzVbnWy7Aq4f93krrkokSftxRL8iWl5MobpAF13/eR6sUpzIOcsV
	 nvmaSZLyg1ZxIP1XcPy57bGka0N01zGPakRSyvp+FdXL5rX3veRsNuveI0kfcYcdJz
	 FgotCRcn927jUu/lYwSp55gQF2Hg+Cli7nKmQ/PvT2mxCCDTOkyHSx6mtncYsBP8s3
	 TClQtmEAWHH/zjid0yJOeiIzKJRlIQXXBa50iJNZr2fOvzbHm8hIWG42t7YuHQSnyQ
	 qh21tXzP4ZMCjrkzvR9Y7lrS5jMZvMyBOowt5bC+IKaxOhqhhrj0LqV6DM+bisN0Rl
	 DDH4RZ7Dlt0+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACAF3822D1B;
	Thu, 12 Sep 2024 16:33:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btusb: Fix not handling ZPL/short-transfer
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172615879049.1648954.9855587456525682084.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 16:33:10 +0000
References: <20240909205152.2397337-1-luiz.dentz@gmail.com>
In-Reply-To: <20240909205152.2397337-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Sep 2024 16:51:52 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Requesting transfers of the exact same size of wMaxPacketSize may result
> in ZPL/short-transfer since the USB stack cannot handle it as we are
> limiting the buffer size to be the same as wMaxPacketSize.
> 
> Also, in terms of throughput this change has the same effect to
> interrupt endpoint as 290ba200815f "Bluetooth: Improve USB driver throughput
> by increasing the frame size" had for the bulk endpoint, so users of the
> advertisement bearer (e.g. BT Mesh) may benefit from this change.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btusb: Fix not handling ZPL/short-transfer
    https://git.kernel.org/bluetooth/bluetooth-next/c/7b05933340f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


