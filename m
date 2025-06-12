Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8924524468A
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735601; cv=none; b=Olc1pCv4q6aOIVbvQFUEBPUyOgR+u/7CtIuQfPDLwG84yqC/KdJzWrCDfQXGvI7EjZavGuX79t6DDE6g143C24GOwxHhFcqh8eTrHR/avW6D6LU9Uf/JQ7T23Dw4djKrtJF48vamuDYkXfzlNdMTjaIx6oWCDhkGWt38WaBVYvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735601; c=relaxed/simple;
	bh=qfOw1DMZT1jOfyskikzQAHg4L0hSQEdCPm7kioPtdrw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=icuOutJ/V9GHPBoffmWKh6C9V1H7qKL0Yzdiuh2nVrlxAPRvqnNhAmwPgeBWROHcTcL2iAp3GQa76+3RBNB0c+5GfrOxycFetdaEG9hlOYML0uP+CiYAtJbx1HNjqoYFhJKYeF+SsuBVrXXqmhfaDVYoThRB6fr1fpJSopbvUp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dupxv14O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dupxv14O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1270CC4CEEE;
	Thu, 12 Jun 2025 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749735600;
	bh=qfOw1DMZT1jOfyskikzQAHg4L0hSQEdCPm7kioPtdrw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dupxv14OKOv8ql96FbBAsInarrHBEbhptOWK+Xl7N7ax/DPd4NmpfeSCKYQGYhdL8
	 XHVHlA+jjubn+Ts+p2WpTRxbcROWT2Tj23i3opulbugAZdDKK15Yc5aku0bewQHNHO
	 KiAVzNk3Hn66mrMO2OejWCt/0tHzqbIn2eAzwo270nHCKOeBKjuJny4kMKvS9w8m6m
	 uU40aw0q5EVGJuL3ToPyYFZRxd6xgCW1RKcWgGdf6B6wUel+KIPxLi5gWoiSDqvRfW
	 wkXb9DRTZn6/r89qxxtQtWgZttAVnxnAwFmMDtylWPkkFx18NpDzruO8OaKU1QfcQK
	 sxaU71swPBcDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C6A39EFFCF;
	Thu, 12 Jun 2025 13:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix L2CAP MTU negotiation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174973562999.4138205.17376867892051147484.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 13:40:29 +0000
References: <20250612075034.190194-1-frederic.danis@collabora.com>
In-Reply-To: <20250612075034.190194-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Jun 2025 09:50:34 +0200 you wrote:
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
  - Bluetooth: L2CAP: Fix L2CAP MTU negotiation
    https://git.kernel.org/bluetooth/bluetooth-next/c/d5c2d5e0f1d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


