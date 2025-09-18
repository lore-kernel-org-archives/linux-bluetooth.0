Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE64308F2A
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202207; cv=none; b=R0ggn+P1yaosqgU5wMXC2HsnsdfzWA3s8g/RMTqn6ewXT4Vot4h2Gvu+zNxWbwsVpmmhC0wA8Amk2FTqigoBHZDG8Q31KkG9G9nL6eNI47u4Ow75Kdwg6GVtoRFyDTI+g3CQtcdLtgXS1wsmF4i3kEe0EJy3LL6FZ7AiCFQewuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202207; c=relaxed/simple;
	bh=ms52kIYThLLBzGvQRziYjk6P03W8c0WkzGIiJPWDuj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EC0KO1rloGloXsuImv026v3WEnLBsb5/S2Zr6Kq8vrAJiH+cMkJAVK9mL4RBrcHSlT/NmAcnXknp7PPrD/uazSAE5k9mMKKiFuhcJ+2pHtTYkp7p5lBypT7tQyiCtI+irYly2VAsnHsjm2jNuSQaU4pSjF1QwLI1NVJ9qjCDRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agLFxEtZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agLFxEtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4EBC4CEE7;
	Thu, 18 Sep 2025 13:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758202206;
	bh=ms52kIYThLLBzGvQRziYjk6P03W8c0WkzGIiJPWDuj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=agLFxEtZrloKKVwmN2oljCJpVFmkjw/p54IhLNMIt8ioRac7u5YkTRO0XvfwMFlab
	 NKecl6unxuOSY5yHp4TmlnHuFhda+m+quYmJl3PxdFYSdELQtYAmGG4kt6bbdlZu5C
	 Y2EPMMjxZsWRNcD3sVKcLPJoQAKws3Judy3lD/afgnKSxgVS9UXH/bHbLVdQGAeORK
	 TZEe6OY4vi24eUMMNHFREpE/TWtKwfUfOjd6ZrGvUvoZfEcSAZFdkKY3KVECeRPaDa
	 DflMzAKbyxG59ilcxPvbKkMLEVt9QEwaoR+lXTnTobeL9XrALzjoJiRzD05RgtKbvR
	 iDCvfszNlClxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7539D0C28;
	Thu, 18 Sep 2025 13:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] transport: Fix build with A2DP support disabled
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175820220698.2414053.11560029662948810614.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 13:30:06 +0000
References: <20250912003233.931520-1-hadess@hadess.net>
In-Reply-To: <20250912003233.931520-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, arun@accosted.net

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 12 Sep 2025 02:32:19 +0200 you wrote:
> $ ./bootstrap-configure --disable-a2dp && make
> [...]
> profiles/audio/transport.c: In function ‘media_transport_update_delay’:
> profiles/audio/transport.c:2653:33: error: implicit declaration of function ‘a2dp_avdtp_get’ [-Wimplicit-function-declaration]
>  2653 |                 a2dp->session = a2dp_avdtp_get(transport->device);
>       |                                 ^~~~~~~~~~~~~~
> profiles/audio/transport.c:2653:31: error: assignment to ‘struct avdtp *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>  2653 |                 a2dp->session = a2dp_avdtp_get(transport->device);
>       |                               ^
> 
> [...]

Here is the summary with links:
  - [BlueZ] transport: Fix build with A2DP support disabled
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=61d3e447f9d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


