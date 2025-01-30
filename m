Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F431EF091
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258207; cv=none; b=LQKEyuYkbW5XLiqBjfkcG/1D91xHt1yfDcS1BNwas2GwYOerYTuuP1mN/fuhH++Pc9mutyBNpESJLyfVOdsq+qj3pcCjPt7oHpQq8FHZLubEHL+kcy8g6DTfbSVEJfI3Us+0PzQdCBopsRg5iI/vMQDGYniZFJuHFVrSGiwjoDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258207; c=relaxed/simple;
	bh=0qsuOEVXQJCm3g/QdQwOnY8gBqRppXlixaiD4l9x3B4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XyQrRxAPdOzp1XMokbv/k1gCDV26QiqoGIHOtMsKuL3NHC7sCMPTjKjckFfKPobx1jjvBGRdTNQjc4uemvbQhrlfVrOlOuMCHbkZzBrYMNfI53ZfpoidtMZvF9xkCbZthheL/a1Ba4tw6Yuw47adHWY6FqK6O7uTInvABOWxmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+OV2kCa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+OV2kCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35E4C4CEE0;
	Thu, 30 Jan 2025 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738258207;
	bh=0qsuOEVXQJCm3g/QdQwOnY8gBqRppXlixaiD4l9x3B4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G+OV2kCafo+r4Z9/M7gFRuv6/TgZAPu3S48pAXb6N1PFTKUQxLi8IY7kyXMu6JcH2
	 sLIW9VbEibzz59W8QJ0Q0hGx7/nQGXLRL0Q3033gX1SsGBHHH6D81sTv6diYTGCvvC
	 M0PhjpFR9InUkeS6oY9ZXwAliUISkNTzO3kDYk6p1VsrTPIE53e8tc12yx6amxVJcC
	 gApQ/dS/bAM+cElPzDuvZFbvbw1loMGzndXtTDoS6WE3NiD54fV+mPYT7qSeq+/Mk7
	 vMFH2w/VJHonOrcVCJFwIKRJFOrpkkGM3PuC5CbbjxdLMGwsVFFLSPB9mzlQcixd+0
	 BxZq0SLjr1HHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FD1380AA66;
	Thu, 30 Jan 2025 17:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: Clear only the pending flags that have been
 applied
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173825823325.1027237.14743068959169429974.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 17:30:33 +0000
References: <20250129172231.329172-1-ludovico.denittis@collabora.com>
In-Reply-To: <20250129172231.329172-1-ludovico.denittis@collabora.com>
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Jan 2025 18:22:31 +0100 you wrote:
> When executing `btd_device_flags_changed()`, `dev->pending_flags` may
> hold additional queued flag changes.
> 
> Instead of completely clearing out `dev->pending_flags`, we should only
> remove the bits that have been actually applied and leaving the rest as
> pending.
> 
> [...]

Here is the summary with links:
  - [BlueZ] device: Clear only the pending flags that have been applied
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f0d0266acd9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


