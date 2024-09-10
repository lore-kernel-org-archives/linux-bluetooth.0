Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E945A1A255D
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985828; cv=none; b=h6l7Es1SVCkNSDrn71Z1/fl50RyIYrf7Tt6AWkbi+2LIk7GgLHlzDt1zrtn5+R0VzPpyt4D6xwMRaRuQK2qRgcII2OyOgvD2d+nNFf8HzWKlrzR1jFkRx/dgplXe4b4PcOmwfciZBikoOgyzC9td1t5sXdj+y/3ZhBNaRPLkgMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985828; c=relaxed/simple;
	bh=cUmj5B244/DXU1+re4VrJpq7v30MGqtEXmcNgHcljfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IzqRvTlB6WBCdrparOF38FzXJeVo1xtP4jJ5nbql6H5iijiT4UOHkmDu7ZXKs9a1IuLHlVqE3OoXWXsKS0NRkyl0/YvsLGX+svmVN8tRzYN1x8C+wHzyUUVd8B2XajIgMSJpDzhBDHelIdDMFmfLD2id507H68sbCKcxpNZRBNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+ZwQOev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+ZwQOev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AB2C4CEC3;
	Tue, 10 Sep 2024 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725985827;
	bh=cUmj5B244/DXU1+re4VrJpq7v30MGqtEXmcNgHcljfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g+ZwQOev2JXfjTOGDpoM7Q9r7gAtL5TpunYCwuuTkfc3Ex8rCXfrDsl/BcMliUWyg
	 nS/VOdt43NB5KWSvqvhjQM7ZzmPJi8gqmNkAlCq/xfs4R0C6VZGkoK2Tu4M8BhoVcs
	 uBfYyr56V6h1uTcRuoLjVFumk4nhzHLJS6QLinQTo/XRq4JliNlWypvyUhrSiIr7Gx
	 1BOAFvYocPRyYYn20qNZe2tloDZAI1AebO4nmMABsA/JxuadPb0teRqR3D6lzkR/bR
	 pfcgkcmvjhTKfp2sR80dfrhDE3SV9CBVh70I/mgqw3aNhuz9blqlK5M8PmcoFeqael
	 1TcsCy2E4RwVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEB9C3804CAB;
	Tue, 10 Sep 2024 16:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND v1] Bluetooth: hci_sync: Ignore errors from
 HCI_OP_REMOTE_NAME_REQ_CANCEL
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172598582854.314676.7315791449613970873.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 16:30:28 +0000
References: <20240909194443.2387703-1-luiz.dentz@gmail.com>
In-Reply-To: <20240909194443.2387703-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Sep 2024 15:44:43 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This ignores errors from HCI_OP_REMOTE_NAME_REQ_CANCEL since it
> shouldn't interfere with the stopping of discovery and in certain
> conditions it seems to be failing.
> 
> Link: https://github.com/bluez/bluez/issues/575
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,v1] Bluetooth: hci_sync: Ignore errors from HCI_OP_REMOTE_NAME_REQ_CANCEL
    https://git.kernel.org/bluetooth/bluetooth-next/c/fd8c0f820825

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


