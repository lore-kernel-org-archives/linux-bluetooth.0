Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737C1F9F7A
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Aug 2025 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320790; cv=none; b=lMY8oH/Ws74H92QacrW6tsNUyG7ICPsbn1dzVTTFMg//qkDPcDikW7I0tkogOe5lX/GRwMeohapFMa4vYorbnQnIzNbOetcZZ8IIeY4gBeJ6DlgRgRC2ihZ7HTxYHsjFow8PiXXZCkjMHRvfJ5l/ZnABxVywHuvDcHwIHldsKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320790; c=relaxed/simple;
	bh=D/EdtbJWc8AdPRTApmiDrvOYU7en7+o5Oof1EeXy1no=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cNp7QLSQpRVOBxdmJAfBJaB10mvLwpRi8c/s6IepR5HU2slLkrTSIH/hTBV91bdPvUSNupHgdbO1znNvGYCooOvYEt3qDKZuyO1Cy+MJ1qYKo8rWQ5kMZYitnQOGZNbRRLMayvlRrB1LptzfPpqGrE3iW+idEwNRaoTHh95Pnx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/mWfWYn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/mWfWYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C7EC4CEE7;
	Mon,  4 Aug 2025 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754320790;
	bh=D/EdtbJWc8AdPRTApmiDrvOYU7en7+o5Oof1EeXy1no=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M/mWfWYn5ks9OSunZcL73WcIj8kHfBrDlH4YkKpYDA7RWrWxIOuV2sFXJrhsiE94s
	 icRac1vaR+G4E+eQ6OjjJgcd9CAneqhH3hn20+QXOrINKoSYJmJ+9yDyL2V3Z7QMCp
	 0y9loXoCk5gKsXakk9QIwkwIvZH1nZg9Vmyok8k9P7DR25nOSxaAjOiNllPnKlYJzz
	 G+JVjYq13K9sVNUreieheNxy3+Ra2il91w9KIUygJoHPc6C9qOzGz7pJCLDuQ8w3o3
	 JPf4ej3P0YLON82YNrFpALAxTVDkyT21q6GKgaJLuAzJFnKbtQDPeKx6HQOvlP1CtV
	 1/RsSQcjfYDvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF4F383BF56;
	Mon,  4 Aug 2025 15:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] shared/asha: Do not start ASHA in case of CoC connection
 failure
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175432080476.1227002.5885652425558628315.git-patchwork-notify@kernel.org>
Date: Mon, 04 Aug 2025 15:20:04 +0000
References: <20250731162605.155115-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250731162605.155115-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 31 Jul 2025 18:26:05 +0200 you wrote:
> ---
>  profiles/audio/asha.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Here is the summary with links:
  - shared/asha: Do not start ASHA in case of CoC connection failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=af816afa7ed1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


