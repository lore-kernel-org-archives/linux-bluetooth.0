Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C88F7261A;
	Mon, 20 Jul 2026 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578839; cv=none; b=MeEBnqFNeOYZF3D+gyKmOlAtHFV8LnSa7dETvDhxTedsCSUwSvzKBKQkrTU2INPxREuxdYaL4brl3e9KX6pdLFTCzMST40IkQto7WOlm2gMY7ECwWOI1tVsVk66oe1/5K9OvwaOhr8LGWShNDaVePJPfjI8jJalHDA/t8CXCym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578839; c=relaxed/simple;
	bh=fOzNGeqRDheD72jzn7JPsPOQ+dihaNRea3VVr6RxHLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RiIFLTo1vV5y9aCd14BzdhZhbKQtvDdQjDXNeVaWwCbLdowukciYg1F1D4mc9Dm9Yw1ycIN/Ewq8nRQYLnKfD9A2QCXS0lIj8Cvs+Nfd2hfbryYJt8HYJTM20RUzhpk8ZryK2qvknIq/MBotBYRZRpSezKuXIRev7hCBECOGAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RswLZWsU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RswLZWsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0811F00A3A;
	Mon, 20 Jul 2026 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784578838;
	bh=+4JZvFNyyUufCKTRoOStZ3NF5h3sX8UaZ+roUxBdSg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RswLZWsUPQXx48EBiyJJ3vzKsGkm+GzmEdaESdc2WH6lBMPaprbVaOrn1T9nH5pLX
	 coom8X3x6jFYlUc3sRJRJ6iU2O9o5iM3ztzC0OxKqjRKZ5brMkH0Q5wRvYI4m7SQuE
	 PQDLXMwsiAF3UTJEWJF9mAyecj8Oi/AzNzSfhgw6Cs1f7JGuzsp5xR/k1vW4/yZk7n
	 QvABgs8Kz1yIq81wO/wivOjmDMWntMW5MDYTkosbfGIALVY1W7bYM4I29Z4Zeki9nI
	 yU0xy+VL0WYRqM37+1fsonHshH49/rJkKJT9+Bk2ofuBiJHcU8IgpCBhCOT/Co/qQ4
	 hP88gCdIEYwJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569F639244CA;
	Mon, 20 Jul 2026 20:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] Bluetooth: harden packet and transport parsing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178457880789.4151939.16161717072950541746.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jul 2026 20:20:07 +0000
References: <cover.1784191283.git.liqiang01@kylinos.cn>
In-Reply-To: <cover.1784191283.git.liqiang01@kylinos.cn>
To: Li Qiang <liqiang01@kylinos.cn>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Jul 2026 16:47:27 +0800 you wrote:
> This series hardens Bluetooth packet receive paths and the HCI UART
> transmit path against malformed lengths and invalid callback return
> values.
> 
> The affected code accesses protocol fields before confirming that the
> complete headers are present, or trusts a received length while
> appending to an skb. The HCI UART write worker also assumes that a tty
> driver always returns a valid written-byte count. These assumptions can
> lead to out-of-bounds accesses or invalid skb manipulation when data is
> truncated or a lower-level driver reports an invalid result.
> 
> [...]

Here is the summary with links:
  - [1/5] Bluetooth: bfusb: validate received block boundaries
    https://git.kernel.org/bluetooth/bluetooth-next/c/b94bab6f1dd9
  - [2/5] Bluetooth: btmrvl: validate event packet lengths
    https://git.kernel.org/bluetooth/bluetooth-next/c/75e574f6a212
  - [3/5] Bluetooth: hci_bcsp: validate received packet lengths
    https://git.kernel.org/bluetooth/bluetooth-next/c/a4c72c8c7cef
  - [4/5] Bluetooth: hci_ldisc: reject invalid tty write lengths
    https://git.kernel.org/bluetooth/bluetooth-next/c/5afe69c190c4
  - [5/5] Bluetooth: hci_qca: validate controller memdump frames
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


