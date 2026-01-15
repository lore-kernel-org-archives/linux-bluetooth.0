Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE4331B131
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513419; cv=none; b=FvKURxFDyRfC/KfmeTdxE1JfstF+X6/QJ9f+ghPDmhbaBAAjFbA5M1T8x25YYlwTcb9PaZXmZ2HG6LSvHLhlC3sx3W5cLEnFQv4fWuAXZ4O6oZkNgOTpdWIzBbRNLfleV5vBFMRGKXNlWAloxA6lvEKg0c7eCyoOcc9KJtz6j/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513419; c=relaxed/simple;
	bh=ZzkI5JLRkLUHtNpErd0D8257wJoYyF/Q9OVZxNz0RCk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nY+EoEt6+NwU/4uaADl72ooFm36QNKMvlMei2bnY9w4d8EIZwbAg09mhG6K1ZJoX+2t9l6CUuAqz5fakqWrrJiFRKPMg+X+mrDfdjp0doFr1BqKgT6C17qr2MXf5tx4sj6fOFTBT1noPFkpAsih92ash0O6fGk4W+oRgnFs2tts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqlCt+Pe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqlCt+Pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A88C116D0;
	Thu, 15 Jan 2026 21:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768513419;
	bh=ZzkI5JLRkLUHtNpErd0D8257wJoYyF/Q9OVZxNz0RCk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pqlCt+Pe7FMT1Zmor4hJOkoRkYOf1swUy1IwidPOYJttIYNTCn+J5IibG7ML1F2wc
	 6CTIq3juHEKY0CW3KVE9r4MF0rTxfk1ngR/6itQzfYkqeuTh1v7ZIvn8Dl/ZuQjGml
	 TQV8V5l3OsgEyoT7O0iFDMQpzdhA9LxVGZQurvRKPgwbVx00oIJ94oRWSU/8B3kJ/v
	 rPjFBeigu1XLQXqCnt0ByumnatQKCIGXE0iLYl4wmjGlw4y4Gdwe6fBquOn6wd7MiU
	 H4IGtlmzKtBt/b7udDp4kgXhY+bXPeNUOdIxwabVpnaFIT3IL4OPk1GmapmboO/5ke
	 1DJvWcrNUStLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B58A7380AA42;
	Thu, 15 Jan 2026 21:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tools/btpclient: Fix name advertising
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176851321152.4178208.4781485684734975816.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 21:40:11 +0000
References: <20260115144058.12960-1-frederic.danis@collabora.com>
In-Reply-To: <20260115144058.12960-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 Jan 2026 15:40:58 +0100 you wrote:
> This allows to pass GAP/BROB/BCST/BV-03-C and GAP/BROB/OBSV/BV-06-C
> tests with auto-pts.
> 
> Those tests request privacy to be on to share IRK.
> ---
>  tools/btpclient.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [BlueZ] tools/btpclient: Fix name advertising
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fe7094da8081

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


