Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682142DE719
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491842; cv=none; b=Jg3G09fGZG1Q8q7YxdYkjazE6prNSfBGEGs66K6SWTaj3A/CDB74t8ypjuwjwPR86kcdsYXIeNId1KtKAlVB9HuNrcvXX9UnJkYQsgZ3hb8mlcyE4LjnQygI8dSbZ2OryxszKMq3qAivcY6KklwP8aXHTrjx5jsbMmroGRT2DJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491842; c=relaxed/simple;
	bh=w+KFrrXN8VBttVUt/XWHdNOt0tcTMehbO5E0zpcMChI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XZeDcStwNCqMBCYNOcB6a5fuf08PuO7mvGkR+B6vRPOZAb/TiFBr173v0y/hk/MfRYS4atVcQU1dWOOt0SlJB/EyJ6Q7kartO2S23kVS3gjWR1deM93rRP0ekGv8wzsWnoHuJfQCwYbcvkAAYSjlY65PYKWJM7qPFBze5jgmBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9kA/23t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9kA/23t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0066C2BC86;
	Tue, 18 Nov 2025 18:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763491841;
	bh=w+KFrrXN8VBttVUt/XWHdNOt0tcTMehbO5E0zpcMChI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n9kA/23tNT4kmRfDwON1Sfgn1AsL7PJhlJMcGPvjAkJy4mSuWUe8XjYHxS1hIjzo6
	 7s12I8jdZUin3JOsRLfgM56nQUyeiIyg8Ahbrlcd3r1N3Ny/h6j69lPA7AaSIlswTv
	 +VK9abyTGitcXNICuOOHQkrUP99Ws4KiTf17W+PgdNTIbJ3KAxW91ENohU1XD+8M+T
	 Qg4LLRwYCmQuZP6xxOdwTBsXb/eynKZhxP+5SSeypJj1U7uJL2clE9FhIaIoyCwD9a
	 ugn/ujx4/glpGO7gh6S5ldRVmKK/ZCAiMndXiJalyWY/ay3yZAAxFoADh+SEx0tCi5
	 XRHQptQKxUU0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC33809A98;
	Tue, 18 Nov 2025 18:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: HCI: Add support for LL Extended Feature
 Set
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176349180701.66479.15702992133064175995.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 18:50:07 +0000
References: <20251117142521.3804561-1-luiz.dentz@gmail.com>
In-Reply-To: <20251117142521.3804561-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Nov 2025 09:25:21 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for emulating LL Extended Feature Set introduced in 6.0
> that adds the following:
> 
> Commands:
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: HCI: Add support for LL Extended Feature Set
    https://git.kernel.org/bluetooth/bluetooth-next/c/5a7903c04269

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


