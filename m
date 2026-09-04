Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B799514769
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788544268; cv=none; b=YGGoB5jYvhufEmkqPiMzMlfm/uEOEVo9z6YacsuEWhZyNM3wzBfbKkRQCwHJNMX/q/aiJik3YQknORqexBR+C6SOUzZ9jPu8BUZzCiEQFYlIZwtrehkPtXdzwXI3lKdibABBoeoSYkx7+df3MAwnBJX6z+nY/2gzsRd3X2GXrBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788544268; c=relaxed/simple;
	bh=LZz6T4croaw4rU+Xc60wGAzKl7ZcB/OGAoRbdbKcMy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=goynKfupSidCeA29h0lOgT+Q93riazu+MFGeaxj1BYztaQNrq2wCjwLi8p/mtBTDMJHUKYzMxbufris2a5dCGF/LXZnl9YNHeyA2sWHYcYhu3r0YH8NoLSlKWNWBvwnD6R5ytQBRCUKK22MXen26Co5etig3j9YtX+YXoUn/7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5d5qhZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5d5qhZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DE11F00A3D;
	Fri,  4 Sep 2026 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788544266;
	bh=BEVPE8szywFaEE3UJLTU8T2FrXxQbNL7RT3H+5QJ5KI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C5d5qhZMcEpuPlbQxWyvx4xDD4BI2l2agM2JQ82bXo1V6T9T0UaM/Y5ktkwnT8IvR
	 zhJbBFVSeRavYfFP2V9in6VGsyu7RQKJwWCDe96feLr1Pd23WgG4XE3zaI2gOi94yv
	 sjID8t756EuE1OYK0e7i1SkSlivfY9R6SJP8Ztikz5vGpDoU0gt29jNIEf0PUfxhZn
	 Gyprzc2kWBoW+WbHab6clWF+nxPEWqZ1UrWGtNUNi7jeoUSRgdTkpflIu1K9DBZPQC
	 NO7FCRzy31R6RhvXmGtg7kriaC4K+MKlq3buDyCIi4gUr6Htim4Fak9hJ8fvCtsW1Q
	 +xIoRTUEggwYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938CF3924A5F;
	Fri,  4 Sep 2026 17:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 3/3] Bluetooth: btintel_pcie: unified decoder coredump
 format
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178854420714.463198.8336408785971923023.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 17:50:07 +0000
References: <20260904002939.622659-3-chandrashekar.devegowda@intel.com>
In-Reply-To: <20260904002939.622659-3-chandrashekar.devegowda@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, kiran.k@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Sep 2026 05:59:38 +0530 you wrote:
> Replace the legacy TLV-based coredump with a unified INI-format dump
> compatible with the iwlwifi decoder so a single decoder can parse
> coredumps across all Intel BT PCIe controller variants.
> 
> The dump is emitted via dev_coredumpsg() as structured regions built
> from firmware-advertised addresses: DRAM monitor buffers (single or
> MDBGC multi-buffer), SMEM monitor, exception event buffer, DCCM, SDS,
> SDS IOSF, ECL and dump info metadata. Regions are collected only when
> firmware advertises a valid address and size, and only collected
> regions are advertised in regions_mask.
> 
> [...]

Here is the summary with links:
  - [v2,3/3] Bluetooth: btintel_pcie: unified decoder coredump format
    https://git.kernel.org/bluetooth/bluetooth-next/c/755cf7adf8dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


