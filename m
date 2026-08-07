Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68916431A22;
	Fri,  7 Aug 2026 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120251; cv=none; b=Uyxj5Ja5UDjAYLySd4Ah/HwdG/DKzKP1fMRNw4699tUb0jciaKaj+efV4jTK4ai488W22HLjr6vE7lvDAGj9TfRN7LEG2b1zjkGHgJT44UsqOinp9AJIkbWsvw0zhn8bPL1lPa0H1sT8kTN4UUdE0jXiFg87RpTw8fnTuC2S9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120251; c=relaxed/simple;
	bh=5U0tO2O6diPenFuV9RPUUQ3iVzExoFiqMUsnygvQrCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n0E19ZC7tgkDdoRVvIG8tsat3W/FR+qk445q+yDoghIpN5dUK20XN7oVNtVAhk2ZTtBWWt3PEibBRFlp1I34LZbC7VTb7oMmKLQnt/Xad1qhBSeTlO6/NVNvMwjC+HBuH16VinqA7LaUBGupoPQF49/uRVNpULpd8T0bDSA/3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzxcJ7v2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzxcJ7v2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C8D1F000E9;
	Fri,  7 Aug 2026 16:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786120250;
	bh=xf7bIefK68zTcZNgSP9NpCRxp9fLSxB948X+5p+GfEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lzxcJ7v2occE1v3UJoDOXMjfWjB2Q8IE6EElOloK9IWkHHRvfZc5N1FcyHdOx93bV
	 qmzRwXk35kelTrEC+Ai41cqhbTahazXRQ+OreQ0VWf5DpCw4fx5sIZ6kBJQ8Qm0VJv
	 kgklF104zX18SdqVVUB3xp3rZfnJXgNeb5Eq1ZdrAWZ4W9XtJPhCG2IJvyekllHdWW
	 zit2yXcwvju+VEQ9tTduuJtzLFxTy5HCE5p9WzxNbiH4FOcj3/uN3iTnD10uvKt4Fe
	 FP24GTyRm1OR980+kgXhmP/8BwLxL6293JqqXoDnR30v1qhkLhINQCSfU8FxIOBLlF
	 yvwRKxTE2wK1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19843380CEE3;
	Fri,  7 Aug 2026 16:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_event: fix out-of-bounds read in LE PA
 report
 reassembly
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178612020889.1887768.16877650332160888837.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 16:30:08 +0000
References: <20260805173701.6649-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260805173701.6649-1-acharyalaxman8848@gmail.com>
To: Laxman Acharya <acharyalaxman8848@gmail.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  5 Aug 2026 23:22:01 +0545 you wrote:
> hci_le_per_adv_report_evt() is dispatched with a minimum length of
> sizeof(struct hci_ev_le_per_adv_report), which only covers the fixed
> part of the event and not the trailing data[] array:
> 
> 	struct hci_ev_le_per_adv_report {
> 		__le16   sync_handle;
> 		__u8     tx_power;
> 		__u8     rssi;
> 		__u8     cte_type;
> 		__u8     data_status;
> 		__u8     length;
> 		__u8     data[];
> 	} __packed;
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: fix out-of-bounds read in LE PA report reassembly
    https://git.kernel.org/bluetooth/bluetooth-next/c/96995a7d94f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


