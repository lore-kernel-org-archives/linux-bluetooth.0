Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050810;
	b=hKdEALcz9Kd6N2hxAG7rKHbL9sNgA0IHk9g7QmBaXP2lASjtTjcklNVJUptsW6NOgXhL
	 TlWeu2VhrfTVv6NCXFEeVE6CMjTOIODUJmg6muz6hfE3kw57kjwfePmER4vej8//hS7DA
	 9hwxm0WiCJHbebsTerHA0I6znMjL1j9Z+bnUgDA20QzLgl3E7JVpU6cNmPZYkk5RCEj7I
	 sAnH3IW493h3nsg8okcQeQi+HgEteBN5FymJAsr2+pIQzmu0SL5r2QhDeXHJfJ0fdKho6
	 9BcwmyQtEVxYupXEh1hmS3FtbD7S683g6J0MIJHwSoclXbiCE0mYMmJr4F+sHBvrKJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=f9ZcLUd5/SxAb0Pfvx3vSPO4xA79VJwyMwHcqMCggPk=;
	b=CJV4CiFX0fQM7XbzQSBykBZRr668FOgbEXslUJTtYa3QE1n0R/EHzYf4/ZOw3A3rrWOX
	 CpiDh+6WG7g+Oc8Qr5rwF1j/DQSJAch4koYFUzL1bBUaZQuTsQLMoxcHPYPOBlH/16U1O
	 qw5HKzLEvPZExUWJ9j11DOzDLgbIBAcu5TLj37wALrOKj4+/QduOCCt8WyRhwFc5j7Ala
	 NXc9Gs2xK4gXPcm0lq0vdzw1rBQErvN9kUW8nqqQypaZdompmhpItBc1iQctl8a4jkE/G
	 8pP8Xun1Q6lD0shdgrQFdAlOALsnP6l4XsaS3R43N5RtfVpUJj2lo2T1PJz3e0ztzig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SW2srY0p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C6606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SW2srY0p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1075B1F01825;
	Mon, 26 Oct 2026 21:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793050810;
	bh=f9ZcLUd5/SxAb0Pfvx3vSPO4xA79VJwyMwHcqMCggPk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SW2srY0pVRI3lofukzIzB0NfbyLgupqiLZA2zw9dHOFXKhQafZ4AL3ZQ1Fv7c98s0
	 Qi22PkVljcVcUuIYNHDtD5+cWwZTDc/+MDXiUnV5vJzY6lVUWq5lSnslcp5IaOkNQm
	 xi1/ro9FFzrOd+60Hmn7ZhwqDjcTmY6/kQm1uCo0EA/1LEHszrauWVVL+btr52Atk5
	 NSuAksuyk4wQ9lH6BAZsH34egLN60tD+upGA4FhRChT87aUmjDLkp3zeRUibJNBaWx
	 /ZiPkWwzbgD1PkH6z+gQJcIuefbfU9nVhzcCr7cJgtevs+PlMEGgT4j3SVEJmhZgzz
	 6eeZ7luOFQrtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 073C13AA80E9;
	Mon, 26 Oct 2026 21:40:10 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ RESEND] gatt-database: Fix freeing wrong client
 notify
 IO
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179305080861.3403508.8946558170896367981.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 21:40:08 +0000
References: <20261026032544.49563-1-jared@kotfu.net>
In-Reply-To: <20261026032544.49563-1-jared@kotfu.net>
To: Jared Crapo <jared@kotfu.net>
Cc: linux-bluetooth@vger.kernel.org, jhs730127@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 25 Oct 2026 21:25:44 -0600 you wrote:
> From: Jerry Wu <jhs730127@gmail.com>
> 
> When a non-bonded device disconnects, att_disconnected() drops its
> device state and clear_ccc_state() invokes the CCC callback with a
> NULL pending operation. ccc_write_cb() then takes the notifications
> disabled path and calls queue_remove_if() on chrc->notify_ios with a
> NULL ATT instance.
> 
> [...]

Here is the summary with links:
  - [BlueZ,RESEND] gatt-database: Fix freeing wrong client notify IO
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f7e2cd91c266

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


