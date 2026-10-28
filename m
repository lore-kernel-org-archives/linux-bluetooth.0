Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194209;
	b=c2okZ/CxS3mZpuKRowy3SHB4SVUoQcgn+nf87aMsRnSgZIr1ETiMKyVVnEVE3OIsV+f5
	 sUYM0D20xjNTx6cdOvfrYtPQPpN7e6LgF5Dx9BZDlhJNW3ocIGGwB55kYlKeeTDbwvz7s
	 dBC5byrB+Ui28leU7U2cgniGZzvnilxRMY1gAU8RP0HDl45GrMozuI3RXD3ES7PKgzkfi
	 XUh69xqAivcFRe3HhdI9cYAv+AgxAUNfdzcIK5ElAM/GPjXjHCVIuwjfGAQzq3QrotHUf
	 9iVBAzVScHEWB6OA9D5UkeMgnIZ+X08aFxKRQxbVb11ymg1eoKTy5QA7gkjsOQAaosQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194209;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=dHuCFJLGSn0CBksMISsY7LivOs3pg0y1BB/XMByzSI8=;
	b=dscnQxeSKXG3/77ZxEK1rFjeXIuqlKYSNnD1p54GrA/Hb9M3gIUKpF0ng3OsLWivBugv
	 wphsWvN/dXQOgOCdFf280uTso/Wp1Rhz9iJLH8myAsq1IMl4X52XGt426Mkhe6Kypm4yY
	 3AsBOwRyc2+xG7TMr9winuyAkQxpikBnk0yUP8zTvKpgPLaVUgdZp32XgflE4arvmTRrv
	 Nal0+WNAwDuJJNmGhWiNAAORCRLG9IOVtVtLuJKjvTc4YtoIq02vLoa8m8UTOiN0XvFY4
	 ZwBxF8nLn4OLZNobQXhHQ+c8TAcML6mlCOWbmZoHY7TS0UNDo/8F7p3NrKUN1OxgpjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DWKPuuVM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0476606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DWKPuuVM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892FD1F01828;
	Wed, 28 Oct 2026 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194208;
	bh=dHuCFJLGSn0CBksMISsY7LivOs3pg0y1BB/XMByzSI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DWKPuuVMuBqkZ0RGM22VjEAsd4LsslJpznsT/71I2dyfVkLDq6nIMKWOpnkdRfIjS
	 UU+AZ21qVQxa7StCJVLLwJSkD5r4LaSLT4VlRgsVvWMB4JVdc4gTqp08e3+2W8XveA
	 AJ+DDdqbz27fk/9cTw+7tfTIaqOvTW4lbd/fe9g3BikbpRoUur0KfNzcmuSct00Pdv
	 DVUs8NUM6miYCODUGeNU8UFfPMROtrI5oBjhT7ozd6FHbfR0YB2txppKMBZ2/G9D0W
	 /tLRrltrqROdCAdEftmYkDaO3SbFyMblSrzFunKpmCgJK3bU5/bUKa4HVXN2sbL2Mp
	 RQ+JgRKNt5KXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815703AAA6E8;
	Wed, 28 Oct 2026 13:30:08 +0000 (UTC)
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
Subject: Re: [PATCH] monitor: validate Return Link Keys length before parsing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179319420706.722681.14649729121486411267.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 13:30:07 +0000
References: <20261027032821.1088858-1-contact@capsize.online>
In-Reply-To: <20261027032821.1088858-1-contact@capsize.online>
To: Capsize Security <contact@capsize.online>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 26 Oct 2026 21:28:21 -0600 you wrote:
> return_link_keys_evt() loops i < evt->num_keys dereferencing
> keys + i*22 while the dispatcher only enforces plen >= 1.  A crafted
> btsnoop capture (evt 0x15, plen=3, num_keys=85) overflows the on-stack
> packet buffer (ASan stack-buffer-overflow in print_hexdump via
> print_link_key).
> 
> Reject payloads shorter than 1 + num_keys*22 bytes with the file's
> existing too-short-packet idiom.  No integer-overflow hazard: uint8
> promotes to int, max 1+255*22=5611.
> 
> [...]

Here is the summary with links:
  - monitor: validate Return Link Keys length before parsing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6475b75e7e0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


