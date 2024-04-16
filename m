Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FF63B78D
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280234; cv=none; b=bpBY3wFeu0z1WfT/2vq3FNJraLXGUHq5rlvKCCxpZDypFScO7nIjzCX8dZJ++5QqpgXfVzzFjLRGzzh6eTLp1xlT3rTSb61w5J16qh+epg+HyWdLroHARoClb4o1wT/OVtr+ZS7dZlsWZ3jrD3TQk7khDtEqJbp7obGt+FPCXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280234; c=relaxed/simple;
	bh=Vu9h8V2inM0Ryhf8Ehbd1CPsHFx3cfn7J/z5xzNqI0g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uVgt4l89Pu++mxVIBZCt4G7hbLyDFcEUrbvT8B0GFtG8xg79XL/c2v/O2ExES+pxCyCBlleafZmOYPvaoiL1NbQL7IQGICMfTfQLzZKpwGTkrQ5zO1QIYWfH+LQ2H8UtIjkNYezgYPnpDfGfH7/AkHHgsiVtCZgT9xRtaDqgGbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIleJosQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIleJosQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CB90C2BD10;
	Tue, 16 Apr 2024 15:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713280234;
	bh=Vu9h8V2inM0Ryhf8Ehbd1CPsHFx3cfn7J/z5xzNqI0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EIleJosQO+zAVmGbWIuHjPeM9vLOCr+yOS6qsexYBwUwSnKx+qcDkMa1t6EES7eln
	 QhQfMqRzUh2GqYXBMkfp6/QDBcAUJAIfD3s0+j5wnbq9v2b2Z1KNoMyu9pw35TU0U5
	 npLIdD5hoZZIpCkMRcpoJbEh1oGshWiDotLuKd+U9hZ3CY9bzMEYg+D8vyaaVmXADt
	 4tZcHxkNQLoQOQsHzb1ZSl6vam83psR4Zo3HQswaX8wTTAFBkwOIQmMscF4YqRmVuo
	 7E+yVx3pgXGsvuD66yrAC71beTcWRIdiobg2rNgeLxv5IKVijjKK4SW6POslOdZihr
	 gnMqxL5x80pEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D7DDD4F15F;
	Tue, 16 Apr 2024 15:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_event: Fix sending HCI_OP_READ_ENC_KEY_SIZE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171328023418.16225.6418530565465065583.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 15:10:34 +0000
References: <20240415174338.896084-1-luiz.dentz@gmail.com>
In-Reply-To: <20240415174338.896084-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Apr 2024 13:43:38 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The code shall always check if HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE has
> been set before attempting to use HCI_OP_READ_ENC_KEY_SIZE.
> 
> Fixes: c569242cd492 ("Bluetooth: hci_event: set the conn encrypted before conn establishes")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_event: Fix sending HCI_OP_READ_ENC_KEY_SIZE
    https://git.kernel.org/bluetooth/bluetooth-next/c/54a3de664f08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


