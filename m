Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB0954767
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299828; cv=none; b=WzVf9SPKvqqiwREACTuWS9A7xEsotgWaj9u6C7YYfANYq8++aJWA7NW+hvNCa7nc3oOsO0o9+tNT9pWyylTlysB6+to45JrEp3CMqdwkxUt8HPAwn8MC5vpgy7u8jjQlzrmJh2iJXOqeATqU6YJEZHYf5ciZemK1qkBSWX9owas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299828; c=relaxed/simple;
	bh=AwPe+A1iED5eBlrrRKcG0GON7MlEYcK+cjMs0tYiJOk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uuiux5VQ0/tN7A0JkmRORjkCmjzMUL2JcjAn4JU/yDqwgxDH3MJM4BT+ssvLytrWHrszM+i3BaMwqVvlfxbWj0Tcnnvk6N+ZfIrMh/3dN0NT4h4yuRNhBOwBzZk+jWWc+wGW2O5yRDBfc2b0V432csO1yu8cy+fANS1ZM4Fc1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDoPIP5u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDoPIP5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A6BC4CEC3;
	Wed, 25 Sep 2024 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727299827;
	bh=AwPe+A1iED5eBlrrRKcG0GON7MlEYcK+cjMs0tYiJOk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bDoPIP5uBAf/4HUgBsid5h57ULzGo1HPjXaVGR41t/EoslEpvhniDUO7y105QPg6H
	 HCxJMoxP7dA6Fv3PedRHiPVt/GVf0Vee/6MpP/RElgCzvp4KWnXNQS5fyySwxUYiFt
	 0a6McL47LoKJ5aOvdrCvQTt8hmiR8sE5I08yvoQL9hRtqyVbG8pwjWR1hzVfO/wIEF
	 dbN6PGtNOQCv2+BSlg1Sl13pyLqGs/086zzrGVBfxoTa4V8efnZ4r8ImmwFYhI1nh9
	 xWMJ6zQ9Lnlx3lARni6gGO64m6U4pAkgvIE4P3iTmt7qdcf1C7rXji+ek0uSU+ata+
	 W0HB01kK29VxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 351593809A80;
	Wed, 25 Sep 2024 21:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with
 LE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172729983001.732232.8659598489282368340.git-patchwork-notify@kernel.org>
Date: Wed, 25 Sep 2024 21:30:30 +0000
References: <20240912161700.2976337-1-luiz.dentz@gmail.com>
In-Reply-To: <20240912161700.2976337-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Sep 2024 12:17:00 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This aligned BR/EDR JUST_WORKS method with LE which since 92516cd97fd4
> ("Bluetooth: Always request for user confirmation for Just Works")
> always request user confirmation with confirm_hint set since the
> likes of bluetoothd have dedicated policy around JUST_WORKS method
> (e.g. main.conf:JustWorksRepairing).
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
    https://git.kernel.org/bluetooth/bluetooth-next/c/257d7307d348

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


