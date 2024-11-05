Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14251DA60F;
	Tue,  5 Nov 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818825; cv=none; b=cjBgRj3Hw7eEqRTm/jA+D3Lv1Ts2Wf6c1rDCQ2nmFtxpGj2OjQs3NVuRkuy8/5eXA40kjFVQcYNFMwJzwsjI+ZLJsMSOznTFUYLgvLBCyIldS7rE/HWniezmuvuTjLXhNf6kVXobMAAm2x4CdqcWeVWQ4onW0sci0JbYwZxujg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818825; c=relaxed/simple;
	bh=/9BD+CG6bSek+ioiWxHqTFIK5p/sQQ/tH1AmkfFf3ZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H6iO1bMoq7eOP9cNfNgZTVe6en50pWtaf8eDCwCSelH2aJwppKKe80J7GtgNxbhI8AIHbKAXMirFaFBYxym3Ftpy4fpHxw4emks0L3jjeo6/IYl/tzJMXr8qxYHTNsGUZKWIkJhPv2J2Jni9sPK5wzhAz/e/K6JrXEtvDbtncKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt597LT9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt597LT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0CAC4CED3;
	Tue,  5 Nov 2024 15:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730818825;
	bh=/9BD+CG6bSek+ioiWxHqTFIK5p/sQQ/tH1AmkfFf3ZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mt597LT9WCoUDcaiiiK4a+Zhxa+8KKaBnc07eS4+66f8j43BPV9rg6IE1hH9IjEvl
	 i919IF23/Lo5axnIsepR3qC8DmBTA4DtP3/JWzEDyeJdq7X1u8FZbl7vfgZvNV242l
	 hoWF7lbfMK778FYqEr0KiaJiH3vB11TfN7qkNNUkGHvUaU3yyR3AJr+TvtbGFQq+0d
	 VLgxrzFs2Y8RtkiK4AlDzU1nmlx58WYQPu9T50U6PuJe10zN2WWPXBxqn1KTiQvgMz
	 4dx11EAp54/r2Zz/0hqlwZH44T5vGMTXLvwZar2vYgQRaLfdtXzF0ZV8Tp/dbEtvcT
	 Kfn9uo2zhsg9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C8D3809A80;
	Tue,  5 Nov 2024 15:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add 3 HWIDs for MT7925
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173081883399.584547.12555123272395386451.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 15:00:33 +0000
References: <20241104145931.5019-1-jiande.lu@mediatek.com>
In-Reply-To: <20241104145931.5019-1-jiande.lu@mediatek.com>
To: Jiande Lu <jiande.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com, deren.Wu@mediatek.com,
 aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 4 Nov 2024 22:59:31 +0800 you wrote:
> Add below HWIDs for MediaTek MT7925 USB Bluetooth chip.
> VID 0x0489, PID 0xe14f
> VID 0x0489, PID 0xe150
> VID 0x0489, PID 0xe151
> 
> Patch has been tested successfully and controller is recognized
> device pair successfully.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add 3 HWIDs for MT7925
    https://git.kernel.org/bluetooth/bluetooth-next/c/408ec48013da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


