Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC02240DFA0
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817801; cv=none; b=LOZ0iwyulepdTWORQdcqutgxDobH6cpYNRxv79o8I4PA51zlpvwJtMQqpaPBnjMRj/CvMRPXdw/BetwMQitKIIFUkUHGGUoXkeCcHNvOmCLuX4ebit+IxgoG9681epV2smBOk3ADb1u8ccx+qcM7+KsfYZH5uBklSQLYHyrwxNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817801; c=relaxed/simple;
	bh=vs82Yp0TiPvwKQLt9fuezE1ZbPdbt9XHfbHRf3B/OhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gRzETix33ZKgNup1XWwjl4gHvzJMcSk8LBwmb2irVwiyvOvycKhbzX5TAOr3BEyw0L0FiBP47LJzs6H1RiQgTc7iPAIBpY7vlpo+cTt9y+JXrkRaQv1n5KvK7d4wodCB01Do95Msfh3yix35pdnvcPGHcZIgQgkTYkt7BvPMABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQ+0IRPN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQ+0IRPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3AA1F000E9;
	Tue, 26 May 2026 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779817800;
	bh=XNA29QUOewM6aWG4KDOQPg0X1vMxgsE0akjN30w/YH8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MQ+0IRPNzR3P+Yu/TkJ4oThtkmdKAJ/8AiTNvMtwYAEaCXkBMaWOjZ3hsJmSgIR4z
	 73TvM671Qgd+7vmzJcWSuSEpkQDzpSYbJFJ0TO/+iCdz6k5ac60RCGisVtMB0Bh8ru
	 25A3t3JGldTdHSr4UKzLGaMPyWOvhw78rtrlfx9GA5PMJc+QexcfRAwvtcI71Oocbn
	 h3TpjCGDHQ5+sn3NYnbBpZGVLg4IwhMQtwE8sR9SerD+0YcD8SkMhISWCuffvJfn8w
	 aCkOv51MBGynpGFEJx/jD4WbSvuoBd7VOy4b0mJNySA4HTwfcvhgz3bqEZowomoal/
	 6h7fyEVwE3P3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C10380CEE6;
	Tue, 26 May 2026 17:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: 6lowpan: check skb_clone() return value in
 send_mcast_pkt()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177981780590.3917724.17525961702845062170.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 17:50:05 +0000
References: <tencent_859B04510A77948C6A97FF769CBB9262A007@qq.com>
In-Reply-To: <tencent_859B04510A77948C6A97FF769CBB9262A007@qq.com>
To: Zhao Dongdong <winter91@foxmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, zhaodongdong@kylinos.cn

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 May 2026 11:21:39 +0800 you wrote:
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
> 
> The skb_clone() function can return NULL if memory allocation fails.
> send_mcast_pkt() calls skb_clone() without checking the return value, which
> can lead to a NULL pointer dereference in send_pkt() when it dereferences
> skb->data.
> Add a NULL check after skb_clone() and skip the peer if the clone fails.
> 
> [...]

Here is the summary with links:
  - Bluetooth: 6lowpan: check skb_clone() return value in send_mcast_pkt()
    https://git.kernel.org/bluetooth/bluetooth-next/c/ba550f4bd304

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


