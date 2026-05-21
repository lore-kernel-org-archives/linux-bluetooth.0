Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE0037187E;
	Thu, 21 May 2026 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377417; cv=none; b=sOCTxsGdR3OCPoHZpeRctR+OeBTfCefd5wHQX55wUOEj349U9k8QbLpCuN+0lk6A62/kBCQABihdVJPoBMygHjaIehErE135fje9xGI/mIylJ4Fbm/ouQqa8Vo3TnEm8LklkyaBzUN+FG+bYObzfElEHQ6EdQ2D3I88CLXUuBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377417; c=relaxed/simple;
	bh=JwYVn2JQxfmfmzoEGwVZPAzIcnsO2z92AHO0R+U2k3I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rvqMUPSacvJhDlB6jy1v79WwtsYSMADZY5SHeyjSSkqZPQTNej1wcxnVulK7ccRhOOZqfAIHoEEO6cwj2HdXwndLv59fONDrfO8peChTrVuU6IAo5GQUyI53iTX9FxAIQwJDohWy3BocmXwCQ/zfZNR3uCnG1ylV8s6SjHLsWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6Htv0KM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6Htv0KM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040871F00A3B;
	Thu, 21 May 2026 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377416;
	bh=wW2EIJlRcTtZ7Krb1jUuZ1MsgafTYwvcWNxQDHTGtv0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W6Htv0KMZQwx9moC2dA+XQ334P5Mw4pdn+EkxJ2IOOrCyYw4VDoAHLDgEDbvuaRpg
	 m+yxu80qEpcQ85QzZV1QPWRNd9GvY5e3hDjZoUDAf+Yr/pNFas5tFShIhrat1hu+Qa
	 62DqDbhHfoK7F13R6s2XUGzTieDAsJlXqKhgBm848hPPxe21mm/YR7TV3Vi2AcDJFX
	 uMMhMNrzxPNlH/Ue+0EyrGKyPXk74hPQsO1Qkxh0lBHxVAf5IIm+6eHRIa4A/6ZUMi
	 CN50TbwnwSV9KVIHNBpZX1UKi9iuwMC5ff65mKhkC41NgOX0urCxcJ0YRrQaLE5Y62
	 yd8cVto7wrRYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197503930E02;
	Thu, 21 May 2026 15:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtk: remove extra copy in cmd array init
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177937742563.384060.10935423618601860001.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:30:25 +0000
References: <20260520021500.13504-1-liujiajia@kylinos.cn>
In-Reply-To: <20260520021500.13504-1-liujiajia@kylinos.cn>
To: Jiajia Liu <liujiajia@kylinos.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 May 2026 10:15:00 +0800 you wrote:
> In btmtk_setup_firmware_79xx, the data length indicated by wmt_params.dlen
> in the cmd buffer is MTK_SEC_MAP_NEED_SEND_SIZE + 1. Except for the first
> byte, the remaining length is MTK_SEC_MAP_NEED_SEND_SIZE. memcpy copied one
> more byte to cmd + 1 than the remaining length. Align the length passed to
> memcpy to avoid exceeding current section map.
> 
> Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtk: remove extra copy in cmd array init
    https://git.kernel.org/bluetooth/bluetooth-next/c/b3e1ce138148

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


