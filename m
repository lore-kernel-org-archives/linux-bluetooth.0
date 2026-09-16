Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F54D7D4E
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583499; cv=none; b=axsUfDFU91y8e6GoWsiuyfl4Q6yn2g9rDEjjzoMC2Ve0tAudYVhcq4LL1A0dT+XBd7i/10QbthyIjf/2P2XpGl8fdoRRiKYANJGUk4V33nCZPuE7Jgs2M38k+l3hkXsw2tRLulDSvyzTE4ALhle4JtDP1N6cOknl5wXDIItGc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583499; c=relaxed/simple;
	bh=WPDbs2cwKkpWwWj+ANpVW5eJlXdGfglGlEUf+MUma2Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AsmoPMGoToIXw7eXtu9STS7V/nzWyQcLLfDT3Km1Q6PMlSW82PrqDeMC0qmnJDn8ibsLyNu0UvQXurcBaMEFgWA/J22qNVq7jt3EWTxDH2796QRaJX+erLq0w1sK/4Ctf+vRBoeJFDS61SV9wlB1R49avWeuFjK9BDhZvPBI3Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6jdAHQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6jdAHQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C5A1F00893;
	Wed, 16 Sep 2026 18:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583475;
	bh=99eQBiE1mPO2g7MQwr+DcSp3P7ai4CpfH3+i/X1MPxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M6jdAHQjOYKmsJx9KQ2uDlX5bsODi++K9KS3QFLbcQgmGcTkA1IxfOl3LGQ5HEetf
	 5JRecBH5zNnMt8gckqU2XTTgEiUmQ6QGgfwoGUiTFgxPYm1UJhCL2r2QaimJitjMkr
	 j8fnFcdaeIjAY81Ld+3AkjC/A6PDwKv7mpw/xXQGWOLVPsNI8YL9GJxoQL2vhxpDHK
	 fu/4sC8s1/6I7DwaQxGS6PXQJ7wKYEDq8l1dzBnKWDlVw10X+81li42yj9Vg628FWm
	 mKDJaQfVoK7Cq/IvA8iTrESlF0Z4HkWTCORtrwU+HRYtZDnJOWiuMjBBEnnsUV4dna
	 nFWzQrUhpnjBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198A639E8A52;
	Wed, 16 Sep 2026 18:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] doc/test-functional: Document PCIe controller
 passthrough
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178958340962.3229304.12375212460389059067.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 18:30:09 +0000
References: <20260915214410.1250646-1-luiz.dentz@gmail.com>
In-Reply-To: <20260915214410.1250646-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Sep 2026 17:44:10 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The tests needing a real controller can now use a PCIe one with --pcie
> and --force-pcie, in the same way --usb and --force-usb use an USB one.
> 
> Unlike an USB controller, which only needs its device node to be
> readable, a PCIe controller is bound to vfio-pci while a VM host uses
> it, so the tests have to be run as root and the controller has to be
> alone in its IOMMU group.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] doc/test-functional: Document PCIe controller passthrough
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1effba22606a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


