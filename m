Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E46FB1
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMSGrygo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B99DC433C9;
	Tue,  5 Dec 2023 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701747627;
	bh=UrFKcYqfHuvcVyKBwC4b6UptExSL7anYQloMn8l2294=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fMSGrygogwm3aVlcwj+nClJZw6PzTheWDpCFNZH57ye3TnihGxP6vpgViefzSbQXO
	 bCVlCeLrlNqQhRSM/BoAyT7N4Vv3L5wznWOf569Rr5BGSGjsTweCydqS0WIdxyQTSG
	 vPfOCo0dFVrCtyO7tiOf8FrkPzMgC8JGrU3SNV3uOgfCsS9Sr80YwrvaoVIuRY8JHT
	 ZhC+Xpokg+XD7lozQIEqGg3PPxXsHL0BQM+Q7/G9peYcyE3WEfQbseF5baElF2lZAk
	 2P+rCX+M2YvOvqhonYqSb4l4urSlaxNmBcA1AL5gMjNeBVReBkfUVV7clbJcfukjNa
	 z1Zhi1XysYZVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEF12C40C5E;
	Tue,  5 Dec 2023 03:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/8] shared/lc3: Add QoS definitions
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170174762697.12231.15325620473943280673.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 03:40:26 +0000
References: <20231204221527.2990674-1-luiz.dentz@gmail.com>
In-Reply-To: <20231204221527.2990674-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  4 Dec 2023 17:15:20 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the QoS preset definitions as per BAP specification.
> ---
>  src/shared/lc3.h | 153 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)

Here is the summary with links:
  - [BlueZ,v3,1/8] shared/lc3: Add QoS definitions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e3d9aad7d6e6
  - [BlueZ,v3,2/8] test-bap: Introduce QoS tests for LC3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9c3824db2aa5
  - [BlueZ,v3,3/8] test-bap: Add SCC Config QoS, VS tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f93fec890447
  - [BlueZ,v3,4/8] test-bap: Add SCC Enable tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f957d3b6c43
  - [BlueZ,v3,5/8] test-bap: Add SCC Disable tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=58805e4f28a3
  - [BlueZ,v3,6/8] shared/bap: Fix possible crash when freeing requests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f10faf387d7f
  - [BlueZ,v3,7/8] test-bap: Add SCC Release tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d2277071237
  - [BlueZ,v3,8/8] test-bap: Add SCC Update Metadata tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9b322d3a52a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


