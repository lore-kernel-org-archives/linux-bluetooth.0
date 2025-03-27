Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FBB7E9
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743091799; cv=none; b=EtiWiNSNAlFyZ79gU+XevWFzHOTfSC4fXaIv3DTSgJwy+iTwtpcQBVlGkB9/QAjx5f0hLoc7QMaeQ5HpvYcr3hIa9blmmUdydqXLV7nI1V9XQBusYEibFXW1nh9DxRCkAqR3GvY5k9O7QC7hHtoRlzDQGPs8pziwAbRFtb5+N0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743091799; c=relaxed/simple;
	bh=HA0YXDg22E+9w78ro6+ROwHmoifyllsiZDiqSwCd+5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r+ZhSaQXRMrzpKnSqQ+ONr5gZOUv8h2Ugb4rNdODmEmXvAxKnBdLL75Q89XLzTULAQtl3rMrEZEr+EGh18eHmELnf5q/OZ/rFC9u75CIZA1WDzYgy1irmU66f+WHtI0qdKkmfk1/DXpoDb0MmmfHWrm+d/yHlkVirQub++fDaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sam5mlJj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sam5mlJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5935C4CEDD;
	Thu, 27 Mar 2025 16:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743091798;
	bh=HA0YXDg22E+9w78ro6+ROwHmoifyllsiZDiqSwCd+5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sam5mlJj+7YndhLBafZQG3IIfTAeSBLxOePVl1NLPKwcSK3xj+GPy/CwU+FMyNJC0
	 hztcAVlbKmt+mViqPq+pmCS4mPeAYOd4NFDN65RYHa0QyawEYWRgN4IxR5g7Mm7Y4e
	 BkLY2mEejuVgVZ8XojVAp8J03HV9IaQX7RYd4lCmKEjMSCZDLltrDJZQWD3PWlFy9U
	 f6tmNu1pHz9nbNZQAX4D4g3gugGD8WlI0iGfVclJT5YgJnALNTtGma+rVAWjsmoE5R
	 0EIzFhBk2m+XySNck8niqoLzNjLg/7wqhEfvpbDaIDynw3h03y4W+FfWy7vMs/sbgM
	 SYQmA8fH56ABA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34F5A380AAFD;
	Thu, 27 Mar 2025 16:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] main: Fix handling of legacy experimental LL Privacy
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174309183480.2118203.11664477033295634846.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 16:10:34 +0000
References: <20250325213230.2513331-1-luiz.dentz@gmail.com>
In-Reply-To: <20250325213230.2513331-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Mar 2025 17:32:30 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Legacy experimental LL Privacy was not enabled by default but
> CentralAddressResolution is which may cause problems with old
> kernels were LL Privacy may not work as expected.
> 
> Fixes: https://github.com/bluez/bluez/issues/1138
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] main: Fix handling of legacy experimental LL Privacy
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bbc1c2a7f06e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


