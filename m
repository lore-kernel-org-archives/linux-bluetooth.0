Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA23F9EC
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 01:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754961592; cv=none; b=DYlQf1+HT2rSkO3VyfYH5UZ1/gIKToVEGXRPme7QGr4cK/RjaVE2Rsov9sqtFgaVTHN3TcuowGRrkP2SrXjEO7RRMkHZ8wWVbJT1MyKuKvqnpio+aitXVVTvDx/7wFeYgYgOtcFEuqFWya8Rh0riSsekWeh9t9fd11nqo0+s/ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754961592; c=relaxed/simple;
	bh=+dhSEgEiJ4pt+00DVPM5CsHUFnkUO1NKuH2AqjCNU5g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qcALiMiIp3xxpsXYVDgz5FrbKGWRhPuDFZcVySd7BKnffjRwLjJ72++IKZ3yWqKe4DFbyDbkZ9J/pXsODl66a8sadfpffznIOY9zhng4r4FFS+pGV9OVkvv+h8T3UmftS69fTgJFf7wL3XtMMFL7qTPSd8DaYiYUjxxlDRlkdbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bruSm5ui; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bruSm5ui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4141BC4CEED;
	Tue, 12 Aug 2025 01:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754961592;
	bh=+dhSEgEiJ4pt+00DVPM5CsHUFnkUO1NKuH2AqjCNU5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bruSm5ui4FMnsPhEU8XT2Iefs47Wd3EcjPxKvtjTDhflYeU80IM8yLxuQnsrm8ceq
	 nW5m1l5H4lU/YyIewv72RnsbUMucLj4MAQqpG4rSWh4dKgRA9gXwhJzlSoQeXJgT28
	 6qlbhi8d2AT/5NUL50E3lS8DBvSDsKcOXC6/pbDNnuG+aG3JnPVuVFtvHgrdLOTlgH
	 EBh/nBSbqAnLG694N/PMbPNcspN0W2X8d2FfpAs+c5gPAsdpOEXGqlMITs98ImbXLV
	 uAiMn4Czzw8D6xfVH4QpYSil8S0wuggrYxp9oWPOPqjeJ+ePYy80y1SlHl+4RYaV0k
	 i6VBNnj243EoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDC6383BF51;
	Tue, 12 Aug 2025 01:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] shared/bap: reset local ep state on stream
 detach
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175496160450.1961218.15065760286817373243.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 01:20:04 +0000
References: 
 <c6ee6b6a02993e4be6d534d023358f5231b43043.1754938103.git.pav@iki.fi>
In-Reply-To: 
 <c6ee6b6a02993e4be6d534d023358f5231b43043.1754938103.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Aug 2025 21:48:52 +0300 you wrote:
> When removing streams in bt_bap_detach(), they are detached directly
> without going through normal state transitions.  As BAP Unicast Server,
> this leaves local endpoints to the state they were in, so they persist
> if client connects again.  This is not wanted.
> 
> For server streams, clear the local ASE state on detach.  At that point,
> the ASE is either already idle or the session is detached.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] shared/bap: reset local ep state on stream detach
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8a304f7fd960

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


