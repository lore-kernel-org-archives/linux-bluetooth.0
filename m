Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99F456DE1;
	Fri, 24 Jul 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919667; cv=none; b=SEIlWXRGNiQA4X4crfD4uxliW8H9VP7XFDR03ojuw+8iaHJWzRJSl3uTIzmwIZq+7yAzgiM/1mlxrTP6SoNwHXbRrjpgo1WbIHxh15F61j+GN85ZHexLd8XT1G/4XNFJW6shS1YBC9SLj7HiXULM//e2gy2vRg4xvRoSzilax3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919667; c=relaxed/simple;
	bh=qsjH/6aRkkEu6Ff6lY5RQAhru4BBqLFp5e0qNI+53co=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L7eTF3f7b3GCkK31wAdJfMG7frghCETCLciXSWb0c1ZjSN5/VbswC7JMeSdxz3qBz+u1JXPTX9asJjZkl8ey86QD/EtUM3tP5vNn1R1w2zEN6XzHZA4H5yUUucJkvd/tzXhCXs8AHMu9xxdHyQIKfR3qdNDvC4VdZyPqjcRKdPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfSu4eB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfSu4eB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D64A1F01559;
	Fri, 24 Jul 2026 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784919646;
	bh=WcFaFD0hzK5L5FAKkHXw9Fdd/gCVaHwMcFFjfY7ejtk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JfSu4eB3O9VEDINPG85vjk99NFZknKQOcEO+isI/GkYz7+KMvSkW9Ewl/pFRdSzMl
	 VA+EjeSKtHU9lAFHjSVX3B6QsxesbAZNJFKx0nAfYDyStq9eYi7TsuYojXuRbwYtsb
	 XhYnZf83Vtoxvdain/Cg1/cMzb5rk3qyCOjFA2b1RqizrAgzknMfko2FIiM9MpYmdf
	 1ZGxnrQ1KtajyXUmSc7QYr0AqdqOSk6VSPb2VzOwxfSMjHNMZ3xfNnUoTfVfQXzaff
	 D7XGabVKrlTaZmGzAwckf448AUxbvk06XUJXIp0Xl7Aa1KSTukNxdhsGjkMJpCv8ld
	 c3WlTIHqAj0Gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B2C380CEF6;
	Fri, 24 Jul 2026 19:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: fix UAF in l2cap_le_connect_rsp
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178491961338.3273549.6968259035260624950.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 19:00:13 +0000
References: <20260723064845.2298792-1-yaojiale02@163.com>
In-Reply-To: <20260723064845.2298792-1-yaojiale02@163.com>
To: Jiale Yao <yaojiale02@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Jul 2026 14:48:45 +0800 you wrote:
> l2cap_le_connect_rsp() obtains a channel via
> __l2cap_get_chan_by_ident() but neither holds a reference nor uses
> l2cap_chan_hold_unless_zero() before locking and operating on it.
> A concurrent l2cap_chan_del() triggered by a remote disconnect can
> free the channel between the lookup and l2cap_chan_lock(), causing
> a use-after-free.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: fix UAF in l2cap_le_connect_rsp
    https://git.kernel.org/bluetooth/bluetooth-next/c/5de0af8b2ace

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


