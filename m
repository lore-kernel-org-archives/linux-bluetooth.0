Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622E208BA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246450; cv=none; b=AHKf/qZi3gC/CQH5Pj+fSvKpD7pX2vp3wBdFW7UQU561oOuE4SP4YOAOxlEJUuocDekPrj/S1Cydbj93aBC4Ad4pWZHGp+ZXyLi2YgqqA9822+BDOMKHeGyhYJgLAr6j/i25MaD1LynxmV/nhgS7Df9Gt1wKZPtOiYi7FmqiQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246450; c=relaxed/simple;
	bh=b7gtm5vfvXAqzm9pqjsaPSPlr+hbpm2FKV6xFEnflL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=srX5aBps/KYJq4Qyn/gIv6gzUS3wnmEVXtQJjgYasBwOd6B3zsRBWVmTWXVJYpGWg+L7ngoBX+QYdWtO4EhppramS69U9zkyoDMfJFHoYveu8VDYrz3giq0/YENpfRCdU4ypXkT4jzjnkrtqDQ05vAoiy7PTDVVXPAYzCt30ONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPVYE8W4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPVYE8W4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94158C4AF0B;
	Wed, 17 Jul 2024 20:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721246449;
	bh=b7gtm5vfvXAqzm9pqjsaPSPlr+hbpm2FKV6xFEnflL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bPVYE8W4T8ohZq73wWXEG3O1H1UWmUoe/F0E+7dioopMY5JXC3wkFh3DGOKJCfr0B
	 5lYmj16506PsAbWKTqaETHZxbE7albsDwvqTj6KG7yirXJl84pzejOYN2KCd51NM20
	 Rd2knisTXoxFhF0SCFdHfo8ARb05Ah0L47OQp8Qz0+CGTxyqpFAdI1Mj7yDmTZHFeq
	 z+4bbLEFNuhqdYFebfJX7qKlkDuB+LV2R23QNY1sZsFFobYplmUCU87IJMSntZmTWT
	 M3OQHYZ8QRDZNJtbxGAMQqHnVvJgGw30ijae86dalnLjo6v2wqBOp0YmnHBSZXE2oY
	 d0Ic7LVeFHjZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B083C4332D;
	Wed, 17 Jul 2024 20:00:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix suspending with wrong filter
 policy
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172124644956.29564.11708078781870404249.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jul 2024 20:00:49 +0000
References: <20240716150126.512727-1-luiz.dentz@gmail.com>
In-Reply-To: <20240716150126.512727-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Jul 2024 11:01:26 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When suspending the scan filter policy cannot be 0x00 (no acceptlist)
> since that means the host has to process every advertisement report
> waking up the system, so this attempts to check if hdev is marked as
> suspended and if the resulting filter policy would be 0x00 (no
> acceptlist) then skip passive scanning if thre no devices in the
> acceptlist otherwise reset the filter policy to 0x01 so the acceptlist
> is used since the devices programmed there can still wakeup be system.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_sync: Fix suspending with wrong filter policy
    https://git.kernel.org/bluetooth/bluetooth-next/c/54dd4796336d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


