Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3431A63
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUZA3ch/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 574DCC433CD;
	Mon, 27 Nov 2023 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701098426;
	bh=edqQ6vjpsHFl2V8k2+hzWDkTb5RL38DCu6vUOLvs5iE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RUZA3ch/FoLfA4pXTq/YlMXqQKRKtM91HqiNs+0zKM5EZ+twAXeaazCJt9IvCai8O
	 h5Jp8aAOLnHn5rDCAxcx55+RDiU519gYelW8vQ75Js68gjF4g7bYVpLPsA2kl4Lh4/
	 DmWW4uvuaNTELZhdbMMlE9CHNK8iip1Xo3YOL5NUrnauNTBHzjC9tvioQ4W/hdLzf8
	 MXd4Ub7Bb8sjc3VUw/lxizslTYtR5sLZgf/5sOMoaRylnypYzKehDL+GVf3/2l3xJv
	 9IyKFutjOoaZVosW01c4KjNqEFaeNR7P339/GudCysgCYCVvMfHr6XWA2AubQOO7l0
	 kGV6sJkWf4ccw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E2DFC4166E;
	Mon, 27 Nov 2023 15:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth:btintel: Print firmware SHA1
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170109842624.13376.2218684253022426635.git-patchwork-notify@kernel.org>
Date: Mon, 27 Nov 2023 15:20:26 +0000
References: <20231123143550.2436697-1-kiran.k@intel.com>
In-Reply-To: <20231123143550.2436697-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Nov 2023 20:05:50 +0530 you wrote:
> Intel Read Version event contains a TLV(0x32) having firmware sha1 in
> operational image.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 5 +++++
>  drivers/bluetooth/btintel.h | 4 +++-
>  2 files changed, 8 insertions(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth:btintel: Print firmware SHA1
    https://git.kernel.org/bluetooth/bluetooth-next/c/514525d3087c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


