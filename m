Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0AF3FF883;
	Tue, 11 Aug 2026 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479075; cv=none; b=sJMWFhk94RPV47zpOA9lpUlRszwew17Gvk1Sa3KCnCL44j8NMCYFFEGJHr9ZecZUfDdaZQWH+35SgcKxrzOIIqyi8owZqLsXBZsYctUXpFoTbRHX0xRC5DHC7vF08SqjliBnAj/wwMo0lf4LdAoBNtJwgqFE3ylMhl6vMUUER+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479075; c=relaxed/simple;
	bh=x64gloiAdoYu2d/YMLr+ivzS0ZddFEaUeAUJyG3Os2I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OxmtytNIbggHpacqw97c0A8IwHSxq70z0i4ocr5Z3kqO5RcPsf8jTUTaNVjDszqoAziZqylnV3OhF+pIQEfo2285yDYmTdnC0yKRK+Vh2ZJSeO9LW4fAiP2u9eIt53ZGjFQ0jEheNqYK2rCjomtglIU6ax1AiWOya6pyfkGwczE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/HuqweP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/HuqweP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ACF1F00AC4;
	Tue, 11 Aug 2026 20:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479068;
	bh=6kRSGTVjaMqAeA1CrWXc07ZqIlKAlbNtsMo5Pfs16s0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C/HuqweP6ZeEH8K9FhJY3oBe0A9nibvJnXM+ll3YbVJLB4jdWIxERaC6Nzc2hQxmj
	 9cEvV+QmHVL6iGwjAgdjYcG1oMMF7NwmNo/Ilklz/Fdh8s62nAlzar+YkrOPfZRKkP
	 gjFs+PpCc8Op1S9Mh3wb+xkbVmpWmcFmofl3GeGaVtLpAXNG9avJkuBOWl4O0+Wdv5
	 Fhwi3bXTVb5InF/6nAKLx3y5TRMXQA/Cu9r/XNTE/bpAI4u2AbiZeYkJMrdKltKh0j
	 r/XEJi9fhbd9JpHc831Ke4S9OKMv1IGRZywjfZV/fqDYOSYsCaJKRLOaAOI2qg3kTn
	 bzSo4IaoKofPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09663809A0A;
	Tue, 11 Aug 2026 20:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen()
 vs.
 put_chan
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647902444.1134064.3239306935930173291.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:24 +0000
References: 
 <95cf567c0e78b0ded9a555da052b4ea9b91aacce.1786179819.git.pav@iki.fi>
In-Reply-To: 
 <95cf567c0e78b0ded9a555da052b4ea9b91aacce.1786179819.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, oss@fourdim.xyz, linux-kernel@vger.kernel.org,
 hdanton@sina.com, syzbot+e6382a2f53f5fc7453ac@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  8 Aug 2026 12:08:45 +0300 you wrote:
> For L2CAP sockets without owning sk->sk_socket, reading
> l2cap_pi(sk)->chan may race against concurrent l2cap_sock_kill() ->
> l2cap_sock_put_chan().  This excludes simultaneous proto_ops callbacks,
> but access in l2cap_sock_cleanup_listen() has unsafe lockless read.
> 
>  [Task 1]                         [Task 2 (hdev->workqueue)]
>  l2cap_sock_release(parent)       l2cap_disconn_cfm
>    l2cap_sock_cleanup_listen        l2cap_conn_del
>      bt_accept_dequeue                l2cap_chan_del
>        lock_sock(sk)                    l2cap_sock_teardown_cb
>        bt_accept_unlink
>          bt_sk(sk)->parent = NULL
>        release_sock(sk) ----------------> lock_sock(sk)
>                                           parent = /* NULL */
>      lock_sock(sk) <--------------------- release_sock(sk)
>                                           sock_set_flag(sk, SOCK_ZAPPED)
>                                       l2cap_sock_close_cb
>                                         l2cap_sock_kill(sk)
>                                           l2cap_sock_put_chan
>      chan = READ l2cap_pi(sk)->chan         l2cap_pi(sk)->chan = NULL
>      l2cap_chan_hold_unless_zero            l2cap_put_chan(chan)
>        kref_get_unless_zero(&chan->ref)
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan
    https://git.kernel.org/bluetooth/bluetooth-next/c/d67f4a43e7ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


