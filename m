Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8836F8F5;
	Thu, 21 May 2026 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377415; cv=none; b=EcL1+gYv15bT4OvlIMGeKdK6e8KVXMp0Xx9XA+pq1vqSSCADgeFFFhSnB04LYx7vdkAZJqZmZwzzh7Kxew/rRfi62Wvhz4NBWvWERKx0TCIzzPeARRwgXI6EaGt38ELWACj/2/rMdrdVTh/xP7T5EcWNw7cmD/YzyVVA7+50lSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377415; c=relaxed/simple;
	bh=Xt1zZq3r3Y+3w9pyyBVWNbEaBEfqUzI76HeylYwNr3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r8W8PRY3c1f0T1QzNDaer6QWcUk8xCvCBpPwqrKIfVYJy3GNjIuNEVmai2dU4QQqUgJiSAt6zSAZ6zJ3C/dnblkhARHkKgg96kfLPc4vOB6rkaZ30t4YvEI9g7p5N4RFJcXqc/mbNFDV2ii9ODxpZDjyj/6U7qOcrG+zMJ1wq9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8YilHv5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8YilHv5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3D21F000E9;
	Thu, 21 May 2026 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377414;
	bh=L8ULRN7UF+uHyi87WtkpbAsGNU/0ErFYzfMwPYqF21g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A8YilHv5j9q5YrK2eYnf+mWZ0ewMnwigD9g9QN9DcXMxg5QOctVJsAiVmcotMlfIF
	 ysIvNNdAFpZ27itgFhQw8VdsAENG5+YQWKirP5FVLiHzbAObJsSmFDzWuRHYDb8dqu
	 Xm+7Vv2B8iDpNnkKwKBfble4cpM6PEP6Yl8errJRFDO4XKPkiIuc1xt+xe8RYPY32f
	 kyQWVbXwSnRs3onwlXBEnTls5qhy4Gi1j1c/1AhCRG7i9+lLer3nZCvgPY6Iduiaaz
	 U0+X/RY8WSDV7U6WviPYdJb4FLpX1PXSNpqH6vYSvkSkOns6QOZH2zAjIAhTPMwZZL
	 ++eDZVHpqbCpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A243930E02;
	Thu, 21 May 2026 15:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix memory leak in
 hci_le_big_terminate()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177937742413.384060.3222345140031912120.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:30:24 +0000
References: <20260521080414.44460-1-jhapavitra98@gmail.com>
In-Reply-To: <20260521080414.44460-1-jhapavitra98@gmail.com>
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 marcel@holtmann.org, johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, yang.li@amlogic.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 May 2026 04:04:14 -0400 you wrote:
> hci_le_big_terminate() allocates iso_list_data via kzalloc_obj but
> returns 0 without freeing it when neither pa_sync_term nor big_sync_term
> flags are set after evaluating the PA and BIG sync connection state.
> 
> This early-return path was introduced when hci_le_big_terminate() was
> refactored to take struct hci_conn instead of raw u8 parameters, adding
> PA/BIG flag evaluation logic. The existing kfree() on hci_cmd_sync_queue
> failure does not cover this path.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: Fix memory leak in hci_le_big_terminate()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6dbf781d0885

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


