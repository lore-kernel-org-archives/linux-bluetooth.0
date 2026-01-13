Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30887163
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343614; cv=none; b=d0QsoZ6R2JuHcipY0Mol7xQA7BaURkvLKuD4hGCFOcAXawgpMEziBSbRyqy1ODzKTlEka+oX1I2nN1vGq3FyFqhsS2KCENTECD/QTQAN8Pttq6FEouNjfp1cO60ZzfQjiCLilghdiOd8hNMQYA0T9r6fm7ns/XHyeJNS+jH+iIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343614; c=relaxed/simple;
	bh=bnVDpXfoAFpErumZC49InyS8hmWXGShYjRUSdqu8fjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=URHjl5B6AIfE9sJUkxhWCnJOuUQAUr6gLLmouM0XlWKORGYjyXZLbwFgroA84imw1TcH+9Hy4gLth8xv4oMGrTv0OCCYuNmpmRcThwAiezfa9Yv0Ei2eb2eM04ivV0+Lg+OB82erPPKcJQCP74h2gcy9G+OwyHwxBTGjv2eshKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qA2XURnk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qA2XURnk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6F9C116C6;
	Tue, 13 Jan 2026 22:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768343613;
	bh=bnVDpXfoAFpErumZC49InyS8hmWXGShYjRUSdqu8fjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qA2XURnkZiKsDNyCyiA3DVnalDQxhQ8U4XU+xUNPKbLbDjn3WJQq1x6iutMlIE79t
	 143ck5I+gbnvCl4NtMsdRsA63s111YyF89nr4Uk9rJoLEr66CRk0/z6WVm9CHwJSEg
	 lAKGsFyldSK/MGmBt1RGQsZs7bpFFIsnH6sRxqJSgaMZbJukFGC3YDk5ci6eGSJz3c
	 /ezNuCVEZFyaTg0cds/2d6ujgMVldfn4Ea4Z4wksqm59Rf/Iv0K70PGE4vILhJ0DZr
	 9XIecMKBjORUzN/VAwa+Komd8MLADeSYkiCfGKQb7NiaPlKnwMDtEAWw4n4PZVYEMJ
	 nefrjvWMv48aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BC473808200;
	Tue, 13 Jan 2026 22:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shared/mcp: emit MCS error if value changes
 during
 long read
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176834340705.2507600.13604274345781396616.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 22:30:07 +0000
References: 
 <977354414f40c09d5a0a14c839b860d22a8ba23e.1765914148.git.pav@iki.fi>
In-Reply-To: 
 <977354414f40c09d5a0a14c839b860d22a8ba23e.1765914148.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Dec 2025 21:46:43 +0200 you wrote:
> MCS spec requires emitting Value Changed During Read Long if value
> changes between remote reading with zero offset and nonzero offset.
> 
> This is session-specific state, so add support for that.
> 
> As server, track value changes and emit that error properly.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] shared/mcp: emit MCS error if value changes during long read
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e9f2c8fdc676
  - [BlueZ,2/2] test-mcp: add tests for long value reading
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4ce4b5d679ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


