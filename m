Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723413;
	b=4J2Oo2OUwIFUC7JrjN+YxwTkCButgHDZuGbnjQmWckXaavXW6i0IwvY0PzyxZOG6dvSq
	 Skm9TuvjNY7ZUbVgnTGpQAkGkHCYheLJqGijAo9MN7NpvfTkoOJjfUtMqgNs8VzikoYmm
	 ejFWWYsW9SkJZzTXq50nFpnOjA27Os+M7Of70PUqNWp6+D8IGAFkOJ80MsTtjLirrcnZk
	 YpZa6xnyzURWpUE4klYGsFQ9OuoW7tzfSxhAOHRS2yzLxcAcAmrUV9E/OD94d60gWg1kk
	 Ra7ttoAr8R9fEYSuDaxi2IwSJ4ytGVYmPaBKcp4UEw0FmzXEnmxq2xlZr6ZN6G+AGDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723413;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=JOT/vkpDhR/gaeMLIXKgQDTblPLIPhe5QlfCpFFsGSc=;
	b=yMZXe3VXzg75pZkeSI0nSXXCEkYNmiVVWe6tCc1853eZHKq3dXejX+qQ/k9T0oshtGie
	 VzmeeBTe0KdTz+rmGOywwmtc6djPg+n7dFoZcJCOyUzIwl1LqPgPOb+DSsdz7TcIjKyTh
	 DcmR6Sy3MLPkq1AVWE7cx2LJKicZBTnhsah2CweLa2qVmTcXlXow07nxznwWxfuHGEOp/
	 DdGUPuOMefwP0dF6kcOKFRR4zPNC/8up0mD5zeZaSPkjOeHYitERUyq4LM0svGIx5feLY
	 9d5wR3deeNH3JVA5JC1yzBZ57XZ+KBMc0346lEukZkM9dkD2swa9fwKBBUOwAMfjW5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6kaZvpo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E638606D82C
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6kaZvpo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7521F00A15;
	Tue,  3 Nov 2026 16:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723413;
	bh=JOT/vkpDhR/gaeMLIXKgQDTblPLIPhe5QlfCpFFsGSc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m6kaZvpoTN1bINlIs0wApg2czZ/np6U7T0mmfOZcLVN8dqmVOU7KY54nDNu2DWq0n
	 cAyuY+txU9sBlndJwae7LFfNc1diOP8FkM5SRh/vZJtS/bh5sB/Qh984d2/duwcvqg
	 cwZb0p3R7xVeW0MtawkBBlf34EEQTagMw/vjxkfaaiBen7xaGOmIqF7T0ZDVXsYsnL
	 2XadU6uqB/3MNHJsUExIv6MCYNDwgQvLf3ShWYeoJT3I8xlDKK77k+cjN58oOLOxOH
	 DjSIpz6hVDveizroIYjPX/2c6Msg8mM9HvSpHCntTX4IziaEfXBJdiLCalHbQFWwuz
	 DMTRDi69TAWmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0322B391AFF6;
	Tue,  3 Nov 2026 16:30:13 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ] monitor: Fix Conn Interval rsp group decode
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179372341154.1736455.322872408424969861.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 16:30:11 +0000
References: 
 <3265e8c3d6e7628b82422ff9cad96eb0db9e7ef7.1793456788.git.pav@iki.fi>
In-Reply-To: 
 <3265e8c3d6e7628b82422ff9cad96eb0db9e7ef7.1793456788.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 31 Oct 2026 16:28:09 +0200 you wrote:
> util_iov_pull() returns the advanced base, not the bytes pulled, so
> each connection interval group was decoded six bytes past its actual
> position. Use util_iov_pull_mem() instead.
> 
> Fixes: 79cfd07224ff ("monitor: Add decoding for Short Connection Interval feature")
> Assisted-by: opencode:qwen3.8-flash-next
> 
> [...]

Here is the summary with links:
  - [BlueZ] monitor: Fix Conn Interval rsp group decode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a713dc0c1b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


