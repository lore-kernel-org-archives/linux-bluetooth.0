Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68719B3DC
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515429; cv=none; b=fcx1k1tkZwqh60oaTiilFSDpCviPb/Vqtp5NC2JEIORNYrEGrHH/+YZjLtRlzQ91qZiV/7YVmylVzEZof6vIAm0d9Q+opunItEo9LdgVdNCaFTH42zKcuP2CdX4vdxLR1j5aByj6bcagWYGmttvhw5E3tunx310huGNDht5xNnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515429; c=relaxed/simple;
	bh=6PJ1PjVUL/qG4anM6w+XG4NqsnF2qUBKzRil25aQPvs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PGPZqyjtw0FIhsCZRsRgasVdh2WJMq9MJacfxGo61puH367ShRv8jq8VmhOoTx7a0GTl38LnwwB0WKmMH5+fZO2j0FLQbv8XuJSFYo7qef6+w15zflOFYWQVvsJR8w4xIFaBDKBhmOw0N8JUjK3/f8wLLTo5wCr9MlsC/ReNXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzlQbGFq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzlQbGFq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAC13C2BD10;
	Thu, 27 Jun 2024 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719515428;
	bh=6PJ1PjVUL/qG4anM6w+XG4NqsnF2qUBKzRil25aQPvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gzlQbGFqNd1lWOCi4sZ8WidroCsvjAjPqvpJUTrj6ya7pyWpX2hezpfvPZowiVP+/
	 eb5lT2MBZErx6eSWlWe+2xFmENDireV6nE1cPbFZitxTRMyGzY19G4ugcXzk4k7b7o
	 xPikvr//Zc1orphpQBIKS3ZrXPdPB9YBjQXMymPYbX4ECeEQD2EPJmdPklt3SeW6l2
	 vvZviMFT91YTzfGgJNOk4/K5Wbgcyd8uiPy3g4z7G0v5Ou4IcdM+O6sJ+M9gvuWZwv
	 wjGJLiDBb9ntWFHc53nrpbqtYCRS69qX7WwCMuBjBk6LJbzOTmQZ5i7Hxg9QArtrIS
	 40Cck9srLuGSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1E24C433A2;
	Thu, 27 Jun 2024 19:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_core: cleanup struct hci_dev
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171951542872.5140.17350624099829688055.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 19:10:28 +0000
References: <20240621130155.314280-1-dmantipov@yandex.ru>
In-Reply-To: <20240621130155.314280-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Jun 2024 16:01:55 +0300 you wrote:
> Remove unused and set but otherwise unused 'discovery_old_state'
> and 'sco_last_tx' members of 'struct hci_dev'. The first one is
> a leftover after commit 182ee45da083 ("Bluetooth: hci_sync: Rework
> hci_suspend_notifier"); the second one is originated from ancient
> 2.4.19 and I was unable to find any actual use since that.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_core: cleanup struct hci_dev
    https://git.kernel.org/bluetooth/bluetooth-next/c/e2b9428d33b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


