Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6BD19F479
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765232; cv=none; b=qwBHXU3M699reXL71oVOZZE6hnTphLuHQK2NC5B8qFYHNI6LSaQvDsu3GQMFBaveMRCM2fchsVkUrvkQZGhdxjvW9oEowfjiH81g18NFl2CX/iBBwXZxx1tHVDChFAUtkn9qI4E3CxRYejrLnMWV3zmYM05XqkBwTQUEPBZ4W0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765232; c=relaxed/simple;
	bh=o/7WDdbT3w1p8aLyXJlX/Ly7WI15BSiPbMx8Y30RdGE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BvHE9mxeCYNBxYREiz28I7OzgMcLauUoZh05Jo77Wvnm2Jz7AeLdKrUf4yZICeWLxzKrlej2+84v0ZA3EPeedW13yvTk2MhfySI7GHYH/VP5TjLuCS0dEXL9mQ4/CGlDvUJ6osqOhozkx1fOJtZyKRD/dHK6X+MAAoyyoaBtUt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ25VOXS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ25VOXS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE6FC4CEC4;
	Thu, 19 Sep 2024 17:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726765231;
	bh=o/7WDdbT3w1p8aLyXJlX/Ly7WI15BSiPbMx8Y30RdGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LJ25VOXSJr8rBNegbRBAb6jo3PWIl4pR4oNOQp7h0UV26T9Pl5cHXtrIpsFEchuiO
	 uAS+yb002DWsOCsy+NBl6DvHdYdbiDrxcxUgYxAdwGykluaaSBIEhS9S+2oROj+5Zd
	 PMVHuCRth85mFPMMKPiM/v8b0ZcOqPcoPPR1kgvBDSy+NON5d3iNANOJTlO/w3PyCx
	 jyD4jYRKhCKGtKhNFmNr7ilbKhh2jRqB6z6FZTlz5b0RowkGdaINbHssj38p5TEwuL
	 M0yuKcoRiRoPtKXuo2Pxy4/kSIZPaABTDR41bTalB4b6AWAE6QAByikg/MN0HQcI1r
	 cB61JzrRboeCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343193809A80;
	Thu, 19 Sep 2024 17:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client/print: Add decoding for UUID properties
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172676523300.1624116.3324367097690246263.git-patchwork-notify@kernel.org>
Date: Thu, 19 Sep 2024 17:00:33 +0000
References: <20240918192707.686174-1-luiz.dentz@gmail.com>
In-Reply-To: <20240918192707.686174-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 18 Sep 2024 15:27:07 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds proper decoding for UUID properties with usage of
> bt_uuidstr_to_str so it can print the 'friendly' name as bellow:
> 
> bluetoothctl# transport.show /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep4/fd0
> Transport /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep4/fd0
> 	UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
> ...
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] client/print: Add decoding for UUID properties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b22859e3cc0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


