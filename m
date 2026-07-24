Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B563644DB69
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919669; cv=none; b=PYIN7hkQWf3uNzRq/3fCTdLlbP7LbKFoHCii2hDDEJJvfzL/JYWlNUH+5nlbltKv5JSzPPXP0oFeGBtKJGeFDulNEtXDKWre1Jf5PLySryFCdRWgoNBHC7alBvnaI+Jk7cCTOscIV29S956IlUMy6mDOS7fvZo9kB3Z6tUyOirk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919669; c=relaxed/simple;
	bh=l2nzx0+Z6hzla6FcIPtHvH1T+lr73sZYBUkC8732Yp0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MiVcNcBzSp7QCcfFw7Z6spiU6FL5PrWPVcHNkT3RkR4Pb6TFfdBMFNNXNmc+uv1zA0iwxVBPF4eUqGgxr+/EYbgCRviNBv2G2hIjA+aYgGRl2DgxhS3He4u3/+5aqpNPK14euMpE/JHc576jB9WEuHcMacMCrzuRliU8v3QMsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1BdB6dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1BdB6dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B09E1F00A3D;
	Fri, 24 Jul 2026 19:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784919652;
	bh=O3zk6dl/vSpoUshkG4u2lrDXlQeoasZp2WG5QQWIPYE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X1BdB6dp+mjI4QMsWUgBXeWEpYGUYDyh0ZfyQHOKIbMiXIeSaYr8rkeajQZ4/8X2k
	 qdt5advX9yLeXsozYOEGDZWla7a/st5IC6FfmJlc3vVE4JwCJtwzW8G55r4TlcNomW
	 3Is+UIESgpZlG5yagyAUhxzv/Tm9nhydcVJJ7uTkVw1MFLcYPo/6VX1z+IHkz27p9a
	 0N1zla0cryxLoQIPpXBpW40jeyfF7YcmNUa8O0vzftQAo1Un+gBzHNKsemz7a351Eg
	 VpdR4s0Rmzml4Ql1dIn9ix0bqa7qauUAOyVbmCEz/BuCzs3Vsk0CTnATeii7Gx1QCH
	 xAyUE/fgdGxmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19978380CEF6;
	Fri, 24 Jul 2026 19:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Bluetooth: fix pending command UAF in EIR updates
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178491961963.3273549.7571796979195702086.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 19:00:19 +0000
References: <cover.1784746530.git.zihanx@nebusec.ai>
In-Reply-To: <cover.1784746530.git.zihanx@nebusec.ai>
To: Ren Wei <enjou1224z@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, dmantipov@yandex.ru, vega@nebusec.ai, zihanx@nebusec.ai

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Jul 2026 00:43:45 +0800 you wrote:
> From: Zihan Xi <zihanx@nebusec.ai>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated a bug in net/bluetooth/mgmt.c. The bug is
> reachable by a root process via the Bluetooth management control socket
> and a virtual HCI controller created through /dev/vhci. We've tested the
> fix with the reproducer, and it should not affect other management
> commands.
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: mgmt: fix pending command UAF in EIR updates
    https://git.kernel.org/bluetooth/bluetooth-next/c/c22eb0db0c62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


