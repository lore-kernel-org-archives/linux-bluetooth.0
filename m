Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C31563FC3;
	Wed, 14 Oct 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998419; cv=none; b=r+ZABu4OH2KO2uTaQu54f2hiKbVXQFtd5snqtKdk/iZ6toJqL0SJBYwFyjoBRcCwunglG5KKe7b/d46hXPSgu+WMLE8mt1o5DsrY3jkbSlAEBb/2dPsy2l04bdiMbH5L3OlVvp+G1VmSbTjWu348LdX30Bw8zuvpzt5J1ziqc1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998419; c=relaxed/simple;
	bh=SmDAHeqNpHq5ZwGxdFQbA6eY2UeS3wHt1600YBiVTys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f+lkDg+cCSLBPRhgvMTRN/IarKQOJL+m2eCMldArxA8vAOE9oanT0Q4RsBDeWFaSMXG7Y5X4Ma0pAY5YTVt5/qN0nGZXMnKCXxXMcbiqAAgTsU3FGnTgC3q4po+NrllxXWgpk29i3iG77LG+MygI4Hyt58kuu6eN5qSVaorTmes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/0e50r9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/0e50r9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DE41F000C6;
	Wed, 14 Oct 2026 17:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998411;
	bh=qSLt1H/hsi85IYc/dCAT4iYiTEKgBzRb5AHJ84ZqiuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E/0e50r9ATkBcR4oV1xlFsi/BlEiTIq0H+M/CLxihxKZSUKdxl2lx4+ekxMaW0ANu
	 ezQz6PnPpMvF7yO9+MLfiZdNQs7YmaB5tUAd4yAetxoPS2EZ1tmxtcUQvDwopF3/C3
	 uofBU2+53506reIJXivz3mlKTDmqzaWEHiCLvLM/ShFzeU5RfQBTBDZ5d755yb0pZJ
	 XZfM3KNmC6zxRhNaDrKuWci+xSIc3eQp5wjPoGH31spUrW920n1Wa/1qvACy8W8JAR
	 SRTkkOZJnW7xzyFbXL6TGFrNA1XjgrQb4oxha0U6NynlSrkU7yMqFpa+KyP+iigh4g
	 U0JasZN3SkYEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15D239FD335;
	Wed, 14 Oct 2026 17:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_sync: scan unfiltered for host-resolved
 RPAs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179199840951.2868755.15045268904522230410.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 17:20:09 +0000
References: <20261014051600.408746-1-cochcoder@proton.me>
In-Reply-To: <20261014051600.408746-1-cochcoder@proton.me>
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 14 Oct 2026 05:16:20 +0000 you wrote:
> Restore unfiltered scanning for pending IRK peers when the controller
> cannot resolve private addresses. Keep accept-list filtering while
> suspended and when forced by periodic advertising synchronization.
> 
> Fixes: e209e5ccc5ac ("Bluetooth: MGMT: Mark LL Privacy as stable")
> Assisted-by: OpenCode:gpt-6.1-sol
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_sync: scan unfiltered for host-resolved RPAs
    https://git.kernel.org/bluetooth/bluetooth-next/c/81a78b10d770

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


