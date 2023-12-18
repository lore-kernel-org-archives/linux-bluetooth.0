Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877CF3034F
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Dec 2023 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaEdrzKD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 286FEC433C9;
	Mon, 18 Dec 2023 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702932624;
	bh=PoVto5solUVNBRRyeuofwCjseJByt2hKuHyCU5iLFXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aaEdrzKD6lU5cwvl0oD3IR66vjuQGkzu8xmnRmZSkLcm5ZWahLniqFn0a8EZHEVHf
	 0DGXnOgCVhIudWfIA60CZCDUonLLNIUCT91B0WHWhFYx28qmnrbg+K3GFg6fqW5wLp
	 Tjotb0xW423t70ckXATlgHdmNwY92DiR453R9HTquqy1NeR7gN7MKrCW542s0x3q6d
	 fhzJGSI2CGUNxdwLgbOYs/GNQ5y+eSZ6kaci1P3bgFdzfZF1ahnsSJHfGENzD8qedI
	 rFQVVL4JaPAi7/pPoaXc4kJeHED5UtRDU45Q/2X1t6ifoLXSyZWk6VERLsEJKGd2Dv
	 0OBOau875f+wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1048CD8C984;
	Mon, 18 Dec 2023 20:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 0/2] Implementation of AICS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170293262406.10818.9217822891982559355.git-patchwork-notify@kernel.org>
Date: Mon, 18 Dec 2023 20:50:24 +0000
References: <20231129134058.70612-1-mahesh.talewad@nxp.com>
In-Reply-To: <20231129134058.70612-1-mahesh.talewad@nxp.com>
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 devyani.godbole@nxp.com, nitin.jadhav@nxp.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Nov 2023 15:40:56 +0200 you wrote:
> Hello Maintainers,
> 
> 	This Patch contains code for implementation of Service - AICS.
> 		- This code covers all mandatory features of AICS.
> 		- Verification: All mandatory PTS testcases of AICS are passed.
> 		- Specification referred for implementation:
> 			AICS_v1.0.pdf
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] - Added AICS Characteristics UUID(s).
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c89ebba80f27
  - [BlueZ,v1,2/2] - Code Implementation related Service- AICS. - Specification referred for implementation: AICS_v1.0.pdf - Verification: Tested all Mandatory PTS testcases and all mandatory testcases passed.
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


