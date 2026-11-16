Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858608;
	b=RYIR5PywGXPnrCmkOmBxsRN2XZh0RcST9t6wQtWoDSK3GodVX1XjY05Yk4tXjJJjRd6w
	 VUVEK1fD76MAGf0DyxXpq9DbEslbGpIaKK0qSCNEQRdvOlOwzmebgrk1R+je2c9M0fEfJ
	 m8LBzxsDlmS5r/nuoE0HyiVaLcmW3wYUnYSDJzygKBiAliTwlfXWNvBCGdeQUs8oMJdZc
	 ag69jn4Bp3UO6VxLT02UfZFpzYfJg5Bl4A/v7lqI6yMnWguW1lAFRX7vA67S2cRv++8Ik
	 5fI7Mexyp8BwC9U+6mugvXB+WY+WfA8sgZlXbxDXFJa4Hqc/XG4+e91BerisITCvt2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=LhQHYPm2yUEVEYJ7DlgZ+UO1FNVuyxJa9eUmVSSSbio=;
	b=4iZ0OdCSXEadjHlTnOXs6oNmQSBrCC9G46OBkUzUzRlsBbzArDaau63OhWk9w8BX4ox7
	 Kj1UN3aX3kPHwYEbWBieGZxGkGkoJrBkCyY5qd/iqUFXvVhkOR7pQdmnF6EwNysEjsGz2
	 i+kC8T3SdUnd7Pgs7QT5qVzNh31se5hMohxpt/6SiMMn5hEz3zC8VbTLwU2+U6YNxSYdK
	 2LbHyUgXHftE5D5rrxAtd6vbrIuErcfB+AnKntc99jcIqAoqVG7WSBI1o/bR+65xXbifb
	 NxPqMqV8uOZs0YAMkeNhMZR0qmQgTapWElj8ipMp8T9ICpgJZ07KbIImBSI4G4G/7yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yk7jKNiV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F046606A33A
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yk7jKNiV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB591F000C6;
	Mon, 16 Nov 2026 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858607;
	bh=LhQHYPm2yUEVEYJ7DlgZ+UO1FNVuyxJa9eUmVSSSbio=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yk7jKNiVfJXj2gTtWYBDAusSOfG4jc7yMl4L2Ie26bHoNgBRXpaYuqdJAMYmwAfHt
	 gvrcbeLX1ljHDKFmYzZkNq/ORaqhOU4hjwtX6SZRv0JQlL31DOBqH+tlnF6BbasZmI
	 sGH/mR9ELC0lY1mauOMKeVAH74Fr75axf8cO5qMRHrlaDSFTZ3ICq8Qr+1FtYLWMOu
	 8+90vMKq49lfNUQPkZ/m78A7ZdOc5tiWcoUNkrpFXWXGmbIJsAxQuI+O2sKE/+MIhz
	 Dugl0LZxrWJ7x7U8v3m967Vi5ZGts6fQ5NVEj1dnHiwZTqHWHZY4BwMty+TmDYl7VK
	 y+wrXLs+cf0xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44CE391AFCC;
	Mon, 16 Nov 2026 19:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: 6lowpan: Always consume the skb in
 chan_recv_cb
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485860627.3856541.8397441841963712517.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 19:50:06 +0000
References: <20261113161952.926201-1-luiz.dentz@gmail.com>
In-Reply-To: <20261113161952.926201-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Nov 2026 11:19:52 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The l2cap_chan_ops recv callback takes ownership of the skb on success and
> leaves it to the caller on failure.  chan_recv_cb() violates this: when
> recv_pkt() fails it returns -EAGAIN even though skb_share_check() may
> already have dropped the caller's reference to a shared skb and replaced
> it with a clone.  The L2CAP caller then calls kfree_skb() on the original
> skb, over-releasing it, while the clone is leaked.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: 6lowpan: Always consume the skb in chan_recv_cb
    https://git.kernel.org/bluetooth/bluetooth-next/c/0d8f6981f55e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


