Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ABB33C186;
	Mon, 16 Mar 2026 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691213; cv=none; b=rbvl1uuAgGKtw+/IEMmkfaqhS27dHCvGNDyJDvn6VpSADElHz5hjlhZiQAzMQwd9sOC3yyHftCzeumbsDGHsjTpfHTUNhzMQbiYzx8rYQC/yJjwNPL/5DFlrjIRfu/VfCSCqod7cle2T+VyzHyMwU48n0p2sYH9EUVak9P8jy2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691213; c=relaxed/simple;
	bh=rquHN782Rf8AmvqGmFAPDpe2uEcRKKliDoY5o7zT78Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dR4EQ48x1ZhPCf15EXOUyM45f63L2vDJGssiXkQpElg8jR4g19tOWptrwF41++6BuPEnRVlDXBDPbb9tC4Oo23sYeGw/go8s1uMG8wzvniaSzc0KDnmx2TctVvDQvnjEbe67YsycDv9OCfwAJPYtWMnHln3ndknZNjkqoYorLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji1XGFZp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji1XGFZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2272C19421;
	Mon, 16 Mar 2026 20:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773691212;
	bh=rquHN782Rf8AmvqGmFAPDpe2uEcRKKliDoY5o7zT78Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ji1XGFZpPSvQ4qc0MKgthVkIvQB43AdAvyNSWXsbLKtPRCTGclqHXiQUaznUR4Hmp
	 TL8tO4XHTRyzMCVTPHjoBnhSCb11M9GBRjXsTwJ3+uUiEdKz4CWSeroVnu0Agvo83K
	 9ZTsQNCjAkk5b/QSDeEmb0aPcJLjRyxh6UuEw0CDrFWleR8tjJatUupx0L4zupYzrZ
	 v7KcQme7j3FTkxxfi+hWTXDntVo9rbyghh6bU9KUnSdvSm/YyNhp57IB6TiYLYJ4rt
	 xUjAV5Q8W4yj6Srsf8MhyjMw4iaO+Z5qweai8BfblyW1sWA4/DHxoIllEr9/6Q8Yya
	 1KxerIWpRZwgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E093808200;
	Mon, 16 Mar 2026 20:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix stack-out-of-bounds read in
 l2cap_ecred_conn_req
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177369120578.3291233.15271468216916348318.git-patchwork-notify@kernel.org>
Date: Mon, 16 Mar 2026 20:00:05 +0000
References: <20260315131437.10890-1-jacob.park.9436@gmail.com>
In-Reply-To: <20260315131437.10890-1-jacob.park.9436@gmail.com>
To: Minseo Park <jacob.park.9436@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b7f3e7d9a596bf6a63e3@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 15 Mar 2026 22:14:37 +0900 you wrote:
> Syzbot reported a KASAN stack-out-of-bounds read in l2cap_build_cmd()
> that is triggered by a malformed Enhanced Credit Based Connection Request.
> 
> The vulnerability stems from l2cap_ecred_conn_req(). The function allocates
> a local stack buffer (`pdu`) designed to hold a maximum of 5 Source Channel
> IDs (SCIDs), totaling 18 bytes. When an attacker sends a request with more
> than 5 SCIDs, the function calculates `rsp_len` based on this unvalidated
> `cmd_len` before checking if the number of SCIDs exceeds
> L2CAP_ECRED_MAX_CID.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Fix stack-out-of-bounds read in l2cap_ecred_conn_req
    https://git.kernel.org/bluetooth/bluetooth-next/c/6ec1f2e822b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


