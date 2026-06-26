Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6003F0743;
	Fri, 26 Jun 2026 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472623; cv=none; b=h8KzOfSQfZ3u9Z5K52Z95ZzC8boFLuxOFppmr5JBRCULA3rrTFcZNLynKXwBFXlaGM4ahibMAhP+nBYSzh7mKDoxry+jwJO9l9lXersArkdCDciao1lO9Q6Rk20/Gxpx/7KmDWeFtPveXYJyqVpBR1SaLciUfWWaMdBQnnw2yGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472623; c=relaxed/simple;
	bh=Sk31ZnApX22zdx1QsB1bag+PWnUwBTe34Z1Z2rHqZFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mNI0EQ/lLAd//VBjgEWaxBHfwu5xlRA8BbNuh2J5pZNUYqGGkRFyPZ+L47x7b+8ZxPHh1Iy2GyK0i06uRd8DSe4v44byoT9KVuKZoUzN8vIUtDHnbwsjafDflYmr1MSn34pg5iIj9iKmO8am8W2otz5cS0AVsg/3IWL9ATDwS68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzrOn61S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzrOn61S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFBD1F000E9;
	Fri, 26 Jun 2026 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782472622;
	bh=tElvAgzgajWUxEY8/hmjuKkVnLPcGeb4lLj2V9+ILjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YzrOn61Sma3nv2RHtl19k33j4hHcfT+MePvNKxy8sB3J6irUixHAj9alXzWCVBEZh
	 TlDfOp1xTzm7MjJIijM9pj4FzN9flY+oXkkHAsbHLt5obaHKAEuLP0CnwJaJUS1S2a
	 sopAo1kn9QlNBpTk1JCGxDDlLl5CFBecZIIFSwa7atcr3nijgzedkFhn+MAiLHgMm6
	 J1XpKaWZjkwncZ2glDnnq7lZVRLEa/TeMcx5maYAFV27UC2mhUMtn/wKoSv6iQY6/F
	 MCK3vM8C7XaSpgQ4o3mwT3Pdheozi6XLLKGMIdJCvrm+KXWj3G1rFeucv5Sd1vWLKa
	 nEQfWkhHYchaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9405839389EE;
	Fri, 26 Jun 2026 11:16:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: sco: Fix a race condition in
 sco_sock_timeout()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178247260901.3816447.13954795809644972241.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 11:16:49 +0000
References: <20260624213304.1460149-2-iam@sung-woo.kim>
In-Reply-To: <20260624213304.1460149-2-iam@sung-woo.kim>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, daveti@purdue.edu,
 luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 24 Jun 2026 17:33:04 -0400 you wrote:
> sco_sock_timeout() runs asynchronously and lock_sock(sk). If the socket
> is closing while the timer is running, it holds the same lock
> (lock_sock(sk)) twice, leading to a deadlock.
> 
> CPU 0                      CPU 1
> ====================       ======================
> sco_sock_close()
>                            sco_sock_timeout()
> lock_sock(sk) // <-- LOCK
>   __sco_sock_close()
>     sco_chan_del()
>       sco_conn_put()
> 	      sco_conn_free()
> 	        disable_delayed_work_sync()
> 	                           lock(sk) // <-- SAME LOCK
> 
> [...]

Here is the summary with links:
  - Bluetooth: sco: Fix a race condition in sco_sock_timeout()
    https://git.kernel.org/bluetooth/bluetooth-next/c/cddcc54a7afe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


