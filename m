Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23851208DB
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aep69IAb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD9DDC433C7;
	Fri,  8 Dec 2023 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702048224;
	bh=tNFd8GV9hI4poBjL4jYLeuMaIvw3sOX6bGKVNXgpamY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aep69IAbVIVQd3Dmd4jSDw3Ut657CKZ7LK3DExP0PajPSyzLgJsAY7KzWNuAk49cQ
	 ITPtAsMi4chDY11rjQMXbkWF4Ce17WBw5rV13/f/ybH94PRxTHmshPb18V3vkdfLd+
	 vHT9953asWNeTGt4wlsaQMrEOfla3nMU0pwrKIv/350H1WCWEMmqtG3/+h4IQFP0rw
	 ZVHTQH/ItTofdnJlT1sfJCgLVTHqkDCjaS5cTjQBYwg+tUDOgBd4NsngLA5SRsc+pj
	 HW8Ly8RDUP7xW4TeGUWMYD/P88A+pIy2u4YXxR9hVBYySxhxvrSy2xm1eaKrOs8PPF
	 R7cswgUVitzLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 987BBC04E24;
	Fri,  8 Dec 2023 15:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Bluetooth: ISO: Avoid creating child socket if PA sync is
 terminating
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170204822462.3151.17183097040428735461.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 15:10:24 +0000
References: <20231205161140.2855-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231205161140.2855-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  5 Dec 2023 18:11:39 +0200 you wrote:
> When a PA sync socket is closed, the associated hcon is also unlinked
> and cleaned up. If there are no other hcons marked with the
> HCI_CONN_PA_SYNC flag, HCI_OP_LE_PA_TERM_SYNC is sent to controller.
> 
> Between the time of the command and the moment PA sync is terminated
> in controller, residual BIGInfo reports might continue to come.
> This causes a new PA sync hcon to be added, and a new socket to be
> notified to user space.
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: ISO: Avoid creating child socket if PA sync is terminating
    https://git.kernel.org/bluetooth/bluetooth-next/c/1581c2ec0214

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


