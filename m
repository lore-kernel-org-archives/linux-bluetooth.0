Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08C91FF5E3;
	Wed,  8 Jan 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352617; cv=none; b=OtpPC8NiaPOBclZGLIVNl8ms/nbw9+pxWy2bsqgX07A6irFywOXhWpMJACgiw7S2zSyvJjHmuuLNIJWDYfoHjJJgeXNz10gRzAJlNm6T4UxzNLnQL+J31ZAHk8DdJ26SbUb8Ao1VCScRZ6U+K91ma89Z7bMImClqNnede6Oy8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352617; c=relaxed/simple;
	bh=sIXYrLDh4aKsTXlsI3p99yuWRTuR2cFlH0iw5Y/uikY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DdBgbkUwWD5Mi0mlU8G1Q1B0HK1BkFnrAWTY5VVhodwXSgF8QCagl4X0KszORk8WCRsGXQj4LO5BDyygTlqO6i5H8/FINI4sjeTwOlOt/7g1ABWDrl8YM7qcIQg9HCSdElSjLgYFgWYCU0/aPYRMu7mbYAlv0d/xIS2hyTeUSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmK3jqfY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmK3jqfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE3CC4CED3;
	Wed,  8 Jan 2025 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736352616;
	bh=sIXYrLDh4aKsTXlsI3p99yuWRTuR2cFlH0iw5Y/uikY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pmK3jqfY0+MoixMACScjpa034KgcRc+lVtHcTm1q9NCdH7Altklqg32kngEq56eba
	 G9xDkiFLC7GSEsVOA2wXXCzJzdxQsqsGdJq7DbU8TpZo9CDiuX5WRJLPavhO0zTj7M
	 WsO1MRlQ5dtWZx/2Vfgv9H79Q6N39eblnjw0G2/awVtW/Qp2W2ggD/tSIuabYUKEEE
	 TJ+IUQqvunjyUgpwMu7GtjAQzTe22ENSNWGrEI8tULRcZYYXoId3aXQJnwWirHbozd
	 uPysCE/RDCbQARzMNwupNTnqChARZykoXPrtCGZKYUlFPPJZHtR3VP/P5RDhykgTqE
	 7xAl+KAIZ8Epg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714C7380A965;
	Wed,  8 Jan 2025 16:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 RESEND 0/3] Expand firmware-name property to load specific
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173635263823.697160.13231849851313043929.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 16:10:38 +0000
References: <20250107092650.498154-1-quic_chejiang@quicinc.com>
In-Reply-To: <20250107092650.498154-1-quic_chejiang@quicinc.com>
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, quic_bgodavar@quicinc.com,
 quic_rjliao@quicinc.com, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_jiaymao@quicinc.com, quic_shuaz@quicinc.com, quic_zijuhu@quicinc.com,
 quic_mohamull@quicinc.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Jan 2025 17:26:47 +0800 you wrote:
> Expand the firmware-name property to specify the names of NVM and
> rampatch firmware to load.
> 
> This update will support loading specific firmware (nvm and rampatch)
> for certain chips, like the QCA6698 Bluetooth chip, which shares the
> same IP core as the WCN6855 but has different RF components and RAM
> sizes, requiring new firmware files.
> 
> [...]

Here is the summary with links:
  - [v6,RESEND,1/3] dt-bindings: net: bluetooth: qca: Expand firmware-name property
    https://git.kernel.org/bluetooth/bluetooth-next/c/8c6fb157eb03
  - [v6,RESEND,2/3] Bluetooth: qca: Update firmware-name to support board specific nvm
    https://git.kernel.org/bluetooth/bluetooth-next/c/ad3f4635a796
  - [v6,RESEND,3/3] Bluetooth: qca: Expand firmware-name to load specific rampatch
    https://git.kernel.org/bluetooth/bluetooth-next/c/be6ff38d6852

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


