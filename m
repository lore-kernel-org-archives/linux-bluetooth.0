Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AB2399344
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974020; cv=none; b=QBjl2zvPKrXUh9N5FBtwRAOnrY0+ktKJAAs2eVSPmP+TycGXNAg1j6Zes7NTn0R2zrjQ6JxzJzq+JwJOm1oeuKwoReijn2mDYmG0t7kD67XbH1n48t8ha2oUTTTPYiydM/hYhKFXxCFFLral1TCu0ZFqOAwrSw1sVnWj80JwY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974020; c=relaxed/simple;
	bh=LLguP+OjQWaRzMlKX2/gdSc8Hg3vRPWQlE6SKtOhJUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vFVKgS+EHklHNp6uRDIJlCVIY/RyKoeLNbcG5p2xXCHBvKsJeuGXRIUlM/ilv+WxFTodfYxGONR2ULi/fsPkDNkrAZwtdYE5tSxVphIbDvrv95joeYEUT8mEB1dbbX3rO9wT/hr+jftatxXwRhnZoydapiI54jU9qLB1jGo/OZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5XO1VAg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5XO1VAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6EBC19423;
	Tue, 31 Mar 2026 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774974020;
	bh=LLguP+OjQWaRzMlKX2/gdSc8Hg3vRPWQlE6SKtOhJUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T5XO1VAgZHN6P0YajN0TOH1D3duu8hkpBo7+Gl92xFTkBDXNddGjyayZRahUvbHt+
	 BYNW23Z+etjk0QP9bDfBvcNtjCidNUZD3OhbYXqyQWje47X4zmZC2i0NoV0YqD6Szn
	 1RkqPewJyb7o42eAcWmyyT1C7ZLPpRaFzl7GCqytcN3+kguxBJaGrUUW8Igw2ZY9+9
	 rTvbUYbpN24+lWqPRop31Yoq05Sjkjb7eIUPXkvfBYaSvJMCHoKoGimsG1zShgSV9p
	 YkwPP6juLZSi775T71lXesXnuvdKBQd1sJLyP19UmcutSnXpkJiBwloHixC0EYb+20
	 0w/tAeBxU9O+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D893809A05;
	Tue, 31 Mar 2026 16:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] iso-tester: fix missing clear of io_id in callbacks
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177497400379.2784741.2473526926802404451.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 16:20:03 +0000
References: 
 <9d365c7dcabe381552d97a347aefd5a038716434.1774786982.git.pav@iki.fi>
In-Reply-To: 
 <9d365c7dcabe381552d97a347aefd5a038716434.1774786982.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 29 Mar 2026 15:23:57 +0300 you wrote:
> Fixes issues
> 
> GLib-CRITICAL **: Source ID 126 was not found when attempting to remove it
> ---
>  tools/iso-tester.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ] iso-tester: fix missing clear of io_id in callbacks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f99562ebea58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


