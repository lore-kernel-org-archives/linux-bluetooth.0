Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B42F2DB79E
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286836; cv=none; b=ZNjsfxb0PokqiCNCmGtz4Y4QBnkrec710YqJJzZn6eM7z/ZLKC+KKf0bOLpBE6XxAVrsd5qmMYzdHiT1HZ+vNuL07Dx/B2Sm7s272234XuggrKVtC9+OWBkypPp/RZgZQ09B2lZj9UArQcte/465xMaD1YDVYb6+BYt8rQu5/G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286836; c=relaxed/simple;
	bh=jTiFkfO5kMe38D6/xOqPyFy1oykywfNfbcIc0TQwcuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WTubtW0yTnskxyabyBjccKk8AOdO0jzchYMaJmbTwIJb3ai8zJZCkj/fceDFDbegMUFL/TBQtT19j8A6liWbe2N/K5nSVkYWvumnJ1i9HOOi9xVhDa1/H52/NvatGM1E80BEm1lo07h72QeuyMgUSOGnYJ8Yngo598GJJzbhIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxSIOz2k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxSIOz2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA824C19424;
	Wed, 15 Apr 2026 21:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776286835;
	bh=jTiFkfO5kMe38D6/xOqPyFy1oykywfNfbcIc0TQwcuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sxSIOz2kt5xNqwsy4ojwiGuNdR2RFyWvUSBzXCiB1KV+2Z/XKQR/2VpQROSC2osKL
	 Tg9qQJP1K5m851HeXRrwZYIbzyIZKtPC8TQZhRTQqHE+uQwArG5dEIcsnL560iZO4k
	 JoZkFccoYPxcGY//XB1mOyBB6Bw/y//Vu3R+YzdKcMLDgIiKJgMw/TTV/9BlmWuL4b
	 FXV0ubFsxjQIR7TJ6Tde4uuKjz+mXD7Yx+831ynLtkrauwjt0ZI8XqP/WHzyU/dNMT
	 HvXOuyQLvVEQ7BJgbzfNhyax8c35VRTEXgxIdZQbgva9wwZ2Js7rAFF4kAJyS6W3nc
	 J11FMy+p4oluQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD43380A963;
	Wed, 15 Apr 2026 21:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: bnep: fix incorrect length parsing in
 bnep_rx_frame() extension handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177628680480.2439002.16377687042419433423.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 21:00:04 +0000
References: <20260415093953.39340-1-phx0fer@gmail.com>
In-Reply-To: <20260415093953.39340-1-phx0fer@gmail.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Apr 2026 17:39:53 +0800 you wrote:
> In bnep_rx_frame(), the BNEP_FILTER_NET_TYPE_SET and
> BNEP_FILTER_MULTI_ADDR_SET extension header parsing has two bugs:
> 
> 1) The 2-byte length field is read with *(u16 *)(skb->data + 1), which
>    performs a native-endian read. The BNEP protocol specifies this field
>    in big-endian (network byte order), and the same file correctly uses
>    get_unaligned_be16() for the identical fields in
>    bnep_ctrl_set_netfilter() and bnep_ctrl_set_mcfilter().
> 
> [...]

Here is the summary with links:
  - Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/5843e5ef062a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


