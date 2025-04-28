Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F820E6F3
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876391; cv=none; b=JK2EFrBKXR9/je4UOBbg2saIdzSZmZbwv44pnzjMSNkURoDEbs5b8DKpUPIhLYk5cKPdpmholi27l426b5b88Ij3NHQbCrCeg9czeqVMqho5AOsULcoVQ7j26WdjtqVBK/i8wj5+cZ6UEiBoIff0OFpFI8oHUskJ02hIpafK430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876391; c=relaxed/simple;
	bh=dtXV9lmXPohtO6FIi8Yfrrsl9dpnq+31u4gkdqbTyDs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NSfX7nJNw86eEb7E6pbasDh5UpPS4+5IEbSTrxDB+jVN2IqlJiMhO4PDoumJL5bSv8aE1luYIOSZt+/AzbUFD0h7s08HQhvCC7RwgxUTV38RgfpY22KzH08LizM0zG2ysiio0RVQKHXMmwLutlXVnRHJNZPk1zuYg0uIIvXgGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uULBml6H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uULBml6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C1DC4CEE4;
	Mon, 28 Apr 2025 21:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745876391;
	bh=dtXV9lmXPohtO6FIi8Yfrrsl9dpnq+31u4gkdqbTyDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uULBml6HxSI9hccFtMs/k8V+Sy9qAL4b/BxEpSsBNV+y9tSHBTGapF7HbTX9HIkVu
	 QU74A5WSZ29SRDpIPwjG8w2I3TLIGhU18HYGSx+TKWstsIvNnN8IqUErS+zT3KsWB5
	 4WApDzYBdfUsFjhlpsSXOvtozDsM3PJFKMyEd7AnOSHaOdGpfqTgm4ONyc6QWvURiZ
	 xjBtT2vZRqD9d862PmeOSqLqaE428HLX0QdBDQ1ZxT2SLHJjWwRvfZCV9VGX3ohYt7
	 9iHLPfuH0CsUa0xyI3NGWCy8RVKr4c/+A+LzdzTFK48im2JyxkUVxOpg46hYZQq0WM
	 j/2s2IIu/QNOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB33822D43;
	Mon, 28 Apr 2025 21:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/5] main: Fix comparison of narrow type with wide
 type in loop condition
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174587643000.1053120.12071776672711237835.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 21:40:30 +0000
References: <20250428195122.2000808-1-luiz.dentz@gmail.com>
In-Reply-To: <20250428195122.2000808-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Apr 2025 15:51:18 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> In a loop condition, comparison of a value of a narrow type with a
> value of a wide type may result in unexpected behavior if the wider
> value is sufficiently large (or small).
> 
> Fixes: https://github.com/bluez/bluez/issues/1213
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/5] main: Fix comparison of narrow type with wide type in loop condition
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=295ec99499c9
  - [BlueZ,v2,2/5] client/mgmt: Fix comparison of narrow type with wide type in loop condition
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=25c23ffca7e6
  - [BlueZ,v2,3/5] test-runner: Fix potentially overflowing call to snprintf
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e18ce6c959a1
  - [BlueZ,v2,4/5] client/mgmt: Fix potentially overflowing call to snprintf
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=51adc109d41a
  - [BlueZ,v2,5/5] shared/bap: Too few arguments to formatting function
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f96f3b34db40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


