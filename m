Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24314884C
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397041; cv=none; b=Qu1JS7YjGIpdZUA7siktt06laHDwY1DVfJT2YpZPUuoUbYb3pUOj0RwJXBWK8rqh6yxTS8axvU34pzxZUH/AsSjbXtxTLyjyIJPA2eVh2d54XmbPiLe6iBRCWgcTgxJLzdk5DELgl2XSRGAT8FGlSeV86SSJK9JAlrEUeOVWOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397041; c=relaxed/simple;
	bh=lr2pWCY8xac7JCU8an81dKqq4uyiEjmc/j4inYy78O8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t8aR9F/54G/+0yvu+ZuHhNmajnM2Q3iTBZIudVAl5I6+bZ7VzhqNPdtyNqwsGT0G9nIAYq6+UDeAH4QMf5r5ht9VLJNjj7rLeBMw2aFMl4miKMUMJNY7iU7MvQ+HBeZ3iWOMV+eaTy/nmvvtFEau2reOOLiSVtaS3TjvcGlRl7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFFs5rKp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFFs5rKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E13CC19424;
	Mon, 17 Nov 2025 16:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763397041;
	bh=lr2pWCY8xac7JCU8an81dKqq4uyiEjmc/j4inYy78O8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FFFs5rKpWqUsllrLKiD1e0sYiVE2+n3jCjxyaF6VaXZpLLPR7BzhGIQWcSWp8h2RY
	 PypwKeZjH35GHN3vIh12xFNRyhQTfRFeRwYAbjZOvzM0qXKBtNgb6ChCveBNVD1vmj
	 nvr9yCOdNZ84Do7/Kx7twXR0gudd0bGQSc67+KZILtT+cd8Oyneet+IleJsKUNuqub
	 D8Hbx74IrZoyh2btxvSyo8S29mGTUySkNmHGkkmD2dt/MpMKwR1hmc05bLcOoEQFiB
	 66ATlsk7qdTa3Ojlw8QXF0mt+umm8cUABi9/3hjJhQ1jV/nYAIELDR+NciWo9L4Q6Z
	 LQyvoNzQYqxTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340343809A02;
	Mon, 17 Nov 2025 16:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] mgmt-tester: add tests for discoverable timeout
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176339700774.3386490.14694966178762197964.git-patchwork-notify@kernel.org>
Date: Mon, 17 Nov 2025 16:30:07 +0000
References: 
 <134dc6196bd704f56902f17ffc72119c9babd7bb.1763301095.git.pav@iki.fi>
In-Reply-To: 
 <134dc6196bd704f56902f17ffc72119c9babd7bb.1763301095.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 16 Nov 2025 15:51:58 +0200 you wrote:
> Test that the discoverable timeout can be set successfully and that the
> timeout actually triggers:
> 
> Set discoverable on timeout - Success 1
> Set discoverable on timeout - Success 2 (Timeout)
> ---
> 
> [...]

Here is the summary with links:
  - [BlueZ] mgmt-tester: add tests for discoverable timeout
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f5043771c27b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


