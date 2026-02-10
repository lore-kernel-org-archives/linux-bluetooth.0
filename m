Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395412877CF
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746410; cv=none; b=s827mIhxmbVnIK9eviYgxyUW2oaa4B7xxi1VzoHwfcsAWDeJO7y4SxE4y7l7+1pD+JLGKKJp90+B/aHTpnFXogeFrEmMpX5Xk4WN6RygbeUFCJnfP2xOI2thJCIaCdkqO/KKl15RMNFtkQo475qapMbGVcjRJW48zLi6xO3oGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746410; c=relaxed/simple;
	bh=MwCGYLSMHTQ6USEa2POxqQu3zno54HHNr+tCJWU0O14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nvvz1B0+XuG/moLF2bZEM/tHPnLSlRi48oxEbBCqw6Ppgo1ByZTofJenVMxEagS6OfdeKv4h+55a+1Fps88N8nu+YE3PAqhmTX8JpF1NLuAazYcHEHmKZutVk8kF5o3MmFDjjOobOfmdwifN/v7qsI71bzgZuybKKHsj7F/erCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvIH7W6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvIH7W6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EA5C116C6;
	Tue, 10 Feb 2026 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770746410;
	bh=MwCGYLSMHTQ6USEa2POxqQu3zno54HHNr+tCJWU0O14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PvIH7W6zhewLpoRTAYyhrN/dGJjxJ/hG4XknXQ1M/Qn3aTHyQN5/tD2A/JYuK2o+b
	 aynQA/7rrFlVbrQUnbHtXTNEfZnhqz/Izt/euyc0yVhEy4HHrGYVMvgShRei4s1JoR
	 WmwpagrBkbBz8Yd5skNTrWb+CQjoEhTQs/2Jky3cdGAIkijJaBYOypAS6d7+MfkqwI
	 dJUNHs4MxK4J1aLhCDLX+EA7J3ii2HWHuTXxzlEQCHsDXVGOK6e/2cvoZAd0CYTOlo
	 BIi97dCOsA8WPUKKI5b3icWA7C1CTe6jfHw43RAMr8fJXCEpa0sa7tIlVmCX69OHwc
	 x10wGOm6MqT3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 850D539E3B79;
	Tue, 10 Feb 2026 18:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] adapter: Add btd_adapter_send_cmd_event_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177074640408.3616367.6343089667493303605.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 18:00:04 +0000
References: <20260209163420.844741-1-luiz.dentz@gmail.com>
In-Reply-To: <20260209163420.844741-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Feb 2026 11:34:20 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds btd_adapter_send_cmd_event_sync which acts as a function
> helper to generate MGMT_OP_HCI_CMD_SYNC.
> ---
>  src/adapter.c | 28 ++++++++++++++++++++++++++++
>  src/adapter.h | 13 +++++++++++++
>  2 files changed, 41 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] adapter: Add btd_adapter_send_cmd_event_sync
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ecf4448a5811

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


