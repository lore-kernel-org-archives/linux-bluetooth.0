Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC73414420
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003928; cv=none; b=sobFDhXgzi9+56ejjpjlTvtN6ukgCj20ujOrMqJCjr9yYN10A+ZcAjatLfo7HcjHKDUcg6LQIrLJlckqwOo35DFghnb/hG5UXdMbJdt/vh0UgRfoMGIicO8P+pXlkKsOJuG9wPEfEYZ+XCbnQ3wMF4azsnO2kJeLgI2rXeKcTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003928; c=relaxed/simple;
	bh=BHE4ElPAsVdaLn/uLjwdFrSJk296PeQUwUauF6mxthA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DPFQHUTu+blyzw72EkSYuKjhS9vFNFwlLyI4V33fYtL8HMr0Y0EDM9+K0Gf349lt1cjyrsl8MPbH9I5fIFVFVartbtPCDn8/9LPy+F0DCBKgXr9H+1BT7+IHaLDQhErn6Bv1xRhTzmtatMl8fou4k6FylSXDhibXC7nhj11FJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwdUK4ji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwdUK4ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DE71F000C4;
	Wed, 14 Oct 2026 18:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792003927;
	bh=Ijb7jgDlV8cORqv0/73Nzcqmw+ka5fcv0Qqcks9Er/k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MwdUK4ji3N8Qy4a5j68vCas//sAj9v15LjeWv/KYcPW+UyXLDWwfFNwUSpT59SgUZ
	 FZi74/Yi0JXl2O6OVaj5aKtTJy5EolcxuN1OlMEqhsUh0OI7gl1WWBA4DybaAHWSP1
	 rDhap7CF0bo1yvWbNBycFG2HGbIxALGHM9bJVG0YmHRldxWsLvnLXCoZVU0ob2T4GS
	 Ibbo83EvfqUxi0r7ZDJZRll8oEX35NWyCpwrqHgzAr3e5Gbg6PV8XUM6pttK5JqBpf
	 /rwD/kwM7TMMm2TjJsNItgimUNlgqZfcmc4OeY+wVMrFVIQbcnggQUc+XjqEbmywI5
	 U7gYtGVM2NrlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15083A5499A;
	Wed, 14 Oct 2026 18:52:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add USB ID 13d3:3631 for MediaTek
 MT7925
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179200392577.2906069.10139994552498838632.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 18:52:05 +0000
References: <20260924115328.15987-1-kenzivoyer@gmail.com>
In-Reply-To: <20260924115328.15987-1-kenzivoyer@gmail.com>
To: Kenzi Voyer <kenzivoyer@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Sep 2026 13:53:28 +0200 you wrote:
> The Mercusys (TP-Link) MA37BE Wi-Fi/Bluetooth adapter uses a MediaTek
> MT7925 chip whose Bluetooth part enumerates as USB ID 13d3:3631.
> This ID is not present in the btusb device table, so the interfaces
> bind without MediaTek driver data and HCI initialization fails with:
> 
>     Bluetooth: hci0: Opcode 0x0c03 failed: -16
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add USB ID 13d3:3631 for MediaTek MT7925
    https://git.kernel.org/bluetooth/bluetooth-next/c/cbfada3f0c5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


