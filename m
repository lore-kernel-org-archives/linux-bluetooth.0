Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F023546F3
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116809; cv=none; b=pef4m4yCQaM4beyTX0xyt4R4EjabXomP3vJ5RVQOoVM4ZnGkm7xj5bbx6ols0pMteX6EnObXjHkd2ZMkPKI0RiQUWW4lcaP1DxXa5renuFdr7kbAvggH2J0h6qmbOH2jwUzaT0zhkFIty2IZaFd4ybHbHoVJN8Ff2Fq9o5mPhQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116809; c=relaxed/simple;
	bh=jdHoaG7vOJglOZ/QIVvhtYthhzPBVZpQcpynamyewxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q+jBoPxnnsuLn75gWlijc8nAFLaDQobRlOtw9VH/+bB7vSgEEI8VZMYUJEQWcd0KWqdETYvPc5Zdkjw2yhICHcuaToW+4xazWrO13db2aqlIJkZVl32S7L69nPCc1GjoCBSj2TpNdk+W8b1vjaQ7QZLyJwv0C0lmkBbZIVzi2fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPw0vQv2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPw0vQv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC9C1F00893;
	Wed, 10 Jun 2026 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116808;
	bh=7LJr1bayZcQU4Im9AaEfvbswFdvw4QNifgrHKnqxNYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SPw0vQv2qFr2fouFLJER92tTVWGkNm4WjIzeCUwzYrhMkSt6iN3OMIypokX0C3S8E
	 8vpNyBClaKgr5S2wavJnl1Epq2796V+PznVl2sNXsCQaXscdOpSQk4xgQMzQd0DNRA
	 w674QSXEGqyTP8dVB81by1JIqltkKf+isrbuh+kuQWnoQKnDXMzvMap32AJRGd8gFH
	 Hzq19f38OklraQRpJcJmnVKnK0qHUaZFy5Ev5uYkdph9scavlo5U3drdg4EaKWCdjt
	 Hq5PctUgJYX78alse2bo9xzVrtkZgEqTn473BpxhVOXccC3JjgjwCgpgVgBl3j/QWX
	 QdX2p2pwVK/4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B4A3930DEB;
	Wed, 10 Jun 2026 18:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] adapter: Fix failed bonding attempt after LE
 link
 disconnection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178111680614.3588149.7368112532783856520.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 18:40:06 +0000
References: <20260610082054.3915366-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260610082054.3915366-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Jun 2026 10:20:54 +0200 you wrote:
> What happens when issue occurs:
> - device is connected to both bearers BR/EDR and LE
> - bonding is requested
> - LE link disconnects
> - pairing keys arrive
> 
> BlueZ would finish bonding request with error and mark device as
> temporary. Then it would be disconnected+removed after default
> temporary timeout (30 seconds).
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] adapter: Fix failed bonding attempt after LE link disconnection
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d836f1c697c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


