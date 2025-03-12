Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA621C5D7A
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797006; cv=none; b=biZBlmk2L3/dxBDAtV5V+WBymklFJLiJlYBdDbOcKxlAnzapE31j8TwyjYg/yltL0F4Ve+Z2YIlGSpQyEDzbOclFompT1kC18isSGZsVR5BE39bcwQe9Obysas7MZgb7F2XJHJGfRfwPpfPx2FdxsTLTO9zZuPfouHcRuYYUoFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797006; c=relaxed/simple;
	bh=rfaRN8LzMW0RcMCr+ayXwaYNFaTCXX0X9ZtYuDKVeX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=enXwJ20TadUzMbyPQYGstsyMs7SQjA4DhJOtiVFOFOGM3n39X4QIEbvRRU8UyAIyBKhVjrMrA2xFAUBPmWK1ZIoPgd0E7ffWucAqSqpBbY88EnVuqLrddoQx9xo/3CpqezOEg79p5OEob2FpQ/Kw5sZuXN4EzWoxEHnFU+u3M0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ/8HMir; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ/8HMir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96468C4CEED;
	Wed, 12 Mar 2025 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741797005;
	bh=rfaRN8LzMW0RcMCr+ayXwaYNFaTCXX0X9ZtYuDKVeX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dQ/8HMiryq75rZc53A2kda+bq/cGAcuVMfAQz1iKMk+Oqu+JC+x9xGBkkNki6tCD6
	 3MDU0OMau+gOAsRugKrStjpdxXS02Kx0WXh46GCBsQomvrTxftYMuDz5lAGR9Uvtej
	 XEk9dmSzthuAvfkchYT9vKh13G/n6H9aTscs5ocIvjqimmkWsde0o+/DteQglUjVc7
	 3NENSo1qmtbyMecG5/17fmsJ4rQpLZHmMvfCn6WeXil4DSQ3UPa19dfCDucyFmPOfw
	 kkVvPONDE6IgMqTc79s7UeL91TladxCJsZPSTtwYpyfdPQwAKZCyVx8U0/fYcIPgax
	 7Hron+qQa5ivA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF65380DBDF;
	Wed, 12 Mar 2025 16:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] share/hci: Fix data type in bt_hci_send_data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174179703973.858864.2955937476874029204.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 16:30:39 +0000
References: <20250312061128.1084-1-kx960506@163.com>
In-Reply-To: <20250312061128.1084-1-kx960506@163.com>
To: michael_kong <kx960506@163.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Mar 2025 14:11:28 +0800 you wrote:
> The data type in bt_hci_send_data shall be ACL, SCO or ISO.
> ---
>  src/shared/hci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] share/hci: Fix data type in bt_hci_send_data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e3b2759634d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


