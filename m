Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38739E19A
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588354; cv=none; b=UicAh6fEgJH9DEq8QYqM4NK9cOh9zyQPCA32aB7Fz/Xwj1o53xk5wgY/7sCx8voKO94UsKGhXONP3KwDiFpCadcGNtH2hs82kp7rCluAPKnP5ikfUIyIV/9OQOubu7FlhVAvQOQ+Sla0zYDTPrTSU6h3pPbVFrRlFVLt4nZpSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588354; c=relaxed/simple;
	bh=dDS6z4Y078fhFxV3lFKx9VOhIMJNCqd4oMJR5QxHVWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=povCdVXVftSLKRSuQ/fNJgtgce/F+FvBxvNdbtRetML5cm8rGp6lBd2IjnHw7huTkStrIPB48ZtneHpxgqFdEj1XmutMgtGwuyIqr1t+xpdCeOw7m0eKNZ4+Gtru2GBwzLyTGtExzjvZ7yB3qOc27xeo9OpPUc6vSoWiBUw3TMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQzPLGAn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQzPLGAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3AA1F0089A;
	Thu,  4 Jun 2026 15:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588348;
	bh=HmeTsyMoR8h4C2E2TDrlEu4lKvJoXrsOQg1Kyc8i1Ls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KQzPLGAnjjFlhvRwrRRfdQE7uP+fIbq0fzN7+9xxkNEbI0dCrtrGCytx3+ulmZhcW
	 cjGyDD3bLqt7BwKgXa/qwPV//egAESbkcpCk0nhvI5T7hBAPgWN6IecGtljM56yAIH
	 kZcswEhC4x2JPwVxuV9OxB7YNy0TZkha7Xw6W5+jfkbJZikHpeaJyQtMyvd5DlD17e
	 A9HtpYfdldQQDTmc5ZTf/jiOMkReqtGomYREMla+wD7eLiTQckQQYvtXhYMcsYsbU1
	 c3N37KgqAIFSOWSegbWsqFuZr0v961jSEJG29L/8m/I1697v9SbHHjCRMIdrHWzJrc
	 4dHKEkMKeEJFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1985339309B7;
	Thu,  4 Jun 2026 15:52:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_h5: reset hci_uart::priv in the close()
 method
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178058834863.2488052.14012403254228008976.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 15:52:28 +0000
References: <4f997f21-786e-4745-80c1-0d6da94c0d48@auroraos.dev>
In-Reply-To: <4f997f21-786e-4745-80c1-0d6da94c0d48@auroraos.dev>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 1 Jun 2026 23:21:30 +0300 you wrote:
> Unlike the other HCI UART drivers, the 3-wire UART driver doesn't reset
> hci_uart::priv in its close() method -- this shouldn't pose a problem as
> all the methods in *struct* hci_uart_proto should only be called after the
> open() method that sets up hci_uart::priv properly. However, it seems wise
> to be more consistent and provide for the *struct* hci_uart_proto methods
> the same state that exists before the first open() method call (so that
> they rather crash than dereference a stale hci_uart::priv pointer)...
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_h5: reset hci_uart::priv in the close() method
    https://git.kernel.org/bluetooth/bluetooth-next/c/745b685608eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


