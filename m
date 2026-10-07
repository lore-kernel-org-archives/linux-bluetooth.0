Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F074D37DA;
	Wed,  7 Oct 2026 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394220; cv=none; b=DaJWX7buEPA+dfI17q1y/LPlW+Ee+KnpDIWvecIzIs/N9kReY0MHWStqC/ZtNqGKLkJ64ATBaSBr6SVdJOo/ntVovT0NGy6S3FOusKUYg6rwLkJE7j6McNG1pcd0UivBX6aGe+g4CazobAyas6BCGrGTcW2PNBBYe44Hkfdqh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394220; c=relaxed/simple;
	bh=cOuYC0iAlwrxg58qiEU+GSsZWdTm6rgYHLoqIjNILs0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GFOnEEjjAGoVKrV+BCHI0qd8a5I0vp1ZAKjPzTKtxVhQ4s//wNo9wzWojkifqnhefLmjp8n8Xq6YY+1jjow9T0K3JO/1GW8aJTNo+0v+FpP0kW0S+Ew+2im6fmBdW8D9cS39jj9RMdFQanZvHv6ZyA+X8wEru/XXYVTWSBim7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYPW/Cs8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYPW/Cs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4631D1F00898;
	Wed,  7 Oct 2026 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791394215;
	bh=NCtKFC7CxQdjXmI/Ky5APoek42QLop43IkigyoNw3uY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RYPW/Cs8ExaISrMy4VhNR8V95Lx7th1yvtQYEuikqGYJW6Sfcr73NJNBWUCawbc6H
	 8zW3H0qebTXccWr593je1tQiyOPIueyJyyPANQVi1ql3eY+qnAk9DgMdxm+Qdvt9su
	 zCsYM4DITXMK7kqRidDhgR3zH//aTmlXcBN8ayp6R7tHEWY4QVsY2oUA2NhO9YMVQf
	 H+C6tcRok3oQwe5TeArGHZDtgwOgPmu26m4pLZK8rW8HfhibMGEhiiJf1Ne3+hUstR
	 f5S5+EiyITbrdpGkb6Q6ZNSNdTOHhIXTLW6dvA7DQK9UwnurHAFrIbDSI5K9ntOYen
	 6RccX4+RSeXfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A37A3808209;
	Wed,  7 Oct 2026 17:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Add missing newline to
 bt_dev_{err,warn}_ratelimited()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179139421378.3628206.2740207447215524505.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 17:30:13 +0000
References: <20261006212142.2168838-1-enghitalo@gmail.com>
In-Reply-To: <20261006212142.2168838-1-enghitalo@gmail.com>
To: Hitalo Souza <enghitalo@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
 michael.bommarito@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Oct 2026 17:21:42 -0400 you wrote:
> bt_dev_err_ratelimited() and bt_dev_warn_ratelimited() pass the format
> string to bt_err_ratelimited()/bt_warn_ratelimited() without appending
> a newline, unlike bt_dev_err() and bt_dev_warn(), which go through
> BT_ERR()/BT_WARN() and add one. Only 2 of the 22 in-tree callers (both
> in virtio_bt) put the newline in their own format string.
> 
> A printk record without a trailing newline is stored with prb_commit()
> instead of prb_final_commit(), and readers of the log buffer (/dev/kmsg,
> syslog) do not see it until it is finalized, which only happens when the
> next record is reserved. These messages therefore stay invisible until
> some unrelated message is printed, and journald, which timestamps a
> record when it reads it, logs them with the time of that later message.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Add missing newline to bt_dev_{err,warn}_ratelimited()
    https://git.kernel.org/bluetooth/bluetooth-next/c/f3d041ec63f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


