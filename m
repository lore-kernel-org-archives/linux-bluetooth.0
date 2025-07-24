Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C1275B15
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389588; cv=none; b=ezpyaplBW6zSs608adRyrKiEWVQeDwR5h5fQprN80DKmzNEjcNl5zazHX0tBZ5M/B46oCWkLZ9pioMLVKT9NCJPybKAYhVo7KRYSUj+Qbjr08aq4ADAGdGrdQKWpeA53O4DoG5UOo+F++HqM5utZT7Fe9qxA3NDKYx1nTgsP/rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389588; c=relaxed/simple;
	bh=NI1JGB3wxQ1QbFEK37G9CDT6DFxoAHInhU5Rawwci40=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XIOtHBbcvLFDhEdPNgpYuZM5nY3c2H3Bqo0Okydr8NjH7f+dovRa2CR/cB2UqFmS9Cgm7VriejTxPx4KUtw6daqojzl/NGDySNXCJPqL5BWSooOJM3IbvKBXVBqfUGfRdCtPIieLF9w5j8YEyueljFIQo9JeatrqVk6uNYbqkSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDKF3LAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDKF3LAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61693C4CEED;
	Thu, 24 Jul 2025 20:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753389587;
	bh=NI1JGB3wxQ1QbFEK37G9CDT6DFxoAHInhU5Rawwci40=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SDKF3LAV4GzeUdQlZVE719sCBOtEDq1bRQrOWS/HS4uwhjWa/x9SfshQt5iBKYdlS
	 DEFoN44DS9ueph6dWjl/SdOlxlQQ+4hL92LelCTWIRQciWSx6Iw68aut3U2tKpj88S
	 ZiY7xUdnGUS1K5e4fkkoaqYqhfVdcVPBG0w+UFOWONbRL38pr2eVLmrsUG766Gg87m
	 XPg983dPOfRhKqPEIpw+BdBbo/BU0ykAn1dksbsKnXyeQjYoMcT5rThCLkDDmmVrqu
	 p4aiDSoOgjeiztVsO1EMKWm0M7GocVSU+3kaE+V7HTY+JceH8mCjmdtKJ3G72nLACA
	 FoagalpfcN6Jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4C383BF4E;
	Thu, 24 Jul 2025 20:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/mgmt: Print UUID and flags when showing
 experimental features
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175338960526.2522434.15593589560454060690.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 20:40:05 +0000
References: <20250719070547.9551-1-ziyao@disroot.org>
In-Reply-To: <20250719070547.9551-1-ziyao@disroot.org>
To: Yao Zi <ziyao@disroot.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 19 Jul 2025 07:05:47 +0000 you wrote:
> Command expinfo in mgmt menu queries experimental features from kernel
> with MGMT_OP_READ_EXP_FEATURES_INFO. However, currently only the number
> of experimental features are shown,
> 
> 	> expinfo
> 	Global
> 	        Number of experimental features: 1
> 	Primary controller (hci0)
> 	        Number of experimental features: 4
> 
> [...]

Here is the summary with links:
  - [BlueZ] client/mgmt: Print UUID and flags when showing experimental features
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=da772d62b295

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


