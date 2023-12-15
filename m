Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DE33FB10;
	Fri, 15 Dec 2023 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS+8ZrYU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6006C433CA;
	Fri, 15 Dec 2023 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702659190;
	bh=ue300XyvjPwdbWkvgmsDGbAt37Dfyst/F2EvZxxTaq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LS+8ZrYUYvdWw2sUBc92N9f3fCbHCULt3fV1iRqGphP12oKg+2s3gO6CE+5fw6NPL
	 wUcK7pSlAHAGg6QYhH4uHRaLpuM85iw5qDVfw+Zjho/LuDJBQrBlH3afdb5wzmcPWq
	 boKdOqcqdQy9DRkqKmRAVGrD9O13VBZzDOFh6XboMKgDNFmXsC99/NalU3yOPONgZ+
	 HD1kpsmNKctb9IwDE200HN2XLty704WTefFHzElheGAfbUmTPqHqkSp8IwAgehOuBG
	 B+EM7eVc9jjbbFAMque8NwoVvSb5k5bQX3ZMX9BQKCymASrpTyHddJydSKeWdn/fOu
	 D7Ht9bq11pUfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C7C2C4314C;
	Fri, 15 Dec 2023 16:53:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Revert "xhci: Loosen RPM as default policy to cover for
 AMD xHC 1.1"
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170265919057.3838.7087037796872243909.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 16:53:10 +0000
References: <20231205090548.1377667-1-mathias.nyman@linux.intel.com>
In-Reply-To: <20231205090548.1377667-1-mathias.nyman@linux.intel.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, mario.limonciello@amd.com,
 regressions@lists.linux.dev, regressions@leemhuis.info,
 Basavaraj.Natikar@amd.com, pmenzel@molgen.mpg.de, bugs-a21@moonlit-rail.com,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Tue,  5 Dec 2023 11:05:48 +0200 you wrote:
> This reverts commit 4baf1218150985ee3ab0a27220456a1f027ea0ac.
> 
> Enabling runtime pm as default for all AMD xHC 1.1 controllers caused
> regression. An initial attempt to fix those was done in commit a5d6264b638e
> ("xhci: Enable RPM on controllers that support low-power states") but new
> issues are still seen.
> 
> [...]

Here is the summary with links:
  - [v2] Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"
    https://git.kernel.org/bluetooth/bluetooth-next/c/24be0b3c4059

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


