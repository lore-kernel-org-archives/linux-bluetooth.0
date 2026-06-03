Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6A368D75;
	Wed,  3 Jun 2026 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509006; cv=none; b=FkEsMGhVsGDTzxkK85p8o2fK2fskULXcAGMlHxTd3HDjEG8e8PRt3isNWfAxvl1mc1JFsHBx6ER3iSdmAIxCqw+SCEceKAthAZ2Y1/Py+699N+7ORatlhg21hn1uEvL6m8HXHYvZRSAEbIgFqgofeJLnVCSRdy37fK6xylPHono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509006; c=relaxed/simple;
	bh=T2soeqRrzKZ3b5MqhdrmSEbyrOpk2SGauKHJN3/zuRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kZ5HfwLMICuyGgY7RfijtC/OWU8jjwr4qgR5AxyRYiKDfPlKzLUF5BEri3txEheP4nYf0hdeHpEEcYBHIjTs85ObpX16R8poiyn4RtaOGwlwlrYyfrJa4pfRGf1/MQVfYcglovosj26nJyR1C6MlcCoWEAVA8OgSMES0fLqrXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBL9T2BB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBL9T2BB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA931F00893;
	Wed,  3 Jun 2026 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780509005;
	bh=+n/GXcJ6n/EbgqDGtN02MqZZuEqO5oRtaPHXFMPJvu8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RBL9T2BBdfT+ebVf4WkmCK1biCP386nQiegvh1g2771MSgt2+w0TpR+p/ErLkpXDK
	 Nv7NLA9utpMIuy0amaSkJxfecbsnHlRHmZFtKoCiYxJytKKFANpTzFRy52/vesIWjH
	 FzF2KUIMLj6cHmYUyu1951xR78ib8xwShJUxQRVPPe4bpcSobTRxDWbd0yKmA51U0B
	 EfUEUqTJp8sya2/JxE0a2amfELyWN5/yfTLoFb9U7Iei8Y+5AtAofVPWgpuudFqVc7
	 Tx5ySaq+GpEBZavjhNC9F0BAB9Omma8EfuWm784VpgwkPJi4VrtGpcN25yMycp35I8
	 pQP1gUo6jqIOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0F0239308BE;
	Wed,  3 Jun 2026 17:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support for TP-Link TL-UB250
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178050900665.1520440.1096131778194850357.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jun 2026 17:50:06 +0000
References: <20260603035818.926654-1-cxs1494089474@gmail.com>
In-Reply-To: <20260603035818.926654-1-cxs1494089474@gmail.com>
To: Cris <cxs1494089474@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  3 Jun 2026 11:58:18 +0800 you wrote:
> Add USB ID 2357:0607 for TP-Link TL-UB250.
> 
> This is a Realtek RTL8761BUV based Bluetooth adapter.
> 
> Without this entry the device is picked up by the generic Bluetooth USB
> class match and exposes hci0, but the Realtek setup path is not used and
> rtl8761bu firmware/config are not loaded.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add support for TP-Link TL-UB250
    https://git.kernel.org/bluetooth/bluetooth-next/c/7e7dff125429

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


