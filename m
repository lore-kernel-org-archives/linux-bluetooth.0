Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338D2517B9
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775997; cv=none; b=FCw6VXkijgsyjFsXaFglir5l59KXqNN+Yt7ExRQ4RgdMAwD308s6pidhIi49hCrBfKsgR0KKElgF1aslQvf6CZxJMMfrFkhHuieZevWL5puDBdbNsgSrDb/rJhN4mLjkU7Rhl/HGOpCgEUj3nMfH6ppvyblE0FmqvnidK3Iczz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775997; c=relaxed/simple;
	bh=7YsmCsYdZw8fCE+L1JHnCURPaNvkuWgFCBTeB7ItqfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PA92nZk5bevf86bRVo6iigVaucu5Cwgvl1Tnzojv6j0+yDrGXETbP+uN56RrqQi/vW3w6tyhZffh8eZ34F7F/P5wXPVXs7gsQUzbzGEzKNbAkr3GbR76Fhz1GWWKESFu3PBcPvhxT/k4p4sTy0AVOdzep+5uX7xM/LQVQlM8c+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOuYZlIF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOuYZlIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F360C4CEE9;
	Tue, 20 May 2025 21:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747775997;
	bh=7YsmCsYdZw8fCE+L1JHnCURPaNvkuWgFCBTeB7ItqfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qOuYZlIFBIru3VfGCIOADs5+1fvvL7XDo7boCFiHFuP8gvgeIrermxIQuj5TAO5fS
	 LLuuZEdFi2eS4qoLcdR2k6uQfBLKwckvE4Z5nxh4Xvr5FRvl+x1N+nQuO11hw9GMeG
	 DgkemFksrbvk/gI7IVGj1KJBWQZ3p5GcVs8Ebxk4taMPsL0gF5MtNwaBFKbrPbTmP0
	 aJhmEIk9Wzzaa5+t38rTpWoN4RTy17+Y4CZoQ9HfZ5ZL6jjphmFVFWSr3aL74udxZ4
	 xD49oge5GbnPbD0pwoOucebcscOWnehU0gkC3YL19GSyObqyVHwYIjCLqZgzxZW0Ep
	 zuZt6PlgoQGYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F2C380AA70;
	Tue, 20 May 2025 21:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] doc: Convert mgmt-api.txt to mgmt.rst
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174777603274.1466863.11582993422585420581.git-patchwork-notify@kernel.org>
Date: Tue, 20 May 2025 21:20:32 +0000
References: <20250519193349.2536890-1-luiz.dentz@gmail.com>
In-Reply-To: <20250519193349.2536890-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 May 2025 15:33:49 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This converts from pure text mgmt-api.txt to restructured markup
> language and then use rst2man to generate a proper manpage (mgmt.7).
> ---
>  Makefile.am  |    6 +-
>  doc/mgmt.rst | 5377 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 5380 insertions(+), 3 deletions(-)
>  create mode 100644 doc/mgmt.rst

Here is the summary with links:
  - [BlueZ,v2] doc: Convert mgmt-api.txt to mgmt.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0402c0674644

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


