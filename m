Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9B3DA5B8
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070208; cv=none; b=TXe6xWiLnmoSjldjbt4rnjtjOYrE8/79N4V2aC1Cct5JOzCP07bImPraAcT7MID6KTTF44eN5+cEH5S47Z3rft700WwTiXt8Txm8YCbszHvIrPz5+hYF+CVfG1dk1uTn99C4S193/xShwt+HjJjoYAOLamO6SIRrENJZu1DMbvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070208; c=relaxed/simple;
	bh=5JedWbKP696fcAfuoVEjdB2fOxt7IlvLMbuKX8FTeZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kIGogoL2uOo2kYJGJUtJELBlIFtK07VjDiiPRxfPoQcK/1+wZF39i18J7F3dvao2Rk0/8+a+ygXemdWKgVuK98Bk1IsTgSq0NiUPJLWMIYhMvFXgKOc6TGpnpo/YuT+VFnoAcuNaeERNf3j2pSUXZbH93k71KHktkchxcrJIkPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTzQT5n8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTzQT5n8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B1DC4CEF7;
	Mon,  9 Mar 2026 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773070208;
	bh=5JedWbKP696fcAfuoVEjdB2fOxt7IlvLMbuKX8FTeZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uTzQT5n8nkokjzrxKgD+PtTaJiHnvl49qiHEiUCHE8LtlPg1OD4aNz0MrrORL2c3b
	 D6HlU773pE0Z5kuFBhv1tQLMCEEloaQyNAb/MkFJHzLfaSgGwZBgiEC3knMJuZhAKT
	 2YipzmegLP26gy6C12TWz6YTKbrdYhdh0zvSRmbYoYPnl1t8PlJB4PS40dZKGfeOMs
	 vgub4E3VLioL54ot4vG6wXIuSYb8gJFPwVNoJr5kusdweNUiNUE13/cOHJWlK+8gpx
	 mg6NSHlb9D1Ym/BDSQevFS64L1SlnT+Fcfqbmu0IrxxYUzf+YDCLu/JJnK1m1bFSEA
	 gXE1oMJQ9L+FA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F5E3808200;
	Mon,  9 Mar 2026 15:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_unregister_user
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177307020555.1274518.3723050232613054153.git-patchwork-notify@kernel.org>
Date: Mon, 09 Mar 2026 15:30:05 +0000
References: <20260306210427.703454-1-luiz.dentz@gmail.com>
In-Reply-To: <20260306210427.703454-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  6 Mar 2026 16:04:27 -0500 you wrote:
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> 
> After commit ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in
> hci_chan_del"), l2cap_conn_del() uses conn->lock to protect access to
> conn->users and conn->hchan. However, l2cap_register_user() and
> l2cap_unregister_user() still use hci_dev_lock(), creating a race
> condition where these functions can access conn->users and conn->hchan
> concurrently with l2cap_conn_del().
> 
> [...]

Here is the summary with links:
  - [RESEND] Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user
    https://git.kernel.org/bluetooth/bluetooth-next/c/99940a6c1ebe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


