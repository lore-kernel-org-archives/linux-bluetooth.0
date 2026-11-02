Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658021;
	b=nvSVO6IH+Upy2YgwZ1axz7MI0PpQnCFgy72pfdgj+3w13jg86rwQhY38t79z1hKXF31e
	 9tZEDGec5TTEtkMrt50cAn9KR0hX7iq0lONvmi7/g3WYeU4x700JQws+0J6yJbFetyXF1
	 dEhZu8FwwyBJhQqUjXbI7xqFGGpzy7HPbtOUgJWZGZAopM8uZ1wXML+HAnMewOsicUGGq
	 iowtdAzfghNX/7dBcL4coago/+HBXISTRAwNcF4N6Ftz5RUpxRZrPYBMObfMaBRh0T0L6
	 mhoLwQWH6ZbRE4FgM/Z1moZ9CsSd7w1UEhmaR5ZgMuho4EIZWGDL93uqWbZpbKRFkNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658021;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=lfQC5oONn1O12zujNbswi2n52JTnkv8/ImyjnFp/67M=;
	b=rv8QgNO2itKDm/6Sy0mBqDPRqmDcmxH5OwOXAtkfVQDzDIXygyK3rMYju2vp6AcNYwEZ
	 1S96aYe9667GjbbefqwFOmtvnp+053E+VGx6nAh2lsCVHSvJV0ThvF0R+WhMGwN2qFvQU
	 cMW0Y7wcxdoP2iBsS2aygdqtKY4ChcYahcRnonKOIlg305wZCis2Q5Nlgaq5SIpMuCiuH
	 ktWHvzxR3FDkv8qKIM59ZYNu1k4aJrjoCCDlvgvcHJJW+qrnk7x7FkjkRSMoTYrizA/kt
	 iFOjh1rAXIEzDeaHHkKKAuuLi9wgFlo1jqZOR9EC99wvIAiMLQy9z3IrBt8GKz7CBWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8N5lI5M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F97606A336;
	Mon,  2 Nov 2026 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8N5lI5M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C52B1F00A1D;
	Mon,  2 Nov 2026 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793658021;
	bh=lfQC5oONn1O12zujNbswi2n52JTnkv8/ImyjnFp/67M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I8N5lI5M3M6VvHMGXvMRJGWp5e4+Zx0bl5I4lkshfU54o/j6HSDNDaNbq6Tx8WZr2
	 VslkIqdn84ju6AfQ8ElryZJoUznP/ALsmPx5XnaHjJ+wsLcQONuuUBXjWN2sYw0A2Q
	 4w2iTqTwyLKsevd8SBtNiQZDkVbOY5mx/w1WZ8+AZwt5dC6e8lMvbhJxDqbEFhAmQ0
	 xVp1XamzGYQa7TNbenSCzc1+h191ETO3QWP65ExccLnFbyRKiWsbyY2UmD9PfpV3/X
	 OgSqkfvE2Eini37VJ80R30cxHiz13n3pOcLk4w3m3MHMUpODqxwLW9u2FyScfutrTE
	 VPBINxNOo+Gzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02FF2380821F;
	Mon,  2 Nov 2026 22:20:21 +0000 (UTC)
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
Subject: Re: [PATCH v2] Bluetooth: MGMT: Send Connection Subrate on LE
 connection
 and update
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179365801954.694758.1964574440994296679.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 22:20:19 +0000
References: <20261102170008.62788-1-kevin@simpleble.org>
In-Reply-To: <20261102170008.62788-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  2 Nov 2026 09:00:08 -0800 you wrote:
> Userspace is not told the parameters of LE connections: the Connection
> Subrate event is only sent for LE Connection Rate Change, which needs
> the Shorter Connection Interval feature, and nothing is sent when a
> connection is established or updated with LE Connection Update
> Complete. Applications that need the connection interval, e.g. to
> estimate throughput or latency, have to read it from HCI traffic
> instead.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: MGMT: Send Connection Subrate on LE connection and update
    https://git.kernel.org/bluetooth/bluetooth-next/c/0c0c3d785643

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


