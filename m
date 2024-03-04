Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A36D7A738
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583027; cv=none; b=jN/w/tB1tdNmdxfJGNFOMRYifg/IoqNH9+G+ItDh18yfQk4DRZ28EbSjoqNGpiRuarG2+mObFlMTMiHZ0DZufloa1PXwBF4rPbqhURLNGq0NEXwHC0tb3inJtaeyo6IT4Ln537unkmYGumQZjivURMYMNtz0i8mVZ6EndW/UYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583027; c=relaxed/simple;
	bh=Tl0F8vnYZlZHfGNjUQKZjcY1vcbvHE55MXI2e68Bmtk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NAgEPSTl8SSmH5PGmgCd1olgUCs5DUeV3wALodRhLvxlfEuEU5ZQ5V9za/WrHCMikij4V7AlSvzbaAtOS6kjuPGyY4PDWJno3SupPhvqyLDINjpTspEhgkVCJItkPt7nKb5Wpnp9WGX8kfPvppL1FflZzpPGtV4WXARNt8gMZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5qkLVKz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5qkLVKz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A605AC433B1;
	Mon,  4 Mar 2024 20:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709583026;
	bh=Tl0F8vnYZlZHfGNjUQKZjcY1vcbvHE55MXI2e68Bmtk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f5qkLVKztFdwoy+6QlglHH7pq15FTQFEQ1jhF78iKOF/yu0cM3CLluGOyYO4/WGtm
	 fGQUF8LhtAA+nS/64pS7xHSDUZ2EVqVcoTr8lXuHtU5R2dwb0UYsyc0fu5HCYsAS5l
	 HJ4bfh8SyxlTx3uSQ6yWwdkDGpiBojfuN/9GO8lo5Wxaet44lb8R4EvXfRsMCCRgEk
	 XPQyJuN1p0TRf+/Crt7/R2JBbgbFMN1oA9aKueaEqTFNdNlV+5uhWBipUbCCbTB1aZ
	 tQ7vAY0wXhMoFClY44p7alJF9jCMwZTw49A4kpZY7OXkwJ+mUz3WE6eXg+qcWQ0rC4
	 AKvTX4/fBcwyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88AFAD88F87;
	Mon,  4 Mar 2024 20:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] build: Fix distcheck
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170958302655.15452.18312812563036978488.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 20:10:26 +0000
References: <20240304181157.3170287-1-luiz.dentz@gmail.com>
In-Reply-To: <20240304181157.3170287-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  4 Mar 2024 13:11:57 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following errors:
> 
> /usr/bin/mkdir -p '/backend'
> /usr/bin/mkdir: cannot create directory ‘/backend’: Permission denied
> make[3]: *** [Makefile:4768: install-cupsPROGRAMS] Error 1
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] build: Fix distcheck
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d5a9195a6269

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


