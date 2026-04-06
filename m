Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA98119C553
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494833; cv=none; b=sEQhyTxZhby7eCI0WhPxSBwUHTkxHJIuoVTgG0oWpe7lR65qAjzeZUUw8KXkLgbzVbNJW4+rSLpbLJFBSlpGi/srKZZDnAhMr8KMRBcAnQMsucCL2+h5kySupU9SzFKColMCITQWK1b6tx69KYWGTchBNHYiw8dsDgEWsDvglF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494833; c=relaxed/simple;
	bh=bntBt8InQHOF79unz/raJ5JfzcoAsY9i2CaVVYAn2HU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nKnIUy/l2hgV2LZO1suL7z1ssWO6h3Fnv89WqtToQoK38scGqztXKc0Xdhu15M1yv+7oKWOSDRfDHPHrvefud8ALnW0l1hTc6LRTBeSg0rfP/vwgfoVU7vGB9edfqSLPYDIKamXCz2HP9WeLQ4cX3FktO6elFkCtu0tXrNVBfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAWBtp4h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAWBtp4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DA7C4CEF7;
	Mon,  6 Apr 2026 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775494833;
	bh=bntBt8InQHOF79unz/raJ5JfzcoAsY9i2CaVVYAn2HU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qAWBtp4hFfAhzA9ZsLlsItBZXaX3v0eKbDU2MT+Cf6+QZqrXBBIvz9hDgBXHQemqQ
	 BVkldGiWRkIbIKlB8jWr+73KTWkqtXVCyW3IkdO+qHzhNjcgvMlIO03QU/aGFYlTY6
	 QhwqexQGi3pGfpI0GJ0uRzSkjBYImnc+bO9jo+jFY2GAtM0luBhTwf0xYqtDsn8Iy1
	 NtbqM3vWTGibPpioy++/THykJYRE1lwdxKYLrms7758ggyc1WNoNWBEB5cubyhKBRv
	 ilUaJXpbRIscZO9l378/t9o6yAFt+7M9Vkqx5XPAtogJo60HRJZQRzy998ymm30NFV
	 fagkB1oZ9dMkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD9B3809A35;
	Mon,  6 Apr 2026 17:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] tools/smp-tester: don't write array out of
 bounds
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177549481217.3188653.2603221352959557224.git-patchwork-notify@kernel.org>
Date: Mon, 06 Apr 2026 17:00:12 +0000
References: 
 <2ea7fb22224bbe69de6bbbd93f9d18f0cf5045f5.1775477129.git.pav@iki.fi>
In-Reply-To: 
 <2ea7fb22224bbe69de6bbbd93f9d18f0cf5045f5.1775477129.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  6 Apr 2026 15:06:19 +0300 you wrote:
> Fix accessing pdu data out of bounds in SMP Server - Invalid Request.
> ---
>  tools/smp-tester.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] tools/smp-tester: don't write array out of bounds
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=46f2edd29833
  - [BlueZ,2/2] tools/ioctl-tester: don't read array out of bounds
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=053c7c61ef97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


