Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1513714B970
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260627; cv=none; b=obsAYIIKFzDD6VeIo2Md4sBpA3zv3cRbxxUEhfY9Hd2pbIOwZ86Q+DriiBpCsyZUIryC6q6jri9RPLyhLmuk5DrYHJvlk/RNq9UTZNMd1sgEt+UoW4AFkvXreL65IeufMrahusneivXVUBIrug/wvDyOvafv3c7OcySiTSI3jzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260627; c=relaxed/simple;
	bh=Eelw+5gEuz7TS9SVhTXJQU3oqjOeRBxUwY9Fb2c2kqU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cwSkhorqss1180FxuVpDlOUGchjyrrHNsejkliFa98GMp49To8fzJXz6jZTljgaCDb9/9e1HHYguKIt3QS/URnGzfGMd4muFlld9C6gPKZ/OBtCT+8EXIkPcZ/x6gxIv+HXE1qIx1Y5NsSVsEf8riXeCR0siY7JG3qKeD1gTZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPLJqTDn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPLJqTDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4079C4CEC3;
	Fri, 18 Oct 2024 14:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260626;
	bh=Eelw+5gEuz7TS9SVhTXJQU3oqjOeRBxUwY9Fb2c2kqU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NPLJqTDn86ce6Zu86P+GwOvZDyEXzgTG93DvxJuJh6D9Zx35Gi7Iy9DaqRlyoNEm4
	 yJ/gNYzRbhSSfA+LPseFVXWeeUSQ+H43we/OSjn9JZgxM85p8EnXJL9VPWAiqKDAlM
	 OhJnCwg1likJf29AnqBg/gzVufe65Xcu1QTVaq7tSHLM1EA1cGVqSlEEhk7uVxOkhM
	 O1c2sAfozgfqw3K+gJWRQKAv2ICPoMQ5UOitO2jLRlLXP00XD0kSCrZvSaZ7RVVShZ
	 a6K+tAe+JSKXC/6pWE9ktyWIou3Q5qfAkMM7IEvAmiseK83QEtzCsY2DHAUlEMWV7O
	 3e47fwHRRr7ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2903805CC0;
	Fri, 18 Oct 2024 14:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] tools/obexctl: Add support to connect using PSM port
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172926063224.3127332.6385489912554787408.git-patchwork-notify@kernel.org>
Date: Fri, 18 Oct 2024 14:10:32 +0000
References: <20241014171058.75235-1-frederic.danis@collabora.com>
In-Reply-To: <20241014171058.75235-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Oct 2024 19:10:58 +0200 you wrote:
> Since commit 5d7d3ac25bd5 ("obexd: Add PSM support to session create")
> obexd supports to connect the session using a L2CAP PSM.
> ---
>  tools/obexctl.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [BlueZ,v2] tools/obexctl: Add support to connect using PSM port
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b30b1eddb4b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


