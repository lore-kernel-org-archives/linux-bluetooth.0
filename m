Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F3441D
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300429; cv=none; b=C/VThyx1SS7MbPqmZJzEBcQpiJb3tAHMckRiVHIbTg9KS8cKz9yN8nILJPQH6GDcS3HGRmil2F32fvEFTl9paJ0FgNu7pVEsrVwd6DzxfMLNTJTNjHEvaCg5QSek6/D8RuVMxYh4V2Xym3jL1ncD5OnKpTTVTi/rM7NAPDd5xhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300429; c=relaxed/simple;
	bh=AIoCYw5Nlduwdn1UbeG5ED8TuXKPOZoU7ote1oFBwmU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MuyFREGUSmeE33gpNiiEqYTbxIQNWYxKq/K07ctD7/vtV/QRmg11T2Roeq2U4e3PqWYTBX4MR7m53wdbaWgVKOFosOXjLOd1Mi3oAYKSxLuCqo9mMqkdpXp1ggjFmb89ZhF49ucq0r6IuaS4FT37YW199j8tfwWGh6I5FatevJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2eMlRuB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2eMlRuB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD02BC3277B;
	Thu, 13 Jun 2024 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718300429;
	bh=AIoCYw5Nlduwdn1UbeG5ED8TuXKPOZoU7ote1oFBwmU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D2eMlRuBLKlFkw1Xn6Zhw/4zrxiK5P+ATwYa7AyRHQ1dn/LrryYusIfAaexpySFso
	 IwUHYEf4VSTA6Uu8lEYb99CYOJHgvPGYgrDsKUi82jXZV2bkdaySnFj9+xnWugJqBP
	 BeBa3WvL1Rvy9egDedfIvtNwzFvI5ksVE6EmcxrIma0j5n8Pa482ErVox6jJD4jEhC
	 rfgKBODGMg1xoPjAlNeDLRTVqyM8c0iuLQfJ3aZ1GAFiT61YoPgFP6rgDpkbTyXaHR
	 F1CV/unRhR/wlECTfkgZfJZIgE+KPSJBWwNPt58zpMr7LUhq8j3KKnTOWDqRwQ+Jln
	 3gIQH0w7V9UsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EE16C43616;
	Thu, 13 Jun 2024 17:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ,v10 0/3] ASHA plugin
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171830042964.19766.2488065716547608795.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 17:40:29 +0000
References: <20240612162041.689679-1-arun@asymptotic.io>
In-Reply-To: <20240612162041.689679-1-arun@asymptotic.io>
To: Arun Raghavan <arun@asymptotic.io>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Jun 2024 12:20:38 -0400 you wrote:
> Hi all,
> Here's v10 of the patch, with some lints fixed. Also recapping the
> rationale, plus some additional information on testing so far.
> 
> This is an implementation of the Android specification for streaming to
> hearing aids over Bluetooth LE, ASHA[1]. ASHA predates the LE audio
> specification, and has been supported in hearing aids for a while now,
> so I think this is worth supporting as these devices should continue to
> be in use for several years.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v10,1/3] src/shared: Add initial implementation for an ASHA profile
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e4bece63ce9
  - [BlueZ,v10,2/3] profiles/audio: Add an ASHA plugin
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c26389c466a0
  - [BlueZ,v10,3/3] test: Add a script to test ASHA
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=792cffb4992d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


