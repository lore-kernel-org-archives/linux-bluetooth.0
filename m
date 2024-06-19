Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486C14F9FD
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806229; cv=none; b=u6R3coQZC+n2NpTl7OMupUvgTdmwqtfVbGtmOujJwZOvRqJ7Yfkip/iWZumXaTwU05xUuHUlTYQzW3JOVkYQu8v5Yu3loWlKGmgHsS83CD1238OwU9nSj1nAJEaJNV8bdF8Q9AdITkezKS+Fq+m2azF2lCCnboX/UbQ92Ou06JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806229; c=relaxed/simple;
	bh=Y0+DexkDMqfmH/+47Gp5RFqbiSJRj4AnIGyNJkmvUgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gLMkCcGcu88J5qe5AZp/qeVc+bZohEqCHgtp3Qt1FvbmUEhpeW27qIZUip5QOJrJVi2619tgYM8R7ACc9xQ2ZvX8pfM0dopDgm8wcN4T/z5NdfLAySIsKZ33zb8qyqfeOMhr6K1T2ZBKDb5OXiAcLUkMJlmri+mLtvT6AqDHGkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDoH4wJH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDoH4wJH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B506C32786;
	Wed, 19 Jun 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718806229;
	bh=Y0+DexkDMqfmH/+47Gp5RFqbiSJRj4AnIGyNJkmvUgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hDoH4wJHTXPfqWAN9aB5Fl3fRmpiJxrBsxBm3bDhMSbYHux2NsLAAiwmBghFkUKfF
	 kJHdGfuIVVYOf+g2q7l6nAfJBYE0MbjPKvcmY6/GJxhR5SGDi9R2jEVf15gKQsy4AZ
	 81Os6ycGK80MDtl6ztNbjKW5Mr6qceHCoErvkFax7XTTJYQIsn7chZ88/rVC4eMz1u
	 piN2PUrUlmkVikS3dw3yC3vTfLcseMiFzDlXPrZ7QGq0JB9YA/P11fSqS4b+iAE1cn
	 S7874bZejKp99welUTzgEZI8j+Ecd/qmPGMytdFljQntP1wwbitJKwBg5jMeGE/tVP
	 R1t7gzEmD14Ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F0DAD2D0FC;
	Wed, 19 Jun 2024 14:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] shared/mcp: Implement next/previous track
 commands
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171880622911.19669.9913507880334963530.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 14:10:29 +0000
References: <20240619120433.3666313-1-yauhen.kharuzhy@softeq.com>
In-Reply-To: <20240619120433.3666313-1-yauhen.kharuzhy@softeq.com>
To: Yauhen Kharuzhy <yauhen.kharuzhy@softeq.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Jun 2024 15:04:32 +0300 you wrote:
> Add bt_mcp_{next,previous}_track functions to shared MCP client
> profile code. This allows user to have basic control of the media player
> in addition to simple play/pause/stop actions.
> ---
>  src/shared/mcp.c | 20 ++++++++++++++++++++
>  src/shared/mcp.h |  2 ++
>  2 files changed, 22 insertions(+)

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/mcp: Implement next/previous track commands
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a91471400f97
  - [BlueZ,v2,2/2] mcp: Implement Next Track and Previous Track commands
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=811e48d340d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


