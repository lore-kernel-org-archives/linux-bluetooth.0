Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941417;
	b=mdn7nxDdi5Ko3Lv1ELv2fq/YuZS6W645jrUP6XyayycjBw61iEp1da+6p95uk6njGcx/
	 +is3/gifrAwmYF6c1OGSmGnJADVdnNJ5rdxF15twrLgwEzrPEZCscFSeDlW0znyrWgAdN
	 pQrgRizEqc0YPCrer3rEObDgEAEKeLIzGOhGiBZaWfU46S7ksH0qs9+HTyl0kaXnVjq0d
	 7F0Xd1oLdwR8Pi0qlkeawLFXiwp93QMUv7IoSW8EfymwIHAr+tRZXV467Io/3bMvw9fvS
	 wKFCep6WuoJv8sijcseZ7vg1/a1ikJ5F6yHfubJRcf8OXy9fg7QwGOlidbr0x4Waq9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941417;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=OkWyP084xXHurVdXkk1MJ8rSrvnivQSXD/jJYphm4sE=;
	b=3glT/qFNgLKD3YLEgfu5Isa2F5yFSg0S7NCmFd6+qleJgyS7bMBvsTS52el4w8GM0OnV
	 93bkQEM/gVjYHjsbk7MefaHrjFZ2oS25cdr2uRQoRznqsuTuo0o3trzgoXmMynXGl+zzs
	 U303KRLoS/gIk7GRToxKardIvd44dLm/RWLE7ab5XWHOGt1+oirBvfPpo6HMWdEBLfP9q
	 jiwDvbUw7DtHXWwKUyhPUo3Q4edvUTvzt2brCXdJ6+XiNryCbzJnShNj0H+jjHUE/Rhzg
	 GucmJzNIS1lMjcjsddRsir0+/aWWsQDfdTw7lEnIkGbcXIRr0x8VDzw2I8HlFHrblZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVgwao2E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192BE606A8BF;
	Tue, 17 Nov 2026 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVgwao2E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA051F000CC;
	Tue, 17 Nov 2026 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941416;
	bh=OkWyP084xXHurVdXkk1MJ8rSrvnivQSXD/jJYphm4sE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZVgwao2Eygfn0iMsUBXrGmzO9+AmM0I14sbBuIWPmiOlkIm/2rtQZT4EaDjM6IdbR
	 F2pIyKVDkzOGNxmMDCyG2kzuCLXhX6eUffXsumHILlvJ8dOwlhiXbi5Lzk+hpRwgiz
	 n5HEeIT3oONz0+4c5h9Q/4/avtybt3RTNHNF/M+XGdLH0R8juuIK4WG69HraEpnUtI
	 y7FAemyaMo5WPqnHLc7SwaIMdelMKlotmuqi1orKgLkBMEHj3OPuil+ZJhSAsxsWwl
	 TfUAcK02LHcVeV/g9z49/qy31pwZgqQaz4yUnTLKxI7hlsCUBjx3lLJdAxZZQA+7eJ
	 wHtQmkpDIJt2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4417392B1C5;
	Tue, 17 Nov 2026 18:50:16 +0000 (UTC)
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
Subject: Re: [PATCH v2] Bluetooth: hci_mrvl: Leave the serdev port lifetime to
 hci_serdev
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179494141527.761488.11110930230675526211.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 18:50:15 +0000
References: 
 <179484691454.54083.14464729860702732145.marvell-serdev-v2@michaelmcallister.org>
In-Reply-To: 
 <179484691454.54083.14464729860702732145.marvell-serdev-v2@michaelmcallister.org>
To: Michael McAllister <me@michaelmcallister.org>
Cc: markus.probst@posteo.de, luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Nov 2026 16:35:14 +0000 you wrote:
> hci_uart_register_device_priv() opens the port before calling mrvl_open(),
> so Marvell opens it twice. Likewise, mrvl_close() closes it before the
> transport closes it again during unregister or registration error cleanup.
> 
> Remove the extra calls and let hci_serdev own the port lifetime. This also
> avoids failing probe when serdev rejects a second open with -EALREADY.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_mrvl: Leave the serdev port lifetime to hci_serdev
    https://git.kernel.org/bluetooth/bluetooth-next/c/c9eb955c4fe2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


