Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8AE25FA05
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526790; cv=none; b=DEuSU8eiEnjOviUN9P4c8qda+RBkcjuAzgBgvQM+oZbUU+10Qrs6WX8lssaL/M9btZEuATLa2vvDwpJFI8xmLM6Z5nO6gRRDsO70TDJH4HqpgGcKHWHTDMLDnG8ZqQgGpYwrX3S4/ASERvFcRUrYhyh4Lam5bHkjMyZsKqEJoMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526790; c=relaxed/simple;
	bh=1VkXgPfNNmAWZBY2/EDrb3V1CXi0f9ZGwDD2KLhW948=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DjMFDgPJltuBZmaPPF4ARBVuhBGeJvKTlCjWhyTBNSqaWxfSB5daYsuXux7nrZJDV8jM72hDQDqA171WOP+21bZp17JQ0uF7q1i0AARxtQj78M5nuybpZkgZLyxvJJv/0qfka4MkEyvQ2pINo9im9AgZLyPuS5f5x1QfVNuwdGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7aDC8uj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7aDC8uj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FD5C4CEED;
	Mon, 14 Jul 2025 20:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752526790;
	bh=1VkXgPfNNmAWZBY2/EDrb3V1CXi0f9ZGwDD2KLhW948=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r7aDC8ujbuCEBpwl9Teza+23HtdgLPA8CG6NwgpkAO2e0W9xIjxv/9zSinxEPTBFd
	 OrApMKZps9kVVQTNKb+LHdusMWasEdyEoKoSYdFyPDIwZiz7/rGZ18ommZFdRSrBVp
	 JhIgByKCCZFUQ6JiXhEihvOIqIG1EL1aTm8Adm6tblOlu4LbSCI8DH6er0c7E1ZOwp
	 xgleRtKF2sIg65eCF+zbL8NK8eqYRYFyuwGAGsiaUnc2lWvErTg+YJJrJ8WGFcXqIT
	 5lF8Li/z1YNdfOi+Pe4L7fRw+A13EgaZb7xNTAXzZfClzPu8rTXDdQJGtbYzd/riYf
	 /z5E7P5pPp7Dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B4B383B276;
	Mon, 14 Jul 2025 21:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2.. 1/3] lib: tools: remove POLL_ERRQUEUE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175252681069.3985397.4375530027413037075.git-patchwork-notify@kernel.org>
Date: Mon, 14 Jul 2025 21:00:10 +0000
References: 
 <2ffec6539fe38318c713b48985aaddda9671f258.1752511478.git.pav@iki.fi>
In-Reply-To: 
 <2ffec6539fe38318c713b48985aaddda9671f258.1752511478.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Jul 2025 19:44:48 +0300 you wrote:
> This experimental feature did not land to mainline kernel, and probably
> would need to be done differently.
> 
> Remove defines and tests for it.
> ---
>  lib/bluetooth.h    |   2 -
>  src/shared/util.c  |   2 -
>  tools/iso-tester.c | 127 +--------------------------------------------
>  3 files changed, 1 insertion(+), 130 deletions(-)

Here is the summary with links:
  - [BlueZ,v2..,1/3] lib: tools: remove POLL_ERRQUEUE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=db061936394d
  - [BlueZ,v2..,2/3] lib: add BT_PKT_SEQNUM and BT_SCM_PKT_SEQNUM
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9e117ebee13f
  - [BlueZ,v2..,3/3] iso-tester: add tests for BT_PKT_SEQNUM
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b0a1386f98c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


