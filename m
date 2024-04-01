Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C840BF5
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980629; cv=none; b=SQCyd+UKV7brDXDz+1/99UDHIoBLexFCJvBVBnYr6/3RnmyDrI2s8cO+G8WcS6FQt3uWhPBaM/iS7Ac1E/zyo5liQtcTziKZC2eheUsqJBjnrA6zUWW5V9qNfYtMD7E6xKhzJhNF8DSPjfOzro1l7jJylO6EnpKJz/TgFD0lVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980629; c=relaxed/simple;
	bh=5rpKPuuded6P50y5EDbPjU0fu8LcH41cChHF0p6s91w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rtmfTohiXZrTTYv6VuguZNI1ptDXRab2DSwGTp+nx37XEH4IlgNQ76a4HB1DnLlwfXe6qOTdZenGNYdQnw8MtJqeixx/nLA8/6VH3Lka+ptm59wmMiMFhnwSN9HarFJiPnEMDBVsmW1OLXE6TEEDSAIBsumBN6YJSPp9O3NA0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYyGsW6J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYyGsW6J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79FBFC43394;
	Mon,  1 Apr 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980629;
	bh=5rpKPuuded6P50y5EDbPjU0fu8LcH41cChHF0p6s91w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TYyGsW6Jz+OeD28/ONohULQ/y0FvAwJAPD7OUpshXXTPBNg/cXMwoVWOmYmd2TMpU
	 7PpmHGa80wagt6ZJe4KiIXIY2e798ZDTx5+SNJcu6HXxjXP+LkeQiCwPIebOPGuGG+
	 GtPEg9TcBzfbcbuNRb8zawbYzvzl8yJyfZ8MkIDM5aYYQY0Twi3aLxvTPj1HWUKFDl
	 fO1QWwu2ePNu5Ky9C7iH+BvliK6zV0pLm+7sziuwJbO/9cmu3StlZ2S7t5fySFyw0S
	 w13CUb87CBtyd5sAUOIErTtNEyHbMPjnakBTTYZ3Kx9MBw4yf+yWwvd4hXQ6sQDN/I
	 afqoGoJcYoQ5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AAC6D9A150;
	Mon,  1 Apr 2024 14:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_event: Set DISCOVERY_FINDING on
 SCAN_ENABLED
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171198062943.26711.6048002435366531306.git-patchwork-notify@kernel.org>
Date: Mon, 01 Apr 2024 14:10:29 +0000
References: <20240328221558.1904865-1-luiz.dentz@gmail.com>
In-Reply-To: <20240328221558.1904865-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 28 Mar 2024 18:15:58 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes sure that discovery state is properly synchronized otherwise
> reports may not generate MGMT DeviceFound events as it would be assumed
> that it was not initiated by a discovery session.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_event: Set DISCOVERY_FINDING on SCAN_ENABLED
    https://git.kernel.org/bluetooth/bluetooth-next/c/ebcd560040bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


