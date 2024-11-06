Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B220C024
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924421; cv=none; b=pJ01J3zdFRgkue7l9UlB53wf62WWyUHzfZVYQxSnEl6+hQRYoKlpoe94jd0oaHN25v+CJuIXrP0zuw9SMXQo8unbXEIvtwNalMujxgldWrNsfpCBDomsTKH0D1sCSRJyKM6QykokS2v0Xr6PkGpJPiKGFbVJJ223Nd/WDzXhvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924421; c=relaxed/simple;
	bh=s0xagmOaYOotKO687Ej8qQY5MpGuBLEXVBFh33/fUgQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GqqzXEHVT9BqHvIhQh0fhGsVNmq8cm7xwO2VxsbxT8S0Rx3+iEuygSEjVUt+S5/oFcHtGzMvgGpzSefqJfwNkN1ga6ANb8uesTg5I/+kpnmfmd8CjkJoto0cFWNCEMfirAvJm1LbH6zuu2ZR9WGQcIsl72Vhiv8OHKjmVO5627g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7Q2dkB0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7Q2dkB0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA4BC4CECD;
	Wed,  6 Nov 2024 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730924420;
	bh=s0xagmOaYOotKO687Ej8qQY5MpGuBLEXVBFh33/fUgQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K7Q2dkB0FX6lMXffYkAHjHBObEb6tLxQJZp+9lhH5SDtk3qjQoqI/P07ExitOlWhT
	 79fejaeDQXmvK+mmKzd3PR5kYu3L9H9qr8Ttdkz2RsoyQjke87F67msTSWwiqa1iY+
	 YfjoeZcOb7sF1dqIr44NryEnoIgnHERucvrYQA93S2JeY7PSZ/rt4CrORUIeEG1ASa
	 aYotzyc7/Oml+HQzq6wdvaYgqVANmAOh5EUuXVGqz3KW+X+IMJYmebtuue1BwOdc4j
	 JXG9B78OCWYrkBsmmeyE6tnsCfzY0ZlqQ2aoke25Q/a/suCyQU26x7UFT1j7nEU/Xt
	 clUcvecDgop9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFA43809A80;
	Wed,  6 Nov 2024 20:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: HCI: Add IPC(11) bus type
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173092442961.1407482.4855364519937344504.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 20:20:29 +0000
References: <20241106145605.44408-1-luiz.dentz@gmail.com>
In-Reply-To: <20241106145605.44408-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  6 Nov 2024 09:56:05 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Zephyr(1) has been using the same bus defines as Linux so tools likes of
> btmon, etc, are able to decode the bus used by the driver to transport
> HCI packets.
> 
> Link: https://github.com/zephyrproject-rtos/zephyr/pull/80808
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: HCI: Add IPC(11) bus type
    https://git.kernel.org/bluetooth/bluetooth-next/c/2336a5b48954

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


