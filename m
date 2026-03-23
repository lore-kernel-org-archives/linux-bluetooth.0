Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB2326D4A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294819; cv=none; b=GVlGlUdN6/obOrn3sn2lWs0ojne7Kja15wzrkUbP/Bp3T8TCmq2oxtSGYKq0UsiTUJLSUsM1bC0gGS9fC9PQPEMu7Eu1T+jnD1+VhRYTlN4YxLVmaKTheXqB2tmdu2pqlQL5Rc/HeZ7UQDv+GgHa4W/X1R027+yPXqGs78qOdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294819; c=relaxed/simple;
	bh=BAIMvtN/JetL721QlzpOqVYzxv2t3Q5Ap+JXzx8zrvg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h7yVv5WJqQfYoSyy0ZZAsD9XfJyHFto4jUo5WdKFB5DWdy7soXeAJRAua4LCi6vXWiTHz4lXPupuC9ytIQ/NjdkSCyfDZyQAv6ORrIl9hOZajpUXtVR1Qrvcn5ZJNFcYo1mEPB05aE0D/2xAd10Op9aWHKtHAvEj47X0RqaVMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtV/Honj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtV/Honj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86F8C4CEF7;
	Mon, 23 Mar 2026 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774294818;
	bh=BAIMvtN/JetL721QlzpOqVYzxv2t3Q5Ap+JXzx8zrvg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TtV/HonjQZ1vx6wi+9u//M0RDOPJ3AW66JxZozVzxBIaaHQ3aghQpYgEGQkuCxM+7
	 pDpvZnRNI0F5qt2PsI/tjK6VG0bkTnK0CAEfka2aXym4RThqh73LOM3CVZQyVtFYB6
	 TVz/KoEkBVBHSbW6cQ+I7AWPjr4EBEqtkHueTQL1h5yCtqfvA1TJmAkcC5HcIb/DWr
	 2RwzP1bk3g7ufUXCN6hK02i5TkHm3m8MLLnec+Ce9R79eG/c3v30ZF8LDgmiFJGT1h
	 YMUsyLo9l1kXMKSDOavc6VIz3REaf6LBDK+a05kbXrS0JdZKAOhJ7RK/sThm1H4x/p
	 rTTJbnqOEunTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE3C3808200;
	Mon, 23 Mar 2026 19:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177429480703.286640.15279296470802604075.git-patchwork-notify@kernel.org>
Date: Mon, 23 Mar 2026 19:40:07 +0000
References: <ab0pBlGrvw_SHFwB@v4bel>
In-Reply-To: <ab0pBlGrvw_SHFwB@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Mar 2026 20:01:26 +0900 you wrote:
> l2cap_conn_del() calls cancel_delayed_work_sync() for both info_timer
> and id_addr_timer while holding conn->lock. However, the work functions
> l2cap_info_timeout() and l2cap_conn_update_id_addr() both acquire
> conn->lock, creating a potential AB-BA deadlock if the work is already
> executing when l2cap_conn_del() takes the lock.
> 
> Move the work cancellations before acquiring conn->lock and use
> disable_delayed_work_sync() to additionally prevent the works from
> being rearmed after cancellation, consistent with the pattern used in
> hci_conn_del().
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: L2CAP: Fix deadlock in l2cap_conn_del()
    https://git.kernel.org/bluetooth/bluetooth-next/c/f6bba07f059c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


