Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B353C13D886;
	Thu, 10 Sep 2026 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073469; cv=none; b=d1cjhQTU1SOgfomBxZpOBWJEGHRFvPYvGjqPKGP5NhgJzHjyhBnzfGDYYcozRs86W5b7lKCqJ6lC0m8KafNQyKF+3JgJ68W3nEnYoxUuRUCnCV1aKDvs20zCI4Oqg50732iBc6z679cwU4Wq8GF1O6s0IxqUi+QS2nuLE76TWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073469; c=relaxed/simple;
	bh=AlJPBMFmsgTS/RClPRSjhWfqCN0P1AfreTGMXRFBCFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C3OpcuB5ighSTUQZMpgPra0iJ5hovttoocww/SpDaTm4GwBpFptQrh3VcVj4J7ZhER93ezM1A1kevh7c3N6hFEv11HoMWsveK8OSH3yD4s0brvJmfIjVtrTYQGw8nzxcoIhrXoYqDKH2+U5feiHG0lsYlF2q4ibPHdgM1KiQceY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC8t0Ab4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC8t0Ab4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3FF1F000FF;
	Thu, 10 Sep 2026 20:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789073468;
	bh=O8zy2lKt1el3me1n5nB1vmemC/4WW44jiXtQPOUxDeI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VC8t0Ab4FhzfOWShXrMBptbPe1foN5rb9Tl/bG3dOKPpj788SOOGyM5HJj68g//Z7
	 ElQ5mMNZP5CY23mO+Ca7+dAArO9Ueg2AnVtoZjDRcJ8T6qg2RiYQDA5FHaZ5YiurKE
	 5wHGRzx9f6Bp4SG+MThPAFSkq61yD9+SGx4d1ZYF9hhS0fj5uuUeNB3nxoIa1+XgQy
	 TIS6U7jHfwOd0OMHKeI2MwzAW/Wysx4b7f1gar6nyWafdxjm7ZgD66YI7h8RGRy9js
	 DEKF9hi7xCnQunnC3MmUyd8u9ijyCEGPy0z+549yBkTWcW+lYJHp+wuboWFMZO5vLu
	 rddTJffS6Pzlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A0F380DBDC;
	Thu, 10 Sep 2026 20:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: SMP: Zeroize raw key data on the stack in
 smp_e()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178907340539.2075844.9772843571255871634.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 20:50:05 +0000
References: <20260910123254.408963-1-thuth@redhat.com>
In-Reply-To: <20260910123254.408963-1-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 10 Sep 2026 14:32:54 +0200 you wrote:
> smp_e() already clears the AES key in its "struct aes_enckey aes"
> on the stack before leaving the function - but the very same
> information is also available as raw key data in the tmp[] array,
> so this should get cleared, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: SMP: Zeroize raw key data on the stack in smp_e()
    https://git.kernel.org/bluetooth/bluetooth-next/c/e40edfa049b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


