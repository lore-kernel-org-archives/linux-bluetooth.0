Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1824B82866
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352838; cv=none; b=FPXhaSNUEyQL073Vv9WoxoZ5OE/HpLgSE8HdzR/uaY8DbC68hnElF1fbwkfetUmI33QztWVYC+YJkoe9grxrELhmBxDb66SA0JuwJ4bZiebDhTNqd5J6aPkXza8IlJCL7MUB9ZGxgMbvSai1Fq2M81XGANlYKTJ9Bqna3bPOfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352838; c=relaxed/simple;
	bh=y3N6MtE4Zl0q6onwLCpY8jWB/a0QPE3mmX8W17FptzU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VcNCI0Pq6UjkQTVu6SeKd8WY84sXX0SVNtZd1ZDj+oTzCku6bUezIMsH+KxmA4JW/6bGqzAckcbv5KytpSLvtc1Bo+JL5NRT1fGIraGQpxtyA2298UXZ1z1xiP68wGlxDtWKe4Flp37LHBzWtbnJCRhDcTuDet2cap714rC1Vrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5VPtA0a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5VPtA0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36C0C2BCAF;
	Thu, 16 Apr 2026 15:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776352838;
	bh=y3N6MtE4Zl0q6onwLCpY8jWB/a0QPE3mmX8W17FptzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M5VPtA0aav+PDDRjKXDlOt/pT1U1bUCKR8glDm3g37jgU3v8QTmnEjmcf/tFDiYR+
	 +Uo/xhcPRWXpCH27JFgQjuJZQ6xBh6x2KS9WX2msm8fEo5RnExRzylV5f8kIzBmIwC
	 49AHfl5uz2EIjDrkXNvYuYrICEW19XX0nTg5RZZC/BJRFdOcIEilvc9pHqlty5tVn0
	 g5Dh7dNuJqkUu3t2FwCg+4Rqw9M4Xe/797Dl4T/Ud/PxntxyQ9f5ih77i0ugZ0MzYc
	 k4UpxsFuuTPDX7a3ylT8EgSHuXiFO4biFStrBs5nZUcaIP1a+iuIw1BAE/NDfW5c7M
	 xAtDVPqxDBW5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E5F380AA63;
	Thu, 16 Apr 2026 15:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/3] Remove glib dep from non-glib shared library
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177635280653.3275927.901198944484854482.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 15:20:06 +0000
References: <20260416141021.3970323-1-hadess@hadess.net>
In-Reply-To: <20260416141021.3970323-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Apr 2026 16:08:39 +0200 you wrote:
> Changes since v1:
> - remove queue_peek_head_entry() patch, we already had similar API
> 
> Bastien Nocera (3):
>   shared: Remove glib dependency from src/shared/ad.c
>   shared/queue: Fix warning when compiling ad.c
>   shared: Remove unneeded glib includes
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] shared: Remove glib dependency from src/shared/ad.c
    (no matching commit)
  - [BlueZ,v2,2/3] shared/queue: Fix warning when compiling ad.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6a6aaeba6aed
  - [BlueZ,v2,3/3] shared: Remove unneeded glib includes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=07a0b87e6b34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


