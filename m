Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18F34250E;
	Mon, 23 Mar 2026 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294816; cv=none; b=hjmXEqBc/JYANqk1Ror+aKIMobV+uYv4nxI2qFeeViJxGAtdk1xXiggEGBrZqJia50XoHrsDJI7XBgL2MWKBw7Q0YM/QTlrrrRgu1xpD/sOcAz86l3RrZ0YNmxGToznFKQthvqZT6nT30LRMWKsik2ltI8VbslfY8Bb35Nemsto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294816; c=relaxed/simple;
	bh=FPMnHHMMhSjVZQ9FOiAxl7DfnBdDI4cqV1mZvGeJWog=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HPdVGUDGSJB2GE+k7qXHlHVhIoMKDnp79G4VsMK6cLff/hNX2hMj7t1whzpB9Ah+Bfzgk3cE5tk225Vd+MikjNUcx6ofTWM0js98nOMUkQcx5zyciOWs4lsNGjJcmCDMQX+xL7OHUxptfQb0gO3bvrX9ELKPnsOXkTUv/KDot1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIC05+KS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIC05+KS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED27C4CEF7;
	Mon, 23 Mar 2026 19:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774294816;
	bh=FPMnHHMMhSjVZQ9FOiAxl7DfnBdDI4cqV1mZvGeJWog=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pIC05+KSFrH26zJtgjpERCFxR/4cmf1PyB1LKNc/vVYCUiUVIuuMaeXelSe1Pq+Qv
	 fk+6viVU1a+o+/FRQy0xAjdNOGM3ppn3bZZOqYtyZRIx1kMipuljP/M+AIFUPLW4vQ
	 bni/8UXbMjTL7ecsC59uJL+BDFgqyHygjBKCl7qOcr9v1hazlGCWPSVWgC2QZBCu+L
	 LG93i8taZM9+uoLi2uiPmOJhFGjUhMnJfzWUVlCnhk8gwb22eY4pUnPukWA0QWR2LO
	 nNUJaFw1s0ltX0NRFqKkbg/dRsvki7U6hux++PQcXs2v7j1vtLxk8/mDujb+nwU3N4
	 GoqCQE6D3zHug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EFC3808200;
	Mon, 23 Mar 2026 19:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel: serialize btintel_hw_error() with
 hci_req_sync_lock
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177429480454.286640.1327011057867905497.git-patchwork-notify@kernel.org>
Date: Mon, 23 Mar 2026 19:40:04 +0000
References: <20260318125403.3135972-1-zzzccc427@gmail.com>
In-Reply-To: <20260318125403.3135972-1-zzzccc427@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 18 Mar 2026 20:54:03 +0800 you wrote:
> btintel_hw_error() issues two __hci_cmd_sync() calls (HCI_OP_RESET
> and Intel exception-info retrieval) without holding
> hci_req_sync_lock().  This lets it race against
> hci_dev_do_close() -> btintel_shutdown_combined(), which also runs
> __hci_cmd_sync() under the same lock.  When both paths manipulate
> hdev->req_status/req_rsp concurrently, the close path may free the
> response skb first, and the still-running hw_error path hits a
> slab-use-after-free in kfree_skb().
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel: serialize btintel_hw_error() with hci_req_sync_lock
    https://git.kernel.org/bluetooth/bluetooth-next/c/b8982b6b9815

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


