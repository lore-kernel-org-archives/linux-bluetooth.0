Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA0C3B8D50
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064811; cv=none; b=Lcesnpzy8lppFkuQnEoOaYLJV9OrO1553OtmZInHAhkq3jSMp4vzKtIgK1cu8ZhE1ur7HKl5xruHQIDxAmQh1uUKcpPMZQtZ7OYaoy2fcyl2+HxauD9Sl1oRadMcqYJGcJ0TsDCfBWv23vyfyefgPkQsM5c+ftl61I5FEMWh7jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064811; c=relaxed/simple;
	bh=Hg7qoFwf+7EtuIhJvkyKtw/Us33++T4T++FVCINvruI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c8Jhwbw7S6PwHzUXj/eNK6/3gJF/aIbQ4JOIitukijdsku256Nx8ap3u29dv1XYmTD0/n4xSW7NVbbmf6Nie+1MMFTaZ8GYi2va1GcLX1Ixhj3oDQbampDQOOHThY8Di2Th28Hy6S9/n99ZQ+tu+Tdq1Ta3l53JhJW10kCJTWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLAP94Va; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLAP94Va"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EFBC4CEF7;
	Mon,  9 Mar 2026 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773064810;
	bh=Hg7qoFwf+7EtuIhJvkyKtw/Us33++T4T++FVCINvruI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LLAP94VaqTKAqoiUSEdErmdubSu7KB/wTTeQdoapbXL3XQ+0fMtPoiWWCPUPPejOJ
	 19TwyNF6IIpjil6pf4bJamxgKVQymAHYzIR/6hQfww7uOb+T/JQqXW3x8kcPdEXgrL
	 J9DlISb7K/tSeZZrRf757iySqAKilPV5vFh6mBMfkanOTwcnLFjyjKUpivg76QYkbc
	 sDmAxs51VzvEo2kmc8mb+fmv3E+uLeAJlr7HKxeo5mypmvNHEA5mkB5UpZnsMLqrjU
	 c3kJpGHKI8aL69e5hkgv4ajQ0xWdZkzQOMe0+3Nyf/0R6slNB0WYkpbrxelFolVjKF
	 XfWjVaWjhCjKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0033808200;
	Mon,  9 Mar 2026 14:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] transport: Fix set volume failure with invalid device
 volume
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177306480804.1231626.1885155857920091121.git-patchwork-notify@kernel.org>
Date: Mon, 09 Mar 2026 14:00:08 +0000
References: <20260309111826.3998132-1-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20260309111826.3998132-1-jinwang.li@oss.qualcomm.com>
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
 wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
 mengshi.wu@oss.qualcomm.com, luiz.von.dentz@intel.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Mar 2026 19:18:26 +0800 you wrote:
> When AVRCP is connected before AVDTP, an invalid device volume causes
> the target to reject registration for the EVENT_VOLUME_CHANGED
> notification, which breaks subsequent volume updates.
> 
> Fix this by initializing the volume to the maximum value in the AVRCP
> target init path when it is invalid, allowing the controller to
> subscribe to AVRCP_EVENT_VOLUME_CHANGED.
> 
> [...]

Here is the summary with links:
  - [v3] transport: Fix set volume failure with invalid device volume
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=121e5ca79be5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


