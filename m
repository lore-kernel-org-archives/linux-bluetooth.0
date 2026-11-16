Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858606;
	b=UxcNHPe+EWplM0sIABOodtFRAU9vxz1lAWxiIwGCL9XFWUT8UaGBnHXyttz4QwHXwT9P
	 FVQd+tglJwPrAhIxsBSV8eCmcTqgwas0h720Ln1ruV+BBTPPSM2wORBSqpuY22aL2kPKH
	 TbKYhJehl8nxQsIYz5XRmX+B+pDqxnMJUL9WLArfQfO/bPXg6JUOf1G9QGkgrnOCYumf0
	 EPk0papinU4OUCy13uDNHRsX5p+iqBRLKJZaM+ZTiYG/7+DEfbO0u6v/DzRAzsiYvJO2I
	 Cmx7fOqJAeo5AN1gqrxRyj1fN9PSxmS7E/bi3nIx8XMfdzOgLCWIdJwVGv6bnxfyVlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=V49zu2a0OXh5byS4ObEAoax3uiBQLwDETUojZMbuRu4=;
	b=QXEYvrnW2p1UPMaiTj7tRUvbpDvBxk6iMdjKm+dHtNbl34HYTCz50JqLoCmQgTjvTbyG
	 lhiCxUnfH9gRQn9cf9lm3GwuFjLel6xH1a/03V6+BsC/OolzXL4TKYe26yFPSD2iwdz5R
	 J/Kr3JIGs2ZoHEKk985iSQvigPQlmyoTMTtd3QYw1zLMERooBuiVAvOFpGYgfBlqzhAqV
	 iSgdRHEqW2gxTutPlFsPQFUiUtSTEE5yblvm12S0Ff17k7YylU1//F7Qc7BkCwX7Bkp5G
	 7Q1bVRDyy8BZyZSS6ueE32jX8hDRPK0eiq0UM0PhqTXaTn0x2VBbeAhHE6CldpJ6Log==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUZ0GfrA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AB606A31C;
	Mon, 16 Nov 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUZ0GfrA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430D41F000C5;
	Mon, 16 Nov 2026 19:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858606;
	bh=V49zu2a0OXh5byS4ObEAoax3uiBQLwDETUojZMbuRu4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EUZ0GfrAScM+Zj4myYDuiyGJW1bFY0PkF7qooqg83EcAJhFmWHG8DyzEvwbg70I5A
	 NMAf2bQhrTMJRjU166pGp+U5rEnnGlfVZ+PXulmspzoW8xNG7GKRXVbJU3K9MW6lvF
	 Z7iwZXyN1ihRyz0of898NFxAVsfO4AZ5EQiGZX9C+iY4JpjKWDwZTi2cXlRn5y+cHN
	 v7MKxpSHZY9TqdLmTm3krcZQ5IA4YGEvwdG3oln9YtOn1JLU3F5GPvYtfqI3Z7nWkj
	 pIJ9gGAPC2j0ursI++VTz02R80Px23/uRG6titJ22ZXFbz/aCDvpNG3Y4fhOoudu66
	 VAX7H5QJlFi3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3AD391AFCC;
	Mon, 16 Nov 2026 19:50:06 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: L2CAP: clear the SDU before the receive
 callback
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485860503.3856541.15241820341597541824.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 19:50:05 +0000
References: <20261112173812.18696-2-piyus@iiitd.ac.in>
In-Reply-To: <20261112173812.18696-2-piyus@iiitd.ac.in>
To: Piyus Kedia <piyus@iiitd.ac.in>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kapil@presceralabs.ai

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Nov 2026 23:08:12 +0530 you wrote:
> l2cap_ecred_data_rcv() completes a reassembled SDU by calling
> l2cap_ecred_recv() with chan->sdu still set, and only clears the
> reassembly state after it returns:
> 
> 	if (chan->sdu->len == chan->sdu_len) {
> 		err = l2cap_ecred_recv(chan, chan->sdu);
> 		if (!err) {
> 			chan->sdu = NULL;
> 			...
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: clear the SDU before the receive callback
    https://git.kernel.org/bluetooth/bluetooth-next/c/76248359ac32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


