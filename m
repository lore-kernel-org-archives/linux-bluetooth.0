Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53C284B3F
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448595; cv=none; b=iw4MdQeDOM1Zd8QBao87AOUdQWF4TOviqpXnHFVHcuou5ROY8tbGzgimpnL/kEzbM3HMSH01O18ZYOdJfUE8Hhp+1y/hy/OQxp6VQqbiiqtOMPSlrcqvUfH5hGzDHprqUS3+YeZyh1PMVSR77nhFVrwTlx4fNMolFP0/6S0xt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448595; c=relaxed/simple;
	bh=ILNJ3sXpOLhSTnj9kckF1yOXU19fcIBIiAFceHxvyV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AfPkBVZG1+epvDVtMf4Jnrf/KY2YlcqbnBvi7hse3zdb9xE7jCCGcCrptUhLw+zQPrSMGh1mo9zPjF5jPw/WhpNUWOruJGR0dWTW+rWlqrw+P1TPvu1npgpJOTRJp+f+iXyuOeI1zgq57Nfy06+fSHgk15bQk5jJF9YwIlmupm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNV3P5kZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNV3P5kZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CE8C4CEE3;
	Wed, 28 May 2025 16:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748448594;
	bh=ILNJ3sXpOLhSTnj9kckF1yOXU19fcIBIiAFceHxvyV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tNV3P5kZAqoHS7t0YSmMZyVuyERtMZpunAVdUxlBum/kEYFh9Oc2BNesa7p9ek10G
	 EQwT3cBtnQEdYbZYovGT0Czg0MtUNou8XtBqWW5Diu6BYDVIzLYCxHHsbChESjx+Rh
	 jDLYaF47K88GzDtHZPIvSOdFtM+qX7XT9BesGEqbqcPF5NXG6APhK0WoG1rM4r35GB
	 jSgkXn0pJzHi0P/hkmNvHm5x/94GFuvq7H5ksneDweVYXQrT4pt9L468yrba8K/mHY
	 s+X6b07zFzOFWMuQcrSqVK0S0ohq0mJu+sf5owhfxtjlUJ23OwtNdCel8EiTSYvv8v
	 bu8nYuCoSm+Bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD963822D1A;
	Wed, 28 May 2025 16:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] audio/player: Fix not being able to register players
 of different types
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174844862853.2452033.15464426045863290702.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 16:10:28 +0000
References: <20250528142112.434989-1-luiz.dentz@gmail.com>
In-Reply-To: <20250528142112.434989-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 May 2025 10:21:12 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When registering players both AVRCP and MCP were using the same object
> path making them clash, so this fix it by adding a type to the object
> path so each profile can register their player in their own domain.
> 
> Fixes: https://github.com/bluez/bluez/issues/1290
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] audio/player: Fix not being able to register players of different types
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f2cc37050402

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


