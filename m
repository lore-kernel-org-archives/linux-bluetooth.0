Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788DA385D7B
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427843; cv=none; b=D4buxy5MHNu/XBQXT0n7iGP6UQSusjagBlhLFic6txQDXIcSry3Z952vubMqSmkxBj4p503MiSefgZMlobeS/Wjlr8/+FCj5YTmSwD2TiQ/PIXG+YQ7bcQWOuZ/H8vRR1aJEtPUyYKXYYsqXRK/0R5Pf3b44WtZxVrZ/iPS08nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427843; c=relaxed/simple;
	bh=x6xjbip1VOsE7dfYHSBEvx2TehxoyZbbav5MQ4PH+x8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T1lodnWhZu1c7el9QPeSjhtN2aCxp+w/pJjGQZgEDNMw9QVRWXARH0A6AGtQN0m45d/OR/9Qxm9QHZAXmpWpGeS4g2wXPTnyaSTYc/a5q14qF+mrsUrQIKbG3TMoJcpguTH6Yrh/z8e2GOFuO5yZ13uAxOM29mohrn31p7iRBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTBGaDnf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTBGaDnf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E841F000E9;
	Thu, 30 Jul 2026 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785427842;
	bh=jkGH90stR15SPmv4fbQLpMJ53mqO2kABC8awszoHMCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lTBGaDnfSWPlfI2uCv1G1frps4bhSgiqihsyxUx5xgAjnSJQbRKwbf6lgyduz1ZoW
	 /AuI82ibo5FJRLdsI51ZDKyKx0ttVibBUfDIinNYn5v7Akps94Ds06MwrFfTgycl9F
	 ws3U001dcHskDj5m+6yMpfGf55eUEzw1Lxr4swHT4kgnaCwOmORsPYVEi717pXzqrY
	 6MlPdtGif6xL9hfK6i7BakzTPjxKpq4Cv8KU9PbgA+fHHpMAr42tYG8UVeScszBfgb
	 O9GV9JIigrd9NunEmH5PQ+l0puiylMkTYca3cmz+cyDwY15LTp3Cap0Kzit/BNDAAq
	 cyXV3uH7O6tzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198FD38119E7;
	Thu, 30 Jul 2026 16:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/3] Bluetooth: Add support for Shorter Connection
 Interval
 (SCI) feature
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178542780564.4069407.14152947693810775028.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 16:10:05 +0000
References: <20260729202422.2658332-1-luiz.dentz@gmail.com>
In-Reply-To: <20260729202422.2658332-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Jul 2026 16:24:20 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Add HCI command, event and feature bit definitions for the Bluetooth
> 6.2 Shorter Connection Interval feature:
> 
> Commands:
>  - HCI_OP_LE_CONN_RATE (0x20a1) - Connection Rate Request
>  - HCI_OP_LE_SET_DEF_RATE (0x20a2) - Set Default Rate Parameters
>  - HCI_OP_LE_READ_CONN_INTERVAL (0x20a3) - Read Min Supported
>    Connection Interval
> 
> [...]

Here is the summary with links:
  - [v5,1/3] Bluetooth: Add support for Shorter Connection Interval (SCI) feature
    (no matching commit)
  - [v5,2/3] Bluetooth: Add MGMT Shorter Connection Interval setting
    https://git.kernel.org/bluetooth/bluetooth-next/c/f622ca15986c
  - [v5,3/3] Bluetooth: Add MGMT Load Connection Subrate command
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


