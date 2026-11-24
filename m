Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552812;
	b=jMUAThmTHpogQj1OTwXm1p4hTWuUWnG45f2KKvr5FY/8e82IMnsTdRjW961RhCLcni/H
	 nAaIUKfmyKTaWDchifLUrMWvQmU5dECwBTCbAi3ROPjQCzLnNfU+YYuN2aC65XDdX5nlP
	 S8E8PRCouXppvnHJg0XyXvPBFr8Y+z0jQLzswxu8jd2+RW6ikXASqggyitieipnDbps1P
	 iIPfWGLZjdWqSObQfCObCCkR7Yz5kUCW1vvBv+jcJnZKrPLQWA3hbX5C9J518c1pgXz9c
	 65D1cRZKdZHmA+T2au4ng5ljKio6itIaAex1PmzI2f5RRXD7ew258qZb9cDKROTC42Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+03FJ1dBxvHnqteUE0m1/IG9OvmE2rYnxqTDIYoYj2k=;
	b=4cex9rBQ9hajdM+FOWbnlLX8tJbPZA5GkrsGTCEe80Muwzd3lvatfU0nQVysbHK/NWT9
	 y4PKtfteIviri5brdY9POjbZNVABPfB5K+DQxEGqs6ip+0RpRGKJc5Uj+dn0XezO00rLC
	 VjUH2YA7NQplrHzGgHbqq2WmVBa+AlqIkaV7KSyszPhJYf0LsD+qC0I4bxw7a4aEU1TVP
	 fj7/+m+RinAUQ/OUhSyFmJNAeHLBFMMby8zTfgWBwBI0aGB88fpU/zsmh8dUVpjT40zbm
	 ikMeprXuCQ7D3zDuG/MK96ot75HLKrJiho20wamFPomdAXw9ucR7wNpM8fyWbypDxhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YCm7gKt2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE9606A32E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YCm7gKt2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE7A1F000F4;
	Tue, 24 Nov 2026 20:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795552812;
	bh=+03FJ1dBxvHnqteUE0m1/IG9OvmE2rYnxqTDIYoYj2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YCm7gKt2lEAkqLIrR8gr3L4trs+Eso9h/kJ6md8wkga0aWuySE4N554FW3uTJYnj1
	 nh/ngQD+cYnN1/fitVOXjBndu0Tzn5hRwzXAkaPIuLtWEEtgnWgF4MBFZB2WF90d2V
	 a6XJDlLEwLj4c/khhHwzNZtqg9id6YdTdB1pA384tmhI1XLIQQa5lfAVaSBBB4hCCq
	 OBzLhzdVicNjpdDtfxfkat9x655CqrMfLtM5PHrD1klkIxHWJtjWOXxbdpmW0wvUvv
	 h5I1HKAaS5qOMaezowI+Moce5O7UUrpx6aD9PnzWJj/ZaUEprJRGrDKSDvq+gy7NkB
	 9y5pyqJ19zibg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15B13808209;
	Tue, 24 Nov 2026 20:40:11 +0000 (UTC)
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
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_conn: Fix BIG cleanup while BISes
 are
 still bound
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179555281051.41195.6219902611296992385.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 20:40:10 +0000
References: <20261124114010.1696510-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261124114010.1696510-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Nov 2026 12:40:08 +0100 you wrote:
> When a broadcast source BIS is closed, bis_cleanup() calls
> hci_le_terminate_big() unless another BIS of that BIG is in
> BT_CONNECTED, BT_CONNECT or BT_OPEN. Until LE BIG Complete the BISes of
> a BIG are in BT_BOUND, so one that is closed in that time does not see
> the others, and the teardown is queued while they still wait to be
> connected. The BIG is not marked as created yet, so it is not
> terminated: terminate_big_sync() only disables the periodic advertising
> and removes the advertising set the BIG is being created on.
> hci_le_create_big_complete() then connects the BISes that are still
> bound, in a BIG that has lost its advertising.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: hci_conn: Fix BIG cleanup while BISes are still bound
    (no matching commit)
  - [v2,2/3] Bluetooth: hci_conn: Terminate a BIG before its periodic advertising
    (no matching commit)
  - [v2,3/3] Bluetooth: hci_sync: Fix closing all BISes while their BIG is created
    https://git.kernel.org/bluetooth/bluetooth-next/c/e80ea455a2b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


