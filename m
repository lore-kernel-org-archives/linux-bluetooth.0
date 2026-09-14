Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9946A4825A3
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396280; cv=none; b=R22QldlNRZFk3++hHhequBYas+QjgVwWl9lTL/QbzhL570vkMvI50jQdsiygNDeSX76/aHKeoKed+IT6Fnh+wCyiQMDWI8MITyg2nWvqm0j5mjRJ8Zo+9m55Pa3ofBs/sDkICj/Ry3gm5vlDVXdj/iRcsJ+lH4onNRfIaMwRGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396280; c=relaxed/simple;
	bh=rncAZ2IhvS/TlpdCogDtxcK1DyWujaq8fdMJKzaF4Ew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iRY0VRGPUFqybwQHG28zMaVxRV+i+8O4gXfaTXWtGrDRu8mH2vumpQiYVbpQ3RNePUSBVHDgbgYY5vzAVz/DRbhL4CRBggm3HbuIHA0Gt8wbkrzsV5G6o/3K7BX2kXYRI0icx0xNfPBcYEAg1cEZluh7d6rGd9JzXMJfnLOpGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYrFO3n7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYrFO3n7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3921F00893;
	Mon, 14 Sep 2026 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396278;
	bh=xeCsWo8F3orJ0ieGw49tIM4F5BOOi06wgwZg9gR0ofM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cYrFO3n7NreFNMJRbn4OfWVTxwuabkjxF689enaS4Fvu0VKh55KR4me2M08ouM9eP
	 9gXw/8JnAWu9Yenr0KqeKb4wzhq6ChsDXU5S2oTOhCkEMeMRsprv5qv68QxeDwyxAX
	 qjbrjy1e4sZaMLViB3ZVFij2+axjZDEjizdgeqzdZiAewEuUDgQTYn4W90VLF/FUk1
	 3K9kkCNrGUegQvebkKsAkD9Af6i3EL5lVONc28bhSMcsAgdiMX9jvvOEXXSdIECCrP
	 CDBDhgnzGtfkAd3LJPf4qVH9tI48k3TbJtgWqopgKDGsnKTZ3QaBV2GRhi+s2jackP
	 FhKNUuLskoDVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A563924A67;
	Mon, 14 Sep 2026 14:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: ISO: Fix parent socket leak in
 iso_conn_ready()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178939621337.604238.10918376880914591840.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 14:30:13 +0000
References: <20260910181206.1558734-1-luiz.dentz@gmail.com>
In-Reply-To: <20260910181206.1558734-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 10 Sep 2026 14:12:05 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> iso_get_sock() returns the parent socket with a reference held, which is
> dropped by sock_put() once the child socket has been set up. The error
> path taken when iso_sock_alloc() fails only calls release_sock() and
> returns, leaking the reference and thus the parent socket itself.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: ISO: Fix parent socket leak in iso_conn_ready()
    https://git.kernel.org/bluetooth/bluetooth-next/c/dc9dac316171
  - [v2,2/2] Bluetooth: ISO: set BT_LISTEN before requesting a BIG sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/21db869e228f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


