Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2917A15ADB0
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763029; cv=none; b=EbJcqiRO+L8rqra5TlektljKs5zxvAOQd35HmkdLSxSkPBoK7q0Ryr01c/8h5lIDWwgRc+VO/zmhtMorVo/v69LKqltqrxYktvJJqSw2susOiaFodJFNwOYTs4WO0am2kvHOTkUDsuYbS8jsXPX+73Jk15l2Bh1mIGNMCKc6ivY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763029; c=relaxed/simple;
	bh=bVgalM/7k0Gw3Q0e03FCEv5zH7x//COKUWJNol7lB9A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LAOcA0/CJVJnyw7WJvsmvm+/kNkNDdvM1SHF0aCypfYrm+7ExT2HdlgMZ7j5Czyjg8UAKYD6m0gsUPok82JuO0Fj/n7CO33pas+Ce/ygBSSidRFuNo4DvbtCakwC6O59RB9b7Z0dZpjqrwGm3tpPLON3KfHtsdStlEIc6e8wHCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u88R+Nig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u88R+Nig"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B77D2C433F1;
	Wed, 10 Apr 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712763028;
	bh=bVgalM/7k0Gw3Q0e03FCEv5zH7x//COKUWJNol7lB9A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u88R+Nigsm8CZwdkmmMeliqjgIbhZlBSqf9QfOZ3aLmuj9N7FV1IGoHz0h7vySw/w
	 G6lVLwwAYIKumds/uOyfiOPV/jcN7R0GZFh5sLxEri6XsrEIy+OsjEGknjgf+navnV
	 w1MuSJSlkOv0SBFPSKkDb575P3a3t8ZzFqAhq01MXXBkPx8b3MHF1GUyVeu7/ozwrQ
	 Bqzb/NpGqvNUMWo6NAXUhpURY6WemwBgVvt/6dgXGjfTOQ+mBaHBv7CDD8YWnROsYU
	 8JwYEH13z45A22cWZCR6W1LG/sImSu4wTBNbQC25KM29wb3XZcE6es/2SlkzHK1p5x
	 tsgA3aR2KLBcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6581D6030E;
	Wed, 10 Apr 2024 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/4] shared/uhid: Add support for bt_uhid_replay
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171276302867.30825.12868319147858515466.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 15:30:28 +0000
References: <20240410140205.4056047-1-luiz.dentz@gmail.com>
In-Reply-To: <20240410140205.4056047-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Apr 2024 10:02:02 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for bt_uhid_replay which enablind replaying
> GET/SET_REPORT messages stored during the first time a device is
> created.
> ---
>  src/shared/uhid.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/uhid.h |   1 +
>  2 files changed, 124 insertions(+)

Here is the summary with links:
  - [BlueZ,v3,1/4] shared/uhid: Add support for bt_uhid_replay
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=991ec8e2e088
  - [BlueZ,v3,2/4] hog-lib: Make use of bt_uhid_replay
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a78c839b5d85
  - [BlueZ,v3,3/4] input/device: Make use of bt_uhid_replay
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=528f5a8c7d76
  - [BlueZ,v3,4/4] hog-lib: Destroy uHID device if there is traffic while disconnected
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b163e2bd0303

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


