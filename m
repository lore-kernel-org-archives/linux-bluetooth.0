Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDCD1BD00C
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Oct 2024 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728603029; cv=none; b=iH4FsD2lspTsIbpp4jY92eR3Ei7ll86MW7ymb0bwL5bUBeDuT/sCRqBJxYJEQzOBdr3JAsAfQQzB8QRpI1rKPXknFJpWKbsuOOboI93pH0xumxdZpcvgWaeqD3QpbsWh1DNcsGu9XxYFrSPSjr5rk8RjnLh0Z4ieviQ1+lryc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728603029; c=relaxed/simple;
	bh=Wtfw47ETnr583V/qzfKvM+kpTWvr/NMIgol1jI3I4yc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AUeLCdlReUKOpJl0LgkikrvmXLDLHZGcvBBvAoE4JtK6WNcLjENGw+5+MEAnGY5Fp7MkixZOfkiA3nen6FlPSt3iI2GRF98ZEreIXkxeaaWZrhFvZbSekbzHCtBcekUfA9x72/HdazPhZ8n7/RewUUTVAxM5sZGu0sBk7RY9Yis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXy68O7r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXy68O7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820E1C4CECC;
	Thu, 10 Oct 2024 23:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728603028;
	bh=Wtfw47ETnr583V/qzfKvM+kpTWvr/NMIgol1jI3I4yc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FXy68O7rGGItTRxUHqp/1spdOWTOCapDMAD+2ygeRYtt5/YtV5q8C/Wrvny5/uxGN
	 qWOU9yKZt8bYt/RUomGY6wku+5lLtRunLN6NyMM5v5zEF1W4Trpp24ZAtSKJ+Dde+u
	 4YHNCT7neZwyDTnwv70JKV5e7QGleFZVl6/RfW57iCU9U9LitN6AgVISwVIVOnMxR8
	 KOW7naJkz/W8+9swdaFMb2s6kAlkKrUKHShQ31klWJLVkG01XRYiqmUEXplD8dYNCh
	 1GzCwaDyUFdmCV4sXS7AXIPPjN2Sdfk/WRAMV5+0bfAX11uKG4r2BGYwG5s7Fcc4yt
	 0yIMe5jf8a8Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7F3803263;
	Thu, 10 Oct 2024 23:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_core: Fix not checking skb length on
 hci_acldata_packet
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172860303285.2203704.3221223334251807499.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 23:30:32 +0000
References: <20241009174159.15658-1-luiz.dentz@gmail.com>
In-Reply-To: <20241009174159.15658-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Oct 2024 13:41:58 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes not checking if skb really contains an ACL header otherwise
> the code may attempt to access some uninitilized/invalid memory past the
> valid skb->data.
> 
> Reported-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
> Tested-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: hci_core: Fix not checking skb length on hci_acldata_packet
    https://git.kernel.org/bluetooth/bluetooth-next/c/32fed76a03eb
  - [v2,2/2] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
    https://git.kernel.org/bluetooth/bluetooth-next/c/7285f89d6a95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


