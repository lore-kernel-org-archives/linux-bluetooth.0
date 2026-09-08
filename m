Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53385803A1;
	Tue,  8 Sep 2026 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885090; cv=none; b=GmXLNSrESKn1dp2QBOhVKhHVYjdygp6bRYSSGqfd4HNRakDJjjlDesS7qyMl+4o1E+/+h1OqJNRURUSlPcYqi9DYL+OKK/IlE/vy1jNVXt6U8mMF9nV/4tOU6KsCVX1awNgQfx3uUbAGYLTlNGkHIBIDTsrdc4vjfBYXblT2Zn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885090; c=relaxed/simple;
	bh=D62RkWzvs4BvBrQrb/emthmWEyvWCXz/z//opsxPg6E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GhTryDE4wxgKcoKa5LQtuZiSTf/b15XsDzOea15XMGg+QiHbd2sWu2bDnKKunHsfmLq2uUjbDcCgtve36d6C24yG8oYTHQZT9eVXn+r+tIQG5cnXj1MyUbScrqowW4a92Nkdmxdl2UXLaC288KmIJQwnJJRI4hjthhKKG5odFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz9XH6Th; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz9XH6Th"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4546E1F00A3A;
	Tue,  8 Sep 2026 16:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788885088;
	bh=JMy9YB1a01bxj2Y8wSR4X3Tr6RjFHWG5fEkw1FsUmfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Lz9XH6ThfpeGvMScNftRGduggIvW/3hhc0w0C9M/A2c9hyCDcDMVrocaFOvYzQ2Y+
	 1+bEaKpkndT3MVR2HLn5dIrTUkfgQiTcp2Yg88nqiuwaZnKs0jFflypdNVj1nRIxHD
	 YjyHo17r7zh9VpS3omjOoVMwHIThNwWO26a3KErPeoQRBYB4aUb1Ji8GRCrwzjSuQz
	 cOMYFLqrPpL0PtrBe+0XmIbgCXkKc9APdibZrHWrQmTDWInzlU5tIjPOAKruqK8NUm
	 6sSYMF487LEwG8Zh8wfkKfTxH5CjGQrrD+qOOyP2+zkGXstTfBd64LhdqfFOxEmNVh
	 p/L8N1LRsSYKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AF339EAF6D;
	Tue,  8 Sep 2026 16:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_bcsp: Use the shared CRC-CCITT byte helper
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178888502661.3627954.13490393593598630816.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 16:30:26 +0000
References: 
 <D667F392AF7221D8+20260907151015.13522-1-zhangxuhua@kylinsec.com.cn>
In-Reply-To: 
 <D667F392AF7221D8+20260907151015.13522-1-zhangxuhua@kylinsec.com.cn>
To: Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  7 Sep 2026 23:10:15 +0800 you wrote:
> bcsp_crc_update() processes each byte as two nibbles, requiring two
> dependent table lookups for every header and payload byte when CRC is
> enabled.
> 
> The existing crc_ccitt_byte() helper implements the same reflected
> polynomial with one lookup per byte. Use it instead of the private
> nibble-based implementation and select CRC_CCITT for BCSP-only UART
> configurations as well. The initial CRC value and final bit reversal
> remain unchanged.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_bcsp: Use the shared CRC-CCITT byte helper
    https://git.kernel.org/bluetooth/bluetooth-next/c/30962c917c47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


