Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC62C853
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921432; cv=none; b=Ql2DYtHUlmYOeTF3fFvr1D8DwH6SHi/cDobKzMpIKPTn4Kn3mTSS0VKvRTVwShj1/Yrd1YqE8heMgWNSn6kGL8mj+tvIRIjd2lZt+kTmQ97gRSAd8RRuBcrEMUREm9LGC6uAaY1HPK6KHUCGHLNdh9Gyit25EuPtL4BnKBKBdZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921432; c=relaxed/simple;
	bh=1oZBTxYK8k9WkotZ24r+DoS17Y5ka8pouUhfCfSeJJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rQ3d7Gun8pCUwrkOaBJIcLPvyMI6q6G+z0sJZoOdLs0HJHq2ptosyJUnxqO/GvVgiapuIeiKq7HH7rNkNe0NMt2f4EWzSxFtJgO84EsH3HI6El84Kxee23OEL7WWl54nrQNYDLp2zgD5e4SNnhXco/9d9L5UeejHEuUitrmdPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmCQ4amr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmCQ4amr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FF0DC433C7;
	Fri,  8 Mar 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709921431;
	bh=1oZBTxYK8k9WkotZ24r+DoS17Y5ka8pouUhfCfSeJJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XmCQ4amrfw48T0cYLbOnIoapcBeNV3cIhxmCJ2IcEmowcOWW5gec6v6+1/yP4avk6
	 ukYsNFCx1IsxhouHoTnEJy6WoCBNpGNFqjutQGcA2am490l0ThpbH4XewSEyPPU5QT
	 sw3J5n1k59gPtcOkYjBW4uh93PUTkdkWd3HSLNrFc27suHnSc8bpmNRKSzJIL6vnYV
	 57caD0BMRTTyO9KLagE7gpGukMObtgVW3raeWjWVbRj5f3JdYL7GKMwiRncpcnbkjV
	 0cL1RrcmUu215vfsg1uQ5KEMrV30PQ0oXkJ0qm2ASbjsWuwTzdPujuz/y7Io85RMSh
	 Fv8DKJItVPCqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55DDCC39562;
	Fri,  8 Mar 2024 18:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix UAF in hci_acl_create_conn_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170992143133.27893.2467618992971339722.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 18:10:31 +0000
References: <20240308160715.88478-1-luiz.dentz@gmail.com>
In-Reply-To: <20240308160715.88478-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  8 Mar 2024 11:07:15 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following error caused by hci_conn being freed while
> hcy_acl_create_conn_sync is pending:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in hci_acl_create_conn_sync+0xa7/0x2e0
> Write of size 2 at addr ffff888002ae0036 by task kworker/u3:0/848
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Fix UAF in hci_acl_create_conn_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/3d1c16e920c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


