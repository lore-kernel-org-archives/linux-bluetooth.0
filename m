Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A50E1F4297
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530792; cv=none; b=QEMbk6ta02T76Hfx2efN7h+W1mWCmMcAPY+yzY1dC4NPFDXYWnp37pYQK7XUE6vij0O9wLkJn8AQUcIWVtOJUtNCsv1pM2o6cTtw5bG5nNNp7ygJRtRv53f3KqHhA/mamRJILBQ90Hjz/BtQAI+Rqil0MtP5SQpU53l+2kR8KBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530792; c=relaxed/simple;
	bh=LayZdEAnGxj3XcPsgvDXqT+ZUVlXRQBwURYEOO7yGlo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z+hkMe3PLBHySQKUcNyJaBFUGGXCGoHSx6obEfbBmLH/VJZycgJp0CFEtBKQ8vZnZKRQuIew3mff5UlIEi0e0R10mSAO/GXLxZtL1eoNynaE4+iRzGzwSDFEMWAoJj6C6zYnsjO5eFP3DSW6jR9CqAKXlIHpg11x03WAnPUiv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZWdrMqt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZWdrMqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A535FC4CEE3;
	Thu, 24 Apr 2025 21:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530791;
	bh=LayZdEAnGxj3XcPsgvDXqT+ZUVlXRQBwURYEOO7yGlo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eZWdrMqtdfqR2c9UjYUiTO5BVxL7bhywBCRMERXwCP95N50sByfPancvh7q5WGufC
	 YVqJeIa2OhwDtDdE8VBzmsKFUsEprdW//hASSXzNCCLIfBGqfapZwKXVtgpqOKhWgP
	 n2Et3n3JWOqCBgiowpN8EMcqTvvEhFE4QLWpIy+z3RkvDRvcqLAfzKUDkhfbtTQt3H
	 BV4/SLRizJP0YacuwxP99dGJsCv7c4dturdXP3X7Vw3dBN7c0TvNwBckWXSsJhrgPH
	 GD3e40qc4ZsPrsX9k3f2wCY8YT+oSLVGSyMt1m8dBPlq71t9TQRcnCrozYBQhiCQH/
	 RdGiBkQBh1xmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D32380CFD9;
	Thu, 24 Apr 2025 21:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] workflows: Add checkpatch action
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174553083025.3499833.16686023878410871107.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 21:40:30 +0000
References: <20250424195643.1375697-1-luiz.dentz@gmail.com>
In-Reply-To: <20250424195643.1375697-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Apr 2025 15:56:41 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds checkpatch action rather replacing the custom CI one which
> will be going to be disabled.
> ---
>  .github/workflows/checkpatch.yml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 .github/workflows/checkpatch.yml

Here is the summary with links:
  - [BlueZ,v1,1/2] workflows: Add checkpatch action
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=55b02fe5a2bd
  - [BlueZ,v1,2/2] workflows: Add lint action
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=faca96e9c9a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


