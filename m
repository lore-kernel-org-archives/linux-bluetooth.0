Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50E62253F4;
	Thu,  9 Jan 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439405; cv=none; b=eo3yFb+Y2Qozlbr9joldlqCcVfcZDCSGWPCJeA4yBuFFLdKcgnPIFcJpT0809POWS3/jGa06ugZaxAaflLQDS0w0t8aU+kJ1iwfzCF0YXz9xisLtK11WXk69yi0BvYVqMOUh5Z3MHlE4y9c41hzSjYvWecaJpIt6S2VY/H2VdMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439405; c=relaxed/simple;
	bh=Du5pnmt1FJxql8gMRIIM1kHlB91c/l4WgQywqqjynmw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J51BqwH4Mgi38xYMrKPxTucGb4yCbmhy9mUF2qIoy+Qz5lIM3eEzMqkOFeTjErM+hPilzr3cthPAQowolz7nUlcLp0amyl0751khpuO65FTkCWpUi5WkkmC3t2sLBXT2yhpk9artf0h5XDVAgvdlaRUmtxkxWPoQj0IJK5CFDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qT7W42lt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT7W42lt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479D8C4CED3;
	Thu,  9 Jan 2025 16:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439405;
	bh=Du5pnmt1FJxql8gMRIIM1kHlB91c/l4WgQywqqjynmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qT7W42ltj2f43G/7U6AVPa9vbzAth9B4TQngw8pFQxmYgt8Ez5ooMj4bgGbVTrgfE
	 /ftywwwS66bsDBgRe+d/k7/KZWpwnvJtIqELiC7G5ZV32txAJ6P8hWg5Y3Ko0XMFOv
	 oKfyJTM8vip5o5w52ZDx+WIpqJ319yKINDON5GLiDIW5m3RjQLoNf48wqFg7C6spkO
	 tmSZukYhasu084wmbim1LeEgkiZaltIEtcHQMZ+DuNgcKG50NSI5v3WFoA6R7egYv3
	 x4byrHNbblukyfRb/rFk8U6oPOJgS72wkLZq9VIXWYYlHofp35gjKcxpzkvjsj4Lmc
	 1yMiAgXN0j/2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C48380A97D;
	Thu,  9 Jan 2025 16:17:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 0/1] Enable Bluetooth on qcs6490-rb3gen2 board
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173643942698.1375203.6019531201019539280.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:17:06 +0000
References: <20250107134157.211702-1-quic_janathot@quicinc.com>
In-Reply-To: <20250107134157.211702-1-quic_janathot@quicinc.com>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, quic_bgodavar@quicinc.com,
 quic_rjliao@quicinc.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
 quic_anubhavg@quicinc.com, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 7 Jan 2025 19:11:56 +0530 you wrote:
> - Patch 1/1 Utilize the PMU abstraction for the WCN6750 and update the bindings accordingly.
> 
> ----
> Changes from v6:
> * Elaborated the commit message with more information.
> * Link to v6: https://lore.kernel.org/lkml/20241223135700.22660-1-quic_janathot@quicinc.com/
> 
> [...]

Here is the summary with links:
  - [v7,1/1] dt-bindings: bluetooth: Utilize PMU abstraction for WCN6750
    https://git.kernel.org/bluetooth/bluetooth-next/c/7e99441aa705

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


