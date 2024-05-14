Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E1AD48
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715654429; cv=none; b=TpgRVYRS8/rkyd2rGu3bh8uZAxbmZT2olWqnuzpwK8ytH3apdPnXkK8F1Oa4ebNs6e0iguLhDTdjDJg6thMTQyGCaGCxoCoD5r15jtFELTwatexg2WD1xDpvgtcqwCsC6k/Gl1ad7XcvM2E1brcpdJoHCy/SgCkFMOo9xsd9bP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715654429; c=relaxed/simple;
	bh=KdaP4RbhcZMscfsSACJJuxt8J5rxm04CooBM93xOh0I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uJMIQu0xxiRp7dULmWiUgqdzIzzk44DH5KcQO6jzcb85QfNwLKAGOXywyRfMuaExoobfALYlJsZLyhP9tNYRWg65WRaT7h/IH/6HQqw2KBjKbZsdSDtPNSOpNDN//aXbEFiMzaEXV11uYUTO59yfa9XyuWO4F7+cev0n4aQpG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9X+9fkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9X+9fkw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D41CC113CC;
	Tue, 14 May 2024 02:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715654429;
	bh=KdaP4RbhcZMscfsSACJJuxt8J5rxm04CooBM93xOh0I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l9X+9fkw5N3vNlUEWe3P+y7Fgn5ehDLTQ4D2OBAK4G57dFJ0IW9uTb/h7urUYmGEn
	 GutfGjJMyuFIjQ8kUldKQfvnCD5VUSF81o6E2s7gDUFQVGlssMJg8Cz4te+gIv5jt/
	 Gb9ywGP414EjIX3wrM7GqOYtW5nzb3NhiSs+7Y7DGv1bCg4jjxnjzGc8ZM23Vzd4rl
	 XgO9n/iaWSyGovbT3ub+SolR84B9p6R77Jr4twiXihigp8fczrSlXpG4mPAZ51nfwA
	 ZQZiApglt7X4Ytw1MpZD36pNH0OdGxzEj3ccB6+gJn/37OIuWGA9xysIWTka1bGUa9
	 rgCp6Og58zZFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30800C433F2;
	Tue, 14 May 2024 02:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] mesh: Fix not setting rpl_dir as static
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171565442919.23416.8732153573969683911.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 02:40:29 +0000
References: <20240513203732.435344-1-luiz.dentz@gmail.com>
In-Reply-To: <20240513203732.435344-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 May 2024 16:37:32 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> rpl_dir shall be made static to be properly scoped.
> ---
>  mesh/rpl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1] mesh: Fix not setting rpl_dir as static
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c7445d973694

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


