Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42D19CC15;
	Thu, 12 Sep 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158788; cv=none; b=lN24wlyFDOLG8Gq+1JagASIJlBFu/N09EA3mMQAdD9cUzksV6yvkfV/A5yj+Wp6Gcp0xltztteZfjYK/rLTXzrWZtSPRUP3O4suCqWGT3dVmluvoQZSjopiwpC6auNiWY7dOQlU8kmbIwqBnSvt6zkZiRkc6S45dcokz5Wgzn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158788; c=relaxed/simple;
	bh=4MwI/Pk8WNGdXqktB61pOKgYeO+knWkwU0fmIXiQXe8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s39ZNKHMbzuCic2WFbyJ1VNwfONfGPoOJoC/EvLjMAbrLOiOjIB33+mAC+ewtaHEmMMSjMdplJu2+krFUspl+BUmPOxeb/t+6g/VLMt05kcci8NnuzZR7w6Z3KDujo65dbAPeCOIVhl3voJLdV4MA/C8R1fN9R2tfxpbD35hyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3FMWtwO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3FMWtwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108ADC4CEC3;
	Thu, 12 Sep 2024 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726158788;
	bh=4MwI/Pk8WNGdXqktB61pOKgYeO+knWkwU0fmIXiQXe8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D3FMWtwOzRwh3bERw6k+UNofnJGIzAqMVNw2GC3vwSbmLoHs8RNbmKAtVU3Fw310W
	 afI3PdKPdGEe+TlisqyeyXCYTM4I7O3N1IuJwO+2hAmtgGT+3FpPRVRZLYlyScvzxY
	 ncmeDNnkvFwHVEVnOE1Vwk4A2PxFSKbHHmIH8Y/K0A4SDIB7yaxG/11DsZVowzjcZI
	 7cO0z6HtyrcmKyAVpn/H3Ah19eAqAfuqeacsB/uHMVeshypyKw1iWTc9R9FIKfTguf
	 4qlCW36ulTnfGuT8qRTaglLC52DfA85rfvzaD1ritdvH1UxNqRLEIpu2wGwJy7hHJx
	 Nfjd5fd7ijC+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B763822D1B;
	Thu, 12 Sep 2024 16:33:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btsdio: Do not bind to non-removable CYW4373
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172615878900.1648954.3109963207788046118.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 16:33:09 +0000
References: <20240905180100.507975-1-tharvey@gateworks.com>
In-Reply-To: <20240905180100.507975-1-tharvey@gateworks.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 ehlert@battelle.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Sep 2024 11:01:00 -0700 you wrote:
> From: Scott Ehlert <ehlert@battelle.org>
> 
> CYW4373 devices soldered onto the PCB (non-removable),
> use a UART connection for Bluetooth and the advertised btsdio
> support as an SDIO function should be ignored.
> 
> Signed-off-by: Scott Ehlert <ehlert@battelle.org>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btsdio: Do not bind to non-removable CYW4373
    https://git.kernel.org/bluetooth/bluetooth-next/c/9a53d1ff631f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


