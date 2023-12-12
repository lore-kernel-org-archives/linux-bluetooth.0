Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DD77765B
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjaaCOW1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5A0CC433C9;
	Tue, 12 Dec 2023 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702398025;
	bh=Gv+mO4PMFcKCSTAW/D0ZVcdMq7d8CoX5pEYybTDqgPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YjaaCOW1fCwRdEEdOl0SVCkPGKPdXzosMlrVNXS6mJLoyFN7V8yCuOK439aihW5q6
	 Kd6VYSryGu9NKDwCQnMfqYwoQf4p/7bNzD3Hz6hXU2gl11HjGQv2cK4d8G4OxZHRod
	 gXnsuz4AqrB2OZifQjmhpubDMJTMXq13qwSdvTg7/VYIn36+oyCfTxs901uWn8HspY
	 ZE418llpCZrBmPmoW+bshBpKQO2w9vyom5wryOMov93dVogs5eQEUkHDz5JWP7EzG/
	 NYxMBTUKsZ6MAf5nEtNXIJ/UwfSLuho6vg71bqbYQNPoEbW7tuFUyU3cbDTRIo0wK/
	 dug9xTU6yfq5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D7EBC4314C;
	Tue, 12 Dec 2023 16:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Bluetooth: fix recv_buf() return value
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170239802557.22444.1717551799062581956.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 16:20:25 +0000
References: <20231211164020.173253-1-francesco@dolcini.it>
In-Reply-To: <20231211164020.173253-1-francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: sean.wang@mediatek.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, amitkumar.karwar@nxp.com,
 neeraj.sanjaykale@nxp.com, francesco.dolcini@toradex.com,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jirislaby@kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Dec 2023 17:40:17 +0100 you wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Serdev recv_buf() callback is supposed to return the amount of bytes consumed, therefore an int in between 0 and count.
> 
> Do not return negative number in case of issue, just print an error and return count. This fixes a WARN in ttyport_receive_buf().
> 
> In addition to that a small cleanup patch is added on btnxpuart to remove a useless assignment.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: btnxpuart: fix recv_buf() return value
    https://git.kernel.org/bluetooth/bluetooth-next/c/7954bbcdd7ea
  - [v2,2/3] Bluetooth: btmtkuart: fix recv_buf() return value
    https://git.kernel.org/bluetooth/bluetooth-next/c/687d2de93b11
  - [v2,3/3] Bluetooth: btnxpuart: remove useless assignment
    https://git.kernel.org/bluetooth/bluetooth-next/c/99f188d71731

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


