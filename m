Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0C2D24BF
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863430; cv=none; b=StmyaB0BHEfxt5tR7adUB/0z2aENwWDPQQLHF3O5LnADC/P1qQEoBnkIr3ONn+ZImCPrOTfqdBIkRBPBtQitGbLrtqKoaV/BOTu6Otl1Hc5E5FJz4h+Qm0+jXyhlxxJ7+lyaiRVPbSeKKXq1oai+TrCqcuiA5/VGJqT1vzDlFqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863430; c=relaxed/simple;
	bh=6Qi2xNf9z+TDHUzS6roD6ofwJPN8xSvekI8XrSvpFV0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h96L6tkzL9JpcJtEM6PEnofsj7NDc+N99cUfTZSyhi5ky1FgcBrkbgRsm+luacOJfkEwkzgntwE6BWjJB2T9nxTdyPJ4hwebxn7RwDpUSWh9S307sh894V6EoObxZBeFmeT/8woQZmO8LXCv4SlT9fjWS1QJU3PpVOzg3yBuG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg2/gWQD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg2/gWQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEEAC4CEF1;
	Thu, 30 Oct 2025 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761863430;
	bh=6Qi2xNf9z+TDHUzS6roD6ofwJPN8xSvekI8XrSvpFV0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kg2/gWQDsdOmbzajSE13I5+KUx0M4YCmxF/xAed3bWdrR8m4YWKKzHdUk5XH4HRnu
	 W8scFdkBCs+bFat6zLw5ZNx0B45AiIqi4l9s/DglCATqB/ZteSWDZaPAc+LOaTNGq4
	 vcT/FuVeCToL2kEefABKDSzp8Bjtd2DaUpXqEkPepF5Pt9dvDTEhaWwtzZRo4+Ygk0
	 NgT8ZoMKG7KEZGAb1Y9gbyKDov0Ug2LB3ujigMJ7efCAORbHGkIQj9QNwqXh9cWz22
	 OG9SbAGd25wl62PWW6dI1Bp1Jsft6878+WkkxWZlkbQ+oYodMaF9InuKMIH6yjRXDb
	 RAd0boylSCzHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0F83A78A6E;
	Thu, 30 Oct 2025 22:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/2] monitor: Add decoding support for LL
 Extended
 Feature Set
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176186340650.4061108.10347184025067875924.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 22:30:06 +0000
References: <20251030194856.296603-1-luiz.dentz@gmail.com>
In-Reply-To: <20251030194856.296603-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Oct 2025 15:48:55 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for decoding LL Extended Feature Set introduced in 6.0
> that adds the following:
> 
> Commands:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/2] monitor: Add decoding support for LL Extended Feature Set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1479b279a016
  - [BlueZ,v3,2/2] monitor: Add decoding support for LL_FEATURE_EXT_{REQ,RSP}
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=32d740d87970

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


