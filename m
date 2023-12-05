Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6378F5B
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2wEBTK9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 277B2C433CB;
	Tue,  5 Dec 2023 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701747627;
	bh=Vp2G69yGJkUARxbbTbJdldxBO+/rIFt8C8bwbPbqFSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c2wEBTK9mlGDIzpITOK2IjMCj00Hs2fUjqO+xI/f1fjMW3/7x4F4rDlc2cA/LCLKz
	 Zrudk9U5LcyWdf3+vJ+cJW/UtmiPoAlanO006L1PVi2Ud6p/8YEpYPHtiG5E48BXw9
	 I2pSPdcKB8JGcUx/DaCFj97TYUvwSuU7a8unfrTuix4gt8KjcSpou6M7DLMib0DVXq
	 L7Pe0LwDsSbYTrImGWUeQrHF8fIuqF14mG+RDDpCOj+zrgWBrYJWgOcQJL1L0yJ3z5
	 fZX7fXMnJRZKEyeWMKz+l1nQiXis1W6qGP8NPekXkRgtXbTi2SaUfLZgkRd6SaKr76
	 ICj5jTfpPdlAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C0EAC395DC;
	Tue,  5 Dec 2023 03:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/vcp: Fix comparison of values in different
 endianess
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170174762704.12231.17178652372988481459.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 03:40:27 +0000
References: <20231204220711.2974630-1-luiz.dentz@gmail.com>
In-Reply-To: <20231204220711.2974630-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  4 Dec 2023 17:07:11 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Values received over the air are in Little Endian format so they first
> need to be converted to host endianess before comparing with other
> values.
> ---
>  src/shared/vcp.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] shared/vcp: Fix comparison of values in different endianess
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eae77d7e49ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


