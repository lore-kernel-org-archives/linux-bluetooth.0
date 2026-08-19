Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C563C10BD
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159458; cv=none; b=kSB10TZ4k745sAdCZGFcNZ6jMrfxTNchauKCnSpkIgH6vR1im0LCyZjAqQDu1cot/dcFohU3Qeg+FP1b93KuGyzG6as8D+Ny2uXNkDiVq9CwnD3Q5XXnJ7aHpzFgoVqIUyflOid2whRvdKDypm14AfLYkLA8sLZ2ujbZaV06UfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159458; c=relaxed/simple;
	bh=uKSLAFf6b2lv8NQ44hhLwmcN1uIMMkndL7Qjwr/Vkyg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R07KTMLmITe/bxIPjk2LXQKet8OAguw24dQlxN+9xcH2/fglT4Nhiq25deoO4WJSTGfTBbxXxJq8UapuE3dnOxtXoC+iLBcShr3+aDbhv7KhPLWpgFBHM7Ng4T66C6jGqBmlGV0S8wnRBVgu+b5FbLmlQsSmojFc3Qr3xVECpHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcxwRSBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcxwRSBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E4F1F00A3D;
	Wed, 19 Aug 2026 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787159457;
	bh=xt3LwgeQ3akpSqA4yj9hu3whM071e/Unf11sK5S7LBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lcxwRSBwvqBlOx3Gw6oizszsyTeY35yy5H2xWx5MXsSXYCp++v6WUCwtdtdFUSzUS
	 mMaSQ/aLiAw9f+kjbY6JTGr7xmMC1UYGpoYEovTc5Fg8nvm0Upf9Dt1AIY+3gkVgTI
	 a6ZlMGWmClLTxjkDXgOXxwZtkSIwRDiOmZ2+/Nf6b+yojKjG6SJblukyMOFqdCHA8O
	 PtrLf5aNFthp1+DV37V21+aNmaA+Td06kTLGrY9x0kZOeJqVxKILzEORJvuGx2THby
	 wxW3xEH/2at90Ue7LvZhmdWalCS1iTDKHnixTaBZMGkFjTbkWgav8vmJ0/RWw09Uu8
	 K0PN/HBDc/Hfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5688638119E6;
	Wed, 19 Aug 2026 17:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] Bluetooth: btintel_pcie: parse FW memory addresses
 via
 mailbox TLV
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178715940789.3583745.6902246283007182525.git-patchwork-notify@kernel.org>
Date: Wed, 19 Aug 2026 17:10:07 +0000
References: <20260819143219.22728-1-kiran.k@intel.com>
In-Reply-To: <20260819143219.22728-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Aug 2026 20:02:17 +0530 you wrote:
> From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> 
> Implement GP1 mailbox interrupt handling to receive memory region
> addresses from firmware via a TLV-based protocol. When firmware sends
> a BUILD_SPECIFIC_RESOURCES_MAPPING mailbox message, the driver reads
> a TLV table from device memory containing addresses and sizes of
> debug memory regions (exception dump, DCCM, SDS, ECL, SMEM).
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: btintel_pcie: parse FW memory addresses via mailbox TLV
    https://git.kernel.org/bluetooth/bluetooth-next/c/6f5f8dcf6244
  - [v2,2/3] Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive interrupt
    https://git.kernel.org/bluetooth/bluetooth-next/c/185b9b3869fa
  - [v2,3/3] Bluetooth: btintel_pcie: Route debug traces to WiFi DBGC by default
    https://git.kernel.org/bluetooth/bluetooth-next/c/52eff0428bf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


