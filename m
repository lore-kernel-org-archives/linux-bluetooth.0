Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B781C68AE;
	Tue,  1 Oct 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796032; cv=none; b=gA+B5pWmL+kZwPdOCeBI2zyDtmBo9wwrVxsPb20pPr3r5CEX5jOEaTWVBMeK0Pnf1myYjMsetw6SyD3PpNaElujszMqM3eyfNHVDu/O856O2CUw76pD0Qsc6ezeXXda5a3+hMeBqA84tQMttfGIdaHSla/A/p9R/4OhIunsmdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796032; c=relaxed/simple;
	bh=6N1tRxX8RZ2vhrq7MpVJGZcbKR3JqwsEu+rl5uddPWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K1AJj7aNR17vvXFNydOcTSm57Ikeq1C6t3N+AXqrcLag1AAU6jijocDyAiGlEA1sKcQgFOf/pgad2UkVYAxizCp4jculAnHTgWkKytrZBak4U4+xhQMdoJ1Re+JCa9DNg9IX4FLgVL4XWBUfCSvr0nahvj5rdrRdT1gBOpROrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnSDJ7de; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnSDJ7de"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAD3C4CEC7;
	Tue,  1 Oct 2024 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727796031;
	bh=6N1tRxX8RZ2vhrq7MpVJGZcbKR3JqwsEu+rl5uddPWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mnSDJ7deY7WgSx0gAnPssQH9SwvXc0u74ZMfGK1R2ra30KnHJdukGiipmmVFvqskl
	 ptlmnGChHauBggOn2Vv7uMWJ+CgPKoiz2BLyAvDxtLEJdkLZRyOyqqTutEr2JRuW7B
	 2dF1bfDirQRdzF4D+z79XaWNd0qnxg7OIpHJdb6oru/kBLS5tassd4mXt8GnTdZeD9
	 s+cjK8b7VRQMzzr6B4hLemNw6a6hBulwcSoRDeensAEHD6XsnhCt+IX3IcbhZ/mE1E
	 tISpH1v83TMTz4u+xl4lDvHo3IT9bTJ2X0Rgf4/ZXQQk4gtZO+N78JI9dv3kmKCoA+
	 5nWhLxgR4HEww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB9380DBF7;
	Tue,  1 Oct 2024 15:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] bluetooth: Fix typos in the comments
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172779603451.424883.16063021833718946577.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 15:20:34 +0000
References: <20240929085727.523732-1-yanzhen@vivo.com>
In-Reply-To: <20240929085727.523732-1-yanzhen@vivo.com>
To: Yan Zhen <yanzhen@vivo.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, sean.wang@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 opensource.kernel@vivo.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 29 Sep 2024 16:57:27 +0800 you wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Fix typos:
> 'fragement' ==> 'fragment',
> 'genration' ==> 'generation',
> 'funciton' ==> 'function',
> 'Explitly' ==> 'Explicitly',
> 'explaination' ==> 'explanation',
> 'Tranlate' ==> 'Translate',
> 'immediatelly' ==> 'immediately',
> 'isntance' ==> 'instance',
> 'transmittion' ==> 'transmission',
> 'recevie' ==> 'receive',
> 'outselves' ==> 'ourselves',
> 'conrol' ==> 'control'.
> 
> [...]

Here is the summary with links:
  - [v1] bluetooth: Fix typos in the comments
    https://git.kernel.org/bluetooth/bluetooth-next/c/89f69afc2c4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


