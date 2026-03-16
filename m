Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18FB22D792
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691212; cv=none; b=McJCH/HjS1zQIWj/BdbyrX8+qZj/6PCB169z6+pvs1jrV4qtvYZyDLPpAvce8GmTRKURatoVPJTAjw6tHj/WiOiVO+M4DZTewQPK24LIxZGYqs9QimfGNiwi7bVfQQGXXOevfsskVStHtAsBAcyileLFXZNdeNSUDYBoaLfKdvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691212; c=relaxed/simple;
	bh=TZ6ACp0kacfzjMHAWYe3H4fUR7rfTnSrmjUvjGj1bbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m4bCM3e7SBBHKQLR30afI8DwZTQ6CfSAsGjliL5AScAXoxbszOhxEe8iaaLw1u909uaCGxnYyJcXUtRhhoHsr5ptGmTNDlA2+L4QE2Tg1kodoC/ZV46NZwrP+rDn4873qJCe7AlHPfY39Z9SeaSK+ZUa4aMX8T/V4kIvjfu7Sek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRpvl1YK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRpvl1YK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A733DC19421;
	Mon, 16 Mar 2026 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773691211;
	bh=TZ6ACp0kacfzjMHAWYe3H4fUR7rfTnSrmjUvjGj1bbo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MRpvl1YKgQ+o6K4Ngwg+08yR95ozLpPGOEUCSHaTHmo9YlkEE+YgEhHvemhm2MBdV
	 88Im3Mpq8HZSAVDuPtOZdHW1Wh9W33eNew3NU3gyvqB0ZwTvJFR9mmbt13vUi9rKU+
	 9sMbE9SUnOLIBckvw4tm2PwSVgUER2AUMg+E5bnMD9Nas8dhG6QAzr+qYrbWtpKb7P
	 hV1Ywdo5jrl3dJa5lmxUPzCJsjZebFbqDd4QOdfae8KIXBmhrPGOwBTpRqO4O6SK/6
	 snizSZwLm9hcfdqavW+oG7ywGRc5Jp3+EylFiJWBXZGxrWppP0uaKOnbp2uQA4yk9v
	 cl6CwLar6Ov+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F263808200;
	Mon, 16 Mar 2026 20:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: SCO: Fix use-after-free in sco_recv_frame()
 due
 to missing sock_hold
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177369120454.3291233.10300551913850448433.git-patchwork-notify@kernel.org>
Date: Mon, 16 Mar 2026 20:00:04 +0000
References: <abMhaMILH0Db12LU@v4bel>
In-Reply-To: <abMhaMILH0Db12LU@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Mar 2026 05:26:16 +0900 you wrote:
> sco_recv_frame() reads conn->sk under sco_conn_lock() but immediately
> releases the lock without holding a reference to the socket. A concurrent
> close() can free the socket between the lock release and the subsequent
> sk->sk_state access, resulting in a use-after-free.
> 
> Other functions in the same file (sco_sock_timeout(), sco_conn_del())
> correctly use sco_sock_hold() to safely hold a reference under the lock.
> 
> [...]

Here is the summary with links:
  - Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold
    https://git.kernel.org/bluetooth/bluetooth-next/c/506c02824131

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


