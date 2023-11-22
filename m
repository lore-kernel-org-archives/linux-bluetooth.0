Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5F157888
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz/y8y/C"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65B5FC433C9;
	Wed, 22 Nov 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700674824;
	bh=AWnDKRyA9F4MfhDKo7u6s4tD8YEdg/fXda4p6LfVsL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sz/y8y/CJhYKG4e8YDmOTuObdgjmTb6lz69QP/HbLT8GkBANMnsPXFelWnSJ5XXXv
	 9yImGem9QemCMNdz20Mcuq68RkTt8YY/o7sjPw1nUKb/V89zaQwnXNonWR4Fun0ok1
	 yfUkCwLgxbNFH8ZIzx473WMrWHl6vu+I8mkI08VGMMEYuj35kRI/Wp7/16VblXJP/7
	 imvBCUiaGojKKXYyhmaS7bkGNNBIudEp4iuUB7sktMOT0dlVj3QcK5IuZk6sN9rxHF
	 HJGQZwjML5Gbc3zrBEeltjAn/5enu00dkchMQJ3MxpcFVrXQKVimpnt4IdfCOiPigp
	 PvSyZE++b/+fQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D8E1E1C281;
	Wed, 22 Nov 2023 17:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY
 has been sent
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170067482431.16276.12054643321787075512.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 17:40:24 +0000
References: <20231120151039.323068-1-luiz.dentz@gmail.com>
In-Reply-To: <20231120151039.323068-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Nov 2023 10:10:39 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Before setting HCI_INQUIRY bit check if HCI_OP_INQUIRY was really sent
> otherwise the controller maybe be generating invalid events or, more
> likely, it is a result of fuzzing tools attempting to test the right
> behavior of the stack when unexpected events are generated.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent
    https://git.kernel.org/bluetooth/bluetooth-next/c/24ce9ab6c3a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


