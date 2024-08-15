Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF41AED33
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737637; cv=none; b=ZsRz6xBIWr4hlhpNJX6tSvAY2DcjPJ+ITGaWE2jkX0HVOwuK8v0PUxbMXAwuSHVwRUqwYTDxIVB1AzgW+mgmwpnviWafm5hTPzOhq5SLlDuIFtVNFAQJ/x5fznx4vLG/Pz/+8Hk7sjs616gnZ6NRfSPriEDm5jFWhEZ+D1aQBZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737637; c=relaxed/simple;
	bh=gPt/xnNqtwi2yxUMlRFNyGFpMg/NuY0kHZD4n7u3VdQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SZD5AdcIGdUnucv4+vvgAmwgmCWcBwREVP+ABpXp6hDTSSY5SkdtjA3YmRWAj6kU2R0Zmb1pkVZn8OC17AlrfemMojZ/i41hylI6Gt/DlLy20foyN64AaSJIhqYfQrSDwRw06r+XpM5Ejt9nptHPlfeUph94vJ6ECXIiAJP+KQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ly4on0Lu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly4on0Lu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EF6C32786;
	Thu, 15 Aug 2024 16:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723737637;
	bh=gPt/xnNqtwi2yxUMlRFNyGFpMg/NuY0kHZD4n7u3VdQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ly4on0LuGMkgeQptYLKqCpATLaF7c44YaFeM83ld2sMt4wwqrS6HHVBWmBYf8iKBa
	 WMLq9xu/T+JEuFsQWRP4Uv2WBtDyziwd3P8tamM2VLLcPvcey7cWiMpDgutcLWNIsS
	 +yQhQpCssYFA0lFS893Ugyw3H/mb1WFd7SSZQwoQI45Ebk0zyiZ5Xl7Ecode/TA3Mq
	 d5pRd4uhucwPevCMrYNNVvrZk4eGsiiLBKovHXv3FUgF3KwWmJF7ysyXI8KtKs2PGa
	 tyW14WkIZUJSZZlWLRnZkhP9Q/QLIpx73bgv9JHqSCWuIdq2YTqCnwdW9IIXU33Tvb
	 4vivI6TCDbsKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A0DF3382327A;
	Thu, 15 Aug 2024 16:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: HCI: Invert LE State quirk to be opt-out
 rather then opt-in
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172373763623.2896787.14133440981768095341.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 16:00:36 +0000
References: <20240812150439.283920-1-luiz.dentz@gmail.com>
In-Reply-To: <20240812150439.283920-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 12 Aug 2024 11:04:38 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This inverts the LE State quirk so by default we assume the controllers
> would report valid states rather than invalid which is how quirks
> normally behave, also this would result in HCI command failing it the LE
> States are really broken thus exposing the controllers that are really
> broken in this respect.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: HCI: Invert LE State quirk to be opt-out rather then opt-in
    https://git.kernel.org/bluetooth/bluetooth-next/c/f9774a6ac662
  - [v2,2/2] Bluetooth: btusb: Invert LE State flag to set invalid rather then valid
    https://git.kernel.org/bluetooth/bluetooth-next/c/56817724f4d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


