Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A24A35
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724631; cv=none; b=SqmEf8vSq6qv81aN3AXrSxw8dUZi3XtgY8xy0cLkPkQXLqNL1KmRhS2iTeGghrEGGDoSgoY/rLweBx77S4HdL3ePe+ZGF2Wbc/3aMmyul8OtozTgB2tG17UKHopLF2dYQMsQevZcObmfqRnfsa4hv2LeCEyeAdifskkbR1Xu2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724631; c=relaxed/simple;
	bh=C8Dj5jstorT/PUlX/lrwX336YuuZfi8bs+4SZsOUXf8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qHDeopA9AHc/gkyo8gbUXvdG+l3oblWGqM9Cr4teLM506eqonXHcWylHF+AMjIN13yfdaswo2bS2yOSgVnnvbSTcIACEeWZAVzta9cRFnVMsgwmI5aVayarL9aFoigfvnfd6z3bAiPKpPcgUCSkFqatBYchU6+BLxU2he6e+ExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEnd6qJa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEnd6qJa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 451C8C4AF1C;
	Tue, 18 Jun 2024 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718724631;
	bh=C8Dj5jstorT/PUlX/lrwX336YuuZfi8bs+4SZsOUXf8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IEnd6qJaQv9uVAq9vtWZWP9gsPN/xUm0NUK7dtqwa5O8flRTHkzCIMMPw0wx1d8VF
	 57snI103YIDf9KAyL4bj3sDYZ5p6sHYWycFFwo0wqOdTTRK+gaI6GzydS+fx60BKmP
	 JZ45Y2ZRb+c5DLkmeam9ha847tT4uGOY3FIwXt1ushdjp9Hctpz9wOpH5YflgUwjR0
	 qcxmwULBRzWemOfSCusC903eQzedegJM4xQ+/VlM8nMbDAMSKNg6560RVKEkzXrO4f
	 +lQ42aBPiwRSMAB5JquxxDG/blPEqi7mSwQmsDY+QL0MLIMhS+qU68ZnLF55V2j3v6
	 9rlscXEgydVrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37142C39563;
	Tue, 18 Jun 2024 15:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Bluetooth: ISO: Check socket flag instead of hcon
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171872463122.11632.4941681596025782774.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 15:30:31 +0000
References: <20240618103324.15645-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240618103324.15645-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Jun 2024 13:33:23 +0300 you wrote:
> This fixes the following Smatch static checker warning:
> 
> net/bluetooth/iso.c:1364 iso_sock_recvmsg()
> error: we previously assumed 'pi->conn->hcon' could be null (line 1359)
> 
> net/bluetooth/iso.c
> 1347 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
> 1348                             size_t len, int flags)
> 1349 {
> 1350         struct sock *sk = sock->sk;
> 1351         struct iso_pinfo *pi = iso_pi(sk);
> 1352
> 1353         BT_DBG("sk %p", sk);
> 1354
> 1355         if (test_and_clear_bit(BT_SK_DEFER_SETUP,
>                                       &bt_sk(sk)->flags)) {
> 1356                 lock_sock(sk);
> 1357                 switch (sk->sk_state) {
> 1358                 case BT_CONNECT2:
> 1359                         if (pi->conn->hcon &&
>                                      ^^^^^^^^^^^^^^ If ->hcon is NULL
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: ISO: Check socket flag instead of hcon
    https://git.kernel.org/bluetooth/bluetooth-next/c/81e5a080450a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


