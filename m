Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF54EEBB
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756321801; cv=none; b=uGoUtfHIRodLKhcJXykOoy57Zm78ewqM6bRv2WvM2GS4jSPWHwgutt00bSC3kVrV1PCEKPTCEz/KSlkRzzT8pZdHIFdiUKQvz7a0mGQ542uLhgZSVpgHDSE6R7gubczantL3n5xWeJW/q+uvrg4JXMrGhdS1FGiuABjmNZQCae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756321801; c=relaxed/simple;
	bh=q6LK+tCY20WQ7EvMSsPGgLBKrz12VuadRYp4P/FuQ+M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d7d/Nn+OWSKKkF+/DHXNrfe0cRIon/FNi+Pa8yml/bC9tVlHCjDzMHm2fJCz4frMcDaeieKNZEQyEQ9/bjsNmqt6G3OPk+yKyfonMCnCGAEhwVJ0YPnqwppjdIADXtw+VjW3xlKOBPTBCIJ2KYBouDIMzWBOmjnjW9bQ26GTIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4sLgDIF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4sLgDIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D56C4CEEB;
	Wed, 27 Aug 2025 19:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756321800;
	bh=q6LK+tCY20WQ7EvMSsPGgLBKrz12VuadRYp4P/FuQ+M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U4sLgDIFe1npq8Sb+txV49NJaImpEhPEhfWAC3r0UzZiwMrWc9rrD587SCuOnwSfT
	 UFpsLpQ3ZvB1jYd+jD6ArL52AwqBz+FjLl+klClDQAGC4jRlS/3Dz5rIkjrBFy1nM/
	 LanXqUIsS0rLOM/TSYQ/fCiXceIQ9b6W/pQVqBMNDoYu+Or0ZtWTnKVH1ghqKCKZ94
	 L2A3UESw0B+4FS3CHs0KLCRyTGOHSJGIxv56p8sK+iK4Dv6rIJTE/1CJwLGa2UTo57
	 7542ZWjOqrojUdnnE/AnYYF12lYZwyvuF7RYAVwEQzIHZUF0UM6vjiE8mJENzr0ZRk
	 75qwdMsIGo9ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 47042383BF76;
	Wed, 27 Aug 2025 19:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/3] Bluetooth: Add function and line information to
 bt_dbg
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175632180802.807633.4679397145416652146.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 19:10:08 +0000
References: <20250827160555.1446966-1-luiz.dentz@gmail.com>
In-Reply-To: <20250827160555.1446966-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Aug 2025 12:05:53 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When enabling debug via CONFIG_BT_FEATURE_DEBUG include function and
> line information by default otherwise it is hard to make any sense of
> which function the logs comes from.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1,1/3] Bluetooth: Add function and line information to bt_dbg
    https://git.kernel.org/bluetooth/bluetooth-next/c/e845c8526165
  - [v1,2/3] Bluetooth: hci_core: Print number of packets in conn->data_q
    https://git.kernel.org/bluetooth/bluetooth-next/c/628a96509cab
  - [v1,3/3] Bluetooth: hci_core: Print information of hcon on hci_low_sent
    https://git.kernel.org/bluetooth/bluetooth-next/c/bc606b7bec57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


