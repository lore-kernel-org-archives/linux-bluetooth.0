Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F761E4A1
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825432; cv=none; b=hYM4dMr7eKhCPFa1igU6HeZdqhhbZ/E4c1MSDMXMVfrvFYP3D3POy3EsVe3wVQo8Vv57knp8mEpu2x+OyOiB0RJAR5p0PjS+LJW9ebjO86UnR6G87xZygwN/gwkT4BVFmlrfXGwFEV3XNpRfK7qXEv9vu3yiXM+8yyPHEdO6ahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825432; c=relaxed/simple;
	bh=RF5R4N2C00ZvfCGrdXcnO6FtbeWwtkDbrZrnL4D7pO4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r8nV/BGzIluXTp29cfr5uHWWfc1tejtOiwd9eAjwxPflzDzaJx7xCY7fDhwltmj5BOh1ajmmd0XXFQTdVg9tcfFDti3L587L2c4uzT2W/Mxt5mq2bBNCT4UqJO1dRAJjH0RmVflwCfH4/swkx4aw+I5sjjH9T/QeiBskX8kyNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=an0RZvAL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="an0RZvAL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D4DBC4AF07;
	Wed, 19 Jun 2024 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718825432;
	bh=RF5R4N2C00ZvfCGrdXcnO6FtbeWwtkDbrZrnL4D7pO4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=an0RZvAL/ldBI0mVcAnb63sqzaUYBfFEUEKoV4Swseln9Bl644mygp7n0n+W/nynn
	 fRjdLPNY2hHcC1GZnIdtG1zTmvNw1KHDflusKstMsQN3sC0BHxr7oRtGvh9wedfL9f
	 b20OPLUjNieXdMJHq1o5Rw917v2SXmUIyRW/hc9EUGhNPAPGogpO2pf8OK5bZY3qtR
	 YoqQQiUBynwm6HEkcl1PXOi70Pk6Tv/jGmwwO+2l8Z3cQCrp7zfqiSp0bQzy6K5m2h
	 N5gRQ4vDoWlQekXC1v/SVNQMvYlBTHmGonaU8DQx2O2Q1NVsZSpEdtBfgga+FyTmlz
	 S9fIwot1I1C8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 345A9E7C4C6;
	Wed, 19 Jun 2024 19:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel: Add firmware ID to firmware name
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171882543220.4484.11758065252756983156.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 19:30:32 +0000
References: <20240619100933.2054286-1-kiran.k@intel.com>
In-Reply-To: <20240619100933.2054286-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Jun 2024 15:39:33 +0530 you wrote:
> From BlazarI onwards, driver shall append the firmware ID (usually
> represents transport type) while constructing the firmware name.
> Firmware ID is returned on Intel Read Version command.
> 
> The new firmware file name for operational image and ddc file shall be,
> ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step-fw_id>.[sfi|ddc]
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel: Add firmware ID to firmware name
    https://git.kernel.org/bluetooth/bluetooth-next/c/a5495fe62d9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


