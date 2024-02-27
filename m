Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36CC376
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051432; cv=none; b=MVZ6x05FRwpxyLHSXDjmNmudAytN6Grv7szvNXryIxvNlA+GnQDl0140qZTCbE6fuDzFRaGgmo/Qim5EihLHNrX/IeQ/QllozAR7wwCssF96ZDJ11O3fTHhCvy9oVhSMgiL5IzMsTF6+EMiIf/jrbwBY01WOpB6UgrcIlhaiBDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051432; c=relaxed/simple;
	bh=CceMLV+yvAanCgmPu7N9BuMxZ2XQvF3oh/apzy9KMyw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P5kMQU4tv8EqR84gPFLj2RVY77rQ/VjAOv8wKs4dNQZvNvWgKL3khOqle9kNaiBOT3P4ZzUz8NrPKpenKWxYD58yqWfDb4cx9bcXJSkxx2PXhk+LlILznlmfNq7w0sjgaR04tnJZSFx2b3IQUNWYcUHPYtbnQcdGD6sfrz+yqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffKTPP4b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffKTPP4b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 524EBC43390;
	Tue, 27 Feb 2024 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709051432;
	bh=CceMLV+yvAanCgmPu7N9BuMxZ2XQvF3oh/apzy9KMyw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ffKTPP4bZV+XMNtXpa/yUF+z7zoYORLMTybxOWE4rIvEdZ1U2G7E0cGHhAsCAuNvY
	 JrhQcOHTk5oFPhQkdXayWqg6QfhtWKkADl9h2zBZYphx0fuPgvNMsnhJWPvCu614gk
	 0qZC96RB+8q3N/xnHsAToCAptRSd/TDehlUxlZnfqI5iaRoGjGDI70K8IKQXmAXIUI
	 ew0Sba/9rLdH3hasOU1Ei7RXHWIL4FMB4gWkPrLTwtO5xXeZGyZujaNlfhQ42j4Wj/
	 Zh6nF16i6RaY6qopaDizUYwxeG91SDcr8DF9bG8g3pepmvIsWApYaGMlAbO0eZN/Tp
	 PL1zObI8k050w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31829D84BC5;
	Tue, 27 Feb 2024 16:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/2] Bluetooth: hci_sync: Use address filtering when
 HCI_PA_SYNC is set
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170905143219.12854.3853401443050927923.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 16:30:32 +0000
References: <20240227151537.1884044-1-luiz.dentz@gmail.com>
In-Reply-To: <20240227151537.1884044-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Feb 2024 10:15:36 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If HCI_PA_SYNC flag is set it means there is a Periodic Advertising
> Synchronization pending, so this attempts to locate the address passed
> to HCI_OP_LE_PA_CREATE_SYNC and program it in the accept list so only
> reports with that address are processed.
> 
> [...]

Here is the summary with links:
  - [v5,1/2] Bluetooth: hci_sync: Use address filtering when HCI_PA_SYNC is set
    https://git.kernel.org/bluetooth/bluetooth-next/c/7e2b80470c5a
  - [v5,2/2] Bluetooth: hci_sync: Use QoS to determine which PHY to scan
    https://git.kernel.org/bluetooth/bluetooth-next/c/715b938b3a0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


