Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BED329360
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517015; cv=none; b=ecjDNn+Lj4MoiJAFRHVD9Dsjuz5KkNZJ8NHVdsmFMK4EwikDzRPxzhGhJDG90qp8+ZHSeyjxwtAAXOi9JKQj6ChOQc0LYXL1/QrijD069YEYH7BjTGHRrVAiBhb7dCSBfGWze3jF4X8qAJYkJNNU7iFzrn4mKBgbR8a9AIdmEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517015; c=relaxed/simple;
	bh=C2YOCtLH9cOOYvjAbPGXQbSU/NyHwa4eTdlW6dQgenM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PRtCUuIoWPxmthky3xakUZv59M2OBh6Q/ZH2GiwlxgmH9oZZ5kTHkVo8E74LmZTsswBZzhVPBfEtwH7eOeDJ+XE5X0B3w9wB5jdquRgCtiSzn9EM/p/86k+yRbWUw+wPSFTiI//H9mmMWSbx5USCdtZXRmdVrMm2XGf9q0Dmeu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI9wMvIW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EI9wMvIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B073C116D0;
	Thu, 15 Jan 2026 22:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768517015;
	bh=C2YOCtLH9cOOYvjAbPGXQbSU/NyHwa4eTdlW6dQgenM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EI9wMvIWwAaawzwMogtDgHuqOGCLwlZxzTpg4+FoEm07F/EHgSzzAX3ALOP/oWpBD
	 xjHIMEfEz+Oe0/JEcUGmGnDieDTb9D/evnGTikZ00NDBWr1a9C00zSUOcJNWL4Jsu3
	 G6yuBcvMMvX2QZMBQ2Mt1qhK2a+tHGliDo3qO8EOjXe/QA+hBCPTRduS5NPzmEp2q7
	 +MIXqHdxnptUN4IDJjNAMylDz5Jsr8ydrHbX+sWaxaoWSwjmqHYxVHSwNw79EKBzVv
	 NXkzE5jcXtZAO+gfTlE+4Ne6eIZRiFxVUdiol+q4N+Ugd7uoGOVavfc4WS4GEFPKwQ
	 fNwf5urhglpwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7926F380AA42;
	Thu, 15 Jan 2026 22:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/6] shared/crypto: Add bt_crypto_rsi
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176851680744.4193484.12243082978824882040.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 22:40:07 +0000
References: <20260115205408.1554101-1-luiz.dentz@gmail.com>
In-Reply-To: <20260115205408.1554101-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 Jan 2026 15:54:02 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds bt_cryptor_rsi which can be used to generate a Resolvable Set
> Identifier as per CSIS spec:
> 
> https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/28085-CSIS-html5/out/en/index-en.html#UUID-4dc0c19a-2900-d43e-6ea5-e651151d3c3e
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/6] shared/crypto: Add bt_crypto_rsi
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=07bd0d60bcef
  - [BlueZ,v2,2/6] advertising: Use bt_crypto_rsi to generate RSI
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4ab2161b5328
  - [BlueZ,v2,3/6] advtest: Use bt_crypto_rsi to generate RSI
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6d79d8a3a643
  - [BlueZ,v2,4/6] shared/ad: Make bt_ad_has_data return the data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=acc0a1d1c4eb
  - [BlueZ,v2,5/6] advertising: Fix not verifying if RSI set is valid
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b9daa6718bdd
  - [BlueZ,v2,6/6] advtest: Fix displaying RSI as a byte array rather then an address
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=62fdc13ed2ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


