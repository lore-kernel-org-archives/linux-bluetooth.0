Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172C83DA7DB
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370797; cv=none; b=bBp/RJcI6hbZLB+tiFvnMnVYfotvdjQN9dasWROMPSeRllsDxpVEAA2JWLsl16wcNykjY0ICQuAjqfzpTKYwHL6/6jmGjPERcfgaMLZn0YRgoDLHt22RLV9wtcVauEHgDVz5SvzxfT4jRdh8DFQEOnkGnR7G+q5MlUXBNqoAt5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370797; c=relaxed/simple;
	bh=EIZFevwrIZpaIsmSdlKl7d5TNHxdsahItjhvdWDrjME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l9wTbxSDmoYTfk8ixXkD8TDIHK0pJepTGOu+XDjd6wvLWcNKqRdQ/ncN67aMr7DiBUUarUdOnEz8YNVwOVm/M4MAsT8CRyXjwOb2saO98MocGAPp4zfTTbqIKgZsy15mukMRTq1kPbxyiByVqm/JkCLJ+Ihjrw9NAAHupDN2iZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3gObCN0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3gObCN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBA61F000E9;
	Thu, 21 May 2026 13:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370795;
	bh=UZe++Uh4JoGp24TZHQRKXHNbN0si9GjTtWo2sH7UawY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j3gObCN0il2ssThnKQavchAnfOZmz/mK3N8224nDM4FhdWh4XDqk83fN4t06m8m4p
	 lh6O/aI6qiPR9RjxzPEARm3G85nZf5eoFMPvB1RZ0xPbUulXYiJHyzmfrPGG/ixTeI
	 3dssEvUSeH8DaoOYEJU4YejeXQltk1iXA3qt+YNKROFlYHMybAi9gGY0sNP2IKNEyY
	 QsfCTvZ/6BY0tz4FygVse/Y4RDgO3sI1CZ/hFSC3lp5ePSM6ZompV6FgaqH6oSv7qs
	 MUGrbo4nt6f7arTb/1Lkb4/wupGn0mwVKzLrGTxMVpfj+bAXDYyWePK48Egud8ldMa
	 Mjs/0FfWaffnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CB0433930DE3;
	Thu, 21 May 2026 13:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc: Fix Data Path direction in btmin-le-audio.rst
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177937080557.318149.17077931742242076597.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 13:40:05 +0000
References: <20260521060919.2124-1-kx960506@163.com>
In-Reply-To: <20260521060919.2124-1-kx960506@163.com>
To: michael_kong <kx960506@163.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 May 2026 14:09:19 +0800 you wrote:
> The Data Path direction 0x01 should be Output (Controller to Host).
> ---
>  doc/btmon-le-audio.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ] doc: Fix Data Path direction in btmin-le-audio.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d167d3409e94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


