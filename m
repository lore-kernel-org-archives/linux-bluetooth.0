Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332714E2E2
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745528990; cv=none; b=BhpLyjMeDZoEUElRaXx/VMuTsnvBgDoxPGy5BeU+Z2Nj14hm0Qh+8pW8BNhq8XufHyfEkbC/HdQ1yo/g9K3Y0qYKO8PdxZF9Ya8gNQJRhiXsMLgRJo1nc6C80IV2zwIWZnsWxREIryC0lt/oKujPAT9bKxIm+1c2hgRG2vWVXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745528990; c=relaxed/simple;
	bh=QfsjY7gr3pMHq8hpbXCG4kjfkc02IR4cZVJZsoet3k0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oHH7nblHSjeU14pE8mweFOn1Xsv3uDrIPE0PipWJ7w6jE9MWtAnMKwn69r5IJVd2JCizTj6t08dwBIWMuFZR3bJyK/LuzwJSFLCL7hitBTsRuC3ZZ9jvqVTyNLf+7A3p4/SlOhApX8tZxrJRRPBqNk4F360cCsUVovY5UnqwRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqYORUEe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqYORUEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAF3C4CEE3;
	Thu, 24 Apr 2025 21:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745528989;
	bh=QfsjY7gr3pMHq8hpbXCG4kjfkc02IR4cZVJZsoet3k0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RqYORUEeLNvHb0qTu8TAhJFAp6fRIQ9X/klyk/H7hg7uvHx9zErGvCxjdCi9jEQxx
	 z5XhXgIC7T5EPTsR7gFDIxDbu39rYh7MqdbVS+N8h7WwP2qokt+ZuSem2xXKWZVT8p
	 i7yJiiJQgRSyej7nZxrU/b9mMIZkYu/5EHnoTqT3Ex45NSJBEmgok9I2yd469Wvd0X
	 F3GeKuStbBFl91f9JhGA+buOpfK2P2z6Mx2u3XA074H0eoEshNwsHVCSbyMwHDh9UH
	 BWKF43A4qT+tOV7IgjetwTTmoqJklX+0nIlS0qvu/UyACpeXzp3pNS/RRypvx6scIq
	 40aQWegxLtU+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE51380CFD9;
	Thu, 24 Apr 2025 21:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: copy RX timestamp to new fragments
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174552902850.3492605.4655894838579542250.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 21:10:28 +0000
References: <01117138d56019a8598f24f0df2dd289713cfab4.1745524193.git.pav@iki.fi>
In-Reply-To: <01117138d56019a8598f24f0df2dd289713cfab4.1745524193.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Apr 2025 22:51:03 +0300 you wrote:
> Copy timestamp too when allocating new skb for received fragment.
> Fixes missing RX timestamps with fragmentation.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  net/bluetooth/l2cap_core.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - Bluetooth: L2CAP: copy RX timestamp to new fragments
    https://git.kernel.org/bluetooth/bluetooth-next/c/60b82ca5d6bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


