Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DCA16C44C
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758230; cv=none; b=HRP48iiaf9gSIjb7knpaBy9PPKcOviq7NK2d2fEdGeBIZAmsatAMA78dUcA4tVhQ5BTxEbjG+k9aMwZZbGoVHDNeaCMEfkZBMaof7s7aNBqwkUILGA3868YbyWTiT5wU/nX3ZLBl6MnHJFQNLfBJ8/up/l+VEXdhsrQ4CmqAwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758230; c=relaxed/simple;
	bh=/D5eJHhHP6qQ4txFywgwwFN/Thrp0zLwBTpOXMW+U6Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s8OLC/R48Ao6jtSgLpaL1HMz0pu9/Y+KwS7sY6fPpLVBvigB3kZTXcZhjeMFJal/kn9bk2WcQ0R0W/GWAc0Hf6p4FdFqna3Gja6Iw1rvIUtntYd6mdiwxCG17FSIVPwOR/HhMljgt9+NzCOR1PIS7cf4WYMFyVOFuMdcBFXTN2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9qKTuyq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9qKTuyq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38C52C43143;
	Wed, 10 Apr 2024 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758230;
	bh=/D5eJHhHP6qQ4txFywgwwFN/Thrp0zLwBTpOXMW+U6Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y9qKTuyqife2bTTHa2FJQKs5SyoiqrYHezzt0ZjaYfE4NNP16B6gpsJqR8T5ghpNY
	 Cg9g+Xu6d/BpedTXgqTddfCjUld4pE6yCzVDg3PwwsSYTADrF53eFF9jXUzajCfxGh
	 CG4WzxNhn9rJB0L5uKLCHzDHfdHKYmNEt63lNRF8NwCr0Su8ygYgzPQvcLPPK4roJ8
	 eStq5AUR7bKPPxtUL4QKFeqhJiQUzUnVFNu7fEW6zpy+BV9bKaEhSlb28Aw7+dDQ0Y
	 KEQQea721QUHHwa64Qwd+I412QtvVmp1Iqu1fIQ99e8F3bTUUWSFp2fVpVbAXReMBG
	 6agSFOcQ0DqGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F7AEC395F8;
	Wed, 10 Apr 2024 14:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH resend] Bluetooth: hci_bcm: Limit bcm43455 baudrate to 2000000
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171275823019.12683.2247666157369550689.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:10:30 +0000
References: <20240406135106.16821-1-hdegoede@redhat.com>
In-Reply-To: <20240406135106.16821-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  6 Apr 2024 15:51:06 +0200 you wrote:
> Like the bcm43430a0 the bcm43455 BT does not support the 0xfc45 command
> to set the UART clock to 48 MHz and because of this it does not work
> at 4000000 baud.
> 
> These chips are found on ACPI/x86 devices where the operating baudrate
> does not come from the firmware but is hardcoded at 4000000, which does
> not work.
> 
> [...]

Here is the summary with links:
  - [resend] Bluetooth: hci_bcm: Limit bcm43455 baudrate to 2000000
    https://git.kernel.org/bluetooth/bluetooth-next/c/fd6790ea67ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


