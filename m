Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991007;
	b=Kb2ER7vWClKlELfEz6qFpGs44HsNE3RH9CHiqBVnLKqr5/ZFZKBuPqX7mtGovZwGk1O/
	 3L00p//g08w7NSNdHNVm8/eOGnfuFzHOTMivoyYkvxQalwuOdUDQpMPItMAl/X1Xpj+uQ
	 6fSU+j4Z418Jd26PQ3aNFYegM5eQJdUgQd3vv07niAJ1hdl/1h1JrHl/U+eoR+WXRsF7/
	 ycKOZkqgOOoXsYiykbDGmf5tyzf2rFQCoYSloDLgySkHkMKJbUCDuUb/dY/hQNtJ5YenD
	 iTFFN3NhXGgXGAdw6+HU4kvI19sZ0lRnxO23z8Wo7fxby1A0hUG/aaMFcAPW7kbnVMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=qbqjD2iEGNEAahdAjmc4YuwNw0rF7X3YJg4pPlcB0EE=;
	b=ErZfI9V7AaRrQBISOZ7C2DYppLHDaM2kAbVg3XNSBfJWAtmJNHM1Ll47dyk8LRYLJTOS
	 89sYDJQEywrQkVGYHl7kj8r4T1swmlmDCzOW/TmrpKpeLAB4bzDdSb4Nlywp3t07rcqA5
	 Cvh0m6cEZfQgEtQeRXBA2IP/dKV3HYgJF7wvC/p9ztT726xMebmTdYlgn5BeYUal46pEs
	 5yhhhH+koUoz9Nx9O6I1NMASV0lSOo9qH31ziZgJBX6AmRkhzciAm4gYM54zWf11LhXqM
	 n8XnZSL/6v1A6W0HTPBBldvCUeo8JWMphwyhPCtKZOdEtRqhsrm4pEE8xkinGTC56AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liUv6RC9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC34606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liUv6RC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E111F0089F;
	Fri,  6 Nov 2026 18:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793991006;
	bh=qbqjD2iEGNEAahdAjmc4YuwNw0rF7X3YJg4pPlcB0EE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=liUv6RC9s2E0jZsesRu4Tvr2Ss9DpgBQeNJNwNS7KJKf6U9dlt4BAGvPuZeiDJdKU
	 g5br5Wnzz3hCYml2MoNMj0O/1RUPqfYJJAnk2q7lEbAx9pdDu2OLCVFvzdLqu+5Zk6
	 oKZ7V9jBO/M/rInFyWjR9sQ/7xEs0wMmnO6ifcsak8bhVW304SQBiYgKB1CTfdQNDK
	 G6ZcyP0fdEd5+OvdnJl9TWc23P7errV1HOW0dqTJ1vtM+V8sp5/XrQFljstWYEDD47
	 y2veH7HtVaHcczbzM64K9fNEjhLYKnYlIv3+/P7u3cd24aUrd+YY6kdyYZcjh1sbIy
	 LRFqqJDV0ymig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D81BD3A41021;
	Fri,  6 Nov 2026 18:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/timeout: Fix use-after-free when a
 timeout
 removes itself
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179399100567.811161.6597744778392597032.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 18:50:05 +0000
References: <20261030134426.420979-1-luiz.dentz@gmail.com>
In-Reply-To: <20261030134426.420979-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 30 Oct 2026 09:44:26 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If the callback of a timeout_add() timer removes it, e.g. the tester
> test timeout restarting it for teardown, its data is freed before
> timeout_callback() reads the id, and the id may already be reused by a
> timeout added in the callback, which then gets removed instead.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/timeout: Fix use-after-free when a timeout removes itself
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=70197a083fa6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


