Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38B14F115
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869242; cv=none; b=ArQsOgqkkVHuE3ji5p2BGe8CtXFQDHTLiqxDX+g7AFR8R+TXdxfxWxc775YehMEoclNRofaqLrEs7M7nioWJ5+h5JS+MTgsxuIj0+hhIzU2tD6QWijr6uDdrgUs6m1DTco9SCEjFbiq9GRaU/tmgLpa2cY2F4MGF5gwH+MFl894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869242; c=relaxed/simple;
	bh=qgb3deHhafRD1jNEALyp0/xrFAfULmRTayTHKUOwVks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DE+Bd7xm5aKgblvRVDbl6Wiij1VzZLc157QKnTUWjatH34l7yLr4iI5SAu9oCC4WwKmOne23UnUa7m62WdumxkAGtjlvsRFHTnohl04ZW11V80f6dwelzG6/EL2ynOueYQvP7KWngWwZtzfaZvLWxS6lqbD0cIkRUBD7AGvXUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffVSKkbi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffVSKkbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D129AC4CEC1;
	Wed, 28 Aug 2024 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724869241;
	bh=qgb3deHhafRD1jNEALyp0/xrFAfULmRTayTHKUOwVks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ffVSKkbie0esRdhOZiysKZeuT5NxoCTvWq/2keXfxLPpIXSbSUg3HW7a+b1v1IsaH
	 ak6r8jXl7WTgqUq88LFY+PIVQk2cjNAmPbe+E14ibkm3c9I1czSqnatYIyGP/P+LZ4
	 EgkHsS1VzYkg4ZJCtdqBEvosByRHyNl9ZfVCWW8tomFB9pyZmmkNViCZSNwDd0cw7X
	 rflRZ63TGNC8sV8kHQR1+60MMqmXXxvhYCAOID6c4OxCOYn5W1lwPQwU+W6hq1tSzj
	 ltvdmHLPNutdWigcQGg5C/qKo6HMtJG4lr9Jd6K4aOKIWNbIQReorGllLgEsi5ESkG
	 xAEr66qBFiLiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3533D3809A80;
	Wed, 28 Aug 2024 18:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/1] att: Correctly handle negative return values in
 can_write_data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172486924174.1386371.10574486854610218141.git-patchwork-notify@kernel.org>
Date: Wed, 28 Aug 2024 18:20:41 +0000
References: <20240827080925.55684-1-xiaokeqinhealth@126.com>
In-Reply-To: <20240827080925.55684-1-xiaokeqinhealth@126.com>
To: Yao Xiao <xiaokeqinhealth@126.com>
Cc: linux-bluetooth@vger.kernel.org, xiaoyao@rock-chips.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Aug 2024 16:09:25 +0800 you wrote:
> From: Felix Qin <xiaoyao@rock-chips.com>
> 
> ---
>  src/shared/att.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/1] att: Correctly handle negative return values in can_write_data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=32a0811685c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


