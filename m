Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789233;
	b=O3z+R8bmFxaRv0BOwf7gSaaZ7IQUocMwDO6EVAKwWn6MSzSelyzlo+0AQolzCM45nfQj
	 saOGoaximr809Dibbi0AJ0q9ui4mb5NkzLFn63pJT9q8CLLu1RS1c527B9ov9oL9dZ7FD
	 1lDO9Zx480QaRL/jV03JsowU2i5BYQrYeTdUCG4gc5eWtnEHwv0DYrD2MICSv8dKja5RY
	 tVrOLkoZ+jmiN6UuuhVKFL9bokcnHwA+q+yd6O33eJBANFQmeVsJFgNv/LWpH/newpVah
	 HrxHzoKSiCpK76bsjEjvKuNzdIb+SpfnaOzIv2eQ4sZWU238Kr6tVCY2PNA01Lo42cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789233;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=cVnIspcT2g/hueEIeqEYovRXfKyn8GYBW5SMMIF18xc=;
	b=y9eBB8Bg32+Av9E7u+hkYQH1wTYHu/g5kw3UkexLVCXDqYtaSbSAOmbJtf+fCZMeYJN6
	 kTN+uW7VM7MDdrcSxFCb49cci+EAqQ6LcEz9dl+BD4IY6VBynQ8RLFDEr4Wai9jOrJy3E
	 4E7WWhdTxaxAnPJkAkfQSRghhrJ1cjf5qZsEAx4OxWmlSY4BcMH8YbDypqPPTq3GvGfIv
	 YcKSYlBh6tzdYs7r5JgqQ3G8zMiq9naaKnNbRPtzHC8a5u6UekSNglLNHPVeTn8nBpfDU
	 Mn7WUYdrnBe0EckJO+iiPc6SDH20CcTH8LhQcSP0AFoNewUpmzUQf2kucP2awO1wFBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDOz+e4D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D989606A320;
	Fri, 23 Oct 2026 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDOz+e4D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0CA1F01825;
	Fri, 23 Oct 2026 21:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789233;
	bh=cVnIspcT2g/hueEIeqEYovRXfKyn8GYBW5SMMIF18xc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YDOz+e4DlKi0rSQT5st3NtqDZlmugB+JzE6SirvXlcmdEqMtrhKY/qOP/n2w0Pzw9
	 in3RkNIwrCBXGagv6ox39VM3eFlQtBy3MLOZ1hwrRLZUV6jky4lM8QPD65qrt9X5cH
	 OO9ZIwKT+3T3Oddc4zs5A8IYuSKvIccvS5m+2x6Eg5Gjc4lNoSG4N98dy+eR+E9Jgv
	 vW+m+GaSI9gFz1sML9D/l10+2Lx8YwR50ekOvctwf8EOBYfBbXL9J05SodQm1nY9dM
	 h7Ma9XfEk5mmB3VeMSriEDBTo44ODHqeQnBcs1DQGFfjET7h4a3F8y3se/KL6xwwNV
	 wMvBc6k9Sc2wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 444AF391B157;
	Fri, 23 Oct 2026 21:00:33 +0000 (UTC)
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
Subject: Re: [PATCH v2] Bluetooth: hci_event: Clear explicit connect state on
 LE
 connection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179278923181.1268720.16511882069578397245.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:00:31 +0000
References: <20261023191437.87024-1-kevin@simpleble.org>
In-Reply-To: <20261023191437.87024-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 marcel@holtmann.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Oct 2026 12:14:37 -0700 you wrote:
> Since commit 6cd29ec6ae5e ("Bluetooth: hci_sync: Wait for proper events
> when connecting LE"), create_le_conn_complete() only runs once the LE
> Connection Complete event has been handled, and le_conn_complete_evt()
> has already removed the connection parameters from pend_le_conns by
> then. hci_connect_le_scan_cleanup() looks the parameters up in
> pend_le_conns, so after a successful connection it no longer clears
> explicit_connect, nor deletes the parameters that were only created for
> the explicit connect.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_event: Clear explicit connect state on LE connection
    https://git.kernel.org/bluetooth/bluetooth-next/c/083c4a113833

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


