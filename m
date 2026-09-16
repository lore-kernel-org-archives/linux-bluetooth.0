Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AB3C9EDD;
	Wed, 16 Sep 2026 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581087; cv=none; b=ZSzgVEEy0x6iMZfpvxnBiP1KGS6HDdso04uDc2ZRfX5oIXnbxmJx16dGH2eovHkPwgEHGJjq8wiRYyL5d056yoyhI+pWhORocjC4M+VA+nLl9fHo9GRud5ou3Rl3JlFjBVQJ2PTItGboJ5CsBNWrix9x/0zfWHzMo+Yz4HOsTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581087; c=relaxed/simple;
	bh=aBaGSf+D0I/u+8YfDf+vVHndixbAFKj3A2TR/qNWd3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R0aDGUXo8a1tvG8NpGdPYxMBny1+sNiv3URf63nz5jHuWy2M0mhQhrkznWPrX6qlU9wqAodnNbAI5651C/Vuqjl7mewTcuPJd7SziWpIpB7R4cBu1a7Ewc49YGY0KbV2vn4t3i0WnvIUoiKidCdE0J4noM+t852MYDQw4113d1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giKIyxaz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giKIyxaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B841F00893;
	Wed, 16 Sep 2026 17:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789581070;
	bh=BusqgFyp4HDXzBsDjjiHh7dbJ4mV+ijWlKCMGBRyzS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=giKIyxazB9UK/t1yZRG2zh7BHgklL3GA+PaEqRnSc9sObzJuLMBJwUdLd4A7HlBZm
	 FZo3skRtOChCdJazsnoy7PePrvzUnFZ3af+NN9hO1yhUGtwjAzILGwXeyJmoy4Df0p
	 7hkkviQQvLKPyyr9MzTCQf8xKcez4CIH4bvDnPGfw8gCLyscfUkTes2ZJX6dbjdjKV
	 S/47E6OtLKS+tzpPCoTFyxxvWJR7cgQzGcr6BWj8FjTvXHBFl6/xEi1LwYmRaUq2dy
	 LYQII+eqw/K6KCxRWpoAQRvcA6giZUa3g+VZ2qcns34rW653Pd3b0QKmszlgNSaHce
	 BimG7YJ5JndEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1988039E8A4F;
	Wed, 16 Sep 2026 17:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync
 entries on cancel
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178958100488.2773127.14367630218893812181.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 17:50:04 +0000
References: <20260915120823.3460208-1-lee@kernel.org>
In-Reply-To: <20260915120823.3460208-1-lee@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Sep 2026 12:08:22 +0000 you wrote:
> In send_cancel(), pending mesh_tx objects are removed from the
> hdev->mesh_pending list and freed via mesh_send_complete().  However, if
> a mesh transmission was already queued onto hdev->cmd_sync_work_list via
> mesh_next(), the queued entry retains a raw pointer to mesh_tx.
> 
> When hci_cmd_sync_work later processes the entry, it attempts to execute
> mesh_send_sync and its destroy callback mesh_send_start_complete using
> the already freed mesh_tx pointer, leading to a use-after-free.
> 
> [...]

Here is the summary with links:
  - [v3,1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel
    https://git.kernel.org/bluetooth/bluetooth-next/c/71af682ba469

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


