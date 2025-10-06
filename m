Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78E2D6603
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Oct 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764015; cv=none; b=jmWvOl/l7uFg2ntji7ePEquEnpPLcUsrGL+sv2Qtu9jF8hnywTGQLsMvowpHzq1mopa7rO6AKSOF0CSFMYQe9rm+Gdvt6pVH7QzKFalmFjVkLmP/P1dJxOOrM8GuWcueiuUIGHrtIrNi76yhGnSQX5sG78abgOQoDe7XRMTgv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764015; c=relaxed/simple;
	bh=Y4tW5pHASIGqeKANyRXUPqDdu9ltnNOAVI41WgfPFgQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KniDMGr3endTigSzuJZyFQWe6vegEdlgFycQEWfRuOSObTCs3s/TPMv4yKE79jVdDZWQPYLpegyILBnR58gh1yxJcH+xV3gJZZfIQe8Gg/IWSZQn3l1WHsTq4ly87t9hrx+i0uMruleJtGtwnG9mRrf5pUMrfoaeVb3z1e++8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc65q5Mp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc65q5Mp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43447C4CEF5;
	Mon,  6 Oct 2025 15:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759764015;
	bh=Y4tW5pHASIGqeKANyRXUPqDdu9ltnNOAVI41WgfPFgQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tc65q5MpkquVTvI0agH0gQyN9kLVW0LUQAnLDS+zSh4ET46fnxjusVPh0ftWlgqau
	 KgEXGwfQVaG5erO+HAjZRTFMB8aZJgEUw0hbGSaU8D5KL3Nzga6geMyUcTAmokV7IN
	 NOrac1yqTCaVK9oWMh3sBaNslAvjJsELgMMog6XZzIFs5rfM1JykbepeG/OIRJfI5N
	 F/JIqSgSSoOV5mP9sLNVzcswTV53+XpZyoimC9qP908MiN5bR4hedMWE6NGHvj3VyM
	 6FKTW/qeF2obtU9PSnMAqVpJt6LxqKXhXaXF/D8jW/gTb0fMKRw8vvFh6OlPz8arZ+
	 Q1qRsTwx8HbFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E9139D0C1A;
	Mon,  6 Oct 2025 15:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: fix crash in set_mesh_sync and
 set_mesh_complete
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175976400501.1408757.8167211615664126968.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 15:20:05 +0000
References: 
 <f206fc905f5c747b309d6063acd0128189661576.1759517776.git.pav@iki.fi>
In-Reply-To: 
 <f206fc905f5c747b309d6063acd0128189661576.1759517776.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  3 Oct 2025 22:07:32 +0300 you wrote:
> There is a BUG: KASAN: stack-out-of-bounds in set_mesh_sync due to
> memcpy from badly declared on-stack flexible array.
> 
> Another crash is in set_mesh_complete() due to double list_del via
> mgmt_pending_valid + mgmt_pending_remove.
> 
> Use DEFINE_FLEX to declare the flexible array right, and don't memcpy
> outside bounds.
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: fix crash in set_mesh_sync and set_mesh_complete
    https://git.kernel.org/bluetooth/bluetooth-next/c/fea4150ae678

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


