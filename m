Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D863EDE52
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613664; cv=none; b=ZgvCzijs1es0fYxQhDoH75WCREnTOd/nN3+Ba6GxkG8wqs+OK4YdTgqSai0TxGHYwhl9/2tlSHgRZSzzyMNjaN+pZ5oPRtXTkug5PgbMazmh6Ay2zCvkxc+AwB51dy395Zr2NXBLMp7bLHNE/ZL/BUFg84UNZWAnoAj04QUIsw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613664; c=relaxed/simple;
	bh=926aawpdoYBEci4otQq5f1hj1UXdu38Nf7A1psBHgHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZIvBfdEiF3a41i1BqE3nPAP5LrWH89aW//XpV7aNBA90OlzygRrc/Y21YdZE1fftDBSG+Y5/NNcO8zU7roHB7eOMocL/So1q7cf/YIBE4Rdg7X2qpWaPvqdjzcg7cRzBLsE7gGYVcnofT98TQ5Uu8oRTLdDQ8jtjHBft6bBsuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8ob2yeo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8ob2yeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC95C2BCB0;
	Tue, 12 May 2026 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778613664;
	bh=926aawpdoYBEci4otQq5f1hj1UXdu38Nf7A1psBHgHE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i8ob2yeoYisChUlpFgcTEeNS277Ejwhnto11pueFJpr/3XnJwNhUJn1TLw0xjPbS/
	 l0JXZWQDWREB4bxp6Pw4UE6Q32EQ+3kbxefkZBXbiLsb285cpcmAdxcVKU/xt6sjko
	 VSmjiNJcsJNy5ZYlvICZJa6s+FhAEL2MypTlCKBRQAvqtRCA0kaVrrr/iICWqFf3ZZ
	 ZqR/ZD83dtJDEn70ebk9cE5P9ele3IrKT0mFkM4joU75GxllPMROmo6OHnu84Hkkm8
	 Pcej7pmqnLGac565JJSUOIKTRHEkD4w+LTF3/Ll0X0ZLDLvyw4eANMRsVJC25vXD8S
	 nYbqFJYfcMzQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF013811A59;
	Tue, 12 May 2026 19:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ 1/3] mesh: Remove unused but set variable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177861361004.3045511.14583977326255540667.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 19:20:10 +0000
References: <20260511113511.1217887-1-hadess@hadess.net>
In-Reply-To: <20260511113511.1217887-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 May 2026 13:35:05 +0200 you wrote:
> We played around with the bits, but didn't do anything with it.
> 
> mesh/net.c: In function ‘ack_received’:
> mesh/net.c:1569:18: error: variable ‘ack_copy’ set but not used [-Werror=unused-but-set-variable=]
>  1569 |         uint32_t ack_copy = ack_flag;
>       |                  ^~~~~~~~
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] mesh: Remove unused but set variable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f95b524e5a1d
  - [BlueZ,2/3] mesh: Fix str{r,}chr usage
    (no matching commit)
  - [BlueZ,3/3] mesh: Fix const qualifier dropping when using strchr()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b2b51ac6f64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


