Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9621938DEC
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990608; cv=none; b=ODC9OZZwCT3ccXZED65ETsaZnEEP0NDgto7t3uYTz/5hZqiVDexl/odRB4MriZD3sYrGpw+64ZGzDYBf1HE/XwQFmBUfOSqTcl7GjqT3KluwkydiTpANecrSMXJC0SxqFUZhmoNTXeckQib7aeHR2f4WYN/tvPmjir/LM++9uXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990608; c=relaxed/simple;
	bh=/TTwa1sA/WTIdNuIqQB7gW//Z3F7AGHJA0LY2PqCagk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZInv0Hz/ETR7XMylzdDNceKCb01RyeZBBVcXtvR+9THTofOxFkuVUfvBn8ctZWvKjE4A23YoPizZWDrE1lAhXDXaVDBY00Un8+RKBcGJKalJFuWs2I1doYpszwOeq+f44i07TiElSR9WvQUYFMNvFOcIH+W2GjYcFVqoLpun4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzYW1s/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzYW1s/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FB3C4CED2;
	Mon, 27 Jan 2025 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737990608;
	bh=/TTwa1sA/WTIdNuIqQB7gW//Z3F7AGHJA0LY2PqCagk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TzYW1s/QrUEix5SMK871TKSf6QAEfz/Yvz/ONNNcQGh44Mb2QTBN+hM6VJuVK20tY
	 CGApadyULDDz9XniHiYo4Wy85xaaBKh4Eh3qLVIgst5o7o7o7EqB5P887B8DBItsWq
	 vz2msPk8ovTvKyquyQlaiuvzj3qIeHliuWfHTiUAre5o1LaIlqQkOgmn6so6hYxedD
	 e7IuJPXCh7FqtNj3+Snp8PV2Tps28KXsawZbi18tEVHeIY9DbhasuDH+3t8QDDebBz
	 VhF0CtcyiQN9GU7gz+4VVNCxxmgoaJCvN1bscuTLVdhRo+nrUIh94jux6ORP04fCNV
	 T4am9y5rGWvQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE3380AA63;
	Mon, 27 Jan 2025 15:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] transport: fix issues with BAP volumes > 127
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173799063373.3128680.4792887301552469067.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 15:10:33 +0000
References: <45ff22ec472a18bf3d83355f7e4af24a2b39d68b.1737823112.git.pav@iki.fi>
In-Reply-To: <45ff22ec472a18bf3d83355f7e4af24a2b39d68b.1737823112.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 25 Jan 2025 18:41:51 +0200 you wrote:
> Change types used for volumes to int, for BAP volumes > 127 and to
> allow -1 as it is used to mean no volume.
> 
> Fix BAP max volume check in transport.
> 
> Fixes setting BAP volumes.
> 
> [...]

Here is the summary with links:
  - [BlueZ] transport: fix issues with BAP volumes > 127
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=171930d5b215

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


