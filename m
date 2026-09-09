Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371323A7D73;
	Wed,  9 Sep 2026 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984073; cv=none; b=EvF47PPE/5+eCGb9Lq82GTtpPe/eJbBON6JQWkjjBhA2xYiambGiO0XUT3gjtAEWm+TtFFavkkXvTQxWOxvmc41iw7tupVgHY+JzCuTVURJibOUBJOKzQdCoBgCZKeWTkqC3cWLBPIumPNvVEZfXCTyy0umCqPHueypri2yYtQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984073; c=relaxed/simple;
	bh=MgD8IUvjAyNLLzUP4FV0FPGqVKoOSoWalFsNEThTgnM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A4ZXQHjVZjnzfa0AX8Gpt/JbAS48q2EGr1rUVqA87AKWRCN3bU1Cjhbng1MDdvfYAfDpwjPFw0qhDG45oS/KRL8lBjYSmX/Ix5135HttzK2xCjlCswid4UyumJxgngadq5e+fvWXKkrQgH7T174hkHOX8fOca0/7/oWY8HtNaOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4UeDj1B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4UeDj1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C261F000FF;
	Wed,  9 Sep 2026 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788984070;
	bh=bVBsQziOCe6FlhZ7FOhLXPVigWP9VPum8a09dM9B1yA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m4UeDj1B7G91HQS0eZdqF49gYa9L23JR9ZXcVGtJVNjYN5Jp8aMWME3NaiErkVxNz
	 um73vM1eQ8sDJHozb1LYD8YkxZTYl860ydUN0kJIFvNb42bkH/QFsPbZJehhvDvy6d
	 t4LK5bfl15QXBfya92kjm4YBgc9g3gzKf4xGdac5FxoNaB1B1PWLrv+FNm4yVED3+D
	 VPB2mK1jn3E37fLJf86/SfPCfqrrRMR7LGc+kM6LCCBWcUMlpH7MTGjtDvaeamEP9O
	 lO5RQ0SfSJOfrCYDle7I/dMU4KHoBFGgM1dQ+zrZW/yzX+y/rVzbKx3Dlm39DiwnZs
	 Wo40p4VPhO7LQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B39380AA74;
	Wed,  9 Sep 2026 20:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Bluetooth: btmtk: Harden firmware parsing and improve
 logging
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178898400812.1032931.449738913453021907.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 20:00:08 +0000
References: <20260909120011.1198001-1-chris.lu@mediatek.com>
In-Reply-To: <20260909120011.1198001-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, will-cy.Lee@mediatek.com, ss.wu@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 9 Sep 2026 20:00:08 +0800 you wrote:
> Three changes to the shared btmtk firmware download path, all in
> preparation for MT7928 support but useful on their own.
> 
> Patch 1 bounds-checks the firmware image before the section map walk in
> btmtk_setup_firmware_79xx(). Today the section count, the section map
> array and each section's offset/length come straight out of the file and
> are never compared against fw->size, so a truncated or corrupted file
> makes the driver read past the end of request_firmware()'s buffer. The
> section count is a __le32 from the file, so on 32-bit builds multiplying
> it by the 64-byte map size wraps a size_t and a bound computed without an
> overflow check would come out small enough to accept the file; both
> helpers order their arithmetic so nothing can wrap. A section count of
> zero is rejected too, since it passes every size check but would leave
> the download loop with nothing to do and still report success.
> 
> [...]

Here is the summary with links:
  - [1/3] Bluetooth: btmtk: Validate the firmware layout before parsing it
    https://git.kernel.org/bluetooth/bluetooth-next/c/71147d59cb23
  - [2/3] Bluetooth: btmtk: Improve BT firmware logging
    https://git.kernel.org/bluetooth/bluetooth-next/c/4a7b93f08d13
  - [3/3] Bluetooth: btmtk: Replace magic numbers with WMT packet flag enum
    https://git.kernel.org/bluetooth/bluetooth-next/c/1b737f2ef168

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


