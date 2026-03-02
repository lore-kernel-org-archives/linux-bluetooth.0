Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103354C9554
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483407; cv=none; b=R9gZvbl/pns4HY7pCZzUhXWEq/XVuCz/5C+3EuKzCp4ZkPJfbpB5lOLNG+CtOgMFSUF/bBN4tZBxsE6TljI1maZik1+sI0ZYio+q7H9rksAoZn1ihffqKaPBNa4gFI1MQmoXu2NkTiRzgWSl8zkZk58DojuDSsu0BJC/n97R//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483407; c=relaxed/simple;
	bh=jK6qx2SA6o4gX1HqD6vWsnTsvAGbn7P0y4CDnBW7NEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p0a0dgPPolF7kgm0uu98ORQZiuGvMcVOZERSbGW99nalX2oUguHo0fcHZW41mQ4+kPNkKpuHEKoSwdPbs9OWIEV52mhalN9Y2/sGznG5pMcXXndyL6oPilYFhE67iAK6MDer0qJHDn+cLLmSimxvDsVPYKfDq67ghR6ZzdvsvL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mq1XprBP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mq1XprBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D81C19425;
	Mon,  2 Mar 2026 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483406;
	bh=jK6qx2SA6o4gX1HqD6vWsnTsvAGbn7P0y4CDnBW7NEk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mq1XprBPhzNcDuNO/pOUK6Swb8xdu+eVey30Qe5QVJe7fgbDfEGVjfsZwfskHLhae
	 gbdE+kS+kGn7Q/iqTGgGziPeRD9qdukaVfFhmYUkluVGtqbBxBh2XfmURghl9XDp3D
	 nYBQFKEO3S0Q/9+fEI5v9plNXlmEOsUJuLpyzQTO94x/YXYiyeuJUrkZ3d9pxWovrk
	 BJWKbi9nLVja+JAcY/1fms+OCwIf4nNucZMxIIZ0SYrbbywSSxBbXJhZ4qQXG6hVCs
	 b/2bZRzJYhe6uz6fT9repEwaugJwyByzaNMKaLinkZ8r4zguX6ewKmEDoXKflBbFj/
	 1gm+GH6bGke0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F5F3809A80;
	Mon,  2 Mar 2026 20:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/9] Bluetooth: btintel: Add support for hybrid
 signature
 for ScP2 onwards
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177248340855.476472.6850603435737325677.git-patchwork-notify@kernel.org>
Date: Mon, 02 Mar 2026 20:30:08 +0000
References: <20260228091239.230284-1-kiran.k@intel.com>
In-Reply-To: <20260228091239.230284-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chandrashekar.devegowda@intel.com, chethan.tumkur.narayan@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 28 Feb 2026 14:42:31 +0530 you wrote:
> If FW image has hybrid signature (ECDSA and LMS) then send CSS header,
> ECDSA public key, ECDSA signature, LMS public key, LMS signature and
> command buffer to device.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 80 +++++++++++++++++++++++++++++++++----
>  1 file changed, 72 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [v3,1/9] Bluetooth: btintel: Add support for hybrid signature for ScP2 onwards
    https://git.kernel.org/bluetooth/bluetooth-next/c/806c3369febe
  - [v3,2/9] Bluetooth: btintel: Replace CNVi id with hardware variant
    https://git.kernel.org/bluetooth/bluetooth-next/c/48afb18d3d40
  - [v3,3/9] Bluetooth: btintel: Add support for Scorpious Peak2 support
    https://git.kernel.org/bluetooth/bluetooth-next/c/444b6f088fd5
  - [v3,4/9] Bluetooth: btintel: Add DSBR support for ScP2 onwards
    https://git.kernel.org/bluetooth/bluetooth-next/c/bc83e129f7fc
  - [v3,5/9] Bluetooth: btintel_pcie: Add support for exception dump for ScP2
    https://git.kernel.org/bluetooth/bluetooth-next/c/4aa6235a0fc7
  - [v3,6/9] Bluetooth: btintel: Add support for Scorpious Peak2F support
    https://git.kernel.org/bluetooth/bluetooth-next/c/1beeb9ac1e2f
  - [v3,7/9] Bluetooth: btintel_pcie: Add support for exception dump for ScP2F
    https://git.kernel.org/bluetooth/bluetooth-next/c/f91e668aaa9f
  - [v3,8/9] Bluetooth: btintel_pcie: Add device id of Scorpius Peak2, Nova Lake-PCD-H
    https://git.kernel.org/bluetooth/bluetooth-next/c/e297775d002c
  - [v3,9/9] Bluetooth: btintel_pcie: Add device id of Scorpious2, Nova Lake-PCD-S
    https://git.kernel.org/bluetooth/bluetooth-next/c/ff4941388c7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


