Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A154207E03
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2024 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845406; cv=none; b=JvafzHf3Cuu7DD7MORPrcB1W4tDNGsMUdoJ2RSZ3oXdL0KeN6RIx9BSIQ75d7YQ98semIqr4RvYTYS3peqTxEGUMWBZTWYmgmCuZo53rSMCSrzNt2eAGJwVdgcV3VUYj3/cC1Asj810L5kQs06MEYeQzemgddzqqRaqATxWKSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845406; c=relaxed/simple;
	bh=TfEMSLrH/6QzJ9IDjwkh4hp2dThgny0wRO7n2DtpWgc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FigDB7x/LxSiRSqbqEFzzLsiuF3JIwtH4L0UYfxS6G16YCKywwNM5hH0QnCdXf5QwViqhQKLgKgy39bWVTWXpyjyXcfYu+ckceLKLVFJrj7Qxv6Evo49z+xaNaELmxmmkRglIzZoDybZeJ+pgYjH4CoAD5CgrNWz3isYny18a2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCuB5+fv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCuB5+fv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FC7C4CED6;
	Tue, 10 Dec 2024 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733845405;
	bh=TfEMSLrH/6QzJ9IDjwkh4hp2dThgny0wRO7n2DtpWgc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SCuB5+fvM24snWvePOJKFH2iuxIu5Prt3QqrnTcucMqBjFS4NQlx72cPIPPXnU9Cs
	 8XUcXn1pAEmcXEA1pTn/tmmdnozND2Ho7pkicB19bh3rMqxiHB3PRLS6TitbD7Kf/C
	 YYUA4DxgTDjh0HWVAhwi1bXQscvwEoaVXLUcUEjOLoYtnzjSVrg7LGmgViTiN00lBv
	 qrOSF0hLu/g+XmNBhVmJRRc3CZ0t7j4xX8GuHCDC5i2kvrOH6PnXKY8Y1nCssvJFGr
	 cB7ZRxwnT1wkirdRE5yGCo3CPtPkzoTI+dr8EPKy4SVlhL2i9SK7KdBWtD+BN/qoAb
	 D6BSe08pzN82g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABE1380A954;
	Tue, 10 Dec 2024 15:43:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] shared/gatt-db: Fix possible crash on
 gatt_db_clone
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173384542149.849431.7889441624521962879.git-patchwork-notify@kernel.org>
Date: Tue, 10 Dec 2024 15:43:41 +0000
References: <20241209205843.1394081-1-luiz.dentz@gmail.com>
In-Reply-To: <20241209205843.1394081-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Dec 2024 15:58:41 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The following crash can happen if the original gatt_db has incomplete
> service definitions since the attribute might still be discovering:
> 
>  Invalid read of size 4
>     at 0x1E5A39: bt_uuid_len (uuid.h:289)
>     by 0x1E5A39: service_clone (gatt-db.c:284)
>     by 0x1D5EBB: queue_foreach (queue.c:207)
>     by 0x1E61CD: gatt_db_clone (gatt-db.c:329)
>     by 0x1C18F0: btd_device_set_gatt_db (device.c:7110)
>     by 0x1C9F96: foreach_rsi (set.c:295)
>     by 0x1D5EBB: queue_foreach (queue.c:207)
>     by 0x48EA91F: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.8000.3)
>     by 0x1CA2C8: btd_set_add_device (set.c:357)
>     by 0x1BB9AB: btd_device_add_set (device.c:2049)
>     by 0x17FF76: csip_ready (csip.c:243)
>     by 0x1FD5CC: csip_notify_ready (csip.c:546)
>     by 0x1FD5CC: csip_idle (csip.c:630)
>     by 0x1DE20C: idle_notify (gatt-client.c:171)
>   Address 0xc is not stack'd, malloc'd or (recently) free'd
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/3] shared/gatt-db: Fix possible crash on gatt_db_clone
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0d9f5f6a8c14
  - [BlueZ,v1,2/3] main.conf: Add GATT.ExportClaimedServices
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dbd6591bd1d0
  - [BlueZ,v1,3/3] monitor: Allow caching of temporary gatt_db
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


