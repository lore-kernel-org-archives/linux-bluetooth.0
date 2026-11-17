Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941411;
	b=BomvjK/E+2rjbYrpUXXEbRvyl6Iw8Q/Eju6QHSgAkuSAfcfn+ehoa4t5A1cd7J0U2+4S
	 4kklvWTI2tHtJzfNmGYL94uASU94Tyc1J74LOo3GjG8A4IGbBk0K4kf+/rmT95jSQWpSz
	 x871qK7i6QzJHyxD5IAoj/AcluzMZbrWQd5ZVBDX5jesey0EF4QCr1wMcAMO40ybuRh0k
	 iqab3ik3vliYPkRmnOAxKhv1BQ3PlfOwEoGf9EtcUzEgvOE1eLxGprQTLHwPzag9v98PZ
	 fkQxFcDuLORJtjNZiVVHlyVwPyf4GbyRWvBDSXPX/YVuRI85cfNXP4Bqc5ihosqK1CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Xk0Pm4Tj2KBztL9HGxcmrP906utGSWcnvTRhKs+doiI=;
	b=gH4OTRjnaDe19sTWhDzURybUIbD+uOIxN0OCOgkBRXEEH57MQKIFvINrjAtowO3hAd+G
	 caw7ZeX4M+6C8s4QXSa+Fx4LNItsGr5DJb/ePTUl9xvEO5Jq5SmC3pen8gt/c4fPP0JEv
	 UYhfAQnBdIgMiG4RQJQ+U6qrHESXj1V/MOzdhMQjVhg0tZrn6zfrTJDwP50yYeuU064Nr
	 WgErc9VAX9SyxsQxdYehIV/e9SJTVXFBaXPdxL6GCms3FCwD/akzH5caPDixzLtKgZVIk
	 8i9haGTbjXZTXGUVCerG+1m2vXTDEeuX8mEdCXKv6pApe0JTCwMpfZJFVWm4fkalVnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhY1PUqD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2381606A32C;
	Tue, 17 Nov 2026 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PhY1PUqD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9281F000C4;
	Tue, 17 Nov 2026 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941410;
	bh=Xk0Pm4Tj2KBztL9HGxcmrP906utGSWcnvTRhKs+doiI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PhY1PUqDRitgaooPpYpmdTdIWjFkDhURD1D/PdiRpT2vaIlt+FtFiRgWhKD095wds
	 9RwUQdUOEdgXclv1mRfCx3neJqZZfMnF0GTVZSZoQn7ssRCEGr5EXO5aYqmogLNgPk
	 l1PGwRaH1dksTPqgE2KeBfxs57HVPZCpHwo8W25LEIuAWKrQ8rRIpsZY94a1ZTH7Wx
	 +z7frJwo27D5CeqQL0ErDB/M+78++gLNt+wRpNqS3OQoBauxFH1fCs2qF9LL75Aqc4
	 iGHsJMNo63+yXV/D6rtTv+orlfI3+Qb5nTB7CiakaxNEP2Enwkwhimudi3zLcTY4gn
	 W/yXKwPJ52P3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B452F392B1C5;
	Tue, 17 Nov 2026 18:50:10 +0000 (UTC)
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
Subject: Re: [PATCH v2 0/3] Bluetooth: Fix work queued while
 hci_dev_close_sync()
 drains
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179494140953.761488.11446208316377511134.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 18:50:09 +0000
References: <20261117023344.278269-1-deaner92@yahoo.com>
In-Reply-To: <20261117023344.278269-1-deaner92@yahoo.com>
To: Jeremy Dean Clifton <deaner92@yahoo.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 william.xuanziyang@huawei.com, johan.hedberg@intel.com, hdanton@sina.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 17 Nov 2026 02:33:41 +0000 you wrote:
> syzbot reports "workqueue: cannot queue hci_conn_timeout on wq hci0"
> from hci_conn_drop() while hci_dev_close_sync() runs drain_workqueue().
> 
> v1 made hci_conn_drop() skip queueing disc_work while
> HCI_CMD_DRAIN_WORKQUEUE is set. Sashiko pointed out that this misses
> two cases: a connection delayed work whose timer was armed before close
> can still fire during the drain, and a connection created after
> hci_conn_hash_flush() is never deleted.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: hci_conn: Free the unset handle when adding a connection fails
    https://git.kernel.org/bluetooth/bluetooth-next/c/1f150a0bb8a1
  - [v2,2/3] Bluetooth: hci_conn: Refuse new connections once HCI_UP is cleared
    https://git.kernel.org/bluetooth/bluetooth-next/c/56abe5c17b4d
  - [v2,3/3] Bluetooth: hci_sync: Disable connection works before draining
    https://git.kernel.org/bluetooth/bluetooth-next/c/1ea7a0946b9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


