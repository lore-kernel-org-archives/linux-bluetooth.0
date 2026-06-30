Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261D47CC96
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851578; cv=none; b=Mb371mxLI2qbuyTPmrshJnKZyqrMZ1WRxZWeWpIJZQdXnABb931it+Kirrw0bX2TbHteE/bj0gl7plppmJOFvblryjkDej8cZeXikvTmOGCHy1sjf8BLcyb0PWmzSAA3T1gvYKA3rF0t3adVQzuQ4LZIzlsjC8b0RE6T7u9QldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851578; c=relaxed/simple;
	bh=6cA0lnBXa/w3h9XPZDAXb0gxuUsYqI4T5XkAeK0mc+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ORJDMGJIejIzM/zTy+7UJgeJlwVnaPMN/pNUAuoeug8hv9/EtnMq7dHnilP3923HPf0jUjIazrspG1ekksVawfs0y+eNd+kuZben9DR5SbWA8Nji+mKI2jYh+u4TmZrsMwI8PlGTHhdRpU2HfgO1YIoZ1J8iQIUi9zZf1WhuZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJKUNJD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJKUNJD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325E71F000E9;
	Tue, 30 Jun 2026 20:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851577;
	bh=RGhiq5dOXogF3Vblbk2PyH01iqtoBrDQdGbfOmLuyMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BJKUNJD9n8RGGNZ6GTMjfSEeriWf1FkUDFAfVlbWyQWw8FH85Nac/XlYR1yYMTheS
	 jzeF8EmSaXN9lmhO5HdpotHppYlqaCzNRZ7ga73W3MWXt0l5twjI9o38jipRkaYxLP
	 H5tzSxB4dGcpberu6EdCDQZFClbPZOLVTnuv/cqZ50/I6fZiW0/iY5yTW1wtKgBkL9
	 +Psflo+lEYUIompYqt7fEUK6J+R0C9r9Q1g52LfMxq9DEg1BO/FaDWJYCZ6Df6xdjh
	 lGvPJLNS/gW5cWdwwhAo3shbxgbdpzDnRV41Cm93Px87YfCUZ3n5HwXYKPFrd2SHYy
	 9Dr2UPMQzM4ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56889393A951;
	Tue, 30 Jun 2026 20:32:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 0/1] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_new_connection_cb()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178285156088.267316.6382092731707043353.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jun 2026 20:32:40 +0000
References: <20260629135044.2302753-1-oss@fourdim.xyz>
In-Reply-To: <20260629135044.2302753-1-oss@fourdim.xyz>
To: Siwei Zhang <oss@fourdim.xyz>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 29 Jun 2026 09:49:57 -0400 you wrote:
> Compared to v2, addresses comments on https://sashiko.dev/#/patchset/20260415204842.2363950-1-oss%40fourdim.xyz .
> 
> Compared to v3, rebase against bluetooth-next.
> 
> Compared to v4, allocate the channel outside the function and pass it in as an argument to avoid the use-after-free.
> 
> Compared to v5, extract the channel init to a separate function.
> 
> [...]

Here is the summary with links:
  - [v12,1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
    https://git.kernel.org/bluetooth/bluetooth-next/c/0e2c0392b9dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


