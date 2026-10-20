Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520408;
	b=l+76qwc+L0KHPTdndV9xFU7lELxlijMerLhU2PHSoTFa4bkP3vINQ7WkJDAsQejPmKs8
	 +rh/xMwb07HWCEuGmDFCmacMD1dRRp8VVw0yY1cgNp/UTMi/ZApT6Mvvw2yrn9etjB+VY
	 w8nG3VEMftPgSubaFM3MDZKO83+mNmz1kEA7s53My5C08i1ziMnr2BxEEhgX0h34FdfOT
	 reEpRi8va+pT55YSSNcp5lC3kDN9jfOkljChgHf2IOjdovscOFIiZqx2GaFD4CVw3klcM
	 THdCQ/LBnDtvYNrxCcEFHRF9/KZ6emooe2Sp6uG2KxY4j7ECkXmk+elOkalNBoG9IGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=0+LyitfbSOxoXNDkVYrpuyKuX8hddf1JHZLWeIHdIzU=;
	b=k49v8KKsh7LFURk2tsrghU4QNaZHv8MUxybg6l/R7TOcCufLbXDXIKf4qm/srwl5UQ33
	 +WqrwpvustC/b5LfhY5r/bIRjRPgR3OvUkppPcY3qWr3Q26/KohpXPsMcg2ETpZZT0f0a
	 8jW661KsRQH2rRX7+qM3q94sHi1wltdySWOm5hcoZtEHYOICeDjwH1KWcAov2jK2CAyny
	 N/CBmthl4xLSDnxZxCRv5eFuUAybpBY53OzQ//15FwWjXc1Z5pBbLrdl+7jaxsyc3fKKm
	 ayrAXwWhfXPJw8JF2V7spcO5iJPew7HEAmhOG+It9Z2KZBSjFDCPwMjUiOHhxml+iCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zr9gFTDC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F4606A319;
	Tue, 20 Oct 2026 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zr9gFTDC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0607D1F000CB;
	Tue, 20 Oct 2026 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792520408;
	bh=0+LyitfbSOxoXNDkVYrpuyKuX8hddf1JHZLWeIHdIzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Zr9gFTDCGpt1yU8pzuM3evWBynn0q60y01S4KBzXrBqa+PsYt3UqgemrjiNyRr0/D
	 LX/N/3OFI88CCwWj/sSJ8B2wfQzczA3c1io9btAkSZUPPKKYJ/9dqShZNkj/exzLK8
	 vklgOoRPkOB/BRrmt/zU842M+ZFim0WyqEz6Wvmb5gLp6wEE2iIbr8zRO6jlM+V9Qa
	 8iSgXzdJX9wNC40KxgolOqdeDzAQcvuWK38rv8DWte5C4Pw9VXhVekUdhjP66FMwAI
	 gzJNqeBpvJcN4HrFZxX3sm75Ckt8CfL5wDugXRZqsAthTvDu2Pr/VYCvYSWYHzdY5R
	 XSJJM0oEdfuBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15A73808209;
	Tue, 20 Oct 2026 18:20:07 +0000 (UTC)
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
Subject: Re: [PATCH bluetooth v1] Bluetooth: hci_core: Initialize link key
 before
 publication
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179252040678.143064.16490854409353371253.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 18:20:06 +0000
References: <20261019081711.479294-1-18983559317@163.com>
In-Reply-To: <20261019081711.479294-1-18983559317@163.com>
To: Binbin Deng <18983559317@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Oct 2026 16:17:11 +0800 you wrote:
> hci_add_link_key() allocates a new link key with kzalloc(), inserts it into
> hdev->link_keys with list_add_rcu(), and only then initializes its address,
> value, type, and PIN length.  RCU readers such as hci_find_link_key()
> and the debugfs link_keys_show() do not take hci_dev_lock, so they can
> traverse the new entry during that initialization window and observe
> a zero or partially initialized key.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_core: Initialize link key before publication
    https://git.kernel.org/bluetooth/bluetooth-next/c/153c30aec42d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


