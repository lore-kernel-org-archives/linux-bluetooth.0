Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725054BE43B;
	Fri,  9 Oct 2026 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555619; cv=none; b=W7MNwu9b8pkM1RR7FQF3VXvQw7gWtv+GHU6CtP9dkLnL2D0ucQWRr+G3XDglxp82DQgBEEutXTjDNgDP9kNg4Jr8nbH7L8Y0NnC5GRvf2yg8CuEiy94WadraBa8Qfqsw6V8jLRchxa3KBtf4ikIyMP7WNwUA9SiIQBBM6MSCcYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555619; c=relaxed/simple;
	bh=FK/5QkKrJsl6LQgwJuO9euTHbOe4prmUUKzuulDswwQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fCAiYM0umVevmn0tqHND+AdRyKvLvsFYe75dSg2mwITxKGNK6+CtkCI/c3vt7Er5Au4Q3RS9vdP957Iw/LGHSPRiBoq9DYQjbbtcaYrfYfPL6PTzjNyeYE9+fL6SI4BemPtkmInETjPECGvHdbIk5SU4o8KFsnWPlnCsdY4uMsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzknZs2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzknZs2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060BF1F00899;
	Fri,  9 Oct 2026 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791555612;
	bh=VueJfE8UlGkXA1cki1w3qV3t5fH9UA9JVCjBcoCaaK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JzknZs2SqvczwRk/MukSIZGgw6NIX2D368BBCrH0a6nAM7l3yIkuy5bGCHHejvx5T
	 6Kp3XJnJ+7TnMnL8DAlFtGugRFIVCecVwMr82VPAjbDsyiyVMB6lzoydeZ1u3CrX/l
	 3ykDNRcEYHu39CAEI47/2r6avAp5aXxDk+N1aWWJAy020bCp5G0Q4CUvHxGgN8OLMu
	 kqPxMYrnUQYGwyRuCW9fEyQuxpdDvpUN8SHECFPmUd25u9wr+r9OHh8Ih+AcGdgcoH
	 l+JZ8Gac+ORWJ78m6zymLFH0UAXgr8Sanz3W6iIxSvnf+ixuQfX/sQGvd8MVhooH0T
	 JhPo5Th2owQsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F153339253CC;
	Fri,  9 Oct 2026 14:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtk: fix skb double free on ISO padding
 failure
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179155561051.812174.8873772264427168812.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 14:20:10 +0000
References: <20261009083525.733804-1-edumazet@kernel.org>
In-Reply-To: <20261009083525.733804-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  9 Oct 2026 10:35:25 +0200 you wrote:
> btmtk_isopkt_pad() uses skb_pad(), which frees the skb on failure.
> 
> The error is propagated by alloc_mtk_intr_urb() and
> btusb_send_frame_mtk() up to hci_send_frame(), which frees
> the skb a second time:
> 
> 	err = hdev->send(hdev, skb);
> 	if (err < 0) {
> 		bt_dev_err(hdev, "sending frame failed (%d)", err);
> 		kfree_skb(skb);
> 		return err;
> 	}
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtk: fix skb double free on ISO padding failure
    https://git.kernel.org/bluetooth/bluetooth-next/c/2820ae3262bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


