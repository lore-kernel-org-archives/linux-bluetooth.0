Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDBA1B151D
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737636; cv=none; b=IZ82SFeupMBVf86mjI1X6TuKzY8YCdUUnGt3z5QIQow20xX3KGLBRY+I/YIYOq3XqH3WJPtSNXzxokmO4WJwBom/N4ee8b5zyhpU5CPwN5e7welV3TNCHRrreEtotSP6UvG9aV/SajeFZX1028ILGCt7Rr0LS9iVS1RXUm+HdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737636; c=relaxed/simple;
	bh=ObPF5Yy7vIlC4P/szrX51HoyYImKzZ27HaK18Mz44tM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VX50CQpMSkoeqwL3VVZ5JGLyc8rXwRBpuSegG/1WDX2dDpRDOJiYicKbymPDiypuiPgjOoZwZrjkOgEJadnoOr9OjHW8og1Pk1J5xPDfrJ0J2LFYbn5fvLkk3X1S0ECMuhCQo50Bu36OJ6fJdIypOjTKlGRC+BUtOHbx1k0k5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLyt6c4S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLyt6c4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B757BC4AF0D;
	Thu, 15 Aug 2024 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723737635;
	bh=ObPF5Yy7vIlC4P/szrX51HoyYImKzZ27HaK18Mz44tM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MLyt6c4SXFbsmiUyNAULNrHHT0FzYSb2qKKUsbTmhJrvD5nmJG5CkZhubP7nJbatG
	 zXsKIra8cWtz9nncZCHWLcWvUYqUNMhYu2u498Y998g0SgBMq5ps8gh39dkncZRQYh
	 7llwwgMY4yFkeiHv5RVVh3qQa4Gpdezzo+KSa160F9uiQX5fZSZDdhkXLP8NsLF7IK
	 dSjaA/DUY8kroj2I4xrPx4ifmruGBosnpHgSgFqRDZgfsU88Hz1ytYjfPPt/mBKDZt
	 xAjlJdkvegZhISo8AvHW1YIlHAZDZC17MXJpdRw76i3S3SEFoZc8iMsss6TwEIj2LY
	 pFJtMwsrqZ4pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AD1382327A;
	Thu, 15 Aug 2024 16:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_core: Fix LE quote calculation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172373763498.2896787.1274011083309783693.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 16:00:34 +0000
References: <20240812153219.290388-1-luiz.dentz@gmail.com>
In-Reply-To: <20240812153219.290388-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 12 Aug 2024 11:32:19 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Function hci_sched_le needs to update the respective counter variable
> inplace other the likes of hci_quote_sent would attempt to use the
> possible outdated value of conn->{le_cnt,acl_cnt}.
> 
> Link: https://github.com/bluez/bluez/issues/915
> Fixes: 73d80deb7bdf ("Bluetooth: prioritizing data over HCI")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_core: Fix LE quote calculation
    https://git.kernel.org/bluetooth/bluetooth-next/c/a8d17a97ecfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


