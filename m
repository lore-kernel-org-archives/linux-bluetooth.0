Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20835AC2F;
	Wed, 20 May 2026 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307195; cv=none; b=m161CcIx1urOBg2CgwrFv4ZdpyKwhr0ty5gg21hxedzIAC/DoHBhjFkObcU8dVfIYNRwm7vUA7QXdRwVfk4mhFvrVFELzeh4NsCX+ZNi4Xsms03dl5in/6k/ykp+5FvdKGEV+C8Nd+oEtNiWJzKQ4uq/fL9zn6aL2cLFcGJRJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307195; c=relaxed/simple;
	bh=McTrFVKX2x8KAPFybNzi1OGs/LMHJIl9Ll9yzD4YlYA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OTpSrN3nqzXYoIsTDh0NNo38wOz75pYmRtGhwtQlQOpuADjeMRxtw6ZMLL7TlWIx5ZeNeouL8wRXBEkaBeOpmP47ZYC/Y6ga1s32j6WA7XapHo/7IEThP8Tl0I8eTFgHM/49rCxif70sAsxEriuLv4xgrxwBwe1+pLXgae+vrZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8x019ju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8x019ju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463E31F000E9;
	Wed, 20 May 2026 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307194;
	bh=ALSwCmeG8KTZ3ou1nvJKE0JLWvzFWyHMttzZnY78424=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z8x019juOUF+3jwV68OzeKBlJtNxwdXh4H82uiM9nMEJKEVQEO4wPVojF6wRENNh6
	 wgdKk933MJS1GArir07HD9tVpyOary0l2dTx00ZdMPNBd3G5eM71a0Cf2BOHHeH+oS
	 rX0we4yzec9ZorxtDVkcY3K29vkEEabYMueXBCBWibNbD+KDPM2IWP8HCsAt1/oGY6
	 wEkHcXpEoTPRELl+DbgQpLgbiSMhrqbSwz8b6dLpF4AZg2KM0qi9IwC2Xz6b3bYhi1
	 iFT97mjzCiCaepbDDSQpVKgoDsO3w4wpvqOgIxu2O38xIz4UnmlHVvvQ+NXwKT9dVZ
	 4/Io1KbEBgcsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09323930BB0;
	Wed, 20 May 2026 20:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs
 l2cap_conn_del()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177930720449.3737015.13239327454432512997.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 20:00:04 +0000
References: <20260516181504.3076260-1-safa.karakus@secunnix.com>
In-Reply-To: <20260516181504.3076260-1-safa.karakus@secunnix.com>
To: =?utf-8?q?Safa_Karaku=C5=9F_=3Csafa=2Ekarakus=40secunnix=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 marcel@holtmann.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 16 May 2026 21:15:04 +0300 you wrote:
> bt_accept_dequeue() unlinks a not-yet-accepted child from the parent
> accept queue and release_sock()s it before returning, so the returned
> sk has no caller reference and is unlocked.
> 
> l2cap_sock_cleanup_listen() walks these children on listening-socket
> close.  A concurrent HCI disconnect drives hci_rx_work ->
> l2cap_conn_del() which runs l2cap_chan_del() + l2cap_sock_kill() and
> frees the child sk and its l2cap_chan; cleanup_listen() then uses both:
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
    https://git.kernel.org/bluetooth/bluetooth-next/c/0b580042a1a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


