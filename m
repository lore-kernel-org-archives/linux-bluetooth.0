Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE722DFB8
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215600; cv=none; b=YiVlOn387+wSO+apN4igWHF8YSgRukAqn8X//BouLiY0lu83mP0HNKXrnRjVKMme7A9n9/hX9sQcbdtWmCKRaEalOrCLhhann7+ga39FD/2D/9SvlKEmj+8XFVEnvmpzYuEXDR8vwNwg49+meWmYq2PGHBiXn4KhZzC6KTkx/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215600; c=relaxed/simple;
	bh=yMiQ8jEAvuDrqNiVw1mc/PNJWKVlQVxvpZSxeN6b68Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MoAUuf/fqJ12cZcor7qofsBX+V39wMuVEHc3732JKv61mmqNX/l035WvRukOTp317sJ9N07kWYkRadXalSHqOVJEqqbVjHM6UF8ojHPwePpcyqCVsDVdqOdxZYFQTXJ38f/gNTszqZDg/J9DgFe9JuBaRCb78g/wmlmkI7ppgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7uqolr/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7uqolr/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D00C4CEF1;
	Tue, 26 Aug 2025 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756215599;
	bh=yMiQ8jEAvuDrqNiVw1mc/PNJWKVlQVxvpZSxeN6b68Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F7uqolr/j8MRZvFI3zSBPiBXqv3UWv1x8rdhORT5ogCF0iRXHQv9aQ98SgKl+W9vN
	 /hJWIvpn5rPJ8C+/Yq2YGRQxWzB8aaxKgqXrLLH4cd3sRt6iY4GJ5BdG4wu+BWdw2H
	 YU7cR5i0Y9dWBw1gDRFBbh5fbFT1wewxD3DTuvAMnAv81ulAoY3st4dCWkC20uqoWr
	 f7SlJFvvE7X33CY/t9+JBcuISM0I+aX3MGmsxbxBcsbnraCl+QpH0VFaWMVLZaKOuO
	 3gXMIpuh48an9rcWsTwlh1LRXrwiYMdrJ8OXAwgOUVmqSGsOifRzYXh2ADGdP5jDEq
	 U8tpbH5IVF7gQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE334383BF70;
	Tue, 26 Aug 2025 13:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] obexd: client: Fix connect RX MTU
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175621560749.4176029.5164399582054106505.git-patchwork-notify@kernel.org>
Date: Tue, 26 Aug 2025 13:40:07 +0000
References: <20250826090543.122484-1-frederic.danis@collabora.com>
In-Reply-To: <20250826090543.122484-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 Aug 2025 11:05:43 +0200 you wrote:
> OBEX download from iPhone is currently slow due to small packet size
> used to transfer data which doesn't follow the MTU negotiated during
> L2CAP connection, i.e. 672 bytes instead of 32767:
> 
>   < ACL Data TX: Handle 11 flags 0x00 dlen 12
>       L2CAP: Connection Request (0x02) ident 18 len 4
>         PSM: 4103 (0x1007)
>         Source CID: 72
>   > ACL Data RX: Handle 11 flags 0x02 dlen 16
>       L2CAP: Connection Response (0x03) ident 18 len 8
>         Destination CID: 14608
>         Source CID: 72
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
>   < ACL Data TX: Handle 11 flags 0x00 dlen 27
>       L2CAP: Configure Request (0x04) ident 20 len 19
>         Destination CID: 14608
>         Flags: 0x0000
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 32767
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced Retransmission (0x03)
>           TX window size: 63
>           Max transmit: 3
>           Retransmission timeout: 2000
>           Monitor timeout: 12000
>           Maximum PDU size: 1009
>   > ACL Data RX: Handle 11 flags 0x02 dlen 26
>       L2CAP: Configure Request (0x04) ident 72 len 18
>         Destination CID: 72
>         Flags: 0x0000
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced Retransmission (0x03)
>           TX window size: 32
>           Max transmit: 255
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 65527
>         Option: Frame Check Sequence (0x05) [mandatory]
>           FCS: 16-bit FCS (0x01)
>   < ACL Data TX: Handle 11 flags 0x00 dlen 29
>       L2CAP: Configure Response (0x05) ident 72 len 21
>         Source CID: 14608
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 672
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced Retransmission (0x03)
>           TX window size: 32
>           Max transmit: 255
>           Retransmission timeout: 2000
>           Monitor timeout: 12000
>           Maximum PDU size: 1009
>   > ACL Data RX: Handle 11 flags 0x02 dlen 32
>       L2CAP: Configure Response (0x05) ident 20 len 24
>         Source CID: 72
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 32767
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced Retransmission (0x03)
>           TX window size: 63
>           Max transmit: 3
>           Retransmission timeout: 2000
>           Monitor timeout: 12000
>           Maximum PDU size: 1009
>         Option: Frame Check Sequence (0x05) [mandatory]
>           FCS: 16-bit FCS (0x01)
>   ...
>   < ACL Data TX: Handle 11 flags 0x00 dlen 34
>       Channel: 14608 len 30 ctrl 0x0000 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
>       I-frame: Unsegmented TxSeq 0 ReqSeq 0
>         00 00 80 00 1a 10 00 02 a0 46 00 13 71 63 dd 54  .........F..qc.T
>         4a 7e 11 e2 b4 7c 00 50 c2 49 00 48 b4 55        J~...|.P.I.H.U
>   ...
>   > ACL Data RX: Handle 11 flags 0x02 dlen 680
>       Channel: 72 len 676 ctrl 0x0202 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
>       I-frame: Unsegmented TxSeq 1 ReqSeq 2
>   < ACL Data TX: Handle 11 flags 0x00 dlen 13
>       Channel: 14608 len 9 ctrl 0x0204 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
>       I-frame: Unsegmented TxSeq 2 ReqSeq 2
>   > ACL Data RX: Handle 11 flags 0x02 dlen 680
>       Channel: 72 len 676 ctrl 0x0304 [PSM 4103 mode Enhanced Retransmission (0x03)] {chan 8}
>       I-frame: Unsegmented TxSeq 2 ReqSeq 3
> 
> [...]

Here is the summary with links:
  - [BlueZ] obexd: client: Fix connect RX MTU
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=99abc8a9e1e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


