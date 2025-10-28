Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA02DECB9
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687034; cv=none; b=o/hc2rZBv+gMVNSDJ8y9UQ3DN5W71EMJhmmFSxQGTdBfOyAB2u7p9e2Cjt4gPxdgUZn408YvaMPGIxavYgvghHLav+hzNavz36o+leljI/UFJQ3SO7d4yLz7DH2ak4s2HlOs3ZE4Wj3kGV3SQj47mhxbQ/90ptMA3rA1BXglCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687034; c=relaxed/simple;
	bh=Ku/Su4ncA9CKxNrONFRarIqSdcTR8sJpCxyqJ2/2kss=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a/yThgfQf4/f7hvvIEGvqllhX2efGmflB+I0eSgKv+OaYYgcV7DIix2+L04Y36wrTlVMM39Q6C4I3zSxlaq6PXz5VzOIjSad2K1YBbLnJ8Zx6pJizBI46OfKeloOBumYFyn5m19io4YtosaDL/dK9K2uwDD1L6wFUUr2WxrbZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSz+pAm0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSz+pAm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EFDC4CEE7;
	Tue, 28 Oct 2025 21:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761687034;
	bh=Ku/Su4ncA9CKxNrONFRarIqSdcTR8sJpCxyqJ2/2kss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cSz+pAm0CZ9pQaiIBJdT1fB8FSnFHYhFrAk9cw8dwRz8pZYDND0b1HZ0OhM+8Drmi
	 T2TGxk+I/GX5lLmc6Pr4MCWXK3zmJC5OhAZPbVRSF9rKDiMwA8AhnnqEPMdOejRvJ0
	 vhIqwIACU6O4X+leBpVPDp8rfIXBYDJN+Qail1AEczIvQOxudGFCX5e5OyBEK5Ryln
	 5RCt1GiEP2jlMF1w9KunPfKwpHvP18YgC6lIXMNiI6u7vUYosWDx61qD9lBr0PVZcH
	 JyUSpfKaXPywu93kGCz37DI/W+svBWGH7OLMan2igKRnrUPm6F5VMcghvOa0UcXOp1
	 v4gg3Mji3TQ5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE5B39EFBBB;
	Tue, 28 Oct 2025 21:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] Bluetooth: Remove redundant
 pm_runtime_mark_last_busy()
 calls
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176168701149.2391991.18445661058856546176.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 21:30:11 +0000
References: <20251027133538.393138-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20251027133538.393138-1-sakari.ailus@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Oct 2025 15:35:38 +0200 you wrote:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: Remove redundant pm_runtime_mark_last_busy() calls
    https://git.kernel.org/bluetooth/bluetooth-next/c/c5c38a0b814c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


