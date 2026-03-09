Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B63B8BAB
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064812; cv=none; b=Rk2VJzNJMvN9R7qmI+Di0+ZZMDLBwvofc5Y3AEpVVipRP9PqM9lCAgpCFFzk4fyv2y+XVbFHkECp+654OwRGsRwg+e0N06xBICZQ240p0n41prfUFfvZaK3X1LmsN4K6HiQPd3P8GBUlvCZ+q1ZIpOAbi3KS5ivIZBoWcBPZSx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064812; c=relaxed/simple;
	bh=SQjlVPbrXMcP7FNMVHsxXAS/iDhC9+PKSI1jdTNcsIc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hPWf519zzE34q4nEC9cSjt7snZWBuKba0RRorZ9tlzGmvkR85q7916q3O763ipKAgAdkk/shrmtL1JMTb089wnDqR9dU5EwhANy5lxKeFjrJrBzOHj3dJI9HaT0+c532L+Z5RxRFtU2fz6Be49ScUq3vqnVYYrzx0BY+5BJlSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZOEiGdI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZOEiGdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A8EC2BC86;
	Mon,  9 Mar 2026 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773064812;
	bh=SQjlVPbrXMcP7FNMVHsxXAS/iDhC9+PKSI1jdTNcsIc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FZOEiGdIxpdVw0pET7DWDVsLcfSw4NBNl8iU9jT67DRlnBqd8fQrUKy/6OpD1kirV
	 MwrMjqW4PxlPpM+uy1bt6ARC8gaxHAL9SRkWgfmwb6S1Mdw4dC0RDbtxaKJmeQSSXj
	 S041GMB1T5TJcduLRkXaDXcizGp+k1HATxi/ROXgkjdRubDxt0eCajYgyffbK2QS6j
	 2+yqoXO1kOXqskJoywhn/iFM58d9SurEhcYUDyDd7dXfhgb//535wX7wrYnBkn2+Vy
	 8Fa5SHIZ+fi3+7bfcPcLLiHvaE0CW2M+ywkApqAl36CwTHqM6+ywnU6wvnCSgd5grv
	 lgIDsVy0dNpJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EA13808200;
	Mon,  9 Mar 2026 14:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] Add missing string to list of commands in mgmt
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177306480954.1231626.11120850111186034632.git-patchwork-notify@kernel.org>
Date: Mon, 09 Mar 2026 14:00:09 +0000
References: <20260309015745.1720-1-wolozgabriel@gmail.com>
In-Reply-To: <20260309015745.1720-1-wolozgabriel@gmail.com>
To: Gabriel Woloz <wolozgabriel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  8 Mar 2026 21:57:43 -0400 you wrote:
> The MGMT_OP_HCI_CMD_SYNC (0x005B) command was not included in mgmt_op[] in mgmt.h - it prematurely stops at command number 0x005A. I added the command to the list under the name "HCI Cmd Sync".
> 
> Gabriel Woloz (2):
>   Added missing command "HCI Cmd Sync" to mgmt_op
>   lib/bluetooth/mgmt: Added missing command "HCI Cmd Sync" to mgmt_op
> 
>  lib/bluetooth/mgmt.h | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [BlueZ,1/2] Added missing command "HCI Cmd Sync" to mgmt_op
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9c6e97516cb1
  - [BlueZ,2/2] lib/bluetooth/mgmt: Added missing command "HCI Cmd Sync" to mgmt_op
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9c6e97516cb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


