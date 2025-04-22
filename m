Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887581F8756
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359198; cv=none; b=prUSs3ueZyXUUnysLpl+L1TlrXp0x80Oci6TxJ+uMmu9EK25I9xFxc7T0Sdn4oNNU5M+Q8r2U9fURXsUkEAQ8IW1fjKkfBvExiqX6Z9QSwQ9ttIYihiZJ61xcctq9mLOkMxGop6+YDsELjVKNLezF9yRhYtZX+GkFQ3VueTi6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359198; c=relaxed/simple;
	bh=Ezi+1nz0oPrS9jr2cibh2a7MmgaW0BawMHsvvX2/RKE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RWcPUIwGl35CV6Na0le12Qj+k0oOixB67i+N6+G2P84cqIeqKn4i2ULASEc8MLFbHN87189/Ylrd0aMTWfiAyRxZhWAhNsb8WNPEJLBLAM9KYyM+Kc0UhpTgijpvQfqByKUDPdcWuUgf3ddw5SEoTU2al88nVoBccrBOheSp58Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txh7oIHE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txh7oIHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08465C4CEE9;
	Tue, 22 Apr 2025 21:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745359197;
	bh=Ezi+1nz0oPrS9jr2cibh2a7MmgaW0BawMHsvvX2/RKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=txh7oIHETS/96/3dhQkgPvHbCRd71AR36FoPmfcRA/bjT0OR8SlfiiDCDpg7ZGy9z
	 a5eg2j4auVEPliKRiZdRimgoA3vp/nJo+ZNHvYGVb0QGq9nXrgYMIUrwDdfwfkObcI
	 A9W+z98TRTP7NRVDxDfqftfj0OfwDIJmb15NJwY/sJOC/C3m8SdhnEbzFIdHA9n5Zm
	 1Wp5fKxCuDTYfI0Ny1/7NFXpS77dhJDVaXTPp8gFiaq7iRhMo6GyuDc2zUA/U/TCFI
	 mCsrC/TCn1yZLeV+DFzqifDMCC2V/BKWUqeIhCxPT9OJc0T+j+Ivo1p3/pgJu7GvOM
	 RvA/QyKP/iFpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE82B380CEF4;
	Tue, 22 Apr 2025 22:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] workflows: Add sync action
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174535923550.2067560.567124223573252925.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 22:00:35 +0000
References: <20250422214935.993192-1-luiz.dentz@gmail.com>
In-Reply-To: <20250422214935.993192-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Apr 2025 17:49:35 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds sync action which was part of https://github.com/bluez/actions/
> but it gets disabled every 60 days due to inactivity, in addition to
> syncing with upstream repositories it also syncs with patchwork which
> created the PR and then triggers ci action to do the testing.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] workflows: Add sync action
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=46e6a3856dbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


