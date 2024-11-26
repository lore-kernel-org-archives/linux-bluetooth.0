Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733563EA69;
	Tue, 26 Nov 2024 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637419; cv=none; b=RYNDCiCi6Iuq7TKNqoLL7ofERnsz0+CVeKsiNsvfkQ8sM7cNqN04norKleoIxPhn4AEww6qhbNCxA/a+FQcQGfPkQUVju0UTYAk4GxY/W7/o4UhOSXHOUnG/IW4IkQcM8b7klgVrHvtmONeKkg43OauCTti554W/YEvDBozCII0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637419; c=relaxed/simple;
	bh=aeWl5iZJzCtMgyW2FAU0cI6SmZNsdj8o7F+zC5EHgzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pewagKaCuDVNe74ahbTckIfljFAs6MjMNa9g20u729Ieoz0NanyErq2VwWLLM7qIOT98pVzI1eIMThvpxgf4T1P/bQrV1YAe+l6YMZMInQEMVkqXlhJv3rJX7uhjLUdrpOJz9RZR+tNU3TGel2Iak4N+U9IrUrMzi226ayvdjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/WVFEV9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/WVFEV9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD10C4CECF;
	Tue, 26 Nov 2024 16:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732637417;
	bh=aeWl5iZJzCtMgyW2FAU0cI6SmZNsdj8o7F+zC5EHgzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a/WVFEV9gR15iLgbyjXIQA3gxmuKy2vR3i7/rk0A82SJsxab9W8eFX0XjAzGFLp+6
	 bcOQBl9dgpKqkeBtbYY+visfgDn9xa2fWQ6chMinDdprfH6Kr6Ge+so7o1NFG1rBKK
	 LENzWkXTD2CFwVNzZlxA5sllGLywGf89HprUFBf76iyf2T5hpW0ErVOlzGK3KtEXIY
	 gsEp7GGSRoyVq7dzD2eqCsNy1tufq4vzZcdAxKt/PaqND6fMSo/l+Uu45DLYDoXEC4
	 c2Iq0q2iFHhu1KQj6qkUf1lOt79iGBNzcK3VX4C3JVuUKceKO+ovKiMSxXD0jJwKs6
	 vy5IbEHBRpWlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB02B3809A00;
	Tue, 26 Nov 2024 16:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: SCO: remove the redundant sco_conn_put
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173263743076.458202.14094125770586556197.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 16:10:30 +0000
References: <tencent_10C852E0467D89872ECD2EFCCC9C27D68606@qq.com>
In-Reply-To: <tencent_10C852E0467D89872ECD2EFCCC9C27D68606@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+489f78df4709ac2bfdd3@syzkaller.appspotmail.com,
 johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org,
 syzkaller-bugs@googlegroups.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 Nov 2024 07:58:43 +0800 you wrote:
> When adding conn, it is necessary to increase and retain the conn reference
> count at the same time.
> 
> Another problem was fixed along the way, conn_put is missing when hcon is NULL
> in the timeout routine.
> 
> Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
> Reported-and-tested-by: syzbot+489f78df4709ac2bfdd3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=489f78df4709ac2bfdd3
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: SCO: remove the redundant sco_conn_put
    https://git.kernel.org/bluetooth/bluetooth-next/c/ad0d88dc33bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


