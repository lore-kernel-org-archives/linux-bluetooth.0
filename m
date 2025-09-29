Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA532BB17;
	Mon, 29 Sep 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162214; cv=none; b=qDGcGPa0Nl2uVtIvppA70yck1iXNcZzq9PBxFCcHETqD9jl/rzBLaxA6pLJPSWEBnMfQAgMlWDy2rv9eEG+y+S7t7sPttcM1u0K226swtxpBWqmXn845Rst5bl5DRv0CRln76JyqpPXlWl9aCLNBoACRpW1XjqGDOOLnTSmnylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162214; c=relaxed/simple;
	bh=VwMhtKXqp3LJwH0OUSm1EemiOWjyAmIPXaZUF2o60sw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EbKv7bzCKbkRRWbWJBAkULzaFRSfzLqg8VyuntjFbwKYVuyOjMNj2OILYTfECpmFVO7b6tegXQlj2ouIFaGTW6E1nsBs5dmiZpKi8ofOaLVx9Sb94Liw5kFhVaFf7Nbgdmo16LfUxOfFDYsjQnMH6IDxKH6LRNuyBmIVH0Tnr28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBhj9yc8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBhj9yc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5ABC4CEF4;
	Mon, 29 Sep 2025 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759162214;
	bh=VwMhtKXqp3LJwH0OUSm1EemiOWjyAmIPXaZUF2o60sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PBhj9yc8jaOsTTukyhZ4zNItFdk5J8xaZApDb4/6SYHiICmDC/IuAqFxlhXNTJDKH
	 PVnBh8tl0KS/ONXvfe117/uz4HNw2WhXYxCHWkqqBmGMyCC7luKvuANlX36uIjPbHs
	 YiogN9tGiCrEkSLJ1CSINU9O4VnxTwbh9RmUrpiw/FzVLJPtNrFEczLYor4LdpSbHp
	 AOXHNb27OmXHcGfBaPIWKxq5YXMeJuhWNANXHBqS0EErebR7hNV0YohGMXPZXL95/x
	 iPYMZuZxvn9cx6do++dx6HV5KKwqhEXZa7/YM1L0iE4obi0Dv795/jMwslB+tqb7qu
	 vKOC+7QA79Kcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBB1D39D0C1A;
	Mon, 29 Sep 2025 16:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9] Bluetooth: mediatek: add gpio pin to reset bt
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175916220774.1630000.3594430707404440573.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 16:10:07 +0000
References: <20250926101046.26559-1-ot_zhangchao.zhang@mediatek.com>
In-Reply-To: <20250926101046.26559-1-ot_zhangchao.zhang@mediatek.com>
To: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
Cc: marcel@holtmann.org, matthias.bgg@gmail.com, luiz.dentz@gmail.com,
 angelogioacchino.delregno@collabora.com, krzk@kernel.org,
 sean.wang@mediatek.com, deren.Wu@mediatek.com, chris.lu@mediatek.com,
 Hao.qin@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 26 Sep 2025 18:10:46 +0800 you wrote:
> Support the platform Bluetooth to be reset by hardware pin,
> when a Bluetooth exception occurs, attempt to reset the
> Bluetooth module using the hardware reset pin, as this
> method is generally more stable and reliable than a
> software reset. If the hardware reset pin is not specified
> in the device tree, fall back to the existing software
> reset mechanism to ensure backward compatibility.
> 
> [...]

Here is the summary with links:
  - [v9] Bluetooth: mediatek: add gpio pin to reset bt
    https://git.kernel.org/bluetooth/bluetooth-next/c/8fe90a5ad3d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


