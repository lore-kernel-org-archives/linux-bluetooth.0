Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E541E864
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536632; cv=none; b=Dt4HMJsuTU7oWtQkq3h0kwtVd1sOYEOtbWywWhUvThABkSZ0Cn5eEC0pXlIr4ITKZxKZcoUmgX0/lPUSiJy8Jp0fNoqQsu9TpqZGJZ0ufXm4xYm5T03R5JzzgLfmlgKoM4pY/2k+GvvvVoZFXbkkMWxN4D86BHNTsFtr3/zDaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536632; c=relaxed/simple;
	bh=eecmR4ijDPn0ze5TeIl/+KXQrfogS5OtxD4P0AFoEXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iS+cUIjo7KBo7PuMsyooyJ5sp6gw+8rbDdTJ1hJM2kT0AYJJH8qUc6da4YpiVfAt8buDBFLwB+H4KB4aUvIWmtGkyF3cTVjrjkBuYz+uwPT/yIrg+aJhbi3zU+4KzFJzurllMeOrbZGpJJ22jpTyQf4uIwcw68cBfiBOV0Vayfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/7wLgBf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/7wLgBf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC89EC32782;
	Tue,  9 Jul 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720536631;
	bh=eecmR4ijDPn0ze5TeIl/+KXQrfogS5OtxD4P0AFoEXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b/7wLgBf5KKY2x8320c5UvdIkz21WplDcd2CWZkSeWgnlEjde3mnDt4D9KivKQCAO
	 3j/4XfAAhHaxbg1zX0p9+Jv6SDaJAr1C/l7gtbCES4hCya2BK5RfrnQh055uoB2S1d
	 Nuwwe3R5uggLs5qg0SyE/KUr90fC0ZcJvAIgHwtcJhntf4ENc2xGG0HinW/6oZXhDW
	 sfR6ShWyxRGiac3hS6Su35MmDW6PlMRFtSZ42rcC9mBcooq/pYLXZAiLjxGE0234hL
	 rOzNwIUS/svHy6OY4mHGUFB2uVppJuAh+IdgtXu8eWl14SsIxfDdRc2LEztBLSLf8D
	 TDie72+aXXyiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9ACFCC4332C;
	Tue,  9 Jul 2024 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/1] doc: Add initial MediaAssistant rst
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172053663163.10405.4913491557601683491.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 14:50:31 +0000
References: <20240703145839.34828-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240703145839.34828-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  3 Jul 2024 17:58:38 +0300 you wrote:
> This proposes a new D-Bus API to be used by the BAP Broadcast Assistant
> role.
> 
> The Push method on a MediaAssistant object sends stream information to
> the peer device. The stream information refers to stream metadata and
> the Broadacast_Code to decrypt the stream, in case it is encrypted.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/1] doc: Add initial MediaAssistant rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=66a76c268d05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


