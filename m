Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A48C220694
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709412; cv=none; b=bIYViplFI330Tl8aJIGpZbg/g0vqDu3UL1HJQ4nsWbd9/Gk9Bc6QIageYBuIZf3Ym4XqP57sv5ZHHTkRUOy3UNrNkkQGxDUS9GaSgJGFNWruIR0m73QH/X11cH5dN2U9mSp0a1t9xXr01O0kt4LdYt8RItOGfoKXyc8CX+l1meU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709412; c=relaxed/simple;
	bh=4s20CqM6hQWixWCzyBGoPR1EgQ9IYIvcB8StKke81ls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SnIc6SZ//a1xWfuAygl2/UhXfW/j4IyCy4lXfEgp/HaESUteUBdcbkgMdfkrNM9LRioicfqX/nw/mmfpNcICAQzyALRQOyfUfyIfkJYbg+LVDefhlQOFFnzq0fme7sQ2ft44vQvBrxNQA9IlGcdAC2ProeIq5GEkNZPfSFlfI2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW7r2eZx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW7r2eZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A81C4CEDF;
	Tue,  4 Feb 2025 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738709411;
	bh=4s20CqM6hQWixWCzyBGoPR1EgQ9IYIvcB8StKke81ls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nW7r2eZx0U6DpmRtkUVHJFXHb0R4V8ojcy3O+n8yb7D3TTmU2dzpkLw7oSVmEOWBg
	 JMSGvHigJ5pEii+imxn+Rd9DO902wX7WbRSHerU1jXRo2qJVBMWIzTu6+WY5u8z6WX
	 8UCGZOyZur5oeY2CzextvQgkRmgU503o1n1Wqoi6eFdlgpsiwiSch7+rtTCzWlrCHi
	 IBGcNXs9ntIFLSQaDMjiAS/AHLVthsp4Jh42GFNoOmUzCU+xgYAdod93lNNkWVfkDi
	 peNncRuebwUhW2DgW71h6nEUc8FfTyHXJ2+5dPK1CN5CXhvUX0ayIh0wQMLjlEuMlr
	 /tRgqipWVzhgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C87380AA7E;
	Tue,  4 Feb 2025 22:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] Fix Ubuntu 24.04 build error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173870943924.172153.14276981718229191331.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 22:50:39 +0000
References: <20250204101612.66823-1-pmontes@shsconsultores.es>
In-Reply-To: <20250204101612.66823-1-pmontes@shsconsultores.es>
To: Pablo Montes <pmontes@shsconsultores.es>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Feb 2025 11:16:10 +0100 you wrote:
> On Ubuntu 24.04: build warnings for buffer read overflow are treated
> as errors on emulator. This may be ignored with
> CFLAGS="-Wno-error=stringop-overflow" but discarding packet if offset
> is greater than buffer size removes the warning.
> Could close GitHub issue #1049.
> 
> Also I lost some time using mesh-cfgclient on a fresh Linux with no
> .config folder in home: mesh-cfgclient failed but did not explain the
> error, so printing a message could be welcome for others.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] emulator: Fix Werror=stringop-overflow
    (no matching commit)
  - [BlueZ,2/2] tools: print error on mkdir
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9dbc92a360b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


