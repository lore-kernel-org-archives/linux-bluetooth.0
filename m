Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A31DE3BC;
	Thu,  3 Apr 2025 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711601; cv=none; b=JUwjVwxOSerZr4FkpkNux88JyXHoMOOi1Ad9x0ufkI2FntALw+AJAY7rmI3SPyWoYZpExrYfkvEWjTPIiy69jKnajPc477NzP+32OTNvAgZZX73sy0hjoqmMvA8eOrqnOaEEA4seZATNUibtOHL3I16Bxyo6XkxK1HTo1GA4GPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711601; c=relaxed/simple;
	bh=wvPqjOuOR9Ulq0WgG7bG13zjd9XVTH/MjdiQJlpHGlE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L7VdEdQ3vAyY9q9ljiTtXXhoC6pDmpzYLEtjSpjd2FyEXVnfC5sN2rSw9QH0tba4EWSjhlS//vcn9aEcSUnplU7hRb/6JrVxplcTwYAxGAKoN+FRfcaZplIJFFBPWfPUzu7lzvqJsZ2/GxtcUN93xvQypj579rfEzD2/vzNYMfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKSy+OFj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKSy+OFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41318C4CEE3;
	Thu,  3 Apr 2025 20:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743711601;
	bh=wvPqjOuOR9Ulq0WgG7bG13zjd9XVTH/MjdiQJlpHGlE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CKSy+OFjQ5XVP1e3hVaSiTLVJslb7jr3VACO0oGTjvwQU+4UTopuZje9D1PVklZE7
	 8A+CNXkvfgt3Z1e65fHPVrUYiupQX0wOlvd+Di6zxlbzU524zeF9gGx4W94uNiro/p
	 9YtkvbOVkvq8n3CPrHF636uh3mxFIR+ucJmTWrVzBmVS9CJc1S0w5nAX4xdjqneSr3
	 YZdUC3lLv00h0uFwoWLmq6NykuXDxH6H8GzP8IgT3aSDDKG/Co30Hb8cfnp85t6Im+
	 coMH04iYbOzCYtY9gbtnWNTY1eGKmugdzvFfz5eBpDyV9UgSW/Wd7hbHuxPWa1tO2s
	 p1jF3CqG31w4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EAB380664C;
	Thu,  3 Apr 2025 20:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Revert baudrate change in
 nxp_shutdown
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174371163824.2672071.8887469535332941682.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 20:20:38 +0000
References: <20250403150223.4136-2-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250403150223.4136-2-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Apr 2025 20:32:23 +0530 you wrote:
> This reverts the change baudrate logic in nxp_shutdown.
> 
> Earlier, when the driver was removed, it restored the controller
> baudrate to fw_init_baudrate, so that on re-loading the driver, things
> work fine.
> 
> However, if the driver was removed while hci0 interface is down, the
> change baudrate vendor command could not be sent by the driver. When the
> driver was re-loaded, host and controller baudrate would be mismatched
> and hci initialization would fail. The only way to recover would be to
> reboot the system.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btnxpuart: Revert baudrate change in nxp_shutdown
    https://git.kernel.org/bluetooth/bluetooth-next/c/17931d1b6d0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


