Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48B46535
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712001639; cv=none; b=juGWv4gtvoGUxZ+gfTFRdngbUQbGq66JY5y7vafujNWIOVjBtt+ONhA6WAiLHU2xvUyxvEstm+AzCNqJ1qoPf4KhgVwEPLWwBF2aENTCWZvr3zlp72fKzGa9ncTGFKvnaOOUx7KndzzXQ4iBgP0Cf6kXg1ckiJRrVPUSs9LqroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712001639; c=relaxed/simple;
	bh=FksGzg0lr62A6XmJfShnOizpCRg7lFW/OzeldxFwq3w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bEPJbmMRDfkHjUc2DaAzf/uzFrkI7byhTE8X6cn/afLV9LbvjVxLRabriD1/mDouFlSy4jgoJ5n+lPqglOU91Q+G6/xOMH4cCGC8XN0yeGPfqMaPEK6+zWehLslbisQSqsy2jf03nsHjhryzztQrSfKo5WIlrsM7PCfwL595yDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZs4C+uO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZs4C+uO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89C5DC433C7;
	Mon,  1 Apr 2024 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712001638;
	bh=FksGzg0lr62A6XmJfShnOizpCRg7lFW/OzeldxFwq3w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HZs4C+uObm+XfDAWag02F3qdUs8RzVhxdjQwY/W+54OLj+ylrIVPaetHCZYEwUT55
	 PFTo5T/4weTiBBZ9A9goxmSv/nHQ3Eu7XccP58WMBjBvz2z4nBAFpWA84TXP2HLzby
	 R+OOm6mayQC95hfzdciDZVw9lcoDRFAX2lSxPMZFNpLhhXsg0mYvCP9Y1HMoSzAtPe
	 zQgsEeBZwFjZvAFW+tBl0n27/GRCv8kP6ghACqYKrqY51b4OSbazrP/dzNUIUr624V
	 rTWZBpgv/M1Y0U36y24XVwMlkRLQn++8WK5yKU6JHnutoCtxYsZlBYfZH5Pzf7z5X4
	 5IodtTDK7eY/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CC0AC3274D;
	Mon,  1 Apr 2024 20:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Bluetooth: add TX timestamping for ISO and L2CAP
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171200163850.25745.15315439474290057773.git-patchwork-notify@kernel.org>
Date: Mon, 01 Apr 2024 20:00:38 +0000
References: <cover.1709409547.git.pav@iki.fi>
In-Reply-To: <cover.1709409547.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  2 Mar 2024 22:07:35 +0200 you wrote:
> Add support for TX timestamping in ISO/L2CAP sockets.
> 
> These patches allow fixing / working around controller(?) issue where
> two ISO streams in same group get desynchronized.  Having accurate
> knowledge of the packet queue lengths, user application can drop packets
> if it detects the ISO streams are not in sync.
> 
> [...]

Here is the summary with links:
  - [1/3] Bluetooth: add support for skb TX timestamping
    (no matching commit)
  - [2/3] Bluetooth: ISO: add TX timestamping
    https://git.kernel.org/bluetooth/bluetooth-next/c/3067d73e114f
  - [3/3] Bluetooth: L2CAP: add TX timestamping
    https://git.kernel.org/bluetooth/bluetooth-next/c/e22f35ed23a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


