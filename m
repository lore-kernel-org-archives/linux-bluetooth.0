Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249BF221D96
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 May 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746718190; cv=none; b=nmTRY1a/sxsEeR4IfpbcF9oJHiHBbo7qFOjQlBS76mIwbRmNKnNF426SnY3hzRDydlBUElQWQh3JE6ZMtl1IMHbcPsplEinKnUyaHL4lf2+ya/CU44yLXSinhqzVsUbVeSnzOL+c/hngXA4W7VHAlAM+qYmAapzqgEtkB+RdRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746718190; c=relaxed/simple;
	bh=14EnEVfnPUQF5MXzb+RIq6nYYBGNpg9384HCBQFwg4o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kvK2L6bSx4c6mHqEbbIYG8fPzQpXNM8uHOTgaz+9CG0v1RcUqEpho0Ij0wFA80CKoIjuH1DentLCmwMgTKrLa5j4AHwuBeqPLGFC6PISrlcjI2/cdUfpIIN7aPjRKOqF4jjnRCk0534XpolyeRbiXQ6X4JxCsasGrTixcFt1BA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DL/f8vBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL/f8vBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9039CC4CEE7;
	Thu,  8 May 2025 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746718189;
	bh=14EnEVfnPUQF5MXzb+RIq6nYYBGNpg9384HCBQFwg4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DL/f8vBmFLEM0Axg/XVqYtBv9j3pr9Weh41urZ6F9JEZ6Tw3QjxjuxSwwO6sF827V
	 2tywCyLD8xPkV73rWauS4k0NSFkTfqJtq4m83Jjee3tL9kNvQaTE6gRe/QQd3gm1N+
	 DBHdG3sIAlKra145lRQ1Fh42mjOnBzeSlqZ6z0635SnBCTsmVfuv6I0kO3dkE0hNkr
	 G0kduYT98wz2BQj7sThfDcNdB4VNiXSV3uuothUZss7ZwLdRuVoP3HWo62boic/z1H
	 u1Nij/xFyQQmBza6J+hSvnRpBIs62tb7SIhLf2l/NjBf8BVN1Rl6nCYP4dhmjY3X5b
	 Ci8Z1WISYe/tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EAE380AA70;
	Thu,  8 May 2025 15:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Fix not checking l2cap_chan security
 level
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174671822825.2952624.10226149383702580135.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 15:30:28 +0000
References: <20250507190533.289009-1-luiz.dentz@gmail.com>
In-Reply-To: <20250507190533.289009-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  7 May 2025 15:05:33 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> l2cap_check_enc_key_size shall check the security level of the
> l2cap_chan rather than the hci_conn since for incoming connection
> request that may be different as hci_conn may already been
> encrypted using a different security level.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: L2CAP: Fix not checking l2cap_chan security level
    https://git.kernel.org/bluetooth/bluetooth-next/c/18f5b2456b36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


