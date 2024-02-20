Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1ED13475F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456229; cv=none; b=OYpZz+yfho5Plgt3hHNpPfEo9oLbi18+T2wxzRjV9FvzQDSJxt68wiRtCR53JzAaxKg7FoRcpkaOnnJQDVysj0yt5zKwa7/49H4ZgkfsbOGdEK7GqzrIvW4oSQ0+495I+o2WxQ5tXNQyEwb5sb2dex5T8mSWOG6KDzcd7J2vUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456229; c=relaxed/simple;
	bh=B7XzCkafX7kFYHJ4bKQHNdI4x4GVsQOHxEc055709rw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gx25ZFhGKZioBs6xFyzxTkkZOAc8nbXzecHo+Ba7Nf1l4fxvRHm9hbrjx/LW3sC4OF8IoqO22RuRD7MC/GFh+sGQiqtwS9cJPEUrXxeNElG6ciIzcq1UnY31pmuoYxLgEsWhLMn1jmRCgvoVo7+jjUnNZnaHBDOPd8i1UiAWYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icAiGkao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icAiGkao"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 654A3C43394;
	Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456229;
	bh=B7XzCkafX7kFYHJ4bKQHNdI4x4GVsQOHxEc055709rw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=icAiGkao1S6emN+rXSCeogq2I9Plu6VqTUZUZKEGdXwPEr5gyc1OBaKozrTlb3/FC
	 Y+ZpZ91MHbu5bmQ8Yb1FZDg8scinmB3V0dc4yPEl2arU0agOKOfEAUu/URI0U1QvyR
	 hvkyeyI5v64Bub61a7qh4wfPC3Btb4SuHoXtJSkTK8ckzW5v7N2rtFlCZ+SCDUXmDI
	 V9rYoEp48dBrxINtKQMOIEcY/ha0gQFIxhLt3JsWEcODJzqpDmORwSf5BLtn3z/jvM
	 o/8RTUxl/YYTH9ZWU5J50HNUPtmgf4ZSelcef+o8TqXt/cuOXinTiuJqFzRNVsrOSz
	 EwKxXX9d/9Nbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49591D84BC2;
	Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170845622929.2554.5406134305914775720.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 19:10:29 +0000
References: <20240216205005.111967-1-luiz.dentz@gmail.com>
In-Reply-To: <20240216205005.111967-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Feb 2024 15:50:05 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Fixes the following trace where hci_acl_create_conn_sync attempts to
> call hci_abort_conn_sync after timeout:
> 
> BUG: KASAN: slab-use-after-free in hci_abort_conn_sync
> (net/bluetooth/hci_sync.c:5439)
> Read of size 2 at addr ffff88800322c032 by task kworker/u3:2/36
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/55a7c10e71ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


