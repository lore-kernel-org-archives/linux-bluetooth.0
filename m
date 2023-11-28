Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E751B39ACE
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ8P+kKr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 865F9C433CA;
	Tue, 28 Nov 2023 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701193229;
	bh=PJMhicx3hRghp056OZmcPxsp05XsadPOoJxtb1Br0bw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fZ8P+kKrfVEZr+qVRu2FnHQthfkvAq5EvY6MaF4IOK5sMYdI9/Qingy0KJnQXrjjY
	 1GWfYYZvUCjhhCZ3Z2AV50VmI+ADz5n1aSL3z4q65RePmVUOboYhUjmcEqZMlpN/q9
	 +yqRfg7TAmwQao5g0AfzW3326CnnCaCH0K4dJD0ppYTLV/o6TyNq9XjrJGoBy7WZjf
	 TAEfb126EGxv5k6xJrZLPpXFAwpgOLQgrhXOnTU9QQTWg88sw2UQrfZw20aVilQWNH
	 xb40pF77qMsf5zbXAnUynVAK+boEKfkKws43vPNE22hqxXMgiovcVjF+r7crh34j7m
	 e6LsBJPIt/sDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F9BDDFAA8B;
	Tue, 28 Nov 2023 17:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] iso-tester: Add tests for GMAP broadcast QoS
 presets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170119322945.16253.5809807043480910479.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 17:40:29 +0000
References: <20231128152832.1730901-1-luiz.dentz@gmail.com>
In-Reply-To: <20231128152832.1730901-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Nov 2023 10:28:30 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the following tests:
> 
> ISO QoS 48_1_g - Success
> ISO QoS 48_2_g - Success
> ISO QoS 48_3_g - Success
> ISO QoS 48_4_g - Success
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] iso-tester: Add tests for GMAP broadcast QoS presets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2ba614813971
  - [BlueZ,v2,2/3] util: Make debugger arg of util_debug_ltv const
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=acaf8f866d29
  - [BlueZ,v2,3/3] monitor: Add proper decoding of TLV for BASE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c9a1f2080828

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


