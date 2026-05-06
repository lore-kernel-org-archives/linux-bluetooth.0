Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D246AF2F
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074260; cv=none; b=B0WQHPyJXmewStJ9tDzwAyshsLl6SN/6lQzjpwoJ3/6c/J/osXuAMXJOCKtBqQ0I9McLER/5c5lN41qjI3PIiOxAxUduj7c2Ek+ExqwlSLILr0SFLaV8GNusRvN3XjRGDlmuoA/cXH0zu5TBgTb8WLbqvg0cTxM7cKk660ESlPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074260; c=relaxed/simple;
	bh=iWsjZ9Zp2IE7CSCSStSoO/C4cZtapqGiNB4zj2dtr58=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sg6cTbRj5g80UvUGXJAyiqJRsWt+sljOf3mlTAfd+JQxX972EBr7lLt/qByPkkN1TaErxJEVwx0Q5aEI4ux4LFyUDHMpxF/CNnU0SHQsx08GVFey7VIIU0Sez/r85jmGqMYjTBHp0mkQPvTZoeWxL3Ugz4mvPu36PcZ18RPB7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmYrkgVl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmYrkgVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D58BC2BCB8;
	Wed,  6 May 2026 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778074260;
	bh=iWsjZ9Zp2IE7CSCSStSoO/C4cZtapqGiNB4zj2dtr58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NmYrkgVlSmWbc/52k5krf4LiNZ5O/2tTpsT1qbO+DwBAc3QciHMH6wrDTsoOymcW0
	 T5AgSpRpabawEqJnnfSJobkIwPzMSDsthU+fYqxmxDdZRsZlRVkPtx2KJC+vgbaMm4
	 leSepXvLW71QY0sa6Ix5fUhnSAu7zV8miNLi9tHa+jx+MKfyD6Nuk+n3A16GYui++j
	 s7g3JaJBnaDXHBXPoVF0fOf+1as6uc0M1EJil3zL2EeOnHNYhulWgbIImUnGbnsDvh
	 SWGDZt9EVPcHweQxt7YmTIjtvOHzim/yrdo2UIT554F50IkpmctTA1+4VbE8pBBr/b
	 SJxXZzhM9VNZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FB7539307BD;
	Wed,  6 May 2026 13:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/4] shared/hci: Add BPF filter for registered
 events
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177807420979.2587487.13806192494847609628.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 13:30:09 +0000
References: <20260501143847.724150-1-luiz.dentz@gmail.com>
In-Reply-To: <20260501143847.724150-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  1 May 2026 10:38:44 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Implement a BPF socket filter in bt_hci_register/bt_hci_unregister that
> uses setsockopt(SO_ATTACH_FILTER) to only accept HCI events that have
> been registered, plus BT_HCI_EVT_CMD_COMPLETE and BT_HCI_EVT_CMD_STATUS
> which are always needed for command response processing.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/4] shared/hci: Add BPF filter for registered events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ccc22a919388
  - [BlueZ,v1,2/4] shared/hci: Add bt_hci_register_subevent for LE Meta events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=98f7190cf6b9
  - [BlueZ,v1,3/4] ranging/rap_hci: Use bt_hci_register_subevent for LE CS events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=45e1e7ca2243
  - [BlueZ,v1,4/4] hci-tester: Use bt_hci_register_subevent for LE Meta events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3502f9f51704

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


