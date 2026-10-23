Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789241;
	b=I2UHnCKrUWiP4YOQylp/7UDw/7JgBy0KByhjvqWxZ1+041p8gRMV8EeCFwoDwUJ4IpCD
	 5x/jy73kbqcHC+vVAjWFqyl3F7Imf9A+5ZVs4uwChNaVQIUnrTuCSLY+fftkvg+1ANDbD
	 RcoLSld0KNi53CzCsyuz6Lwn66z3oWZ9l4NtLSB2IEmI/JcbljVzRkBgr++tjRHE8xeXU
	 DDNk4gwe4eqPS6N/O33b3SrsFQ44TEyKnPax1B6qWBbajpOgrCsKdto/nNn9Bv765tos2
	 1nLz5k3BRnkOn8RqUTC+zQLyU3FPCDjMIzhD9sItD/hcR7WZHDjz6s0R2tbxTiaAERw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789241;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Dpo6rOC8b0oZMrJnBpilHYeohIGR7jL97FBiqCtY3kA=;
	b=ODWcVQsxybmwibHrH2qavbvmzFLjG3IMjQSFI4jB25MVQavIC0kAyWUAqDM1KmVJr274
	 hnQtIwpZLn+3KPTGsK0NPdthly8LiiTlJwwEROLEKrf41N0JOKUZuXThm65y12RS1+zuV
	 D023N8/vBe1N58fuEXsaI32/M1geuTvd28V4LE1My3fVZADq0yPxf2spkrVcbaME2cGef
	 WqiIWJ0HblwegOK15Aal7DX0TV4FeXTK81g4eYlh7CC9b8zGDgL8/qF0bquBmh+zr5SLV
	 rVPoSXQasp0rR9Fxub3AARu5t3wOtS3dKMkIRkNP9KCG1x2wiT6JOqHKxGQUwpdXSsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XbfTA7pL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B6606A31A;
	Fri, 23 Oct 2026 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XbfTA7pL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113C31F031E0;
	Fri, 23 Oct 2026 21:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789241;
	bh=Dpo6rOC8b0oZMrJnBpilHYeohIGR7jL97FBiqCtY3kA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XbfTA7pLu8c33dpOytc9kqa2iRxHaAhjmKdguoc10x/jOwMbvboOgxVchPwRY9VLC
	 1zOTT/+qgXUTqMW65rzcAkCZhMs5XBoUhFGChWUs/vk+5eMwgMW52Ftsla2VL0/Gz2
	 +Bek2EttiqSP2QQR0SdtQyd3CGaox4dcjbKj+HxAPUbmwaVr1nfWRu5/Iq5Ax0Q6fc
	 z+Vp2i7ktfjl/GXOmKjVkR1QTFPtYIQM35/wXQMA87WEKAr5TJgS/gaObcCxBK9GB9
	 HHjcbhaHWWNjN7njK41yP1rRiQFhYIZX8hKQlAb0CS17F4gfwgljlBarQuyDTgzgJI
	 xb5Rujz4Rcpqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 07435391B157;
	Fri, 23 Oct 2026 21:00:41 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: hci_core: Fix queuing rx_work while workqueue
 is
 drained
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179278923956.1268720.15284721723706023982.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:00:39 +0000
References: <20261023161609.253097-1-akhilarul324@gmail.com>
In-Reply-To: <20261023161609.253097-1-akhilarul324@gmail.com>
To: Akhil Arul <akhilarul324@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 syzbot+2344fb8002f3ef5b1712@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Oct 2026 21:46:09 +0530 you wrote:
> hci_recv_frame() drops a frame unless HCI_UP or HCI_INIT is set, but the
> check is not synchronized with hci_dev_close_sync().  A driver can pass
> the check, then close clears HCI_UP, flushes rx_work and starts
> drain_workqueue(), and the late queue_work() of rx_work hits the
> draining workqueue:
> 
>   workqueue: cannot queue hci_rx_work on wq hci0
>   WARNING: kernel/workqueue.c:2352 at __queue_work+0x2c0/0x780
>   Call Trace:
>    queue_work_on+0xb2/0xc0
>    hci_recv_frame+0x18f/0x330
>    vhci_write+0x174/0x240
>    vfs_write+0x271/0x680
>    ksys_write+0x7c/0x110
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_core: Fix queuing rx_work while workqueue is drained
    https://git.kernel.org/bluetooth/bluetooth-next/c/63bcf9f4a40d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


