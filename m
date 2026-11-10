Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327016;
	b=JvodxueyqPYAm9n+YemF30YvBfG05DgdqT/lkbks44OmrSj6IgYPrIeM+8S9GjCCyDjq
	 bklyn8uKgVOtMLkuJ1vH7A6P21/bcDacE4EnZWuVoToh3yCREjtHO/1lnKebeAWsJO1Su
	 2UOb6wb3TPMbej52aRlsfxYigpH524lHDBuSLfQYJYfg125+G86WJfZ0+A50IwPFHFmUm
	 aGl6Lhvi7PbW0aj9Y5yE1zVn7SaYhYHmUIEn3mrLRZ6y6NlrU9WoQ2B9pkN6X7j471aWv
	 wIc4pQnncWWGB+J+3hInPpDMyJDerUZaFgCCU7r1ig/J3xMVp7rH0gpr0J+hbgWuS0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327016;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=h8UAtxnGnSHqo8kwEhuArMQx5yI4oacoTVisDIKfIZQ=;
	b=yJyzcISIK5lQrzkwePC81m4neTHIIxHaHZtSgYs467dtLe+KY8fAOJTt6Tj1DDqlQZRV
	 W97l1/G6SiOvn3sSqtb0L0jfl+XPW2YsdHx/SADQgVoYmXD34VD8sYt0dGLfpTMeEibc3
	 eX7lPsO+IcXO9MIij/y+v4/lIrA26clzUpamxIGNktdoDO6XyzDqTGMpQ+EFzZWcQ4dOX
	 5VW1QEbxoBZqVN8VjqJrkpHaFz0HI3/8FK4unw9BMOFXm573A+4PBlTLXGVlbFycOPezW
	 vEdv5eTOUAchXAxQBhqCwF2MFB7gOTT/bESSbKDAi+EU4F7EYhcKsUUpEqfBVVnJNrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNECkWYj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D660A260F;
	Tue, 10 Nov 2026 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNECkWYj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A458E1F008A6;
	Tue, 10 Nov 2026 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327015;
	bh=h8UAtxnGnSHqo8kwEhuArMQx5yI4oacoTVisDIKfIZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jNECkWYjtMde9OR4Cb+tJdiNcgS54JN0cljmlhpwlqfOLoS46oj2kY1HBSjAX3qPC
	 ZQWWfn3oxosxCa8hFwyfsu/amUopOYOZYrCTBWNn2BGKYGGIvSM1rBjslaAD2MBPxW
	 LAPcpskD7mHnjScrGdrYstuw4NdvYdMkZOLG41vgQE+ttBVHLvPAGHUTDiVSZnzQf8
	 ZQI9YFURKJUrHzSpZVIgd1Z6g3OgkwDO1NLTva7zE0Eq8C+D8A4WtdTIX/1KjfIkL9
	 k+5VXr9H2w+gQcUl1eYYQoeIBnky+XHDdYuGBlYeKSZ//jviKKsa+m9/eMWl1Oghc2
	 SXXIIcARYOPSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B0CA39D267B;
	Tue, 10 Nov 2026 16:10:15 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: hci_conn: Initialize the device before hash
 insertion
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179432701417.4062787.3646978877662971174.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 16:10:14 +0000
References: 
 <pm-bluetooth-objects-candidate-0086-v6-dcaf08c3bc9952d7022d@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0086-v6-dcaf08c3bc9952d7022d@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 24 Oct 2026 23:27:49 +0800 you wrote:
> An hci_conn must have an initialized embedded device before an RCU
> reader can acquire a reference to it. __hci_conn_add() instead adds
> the connection to conn_hash before hci_conn_init_sysfs() calls
> device_initialize(). Holding hdev->lock during creation does not
> exclude hci_disconnect_all_sync(), which looks up the connection and
> calls hci_conn_get() under RCU without that lock.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: Initialize the device before hash insertion
    https://git.kernel.org/bluetooth/bluetooth-next/c/d9a1bd14caf5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


