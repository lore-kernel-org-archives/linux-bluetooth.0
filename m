Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D2751354D;
	Fri,  4 Sep 2026 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541047; cv=none; b=ur8I0AioSegNtc98tQccFvB0cEMqGz3RSrZ75+RhTiQe+76Fbajd2w07Wri5g8Wnup/nj70n+LB2RlVFimMXEFl4V0EARLWEG62couP4Gn/OI6xXxCWXBkou4++Vlor8PSuXlbDePmRdFGltItxu994gh1Nd/77iISHCrESjhKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541047; c=relaxed/simple;
	bh=d9LE71YMOWvgwrfLXCc0TVHu4a7rCzbS5efLWgT/eVA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u7DCG74z+rqtrXgPJCW3ZYwB20JegFmeBy96ks6DQJN4O8fVLwp8n79E9f7ibiZcUeFu+l71CLRzEnvmtth/R9YoY3Xt3aHyvDQ0xaTo3m2pPg1vZqBaTX1KKTrT5xKCCKqbKuiY2RE9fGFRili04+Mo1FVULcNNBK6/iuTJE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxxpBRW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxxpBRW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B971F00A3D;
	Fri,  4 Sep 2026 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541044;
	bh=q8QHZNNoPSZ8H5EGMIMVa3JWvIiJV5t0mCimEQh3VyQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LxxpBRW2epqs5JrEKGYDfmU6ILtFkM1RUVluI2HN5DcVFXFvkBHCirBH29+wy6Pdc
	 wunJPhbD5E0Ldj0gZXX1Pbmlx67joE7zmxKDb6tZpuW62tIJMmaIgyoqpxtWbOs5qp
	 Y/HUQ8zL5qwEjeUEkY8elmF3h2tKpNepjfEFqLZpT5cRQC5qT+AHCd8+7ahl7ONVSH
	 6M9K1N/EO+JWBnBXa/LCs8rntLm0kPLdYtbmzuIRHpDJDajd7BdHMNasUdEkhF/69F
	 9uSokXS5ihbfX1MAkK1zPKFjeg6ZDY/9RXfKx0moKKvoO9zgsN0TshMvVZIT4V/IN4
	 6gb22v4CFJo3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398B3924A50;
	Fri,  4 Sep 2026 16:56:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sysfs: Fix NULL pointer dereference in
 device_del()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178854098513.344939.1951546712000714507.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 16:56:25 +0000
References: <388cbac3-b865-4843-bd65-c74059a5a459@mail.kernel.org>
In-Reply-To: <388cbac3-b865-4843-bd65-c74059a5a459@mail.kernel.org>
To: syzbot <syzbot@kernel.org>
Cc: syzkaller-bugs@googlegroups.com, krystianmkaniewski@gmail.com,
 linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org,
 dmantipov@yandex.ru, linux-kernel@vger.kernel.org, syzbot@lists.linux.dev

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Sep 2026 12:24:22 +0000 (UTC) you wrote:
> From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
> 
> A NULL pointer dereference in klist_put() occurs when a child device (such
> as a BNEP network device in bnep_session) is concurrently being
> unregistered while hci_conn_del_sysfs() reparents child devices.
> 
> This is caused by a race condition between hci_conn_del_sysfs() and
> concurrent child device unregistration (e.g. bnep_session calling
> unregister_netdev()). During device unregistration, device_del() snapshots
> a non-NULL parent pointer. Concurrently, hci_conn_del_sysfs() finds the
> child device using device_find_any_child() and calls device_move() to
> reparent it to NULL, which removes the node from its parent's klist and
> clears knode_parent. Subsequently, device_del() calls
> klist_del(&dev->p->knode_parent) using the stale parent snapshot, causing
> klist_put() to dereference knode_klist(n)->put on an already removed node,
> resulting in a NULL pointer dereference.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sysfs: Fix NULL pointer dereference in device_del()
    https://git.kernel.org/bluetooth/bluetooth-next/c/21c3501e5f46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


