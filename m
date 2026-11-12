Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514807;
	b=iLwzg9rsoeFdjo5XNqAdeBOw3uoGjelRl2FGcdmYu5UtO2yjK0Y5KU1kgUQpvnACyRbo
	 Dix2QRWsEBdI+6oNwA6FELjBXzVgXq2NEy9BpBdrYZEmnXo+PZzQcDjExwcHJwoyNBDqP
	 IkeTBe3V4d1Xd1fzTUjg8eQpYbvpucDMFAg3z445+V+so5Law3v3a8T7MDMMWb2QKIXGP
	 pstFXqgSf/25Q+qUpX0b4LH5v/U2m3uEKjaozRKF6muPrOlAvR9O0gMVx5+RR6wilv3VX
	 UT4htl48H3L5Injm+myS3Up8B71tY39ukKEgMwt5hvioXGc1o/ekKSmMqvLbO6yExfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=AuIrpwqq6b9D3mRoevwFLaylT0YExLcBIQSkTN6KrGU=;
	b=S149O2Ayd7jB/ed3cNoXK9kKkC1TFonn567Mz74nsRcG4Kf7XP1Ww/tSTyvEmFKWkHrN
	 Ie6CgcDNptnT7/THDi7XY8jPh7yLq0NR6pNclcl7bdOzVXT4Jckgf+0vf8yFIblCegb2t
	 m2Sj9Dy85VFx7U3cs3Xh5xDcJ/wgrjYbO+AFVX6Aw/4cSah8g6CM7eWkPvYJ/p7iW2+UQ
	 lInFpu9hbN0heY7ZO0TxzVIxeK8VAJc2Hhg0zKf7t2t9o7rD3+QcGoHNiSplGSo0kJX5J
	 EM9i+LBdJ5Lxfws6OxoIRbVElS00Jh801jl6GylDQ1mUSydTiPRAHqIzXxkukvBxMZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gG2TT/RS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF6E606A335
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gG2TT/RS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC391F000C4;
	Thu, 12 Nov 2026 20:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514807;
	bh=AuIrpwqq6b9D3mRoevwFLaylT0YExLcBIQSkTN6KrGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gG2TT/RS9YxQevP2jpqjn86Bas0ckexdvK9cLkso/vMand98Y5rurss8c3PlW3Z9C
	 VEebSt6qv4nuxBP3a5rlGXHEUL9teM0GW1XJwjAqa0M6JSqng5GoW5VKZizV0q2QeC
	 KsOWkxLcUHBoUxgNbRZ9M8ALSInT2dFwpLr4S6D7bJk7SUiGt8Mofk9v4is2WrA7RH
	 gJLChqqYdZVZFSWpNJFP7fK/Fbqb3t+ASN7ngKBCGJWI2/oQTJr1PUrStMKR24yyAX
	 zzJgQ1NKN8Cn9yRnLoL+0gMjl6M2P6IaU5+Rrt788+8ka6rypDHHkLNSQ5R6EB/GJ5
	 +wsh45VQfqxog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44273926259;
	Thu, 12 Nov 2026 20:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Drop the command's sk reference
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179451480627.628769.17407039026686649697.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 20:20:06 +0000
References: <20261112033428.898540-1-weihong.guan@gmail.com>
In-Reply-To: <20261112033428.898540-1-weihong.guan@gmail.com>
To: Weihong Guan <weihong.guan@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Nov 2026 03:34:28 +0000 you wrote:
> hci_cmd_sync_alloc() takes a reference on the sk a command is sent for
> (sock_hold()), and hci_cmd_sync_complete() means to drop it, but looks
> for the sk in the response skb, which never carries one. The reference
> is never dropped: every command sent with an sk leaks it, and with it
> the sk and a reference on the bluetooth module.
> 
> The commands sent with an sk are LE Remove Advertising Set and LE
> Clear Advertising Sets, for MGMT's Remove Advertising and the instance
> removals, and Read Local OOB (Extended) Data. After each, the module's
> refcnt stays one higher with no socket left open, and the module can't
> be unloaded until a reboot.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Drop the command's sk reference
    https://git.kernel.org/bluetooth/bluetooth-next/c/f3183d7ad101

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


