Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B101F4A92D0
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363668; cv=none; b=m3Z66Lq/qaz2rUdZdK8wYTso1zXJv9iR1aevObRysWMnq8KIHzu6+PNBTO2j3jrJVBbVY71h4ozW3PqSimqN1C3/LNnvhpacxTyECWc3LPKogCNihvW8fkwI1y8d/UL5J6wg7yta2nKtGTJpd+CZbZ8Y5biY4MyFYKTBjMWXZdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363668; c=relaxed/simple;
	bh=3TqSXA3B1oeCI+MLR0gbf4ftmUYaDMAiL54AEiHYwxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Clbn3EEcbLlB3S0h/b7YoV9MNEz9NihlDBpMaSAZ2JNdDtey86iEeX3S3vVr7LA/8aiRztxzY3hJCbEtF5zU4V5V+rnQqO7gpDpGB/8IjOoN6wRdyZ3rzJkcOT/epCD3CuG88AxSpdMtqyvxQrjwT2o0SIjUNo2nLbUowTaKdcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4XZNLar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4XZNLar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE59A1F00A3A;
	Wed,  2 Sep 2026 15:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788363666;
	bh=H49F3KB/Gb/L0x1yXcxnv/f21YYdl8aO5lSTTFiQahY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C4XZNLarLlVjoT23IDra4ggdW61JvQAHdBhKBGIZXxpQ5GnbTNHqzogoCNajlS8yw
	 vq1+ENH+aq6uWr1gxkG0FXaw917UXvH2hXhIuCdBrOwY8bUCIz7rwrPO7lu7fzhk84
	 92Se49qv1e5HbYX43j3KJhtf5GsWbB/Gr6igKOiUKfTB1Wb1Chy0Vot/1Wx/eXoL4O
	 6QfmlRT3NCIo7RNPrSbfETUa2QdOsfLb0ig9+Y+42miGkQzwTXakrdQ9tmFCFWb93w
	 TkRcCjNokYOnjqhEmy+jMv5tCmW/+AbKXWrEGwfkVVn4hDl8u9bJlQ6H26FnEZQdZ8
	 LGJy9orWuojWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987D3926648;
	Wed,  2 Sep 2026 15:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] transport: Fix use-after-free when replacing a
 linked
 transport's owner
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178836360763.2802406.9178353804129746486.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 15:40:07 +0000
References: <20260831144556.128154-1-frederic.danis@collabora.com>
In-Reply-To: <20260831144556.128154-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 31 Aug 2026 16:45:56 +0200 you wrote:
> linked_transport_set_owner() unconditionally overwrote a linked
> transport's owner pointer. If that transport already had a different
> owner assigned (e.g. its own Acquire request was still pending when the
> paired transport's owner was set), the previous media_owner was
> orphaned: its D-Bus disconnect watch stayed registered and its
> ->transport back-pointer kept pointing at the transport. Once the
> transport was later destroyed, the still-registered watch would
> eventually fire media_owner_exit() and dereference the freed transport.
> 
> [...]

Here is the summary with links:
  - [BlueZ] transport: Fix use-after-free when replacing a linked transport's owner
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a03665b6dd20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


