Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C32F4ED
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 21:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743543599; cv=none; b=SFbmsHVt4S4HEKImDVMkdys0kTVrgkqXHRC0fGfeqlugnBV0w/dFsuXuIhhO7+3vsca6Bp4xvMBnCmwzsrRZjgcZT27rpuePHtNAgnEBesnOZdpD8HkTGKMypYt8fkjtbDK19eqKLictS71AquHzdKIKBt6X+rURrynVUjx8egg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743543599; c=relaxed/simple;
	bh=OJA66NOyc+aaaaITZEy2a0milyuj7J777QXiqQvJ3cY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lgsboim8Wg5TzNqOnJswTpJIn7EEhILRPx5tQz81WfCqlxYSOWrsd8IUXJ4DWjn688mU7tdEQFOMC5SZoUsZ5T9P4jU/GtHeLac8kKQ2yWaJu1oqVb7Mf613XyHjIlHrhJveG0I39Ayk16647JaEO7Lr57BcwnYMj9zebj7gzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvyNEDvH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvyNEDvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F566C4CEE4;
	Tue,  1 Apr 2025 21:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743543599;
	bh=OJA66NOyc+aaaaITZEy2a0milyuj7J777QXiqQvJ3cY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lvyNEDvHoC8/k4xZ/l/WXZEAF18SoB/IIhFCtbzlT+ZwJPQu2K0icoICQn3L0/oev
	 99XYRlzngUPSyEJ+wldpQKwQOdBZVBcdl0mc5pSptUtKo0dU/3Tg5wEveqP2WD53ZX
	 jA7cLHWuF5iysQ2JSNfB76BgbkzHK+Nxy4ShTvW/+1YFhrfh+uGzt3shKBYFTLv3XV
	 p+LlmzwCZdyrxsd0gotoc4mSqECymnCFAF32J90N2Ei6FwfQfsS62vKbLdPZoTBURQ
	 lGfOiMmB9Vg/6KuOs0oqry1xq95CQa4mAKvlbSQIFjXCEmyEvGngZq8n0F5gQfRdOt
	 2/df8Nn6E8x1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DD2380AA66;
	Tue,  1 Apr 2025 21:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] shared/bap: Fix swallowing states transitions
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174354363575.930303.10641347854085068455.git-patchwork-notify@kernel.org>
Date: Tue, 01 Apr 2025 21:40:35 +0000
References: <20250401135115.3735533-1-luiz.dentz@gmail.com>
In-Reply-To: <20250401135115.3735533-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Apr 2025 09:51:15 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> In certain cases (e.g ASCS_Enable) a Control Point operation may change
> states multiple times causing states not to be notified.
> 
> To fix this attempts to queue states if timeout is pending (state_id)
> and then proceed to notify them ahead of the last state set in the ASE
> so the remote side is informed of all the state transitions.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] shared/bap: Fix swallowing states transitions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6d20a300642f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


