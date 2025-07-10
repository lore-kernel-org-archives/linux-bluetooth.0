Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D02F0E4A
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168746; cv=none; b=OtnXI2hTVdRodoVTBQ7h5iC8a5YZpDqaMGZh8LEOlKgsVkWgXxlrreW7V9cz17Pgsd+gx49AhWKtzejJq9bPX1tBAaA3PiC5rUt/NaQcex74oy3ArUmMrsK8vg1RzaTdHliH4x6F1JDTyqSZHdWU65dLE0lHhj4nNlRz9STg0GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168746; c=relaxed/simple;
	bh=8nOn7d3LwuLWMcpFwa7lDacAUPVjTrCW/O62RpdiQ78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B0XekH44+U0SdJKYKzMWiN9htp+CVteAs7JdIMluGsvVOAtbv0mq4fTGSH8GwaWmxSeXD2cm8HlYrs2iFSfz4g00QIXMfCHH8EZ5WV3QYku/1CXus/5Lmiyx2EjLzrE2g6lhYW5AuczPnXfDCCZaZRHF67lnBkMMAmWs+Vu4Fjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmzzxB9T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmzzxB9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21B2C4CEE3;
	Thu, 10 Jul 2025 17:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752168745;
	bh=8nOn7d3LwuLWMcpFwa7lDacAUPVjTrCW/O62RpdiQ78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GmzzxB9T5iKok8xWO6xpd6MBGDhVJp13yCKj0OyTxppwgXyCpZg8IuWf5WkD2dmFz
	 CFIPVoTd41f4tMPClHex31FKiPhDkt1bwK9auSVQReIt4WheCoo8LL4AIU8DOwxoSr
	 cgggxWqEZK0hx8U4tH3/xD+DaSXuVgL/w75wjihmqNr21kna4wzUTu2IIKPEeUk3xE
	 xhSaEGYpq1bLei3aJE6PPcFGkjk7KAoghaPIRxGewR+5rOIbHFBcCitBekkLVSRsMS
	 Ru9W4GIlcSAr3+jzb4STnh5vMNfVOkIcxhgs9R/SJUq4QCcwreXFGSB2G3aBTt34cR
	 TjT9xzuXf3SLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A8F383B266;
	Thu, 10 Jul 2025 17:32:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: SMP: If an unallowed command is
 received
 consider it a failure
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175216876774.1607762.5527949828152506084.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 17:32:47 +0000
References: <20250702162352.1374119-1-luiz.dentz@gmail.com>
In-Reply-To: <20250702162352.1374119-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Jul 2025 12:23:51 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If a command is received while a bonding is ongoing consider it a
> pairing failure so the session is cleanup properly and the device is
> disconnected immediately instead of continuing with other commands that
> may result in the session to get stuck without ever completing such as
> the case bellow:
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: SMP: If an unallowed command is received consider it a failure
    https://git.kernel.org/bluetooth/bluetooth-next/c/11040353f444
  - [v2,2/2] Bluetooth: SMP: Fix using HCI_ERROR_REMOTE_USER_TERM on timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/3f412d11ddf5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


