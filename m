Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42315216C
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800428; cv=none; b=Ab/MTnc9ktdfcHgGL4vnTxFsJPlVbSgdT/gJQaendDJRmjF6W5PO9PMBG+z6+aWvN2tem0sxD+tn1NyX9+JIC7bYAj43NWykZEDT5PwQDDpz4F3mRJ75p7ddjKSI/uXiVIqO0O2pWup1lUi+HCcG77QHvGuLSuDsdhOXEteJiDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800428; c=relaxed/simple;
	bh=5eIckIZnU/n4bAh4Kj3iXzTcqPabooE37/kzArrPWnM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u2FMG+L5a92tctc73nK81Poi0/Gq+U9nOQGw6hXmOneryS5sg06VElxngWRyqXlVsNdTYlqjzSovySI24TP5Z2CPEFBvZw0+qwNwZB0q7zg5U1u+IJdHaR8u+56YLOqBHnTe75R4P8UhGsVSnsEfCv352PYXI8vU5EMKJ6duTzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hg1WF7qt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hg1WF7qt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABE7AC116B1;
	Mon, 22 Apr 2024 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713800427;
	bh=5eIckIZnU/n4bAh4Kj3iXzTcqPabooE37/kzArrPWnM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hg1WF7qtOBQHmknRSsbyqtIWZvueGUK1RBWSfekF1z1dTovgSUEzFiswqMWoDOmIz
	 /j9Y30Y5OnvzMT0XAJb5gXCgh/FivIEnxgvix5yxpw72nb3SUN3OwnYrByAh4P0H8r
	 fq64P6xV8yFDsImShjroQlZ91NGhEySL9Eq0VNj+xfyRNCPia+MaSCi5XoALL7LuMC
	 ECA2XLe/97s5Hr1tx7Bltclh7lkGSPGQHdQOIYujHHpvdAaEBBVqTJKbA8a2P0GHhD
	 39PkRNkOAljCeoCrUsNqAzjQvTA41/LeEqHzPqimiRZIkM0n3ByifczCFbo+6WEzEW
	 cYm4pkhywSRSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 957BCC4339F;
	Mon, 22 Apr 2024 15:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] client/player: Fix calculation of number of
 packet
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171380042760.2328.4027855855104316020.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 15:40:27 +0000
References: <20240419202341.1635591-1-luiz.dentz@gmail.com>
In-Reply-To: <20240419202341.1635591-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 19 Apr 2024 16:23:40 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The calculation shall attempt to round to number of packets to the
> closest integer otherwise it can result in 0 packets to be sent at each
> latency.
> ---
>  client/player.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/2] client/player: Fix calculation of number of packet
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=92c1c1c36611
  - [BlueZ,v2,2/2] client/player: Fix using unicast QoS for broadcast
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=04153538aaf4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


