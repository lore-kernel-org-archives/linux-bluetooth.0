Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321563D6CB0;
	Wed,  7 Oct 2026 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394213; cv=none; b=J7SdcKpc2QaS3M0ctTvLwZF5xlMyMB0xeOwW2o776FG7ivIRHRk93bteDKBkNDJFkDZypCLq9S+E4aVB5eLIT+a0dU+sWAxO7Yl0g5VpOB+Yj1HxOTxuJgQRLmd5Jysqi6y/zXffxhQ0qcb5xQ/IdiMh+SOWcBt7vm7km923IPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394213; c=relaxed/simple;
	bh=lC+3bXKXP6F5ZODHpD6nuczeZYNvkWuuXSsM/3UvGHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=teWlc9AfQra6RujCz8fUL9JsXU/NFHTCN3dB8udwK42qgykakQYW0rv/pzXI+3LIhx4vmyRtUZ/DyGA3QUGh1QjrVyFmAgH7VJruf34m4wBUTZvS95Ew3ezhp7TZjSZ289skPBVIsHhvcGhWiZ9b7Lz524VuVwo1oZRP/xsVVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rbpp3+m+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rbpp3+m+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBA41F00898;
	Wed,  7 Oct 2026 17:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791394210;
	bh=g3a9uCZo5YTeEEmUHku8N1lhDSF+nlU+lG2U14JPonI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rbpp3+m+YOAUNNrwXdmuYUIY4NCDGRrNL9iUf+BCNGF4sdD0uSwTPZwMI9stE4tll
	 SzKz2zXR8UTS/OlcAyZklbJ9kbiu00QS0KdqWjZINiNwUu3zbzpAaJJSzlr4bGlYLR
	 c9fDGoB0pMqtx5TtY9B9D9PvhfOWked8QhRXTlGLXHm60S6HkbEC+VVNgNY6GoJ+h1
	 8vc0rRZ6buojh7YJN9IXt0ehhfLPZL483iy+8Gh3/qeTUbF8tAUG1HIMh88816I82q
	 e1GOTuA7S7pDtF09NJQkydfXgbJccE/TIcysQC/Ky7l6L+Zpm0QMTSeU6H/WUGXNt5
	 AT4ZIRghj8qfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B442A3808209;
	Wed,  7 Oct 2026 17:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: Hold the listener during disconnect
 notification
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179139420927.3628206.651102883424358739.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 17:30:09 +0000
References: 
 <pm-bluetooth-objects-candidate-0210-v3-42a02e0ef5261660c606@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0210-v3-42a02e0ef5261660c606@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Oct 2026 22:45:53 +0800 you wrote:
> An ISO listener must remain alive until a queued child's disconnect
> notification completes. bt_accept_enqueue() retains only the child and
> stores a raw parent pointer; iso_conn_ready() drops its temporary
> listener reference after setup. iso_chan_del() saves that pointer,
> unlinks the child and then calls parent->sk_data_ready() without holding
> a listener reference.
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: Hold the listener during disconnect notification
    https://git.kernel.org/bluetooth/bluetooth-next/c/e70dbd361a5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


