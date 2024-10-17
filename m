Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CB1DF747;
	Thu, 17 Oct 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180827; cv=none; b=FdBuvKudW7sq2VFGzkohVu1N6XcrTgkKNJMaUrhRCoH10GRGDMwwd49BKuf2hp35UuIvaJVP/lmW5iVEhjxUBSjV2xkwQ7GZLI6fuhXKT4cqmZBNbQB+p7gVBjB3yVjvWuWNFgZp48FTaqz9Pu6jZpfWTl/Iue3V2vb+cljw+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180827; c=relaxed/simple;
	bh=65TWCVymdAh9ewr676UCiwUOsxYZdiWm6JD3dVRruCw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=boJjupo9jbV7skpde0P0BPDOmYf+vK3Ktgd/C5lk9frkSpWZuBrWdFsvzuhiblhnYo/Juj8A5ItZ9xHvOl8dEHsMtAUEDyc6odnnE7UnVMrGjAqY6OkxLOzbLtBBFi+oVCP/napEKmIUygrV/81fyrYXtn9L5+iq1tFTtS4D0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL3jpcUw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL3jpcUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F91C4CED2;
	Thu, 17 Oct 2024 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729180826;
	bh=65TWCVymdAh9ewr676UCiwUOsxYZdiWm6JD3dVRruCw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KL3jpcUwocP6AYUbAL8Co4zAgs+kB+NirkXjLYV0+IBJFoYPj/KnMsm7q7YG33Kjb
	 I4JkgGoL0lmEPdnTmdX/tK1rqQOB9xCSRU8cgNjyy1htixMLAENkCGJrNHgtPULuBu
	 UsGUqi93M+W6380qghG4LXPFhdLTklHzEXKdbjPYKZJAujfh0AKKDAjcwkZlyRaWXX
	 rP6ZkyzAfBrJoSWejcR6RaaOXXHkkx/KmLGalivvH9G0ozPub+RbOf8kkIM1e1z4gO
	 HBQlymLR1w0i1k7KMxd96ZqR3e6rLMfmqKCKuNzFsJSWaNPBX/HgOCID89jDKKHK1q
	 CjAXj2NMmNhhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DDA3809A8A;
	Thu, 17 Oct 2024 16:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V5][next] Bluetooth: btintel_pcie: Remove structurally
 deadcode
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172918083223.2518908.10986881377110470555.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 16:00:32 +0000
References: <20241016213956.4508-1-everestkc@everestkc.com.np>
In-Reply-To: <20241016213956.4508-1-everestkc@everestkc.com.np>
To: Everest K.C. <everestkc@everestkc.com.np>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, skhan@linuxfoundation.org,
 dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 16 Oct 2024 15:39:55 -0600 you wrote:
> The switch case statement has a default branch. Thus, the return
> statement at the end of the function can never be reached.
> Fix it by removing the return statement at the end of the
> function.
> 
> This issue was reported by Coverity Scan.
> 
> [...]

Here is the summary with links:
  - [V5,next] Bluetooth: btintel_pcie: Remove structurally deadcode
    https://git.kernel.org/bluetooth/bluetooth-next/c/8f66f6498463

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


