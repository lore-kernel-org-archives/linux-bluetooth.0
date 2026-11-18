Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018206;
	b=M5WFQ/2w9BxO2gZRLBYp+lL12ciuGsrgIvyYD2HY1HY+PGnRADPfwgBkv7j6GYGxYn4k
	 Qx3HlH3MqNeB62HrV202J4MLUp79wYfHFDiV+LfhjUORTx5tg1GUC/5swYcOK9BtywiGr
	 ime9zgWiiZA7UiOn9NVezMA2+e/Yz8NDfii12mYlBNkohjVF6hU+qG6vFql39MSehQ+Z3
	 lg3UDUvIfPpASctaIO4K57dp007qXD6yWMuktEmlsIN1a8P43dq5M4BDroRk43rf0zCcS
	 z8IcpqzAdqFYZBl7Ifyrf1aFgxCLFDARq5ZTgNOILKWx30ZwPcxAHk66+H0MGT1hXUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=jhU2ftwg6kE0zYbA6HdBhWhrNm/z5T3qrgamjM+k5s0=;
	b=tBspwt98aJrPEkDFxeyr3jvd2AzSHF+SXgm6GA0qaC7qls1mKLKyByixIvifDvHcrGzQ
	 WPmKRN9KGY30k1NTseEt11hV/V4UkhIdBV01G4Q+Lu+bfVaJuU/PNwedUwJCLyeb1E8o2
	 Q1ahj3SLHoYd5dapNXfoLF8/8lhGXsYBcchF3q6tNyFsv9SLnmUeiypCPgCMyg5fY5sRF
	 hIimcLS3vVCp1AzHFg3I/K0SAyL6yEi3DTLZ7cNNK4GGHiUuKecyTQ5NRPJnDt2W8lhxA
	 ImNi7unB1bZfCNsuz4GLvqZPAXbFD7adWv+U7eSI6e8f/kOjNdeTVGFc0uxDWpoCE2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCeX6fls;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E8606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCeX6fls
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059E71F000C4;
	Wed, 18 Nov 2026 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795018206;
	bh=jhU2ftwg6kE0zYbA6HdBhWhrNm/z5T3qrgamjM+k5s0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HCeX6flsrpvVM84JzfybPpWYIBRTSqB81lPcXcWuWvJeYbdm6f9lG4tw+JRoPZfUg
	 yNSHNqFN43oLOkTfyqlU5jGWAJYvUXjPvKQX9EJKJbIlHj3oUDWHu3hHIBDS8bzfpl
	 AmlBdQFggKRQte/juJLylIRlTU3xZ6aTZ37hLGxKRFUttH/ZoBIO8j4c6G+qTCjV5A
	 zhmCS23BNCacSzocHzpucrl1qJDfvOkyMVDtuh/7MUMhptd9OyFeJc215jqGG+4Npv
	 wulpPuwIZ0UX7doNmuEVNrLrHiL35EkCJNrXNNxFCvBJBB49jAdExTIAQFvgYKd/YM
	 71a4ihQEdknyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15573808210;
	Wed, 18 Nov 2026 16:10:05 +0000 (UTC)
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
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Use a reserved ident for
 L2CAP_LE_CREDITS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179501820453.1808349.5157597319638847230.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 16:10:04 +0000
References: <20261118142732.102749-1-luiz.dentz@gmail.com>
In-Reply-To: <20261118142732.102749-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 18 Nov 2026 09:27:32 -0500 you wrote:
> From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> 
> L2CAP_LE_CREDITS has no response, so an ident taken from conn->tx_ida for
> it is never released by l2cap_put_ident() and l2cap_chan_le_send_credits()
> has to free it right away after sending, otherwise the range is exhausted
> after 254 packets and credits would be sent with the invalid ident 0, which
> some remote stacks ignore, stalling the channel.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: L2CAP: Use a reserved ident for L2CAP_LE_CREDITS
    https://git.kernel.org/bluetooth/bluetooth-next/c/06b6fbe05f5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


