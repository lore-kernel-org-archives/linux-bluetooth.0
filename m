Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B936A374;
	Thu, 21 May 2026 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377414; cv=none; b=K0KQSK7S3L/YI2EZouoBJuUAhd5/IPn9F2BNG9oxVvnpnB09LZTi3zny1gqrcMtfDtxAUu37QLp+aC90EKcr5Ym83kStoRgJuc9ocJruWB06lm2crD17Gasm9y2W88I5It5TZFfWaKJsxGoer4UdLu9qrJapF0mQ+unI6oKwHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377414; c=relaxed/simple;
	bh=av+bb5VwN+WfgFxJWdZbipdtaDjlvoq1vagi89GQopo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QeRuucQuGXAb9XSu5Rl/ShCC2HS/Gz17JNIguhQFOrFcCXRYCN8gzzXgX6MIJwUIy1FHvBlmFrXdi/A0bgJaq62TcdMwOAdt6i0hPEo/GqaklgfxzKVWt0CPJ8su2Z/q7d3ERqNodRPRHxlb6bNWpZIiXVyDU0JFbjhFeF/Of5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMTkNqP/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMTkNqP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A2E1F000E9;
	Thu, 21 May 2026 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377413;
	bh=wdDD19q8SKwjxU0DsDyFstu7uBNkEpPoiX8AzzdRg/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QMTkNqP/+f7UoCPnPGHLsgCtzYMQd6cZFTYPyTsCUOIQ3n07lH9VoRF7XjOj682Dw
	 AO1kpJKygsqRaPWFT5UsPPV3mUaQ9nShT6WVcHgCR7wdCQY8lZ6+PzC9RA6c0tAMGe
	 zDOshQ+eEXoIgLiYIzepc8VtbwSgkGsZMSXCU9g1i8W0Mx3najMRF1Iw1mJjBjkOaJ
	 nYWvrg3rY96Ys9wm9IAxakw9JmxL59ECzdvkZ9QdIRus2KVQdoTBRv8fOrPjMEAvzl
	 QTmkPtQvEyBmQvmDJOiZdeFPFD0Glv4BZF1/C2G9aF9HNIAOKMKQrWtBN6ZHReINNf
	 1spNz6zTR4FDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198BD3930E02;
	Thu, 21 May 2026 15:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: L2CAP: use chan timer to close channels in
 cleanup_listen()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177937742263.384060.14413660411972346162.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:30:22 +0000
References: <20260521021249.3258069-1-oss@fourdim.xyz>
In-Reply-To: <20260521021249.3258069-1-oss@fourdim.xyz>
To: Siwei Zhang <oss@fourdim.xyz>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 safa.karakus@secunnix.com, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 May 2026 22:12:20 -0400 you wrote:
> l2cap_chan_close() removes the channel from conn->chan_l, which
> must be done under conn->lock.  cleanup_listen() runs under the
> parent sk_lock, so acquiring conn->lock would invert the
> established conn->lock -> chan->lock -> sk_lock order.
> 
> Instead of calling l2cap_chan_close() directly, schedule
> l2cap_chan_timeout with delay 0 to close the channel
> asynchronously.  The timeout handler already acquires conn->lock
> and chan->lock in the correct order.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()
    https://git.kernel.org/bluetooth/bluetooth-next/c/75780ca4c6a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


