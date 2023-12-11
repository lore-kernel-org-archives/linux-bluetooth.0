Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046D751C44
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auKiWxhy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF770C433CA;
	Mon, 11 Dec 2023 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702320024;
	bh=2XkplhreRlkq03SKAzCcK1PP1OUNnO3hmUvwSZ96yQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=auKiWxhyVsQU7Rxp2K2zoL9V0/Q9OFzBC807Qbq9P7Qm/lTkDF/QCtN31XeUkP7tB
	 1jam+lp7ZamApL3wmIpf2hQHbBahBTVxpdqsDFxRA/44s+GnPH0dM209m5wqj7Q92o
	 P8cjx1PZWM52kqLYYK4kJR0j1sen/xrAXXcsbmrGHzCaSfPWM33CRL7xD3RX3A5TRe
	 gBja42KKGvbHb8JZHvqszCuRGnRnInl7QzPwAbj9ugMbGFijZu4Da01ajrEi4s1hJT
	 vJ0qfNre4MCnjf6L/PRLCWLYPgHBA110Ui38u9Nekz3aavXHLtSO3bTAKXGiSIvxQ8
	 cL9CjQrrRjakg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B427FDD4F0E;
	Mon, 11 Dec 2023 18:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3] tools: avtest: Add reject-code option
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170232002473.25763.12111995761836114309.git-patchwork-notify@kernel.org>
Date: Mon, 11 Dec 2023 18:40:24 +0000
References: <20231208101711.624001-1-frederic.danis@collabora.com>
In-Reply-To: <20231208101711.624001-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  8 Dec 2023 11:17:11 +0100 you wrote:
> Some PTS tests like A2DP/SNK/AVP/BI-03-C, A2DP/SNK/AVP/BI-08-C , …
> request some specific rejection code to pass.
> This commit adds an option to specify the rejection code during
> AVDTP_SET_CONFIGURATION rejection.
> 
> E.g. "avtest --reject setconf --reject-code 195" to reject setconf with
> INVALID_SAMPLING_FREQUENCY code.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3] tools: avtest: Add reject-code option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fb681e795027

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


