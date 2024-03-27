Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD47127B5A
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555149; cv=none; b=l4QGRkDHE9QoJSB/JTtHxWTcFocpO5ytT2D/hQtXiC9RavMd8iWhrRHvCNcYGDBJq0LEEdnBAMVOOOeSKCRma2RlfwsMZ7V2lZ9bo5I5O5NoqswOk296J6w8W573VTtImUWr4qA81gzrtK9Gm6kukP+a7WAvQELwLyqhoqnFDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555149; c=relaxed/simple;
	bh=IVBP39y8o5+0oetlqIV12TE2Ia28jDRu7dJ4mvK8FTw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aRJU1NIrVr0Ughmv0kQos2Wic3IbjgcJvh1bj8zT7TWxA5Oob9Ko+/JVsIGn9dG4kN5HpY0hsHHS66vtDlqgrY2lL59ASLeLQ50Nh8J0BND0qD6CoQR+1hIooykEnQ0QqCFL89CsBWxfAKv3cZCYW4eQTG7F8fU6RUVwO0hDeWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/PbREqO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/PbREqO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46D53C43390;
	Wed, 27 Mar 2024 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711555149;
	bh=IVBP39y8o5+0oetlqIV12TE2Ia28jDRu7dJ4mvK8FTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B/PbREqOMRkB0mwln7xwVBaN3vbkUvMcLhq/30Eb/NLhlEH1ljYETfcSYMnFKS/dB
	 2+HokR4Xd0F0zZvBhuJKSnNHeGtouPBXtpvGN09x+Q/cyzuH8x56dGdk7tqanCdohe
	 Q1SpuHcUhO5mFY4xIp0UzsLp1ps/66gV7Qztffo+2OLVp7r1eVfqPjwQWW36JYx3cA
	 BLrp/kIolHgBwd/q9/h0qOIEtzN9rENB6eFbNgP23z6f6gXcAYK2QC2VaQmQ0ixr26
	 qBxcF8bZSN4XdHnKgawSRFVj5WnX/o/YCL685cbPlP9I4m3uVysVK6R7jgruxWX904
	 RuUiqUbu/aIwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38432D2D0EB;
	Wed, 27 Mar 2024 15:59:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix TOCTOU in HCI debugfs implementation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171155514922.7842.13592921758180898111.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 15:59:09 +0000
References: <20240327142526.332756-1-hadess@hadess.net>
In-Reply-To: <20240327142526.332756-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, 2045gemini@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Mar 2024 15:24:56 +0100 you wrote:
> struct hci_dev members conn_info_max_age, conn_info_min_age,
> le_conn_max_interval, le_conn_min_interval, le_adv_max_interval,
> and le_adv_min_interval can be modified from the HCI core code, as well
> through debugfs.
> 
> The debugfs implementation, that's only available to privileged users,
> will check for boundaries, making sure that the minimum value being set
> is strictly above the maximum value that already exists, and vice-versa.
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix TOCTOU in HCI debugfs implementation
    https://git.kernel.org/bluetooth/bluetooth-next/c/db4597cc88b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


