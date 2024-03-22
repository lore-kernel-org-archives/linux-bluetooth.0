Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F12E822
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102232; cv=none; b=ZhXvkkwiPkK0DJUe8t3aq/UXk9p02L0gcDJ55xmCai4wK4f/LZ0MJz2imMR+Jsfq6xf/dlz3wfH5nHRs+iLw6IklFIXxlq33YGNAJRIuAf6xMHWBwKnmF569lBKZG2Nrz31SJCMV8iWpjritcNEwDHGuDM8Z/CaODIHjQmhGVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102232; c=relaxed/simple;
	bh=eEJxT9zi3pb/qDtrbgkFeHm3/hUAWYT+WgvVryfPPv0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OOEmJUK2GiIBZu+4tlqZShzsg9Sx6amZx3FmMnasl7PspzGgfBTtjzChhmjEdhwLgqQEviDU324OULU9IY5usSxSkSCPjCuTRncQNaiQWoqngNvEKN/EEsNULa7rudXGo+hyj4TCebhm5x3v+CeHWFMHojhP8rydpUvw1RKRXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIvD/XLC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIvD/XLC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34370C433C7;
	Fri, 22 Mar 2024 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711102232;
	bh=eEJxT9zi3pb/qDtrbgkFeHm3/hUAWYT+WgvVryfPPv0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aIvD/XLCqKPfeKg20BHA09brzTQY6DIkSHbeAXx3bATX65fnzQNlwZCaOGJJkHVjG
	 9qdyr+h0F7fimG7e54a9WFfH2Fyjo8WaGrIjOcdP8zV0lxlFZAqzC4bs+cVJVJ++lM
	 CmuvfMXBEkabYWrK7If5POkLUSvko6cbudlJGFPkJ/xjFxNgLqJq2tMa4Sx9NMcC2o
	 YOcgtmeqK446ALwJWhXdIpW5jIiUVIj1KDR/zUAaQ1wSIYZikURGFjjV7M0UUnY1WD
	 ZjvFx3HQmccV5B/NWLo6WuzNhBw7wTbFzCGafdKsoIKS401bXFuywbW6iZ/00jPb3y
	 pE4NVlpf6Gxvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2270DD982E2;
	Fri, 22 Mar 2024 10:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] Fix crash in iov_append_ltv function
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171110223213.5004.5133673168895047268.git-patchwork-notify@kernel.org>
Date: Fri, 22 Mar 2024 10:10:32 +0000
References: <20240320210350.101941-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240320210350.101941-1-silviu.barbulescu@nxp.com>
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
 iulia.tanasescu@nxp.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Mar 2024 23:03:49 +0200 you wrote:
> Fix function iov_append_ltv crashes because is not reallocating memory
> Use util_ltv_push from util.c
> 
> [bluetooth]# [NEW] Endpoint /org/bluez/hci0/pac_bcast0
> [bluetooth]# Endpoint /local/endpoint/ep0 registered
> endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
> [/local/endpoint/ep0] BIG (auto/value): 0
> [/local/endpoint/ep0] Enter channel location (value/no): 3
> ==80806==ERROR: AddressSanitizer: heap-buffer-overflow on
> address 0x60200000a8ba at pc 0x561971611e0e bp 0x7ffd45ab1f00
> sp 0x7ffd45ab1ef0 WRITE of size 1 at 0x60200000a8ba thread T0
> 0x561971611e0d in put_u8 src/shared/util.h:254
> 0x561971611e0d in util_iov_push_u8 src/shared/util.c:534
> 0x5619715c28f0 in iov_append_ltv client/player.c:3565
> 0x5619715c28f0 in config_endpoint_channel_location client/player.c:3593
> 0x5619716226ce in bt_shell_release_prompt src/shared/shell.c:744
> 0x561971623087 in rl_handler src/shared/shell.c:769
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] Fix crash in iov_append_ltv function
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bbf198280e70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


