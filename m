Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF562882AA
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771007411; cv=none; b=U1fvSTn7orqh9TPBVfds0XxI68Ae7NshHa/22CQZt5Wi9gAM2IvsgvUulXVGY+0HfM6eYBJv2M8jHS5IPpoYKTkGZwfnG3lc+uCE/vjHv6WqzOqNLmjQSUpsbyGd7xt7jOMV3cTXZhPo2r452YhJ3S2ku8oAMLEviWQ6iZdb+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771007411; c=relaxed/simple;
	bh=CWyUg+REColF59NTf1pKTVa5et5zcxmVLUvCdXiGE/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jUhtuBcnNqKvVfmI6LkEIHp4SoBdtT1TvrbV8/OwIIRDa08lGe7QtVSIT4ZXqpWnmnmP9g5ARv79bh+cj27QRRq23pRONrOdPB3XEy6lknjpMvanhQ/6jD6xI2RQzjH2SCgVzjaSHd/VKdz1WakraDA0VBV+rxPIyFKpel3ZJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwnb4bSw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwnb4bSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18C1C116C6;
	Fri, 13 Feb 2026 18:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771007411;
	bh=CWyUg+REColF59NTf1pKTVa5et5zcxmVLUvCdXiGE/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qwnb4bSwWC1W0vmvLvTG6cghmJFpFnbL+82sGwMmkMs2BPTq91BWElCOmtXF4BLrq
	 W9CAW+gMH9zZheA6rQWENqtlTgqbcpd87c1Ph71Ud8JT6GmQU6FMXKIwQJj0BbfKR3
	 PjJbQ9K0w7jUeiEl0si7RByZH5XxdWBgQ2KxuWhLG08NHazxU8NhoK+65DBCaYblCH
	 dLh3UtpBXEcuKI6MrY1yEQIC+FOGMkYz2UoXmKaHB0+gUBL+O/AqPHJKlPlrsxDnft
	 Ma44GQo1K2hZa5PdNLE6Bvmo6X8jAf0gz+FBVzW0rRirk+BvdRysEgb2t0OaviIouw
	 5WXYnzXSxoPgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1853811A44;
	Fri, 13 Feb 2026 18:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Fix response to L2CAP_ECRED_CONN_REQ
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177100740483.2509182.8363468007758300015.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 18:30:04 +0000
References: <20260211202815.1464211-1-luiz.dentz@gmail.com>
In-Reply-To: <20260211202815.1464211-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Feb 2026 15:28:15 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Similar to 03dba9cea72f ("Bluetooth: L2CAP: Fix not responding with
> L2CAP_CR_LE_ENCRYPTION") the result code L2CAP_CR_LE_ENCRYPTION shall
> be used when BT_SECURITY_MEDIUM is set since that means security mode 2
> which mean it doesn't require authentication which results in
> qualification test L2CAP/ECFC/BV-32-C failing.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: L2CAP: Fix response to L2CAP_ECRED_CONN_REQ
    https://git.kernel.org/bluetooth/bluetooth-next/c/c53e4c6306b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


