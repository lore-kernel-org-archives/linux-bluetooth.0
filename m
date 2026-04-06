Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8B019C553
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494829; cv=none; b=Wfddy8786FTf1IBaCcJoEaAmw/sBPlKU52kbHmIEBHXpQn/W1VHow56ADxmaRVHp/HBbN/p9kpU8ghguAiH6yn0Gt8NFOQsPP7V56kfHmjF+qifUKPO81d20WelFEKmKUFSE6VyoVmZQBSUQt4ewAbZzGTD7KLj69W+WF+6W71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494829; c=relaxed/simple;
	bh=1SNcV4+Wah81P2klBHVuUi4Npc7ldRwpaYnAlI61McM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mmNULEr6Kt6o8Tx1oIf5kBaXyQqBlGZSetxhVt0kXjlTuRXbYPvnQsq7aip90gtRMXcWXj++6lmCkX31VWMOyi1bqKOWZgIz5gcbT0L6xDzZflflKKeOzxn18Q6aEB1+LP8CgvVioOW3ZfQkLW9EHwX4OFOetdMHPaNRQ6azsoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uafZfZg6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uafZfZg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A75C4CEF7;
	Mon,  6 Apr 2026 17:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775494828;
	bh=1SNcV4+Wah81P2klBHVuUi4Npc7ldRwpaYnAlI61McM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uafZfZg6D5iVHr5PsFtW/vPdcIyO/CdLPAlc2bVBiG8RpzyoeRekdGYeW2CDk6t4i
	 XtRRa2RaJwNw0k1epq6oCf4LgtCSggGwMmxwyLzwYzWMBA4z0rg2p/1QIgYChNZ6Jm
	 VR0e0eWQr2kF8XCdm8Mb5IqmdcE7kvvetLRUuRQ0+KXt4uOFJn0MsgCF6UFEo+kDXX
	 s48NkDN4nvWxKLk10NBlbrmx4hYDqK2/8oC4TtMnVgogyJgimLnzwfZE0MbADiVi68
	 hN6j9/HeS8Qn/HT2BbuQmQQc8/qlpTiOpXcQLeCL1Y31URZxjWUmOzIB+bShkFnQPQ
	 +RpFgrC9uEzAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E3D3809A35;
	Mon,  6 Apr 2026 17:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] build: never build test-runner with ASAN
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177549480753.3188653.15026163954494955495.git-patchwork-notify@kernel.org>
Date: Mon, 06 Apr 2026 17:00:07 +0000
References: 
 <968d832c1d78d26409ed751f2901ea5eb105541a.1775472833.git.pav@iki.fi>
In-Reply-To: 
 <968d832c1d78d26409ed751f2901ea5eb105541a.1775472833.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  6 Apr 2026 13:55:15 +0300 you wrote:
> test-runner cannot run as pid 1 inside VM when built with ASAN enabled.
> Drop MISC_CFLAGS/LDFLAGS from its build; the additional flags they
> contain beyond ASAN enable are not important for test-runner build.
> ---
>  Makefile.tools | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ] build: never build test-runner with ASAN
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dd9d9dab4135

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


