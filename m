Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334942CB1A;
	Mon, 27 Jul 2026 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172244; cv=none; b=How4u16Hw3K3f0ebanf9fKAfuuBVgVM4gDnGKSNgHyxpT4tj8AnnAg10OT3hZYzScNmlY+FlRvEdNROHxWfL6wDb4h8HzDhbyNGce6qL3tVC1P+IvtdQI4Dn5SlKEpEcZpVIvGxMRuEALEIi9UvaTLMvN9oQ9c3x3KGllqmFma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172244; c=relaxed/simple;
	bh=OQMfLGyb6yhnigbV9SWxnwERYE+nwkuFQCSiD9AEZQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ddDNncGvT7AOWhLXZMFFwJqJhWP7vDGY9QKJ2kBZnj/9qWOAOlfmMt0zRcv1OkUikFQTp0KSbb+XoDXyuRAg+NgutMda6Cz+0n8rc2pZuWQyymek/H2bpXkpLV2d1czes5zJV0zWJDQOiH3rq0GWkcI75IwjMt52O5bVRSEnYiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaZjMbhl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaZjMbhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFDD1F000E9;
	Mon, 27 Jul 2026 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172241;
	bh=XXc6Y/EovuIvT+Xd8Dne+L7NYtSUiDzCOxwDIcCIK3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FaZjMbhlsBkBYVzDHbVyqfZnbLhGFSM6M2RgasOGyQ4VokSSHu0FKCVvWSLPP842Z
	 Kmv5XVyrH8/BN9HFfpEbrCVBImZGwUZkj5LmToIPNDI9XFLae3duhmCBBlOkXvO0ZI
	 nCtKrKVkHOp75/bVLoEeD2bINBPaJr5rd+ety/2V2R5L/XRPKRAqR+WX3UFVSYPJES
	 nVR3py6A4B/Wt+SwcElJOIE67sXZOAjdI+ooxOupGpl7DQb3EHxWaEsjGrvMKjKbyJ
	 GFEE4gaiZb0TKgxDAhG83cY9zYjEDDBB3m6JGP7dherR2iO8PKzLhFfs1YDWfeVfmJ
	 L9+O4Gf4Gm+SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD1380AA4A;
	Mon, 27 Jul 2026 17:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/11] Bluetooth: ISO: fix HUP on socket release/shutdown
 +
 UAF/locking fixes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178517220714.1331160.9121301750263866259.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 17:10:07 +0000
References: <cover.1784923689.git.pav@iki.fi>
In-Reply-To: <cover.1784923689.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Jul 2026 23:20:23 +0300 you wrote:
> The retracted patch in commit e824c0bbe0ec9 ("Bluetooth: ISO: clear
> iso_data always when detaching conn from hcon") merged in
> bluetooth-next/master broke ISO socket transition to BT_CLOSED so they
> don't send POLLHUP properly any more, as seen in "ISO Disconnect -
> Success" test.
> 
> This is rebased version of and supercedes
> https://lore.kernel.org/linux-bluetooth/fbd9dd573bb1ce5f38370128dd35447e2ddfed9c.1784625576.git.pav@iki.fi/
> 
> [...]

Here is the summary with links:
  - [01/11] Bluetooth: ISO: fix CONNECTED -> CLOSED transition on shutdown/release
    https://git.kernel.org/bluetooth/bluetooth-next/c/278aeca60782
  - [02/11] Bluetooth: ISO: lock sk in iso_sock_getname
    https://git.kernel.org/bluetooth/bluetooth-next/c/6d16b799d7f4
  - [03/11] Bluetooth: ISO: lock sk in iso_connect_ind
    https://git.kernel.org/bluetooth/bluetooth-next/c/df810355bbe7
  - [04/11] Bluetooth: ISO: fix timeout vs sync_timeout typo in check_bcast_qos
    https://git.kernel.org/bluetooth/bluetooth-next/c/c08593655456
  - [05/11] Bluetooth: ISO: validate sockaddr_iso first in iso_sock_rebind_bis()
    https://git.kernel.org/bluetooth/bluetooth-next/c/126e8f096c10
  - [06/11] Bluetooth: ISO: hold sk properly in iso_conn_ready
    https://git.kernel.org/bluetooth/bluetooth-next/c/deb1d93a07f0
  - [07/11] Bluetooth: ISO: fix leaking sk after socket release
    https://git.kernel.org/bluetooth/bluetooth-next/c/2a93966653a9
  - [08/11] Bluetooth: ISO: avoid deadlocks in iso_sock_timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/f8cb802462f5
  - [09/11] Bluetooth: ISO: ensure no dangling hcon references in iso_conn
    https://git.kernel.org/bluetooth/bluetooth-next/c/f80c3b2232a2
  - [10/11] Bluetooth: ISO: fix refcounting of iso_conn
    https://git.kernel.org/bluetooth/bluetooth-next/c/e4d507fb7f6e
  - [11/11] Bluetooth: ISO: fix race of kfree vs kref_get_unless_zero
    https://git.kernel.org/bluetooth/bluetooth-next/c/4b56754e9da3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


