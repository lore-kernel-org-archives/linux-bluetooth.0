Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315E152FE32;
	Fri, 16 Oct 2026 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165219; cv=none; b=qhu2a5feVkETBIQ6nJxPXBHV0vxX7WF8EFuelEHeQQ8hCsLCiqZtiYb011zeJBUyxtagexoKaoe0VLbqBzB4XAAfs/JwzCzpzbkcThcBEYFzlRi1C17V587iikC/JqJ46ajNjCYNM0e+/Ox4CLS1Fnyl2vlgEheayVsIFdZe/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165219; c=relaxed/simple;
	bh=o97ORKfUsnZwt7jloOd28FAvqIH28ncR7dv1D6etjLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tuE5oLdUtp08+GOjj1WfBCZ0PLl2rXQaE4ayusoR7FD9IimovwS2CASB5txnBicSSLaiw0PA+/DEs0tYScQfE/YT7KtglQxOaUwlv8BcL+3jdP57tJJO7P+t7ctXW9ZDK+Rv10J8EYh5yRCs9iY3fp4ShgX0twGq0oX7c4+HW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4Zt/1fs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4Zt/1fs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7461F000C5;
	Fri, 16 Oct 2026 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792165217;
	bh=OrbLJr4eNLnAIX0UPfAXg9LAgL9Pj7OrkbnQfRvNlLY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h4Zt/1fsjyiiDgQJICoyG7LXoAsv30b0Wr0nzJZb+O6ci3Yj+7zW5K61UeWimy8a4
	 wL8RyRecqJR35JnTqRtQlJJbsIDhgxfBbUk7+LhmolD/VLRZopxXIqf/1z3nVuVR1Z
	 c+PvOXavMDBalhb6Wx11EPJ9wEsblW/5MDyFSftC+5A+yb3DTnFLo9teYEHd7aMw3V
	 uCnFty5bOPi8RAJxLHjm70pi1E/PgIv3mZIhO1OzyKpJRhfVYfwI6bglsUVHHPhpve
	 KupjsG09g4MMJCkYPh2cQNJnXf4k9Ozt5tRqd/naYCSvtBUaWCellFAN6XJyqJ8R8x
	 73/XnEvFhVWXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4474380A96A;
	Fri, 16 Oct 2026 15:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] Bluetooth: hci_nokia: use skb_put_padto()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179216521626.826981.6704041898422015598.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 15:40:16 +0000
References: <20261016150314.2832131-1-edumazet@kernel.org>
In-Reply-To: <20261016150314.2832131-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Oct 2026 17:03:14 +0200 you wrote:
> skb_pad() does not change skb->len, callers have to follow it
> with skb_put(), which is error prone.
> 
> Use skb_put_padto() instead of the open-coded sequence in
> nokia_enqueue().
> 
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> 
> [...]

Here is the summary with links:
  - [-next] Bluetooth: hci_nokia: use skb_put_padto()
    https://git.kernel.org/bluetooth/bluetooth-next/c/185c11232d5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


