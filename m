Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B3E14A093
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300430; cv=none; b=ViOoAUVMCNJQaSP4DgapEj/VsYsn1+HVOejcgofAK9e9SlWMz1yu9mRQky5yS3CRE28x3jSU85DSMHUxqU5bIarRdbkhQQMywWVbrT1HaAfH3V5fqQk6TanHRMXNXl4w/Aqh+E4SyblKaIDVhwRRL4Bq1OEDTgPD95sx6snEGhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300430; c=relaxed/simple;
	bh=01dKhvsoQde/ygXruV4R3Zvahru5L/h7J9XCvl7Lnn0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VG7kgE6DYrhlJhVEZ1FWqfZYL5VqUz0GcxwhH9uYQ/Ue3PEawO6zGYVyIxZTr8DSVT6NwRwRhP7F9Oe5Bm/IXTvw9Qh473wXn6Ej5MEJHpli/gMMG7aXe9ma+9npdAmN0ezwDgl3vqWeV60mpX3WiO8WggAh0YI0dqw4UIhhZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tM20g9bU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tM20g9bU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6F8DC32789;
	Thu, 13 Jun 2024 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718300429;
	bh=01dKhvsoQde/ygXruV4R3Zvahru5L/h7J9XCvl7Lnn0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tM20g9bUt6LZcJLRVpFlW7d4l0iRbJvc2aPx7/m4s1QcGaSS1oRGp+5CDRdbZHSm0
	 NWp1834MZQbb3xHdACGld77fk4hSSTVLrN14dw1R7Nc79d/EdsY7mb36EjzGZQ6O0B
	 WmD4YDcfu+kO6/W8Y4pqxvH2Qu10YSZGxiAfyv5toEg6yVe8KsZM7ULdrNyZcrjJTx
	 NJS9XokkGkiTSkkIo5GnbHAByMOEqMorF72EZndymbglP9AmX1HmG3p4oXJ/cMGHMG
	 UVDiqLAJNB0GIaikYhHFYXMEZYyk4tk/62XhZynCKVOg6enXprwl8y2f0DDBO2gbm+
	 kGsmDWR3Rkt8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8C8EC4361A;
	Thu, 13 Jun 2024 17:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client/player: Fix transport.send
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171830042968.19766.3335532854851472168.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 17:40:29 +0000
References: <20240613134854.1545034-1-luiz.dentz@gmail.com>
In-Reply-To: <20240613134854.1545034-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 13 Jun 2024 09:48:54 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the usage of getpeername, introduced by 04153538aaf4
> ("client/player: Fix using unicast QoS for broadcast"), without
> initializing optlen which causes the following problem:
> 
> Unable to send: Operation not permitted (1)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] client/player: Fix transport.send
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7861c511ca7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


