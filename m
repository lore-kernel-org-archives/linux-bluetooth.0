Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2418014F82
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1iVK5Fy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9B13C43390;
	Fri, 12 Jan 2024 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705084826;
	bh=QPbkLw6SerIsl+sdqYuS4ZIEiEK7UAVlV1pu6qUOVb4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M1iVK5Fydj31Gt+6RVKM5sQLYMpWLg1UrXU8AeDdH/2cj3hxk5j8ShubpJV7ihkNY
	 zbIpyPgeqld9WErtvJ+eJif2Vp4Wa3xOipR6jFRMxX8jMJf2V7xyiCYq1++Ulyr2Oi
	 zfp+BOICTJsvzzLKJKN10WB2k3LbYCuvry7FzWebcyWqvkBXjagnwiCBeUq42vtFqr
	 wqvg5iQnNGfq1uNA7L0AF9GZpSL0YU7wyiPuqqcWWaHh55snhujWZlxp4imylGOYUL
	 35R8NCM81oAzIlOvmRmnX1uRcaB+T0qvhVL7O7XtjiXLXVXfLT0fuYEBRcpplmTD0T
	 bEsim8PxWZw+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE8B3D8C96D;
	Fri, 12 Jan 2024 18:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] avdtp: Fix potential incorrect transaction label
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170508482684.21011.9547197241854864913.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 18:40:26 +0000
References: <20240111171635.144825-1-xiaokeqinhealth@126.com>
In-Reply-To: <20240111171635.144825-1-xiaokeqinhealth@126.com>
To: Xiao Yao <xiaokeqinhealth@126.com>
Cc: linux-bluetooth@vger.kernel.org, xiaoyao@rock-chips.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 12 Jan 2024 01:16:35 +0800 you wrote:
> From: Xiao Yao <xiaoyao@rock-chips.com>
> 
> Currently, AVDTP commands and responses from remote devices are all
> stored in session.in. When one end has an ongoing transaction and
> immediately starting another transaction, it may cause the session.
> in.transaction to be incorrectly modified, so we need session.in_cmd
> and session.in_rsp to be able to handle outstanding requests in each
> direction.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] avdtp: Fix potential incorrect transaction label
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1f9ff8fb4048

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


