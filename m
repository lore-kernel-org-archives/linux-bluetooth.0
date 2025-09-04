Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B92D46AF;
	Thu,  4 Sep 2025 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003403; cv=none; b=ib0jfVQGUzaB7kbqjIiOCTB6cOGbvkSJYnMx3oaGM6kMYAXT/9NKmbRh4F5qFeSzsY7VA+wEoBUoZ/0A5m73wdiY8ofCefO6QqvrfIB5jsQz2hFg5icQMUyKZStUpMZR3FG28/FOynpaQT+XZ1kltI0u8LoUBDqY1YzbDAhZUxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003403; c=relaxed/simple;
	bh=Zuvvt/kT0BpDisJoUGyAuUxPhBEm/+bVuMXkanyohao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F50Bc2jq3ymPcPGVDWJFwO12gb5gzO8012sOTi+GeIrZC7XBIBkWkEMZqtqAa8K3J9gl9m792ojBf9YsIR0t2YRRhCthmGsqfmVCyJiMycaFdJQkruTQVbbfSP8N8XrJDm/sIgc3pQiwUhCf/zdZZf/G4yjMsNmXErVh8rRbOIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS7Oi+gD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS7Oi+gD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140D6C4CEF0;
	Thu,  4 Sep 2025 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003403;
	bh=Zuvvt/kT0BpDisJoUGyAuUxPhBEm/+bVuMXkanyohao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZS7Oi+gDz4ErMUUJMmlrAvyj+bj3iYWjwNzmcKBos/EMbHykQrfCe7tiLOOjAxnvz
	 V5m4aNZJxTfz5MDan+JWBm8FEyjwBzHpAXRm4WPrSPUPTMMAWxlCWtj93r5nSeZCER
	 qQSY7aZSMXUvBLZDeOIRWH78wgWcNasZrcTgLVRAJ0RklDR5RXNR9gmrXwMlmn5vPG
	 EEzmXvYTJEzEc7Uy9jNAhNds86OJ9ZXGenxMGehqe+MJAukblTiE+NIfn9FT36Fh+B
	 HwvsXXsCTy6oG+Y1jiES+VoZPeVCW0lxsaJSzFw9kQg6MTXs8eYId+wf4Kduq7ve2D
	 twNsMB43S3Jbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CBE383BF69;
	Thu,  4 Sep 2025 16:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: Fix build after header cleanup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175700340725.1874432.7709997190612844259.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 16:30:07 +0000
References: <aLhLTiIMRnjHfvOn@mozart.vkv.me>
In-Reply-To: <aLhLTiIMRnjHfvOn@mozart.vkv.me>
To: Calvin Owens <calvin@wbinvd.org>
Cc: luiz.dentz@gmail.com, pmenzel@molgen.mpg.de, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
 oe-kbuild-all@lists.linux.dev, marcel@holtmann.org, sean.wang@mediatek.com,
 linux-mediatek@lists.infradead.org, naresh.kamboju@linaro.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 3 Sep 2025 07:06:06 -0700 you wrote:
> Some Kconfig dependencies are needed after my recent cleanup, since
> the core code has its own option.
> 
> Since btmtksdio does not actually call h4_recv_buf(), move the
> definitions it uses outside the BT_HCIUART_H4 gate in hci_uart.h to
> avoid adding a dependency for btmtksdio.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: Fix build after header cleanup
    https://git.kernel.org/bluetooth/bluetooth-next/c/006c974955d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


