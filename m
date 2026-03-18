Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF73D649D;
	Wed, 18 Mar 2026 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852015; cv=none; b=oxNcGVYbwQvnqrMN/xsIMVSeoX4ly00trMe/yI74sbMCZJIq4qhVhLpIos5T4pLeTae1YIRqDgaB7ouzMKJTjCQze/Y/PmjFw4z7IQHageyQVZeSQrPLNo+55b+aU/BmdMRIrcBnBnaOzwCW4pdanzj0rnfd5oOKvO5rFLLGYwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852015; c=relaxed/simple;
	bh=JnblhXT1CQFT9MQc5MthhwWEzIrXdSrZyGeNZkgJwEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P8clyqHRAjlefmb1j4L6GU5e34hY8RZy0oMMLarBrwgGJ+KI7E/ZgELeoigtW3e3ZetH7WVuYGPm9l+jGrC5B7+cHmBspbU0nllqvFnkZXa9JexCQijm8QHiv/l8Qqg/wDqTRYoD9oCIA4+FBsDDkkY5AWv/h3Hv2WvGQngyyhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5iEbH5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5iEbH5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E072CC4AF0B;
	Wed, 18 Mar 2026 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773852014;
	bh=JnblhXT1CQFT9MQc5MthhwWEzIrXdSrZyGeNZkgJwEk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n5iEbH5WG0MD0ncfPb5DgA6zraO9Q148gmNps1SW9vXexVmK+xy5+b/3uQk+aBdp8
	 JShRavoNyt9JBcfUtztOHolBjexZncw7g520DCRLvtMRqikiTrpCnm5Q8nNqkxxBwS
	 jwtHF6Yz5x95rUmyIzOsTMSpranPaX31BPoDoR3qd520dGAj7l1q9fq70KQuEbqdG/
	 7q+Oc6jql1NPrmFmY2Tm7VPNs5pchuUxbLIDghuzf5d/FGjl06XHhRfDreqMiNxDXf
	 Q7j5YQL81P/4iUHQmKUMUinXZ29FnYuuJFRU+gE8jE4qC4APSDzrubVBwtBWDennWF
	 hG6/LRw70U0YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F3B3808200;
	Wed, 18 Mar 2026 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: annotate data-races around
 hdev->req_status
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177385200653.385489.11487531736969413011.git-patchwork-notify@kernel.org>
Date: Wed, 18 Mar 2026 16:40:06 +0000
References: <20260315120726.2772382-1-zzzccc427@gmail.com>
In-Reply-To: <20260315120726.2772382-1-zzzccc427@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: luiz.dentz@gmail.com, johan.hedberg@gmail.com, marcel@holtmann.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 baijiaju1990@gmail.com, r33s3n6@gmail.com, gality369@gmail.com,
 zhenghaoran154@gmail.com, hanguidong02@gmail.com, ziyuzhang201@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 15 Mar 2026 20:07:26 +0800 you wrote:
> __hci_cmd_sync_sk() sets hdev->req_status under hdev->req_lock:
> 
>     hdev->req_status = HCI_REQ_PEND;
> 
> However, several other functions read or write hdev->req_status without
> holding any lock:
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: annotate data-races around hdev->req_status
    https://git.kernel.org/bluetooth/bluetooth-next/c/9adcc51be549

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


