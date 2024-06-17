Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1145BFC;
	Mon, 17 Jun 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650832; cv=none; b=utaPViwo7oCwT86CRUAwohitepqCdmJv9CD6PquTCTQMCdfAf3cVXqo3z05GRPqhizVDHKOSNx6EYE+pDFl7reLPe8hZhEGjtUYoCU7sCb9P2YTbLzHVLUrSnVh969biCn8A9MywDkUu+9rYFEzraJLJnbJI2mn1QyiwfV5RRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650832; c=relaxed/simple;
	bh=+V9dLynZgNUnHD29CYXC/VTC7zbvQ5KtTtJ1VKlnPzU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lAGCBsOtiT3PJzWAd1ZEyzS1iqC9Rq7zpcQThS2i4XnxzK42lv2NSgoKzddcpMD50S0RRlL18M8+aPgvqI6IjHtdBXnFDJ75tgaHsGBqTK7CukOdPcvbB9fyk3WHOnZm0jLrXXlpeOxqt9D5w4IorPyNojd+HdXwaGXzHRC2EeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov/NzuBh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov/NzuBh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB5A0C4AF1A;
	Mon, 17 Jun 2024 19:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718650831;
	bh=+V9dLynZgNUnHD29CYXC/VTC7zbvQ5KtTtJ1VKlnPzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ov/NzuBhsznNtFpyT6jv+/LuaVOzz2TjcuqA82tp5WlSKt3nhA9/ClJn99G51FJgT
	 2IdbjZpQPDCAhT/co+A9CGq03cd6P+PMbVbULCRvYsx0YftESSsiQnXhIiirIJMuR0
	 1a5lYRBjIM5hP0kmxvK32QE2jLTx7N6GH8TACuo9nIykfWDHC0FxyUuAOloyL8vDdT
	 eKnLD3ERB3bak1CjQ+VUDQeuhitqKVVoKCCDR6OJsprlcjOztP/szAmzD7oZJHoelz
	 3dEFHLElN5Qx/lzOMCh2KajYL13FaFETxdqAAu5NghklVi91340xhMftwCds/SzVd6
	 cMgrzIOczjyzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9657BC4167D;
	Mon, 17 Jun 2024 19:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bluetooth/l2cap: sync sock recv cb and release
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171865083161.26480.1965815963898794689.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jun 2024 19:00:31 +0000
References: <tencent_8D9918CF808DC6A5FF8DCB12055DECDDF107@qq.com>
In-Reply-To: <tencent_8D9918CF808DC6A5FF8DCB12055DECDDF107@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcel@holtmann.org, syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 15 Jun 2024 09:45:54 +0800 you wrote:
> The problem occurs between the system call to close the sock and hci_rx_work,
> where the former releases the sock and the latter accesses it without lock protection.
> 
>            CPU0                       CPU1
>            ----                       ----
>            sock_close                 hci_rx_work
> 	   l2cap_sock_release         hci_acldata_packet
> 	   l2cap_sock_kill            l2cap_recv_frame
> 	   sk_free                    l2cap_conless_channel
> 	                              l2cap_sock_recv_cb
> 
> [...]

Here is the summary with links:
  - [v2] bluetooth/l2cap: sync sock recv cb and release
    https://git.kernel.org/bluetooth/bluetooth-next/c/e3203b177717

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


