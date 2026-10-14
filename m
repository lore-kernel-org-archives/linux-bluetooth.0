Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC7560AB6
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998429; cv=none; b=lMGD96GR4UVzMztZdibpbBWn96BUpVV9/7c2lmE56+IOPjCypnciSxHzUf0nKcc7ZFgJlWPmgw20rxPZw1UnN0deyBnMLlkeXNxz5VxCIHwgHeh3ZxFheC5IrJ+xUOjohstDB9IvmZkHL+o1tkxED5oWWL1q+e4a/nIfO177iwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998429; c=relaxed/simple;
	bh=AeT1PQLedcl/lzir49xxhuxzjEXAbzlyPgIO1tLtFDM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jiq1aMUtqjII+mf3+yYY7vb8KaMClw9rvDKJoUrKWQUlLejD7P2aTePG1ZC+dlws98vT97ZqirYcJlqaLLbJVOgAtlXlzvO9G5BJCuZg/3e1RCNPQM874QprCC/e44H82UMn7MP7/C3Mvk5srucH8dchqnr53oj9HVtl9MyrHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+ezl8Ta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+ezl8Ta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0779A1F000C5;
	Wed, 14 Oct 2026 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998419;
	bh=fXXEQR/TjEGRKFyz5oKWnd0xIDLlKZyoYOafUf1j6eg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S+ezl8TaEZd010utVH8EUSs+5tokqMM0LOZxU3ahUJfA6mceFk0bvGugT2ZayIG+d
	 okctefMeIphP/KGVDnUcYLioHAubf8AW8ZpT8YCLRj1SzOb6IfqHevXdcZFMECZQbp
	 o2POAWVkvGPj3AbTGLOW0+HUmA/4UWEaS9uqEb6wrB4kSJhqwCfM4h6r1/RzJNk0Zc
	 EhJTiTTwxhg9omny3w6cSeZZvePw5I/pu0vyZ28j5ydQjY/mfmUZii3YwYp6Hf8KT3
	 yOYdDCMsvPFEWvG/Tta/3iuRAHS6O1zx+SnbkXN9a9w3hPAxHF52OB1zT4hO/0pix1
	 e84sLuXjqDd5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F140839FD335;
	Wed, 14 Oct 2026 17:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] test: functional: connect instead of pairing a
 bonded BAP device
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179199841751.2868755.15941691793347495599.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 17:20:17 +0000
References: <20261013150336.579039-1-luiz.dentz@gmail.com>
In-Reply-To: <20261013150336.579039-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Oct 2026 11:03:36 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The hosts are shared between tests, so a device bonded by an earlier one
> is still bonded when a later one pairs it, and pairing it again fails
> with AlreadyExists. cmd_pair is meant to connect it instead, but it
> checks Paired, which is not set until the services are resolved, so it
> can still issue the pairing:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] test: functional: connect instead of pairing a bonded BAP device
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0a48b5ef5e3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


