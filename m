Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7303ED135;
	Mon, 16 Mar 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690180; cv=none; b=tBiTZSPQorlJ37EO1FmaTEybyAg2G2h5xrkwwRx7BaNiPJx1wZTvOY2PwOPkcBsluczTTYFPbiHKL9xa+HWGnVhXtZXsvb9SRwyoK9K2RIYzhRwxPy+a2UhiBAMXAXrlFORBJnJc45W2vYm2d2oGbwsdBMhJ5XY8FTwuBNCy3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690180; c=relaxed/simple;
	bh=Jj6BbcYzraXFOQXQwjXzFEHRPAjsRRQvZZ0ky/jjEPQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OJoaRbE9Tj5VbEHFb3VuYD/OeLQDMfVZXMsDgcDfJLOtc0tvpKmL/u2gkc32Ql1CNjRD81Z8AnvOegm3bIHf/zJX+woJqHe103mnxNPuuWCxzQk0kdmLgounqAl9bLf4RHxj9onXQUFTS7YbByKc7apMJER4ALK8a5fTKylNNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3HhHyZ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3HhHyZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1DEC2BCB0;
	Mon, 16 Mar 2026 19:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773690179;
	bh=Jj6BbcYzraXFOQXQwjXzFEHRPAjsRRQvZZ0ky/jjEPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C3HhHyZ54egvtz8+FJBDghgxje6T76yCcWpZHD6G+GktO7Oi7hlX2jZlW/iq13AMM
	 CT+929EtO+r78lV3oA/zWNrHCqHitEBSTZ6hJvN5hIHM/FF5rU1Pnj5LUgoIw0RDlY
	 1gYtRSq68tyHSkf9W/PU2YzAOueJ9IacrFdIiZQHbBmKN55mFk20QbDKaqehoW0BUq
	 PgbZfNWA0qd3QwifvsLNX4D8A9m7A5KDaWJeXZCy360NntjSyYNXHeV5qz6j2+6eI7
	 WVYw1J3qsj9EbtPn+K2a3NQ4QkOOHbSj0kjF/66rwEqD7dkE9OyHZ0bPOTvnuOCMb5
	 0IuNmv6+QqzSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F8A3808200;
	Mon, 16 Mar 2026 19:42:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-02-23
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177369017279.3255020.15622951635181819157.git-patchwork-notify@kernel.org>
Date: Mon, 16 Mar 2026 19:42:52 +0000
References: <20260223211634.3800315-1-luiz.dentz@gmail.com>
In-Reply-To: <20260223211634.3800315-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Feb 2026 16:16:34 -0500 you wrote:
> The following changes since commit d4f687fbbce45b5e88438e89b5e26c0c15847992:
> 
>   ovpn: tcp - fix packet extraction from stream (2026-02-21 07:04:08 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-02-23
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-02-23
    https://git.kernel.org/bluetooth/bluetooth-next/c/1348659dc92e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


