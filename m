Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816431A9D
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd3WKDD1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D690AC433C7;
	Fri, 17 Nov 2023 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700238023;
	bh=CtMZ7BRcE6hE3UEE/hrvpCiDK3ZoUiAZrbEMAhErYiA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nd3WKDD1zn4fUKDSOaO5/15kMsxQ6zbE1ett8IS3WEu3Bpkey22hC+9hR26eG5nrS
	 /W53aSqiQqMuYmXIqGBAGY/tyDjGbJ11uP9Pp85N0MOMR0z+UDdGXkZocnJw43bdlp
	 Tu6ymPSHYgv9aRkHvK6EwlHOek5hRSr9vQEZMh+37Xqo1TqreaV8hB9tOiuJ+djrj8
	 q+6QWSK61xUocrS9xMePCCt36UZnOdD2KLYZXE9gbuy8KrYeaO0jg6p2IQkmzDMOYu
	 Tq022c5FHoP5H8v9/xT+KPDu8sHcpc+EqzwLcdwGWK+CyBXfNBU45D2swNvByLoYsv
	 OVoXa2OwoXocg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD503E1F663;
	Fri, 17 Nov 2023 16:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] Bluetooth: ISO: Reassociate a socket with an active
 BIS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170023802377.26338.10849324218724553463.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 16:20:23 +0000
References: <20231113153800.3771-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231113153800.3771-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Nov 2023 17:37:59 +0200 you wrote:
> This patch implements a kernel improvement, to be able to reopen a BIS
> socket from userspace and reassociate it with an active BIS connection.
> 
> This is useful for a Broadcast Source with multiple BISes - since a BIS
> cannot be terminated independently from other BISes in the BIG, all BIS
> hcons should be linked and kept alive as long as the BIG is active.
> 
> [...]

Here is the summary with links:
  - [v2,1/1] Bluetooth: ISO: Reassociate a socket with an active BIS
    https://git.kernel.org/bluetooth/bluetooth-next/c/498de6c85fe0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


