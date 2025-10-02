Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777C2BD5BD;
	Thu,  2 Oct 2025 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439419; cv=none; b=EgiAjyZWrfX2oht0BiA2qRglukC0wBlEs7I65HTWEMybWq6owc7qTnfNzC2NNJFRdcLitv1DXQhzxgeTIF5xMt2jGxkcwpj4xkJtk2RqT+TL08nkh5cWJptlIVVM+3V4MbMk9MrAZEmZlUjnVAat639X+27jV5Mjhrg4mqdS2kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439419; c=relaxed/simple;
	bh=6sSvzRaeZ3N9G2PZm81Gz5Lg/iIEcQV6Bf1t+oVd0Do=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XKEmxu5ug6vcXH1Ix1c07K6QzV7BZ1p22li1Os7yUH2PMu0YTgg1HESv1tG2GcrHXM+C61UgILjyUgY0PTjWsPySfLp1wRWxPa5UKI8GhnovIBObr032ZzzxMhzxlSUXtRHdftbVmFC6pOZYZZv6nOSoLPTX+9yyzKv7yN0qr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0Ol+maq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0Ol+maq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6C4C4CEF9;
	Thu,  2 Oct 2025 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759439417;
	bh=6sSvzRaeZ3N9G2PZm81Gz5Lg/iIEcQV6Bf1t+oVd0Do=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q0Ol+maqz65r+RXp2NAIWe4ekmJk/zxM/KBIEO6Sk69iSynsGO3X8JNVKVASMlMhJ
	 +QCIn7Co4CXXL21xfqc7vqtrGNzCVoS02mgW4D3xwnLKnbGhRrubzOfVBsyLpKAEnr
	 XluLCwKafq4O6KQMUz9jjwnqXFbQqmnRFaI+orbryJPuOi0b+flYG5Bo9MZOwLULz8
	 eTYdBTsffkm1vxpMKuxZ7y4rzroADIBf7alvA/9Iyzm2uaed17WjOOABMs7CgvIg0i
	 5WSbJzO5Y3GRTeIolodpEHZn8pMn1pu1yUm8bLvfuWWPaJBdDHoaB4zdAx386WpkXo
	 76qfPiFXTjDgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0C39D0C1A;
	Thu,  2 Oct 2025 21:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH resubmit] Bluetooth: hci_h5: avoid sending two SYNC
 messages
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175943940949.3462061.17710963614120733995.git-patchwork-notify@kernel.org>
Date: Thu, 02 Oct 2025 21:10:09 +0000
References: <20250929221553.84966-1-jgnieto@cs.stanford.edu>
In-Reply-To: <20250929221553.84966-1-jgnieto@cs.stanford.edu>
To: Javier Nieto <jgnieto@cs.stanford.edu>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 29 Sep 2025 15:14:41 -0700 you wrote:
> Previously, h5_open() called h5_link_control() to send a SYNC message.
> But h5_link_control() only enqueues the packet and requires the caller
> to call hci_uart_tx_wakeup(). Thus, after H5_SYNC_TIMEOUT ran out
> (100ms), h5_timed_event() would be called and, realizing that the state
> was still H5_UNINITIALIZED, it would re-enqueue the SYNC and call
> hci_uart_tx_wakeup(). Consequently, two SYNC packets would be sent and
> initialization would unnecessarily wait for 100ms.
> 
> [...]

Here is the summary with links:
  - [resubmit] Bluetooth: hci_h5: avoid sending two SYNC messages
    https://git.kernel.org/bluetooth/bluetooth-next/c/aadd7d40f7ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


