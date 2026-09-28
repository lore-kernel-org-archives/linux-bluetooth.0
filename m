Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882004E8DEF;
	Mon, 28 Sep 2026 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610103; cv=none; b=BCK3oUc/dpCej900kau0M/M6G5qz7AjHvxhxd8G+n/NvaQWaCH6azXpbP56pjvM4IzlYS2LcEGA3wWyHghWlNhrSXJoeVSe40Xh+6mOG17AbXbkyHooFxX4fVPo9s/ncr1ei4KR1tSaUCNiFJXRYtNUzemqbijf0uBrio7xVJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610103; c=relaxed/simple;
	bh=/O8MJ+KtFD+tp3Laag1ss18qdwH8pY4PQBI7lgU66HY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kn/MWcq+mn8S8g+r0bfkrtW4y0ffK4sxgnMXAKtSFJ2+fMvtNOJcvNvo4r5ZOsYHhlLPSWDfHYntStF2fVqg19DenRjNrfOfPbhXfTLisFHRi8T1Jcibg0hXC2N1npnOv24iarv8EtX51y+v4yRkAJ7sGoNV67jVzjA1s2F+yEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD5qhPpx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD5qhPpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164A11F00893;
	Mon, 28 Sep 2026 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790610101;
	bh=8k3C2uZ7kozzIMJnNJysOkdL40fx7D61GFFInARuLxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OD5qhPpxmQJa7xTlugPN2SMqkJcsoSnmZjfPLIT3kkyVh5BwXu1vobfJRm3nt5au4
	 1TgVkKzz6bw3lBaff7ZJ6nnAbwH/kSqf05ldSMbIPJx98NJGhYeZT1SQ9u5hnPxPCl
	 0pVnA9J3MPsvZsYr8zZBti9Mz7VyDzVds0Zv/hiDaxF0uHaMzYPQ4fZ1LuN8bUKeuC
	 /t64FfpUODW0pcc2SDNVyoMPAdeKstOMoNkXOOmQlSzkE2vMJOwYIG8sKyoUVE3iy8
	 xjBhWbo/H6VesvGTBXWb6/PRh9qLTPtpYY/aGPgPt4Dc34aYI3IsKZJJmu5DKrCqW7
	 2yb9qmTL5NF9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199B83924456;
	Mon, 28 Sep 2026 15:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: add ASUS 0b05:1868 to QCA Rome quirks
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061002563.4169639.12709606415672221829.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 15:40:25 +0000
References: <20260928143655.22223-1-qstrydom0@gmail.com>
In-Reply-To: <20260928143655.22223-1-qstrydom0@gmail.com>
To: Quentin Strydom <qstrydom0@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Sep 2026 15:36:55 +0100 you wrote:
> The Bluetooth controller with USB ID 0b05:1868 found on ASUS
> systems uses a Qualcomm QCA Rome chipset, but is currently matched
> only by the generic Bluetooth USB entry.
> 
> Without BTUSB_QCA_ROME, the driver does not load the QCA rampatch and
> NVM firmware. BLE scanning also repeatedly reports:
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: add ASUS 0b05:1868 to QCA Rome quirks
    https://git.kernel.org/bluetooth/bluetooth-next/c/949dedf5a511

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


