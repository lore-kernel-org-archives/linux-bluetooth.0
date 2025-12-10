Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADBA2C027E
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765402991; cv=none; b=sc+tsRA/FDHOzsB2zQMlCEy9clf8mbcMUsmC+xwWhvCFb9gTcTekNSRr0+IfSDnT3Gg8/WUufEhrAxSXxyYpdE/ydWn5O3PzV0lNo7wlY9MKHoAuwfy79qIF+OTrlL3lDfE8J75K71NDJc2pg7U3bK8GffoOrrEfAWgxnvKhZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765402991; c=relaxed/simple;
	bh=5tE3Q/VYXSa/wf5KYZlLo5YXOMCSYksmp/rJt/qicHQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J31D9VgwKw5Oaw9x8j6Fda04GP1j7YfavthedJ+CWYzY0zqPho19kA0BS6VjvRoJCunietF8t0/FAhpNjWhODoysyxWrb8hSFyN83wQQxP6WGeVpLHwVkFkTn3gqPqqfjf5v2Yvnt1Qwjzh89pn+wAD4K4GdjYaYNhiCy3LxIyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqBjLnPa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqBjLnPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B389CC4CEF1;
	Wed, 10 Dec 2025 21:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765402990;
	bh=5tE3Q/VYXSa/wf5KYZlLo5YXOMCSYksmp/rJt/qicHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oqBjLnPaOrMPlOQkn/u8SeAW/ifB8Emkae0hTPOc6yaHngUP9sWsKMDQbCiA4oPun
	 R1PJ5QnDH2WejFoUpr/D2ghMQyQ9aYCKQ2Ea37NfhRZIS8giEf3cYJX4BtXrXaPGuj
	 iRJmSz7eebKcH/+p8FvM86cuw9Tzzq4sQka6fZBe61Gog9Bf1rA/GOUIscZLS/ooc0
	 Z6pLRKdadyL+KB8PbRNXMzMkFbnMLWxKXNx4pliyE/fy7R0YQa8EeCmcj7Mmmlikvu
	 witWtlomjN7I3xyZGiiCQg3UL1x2pfCNcGWBab0U0Vn5SItF0ZhCN3LDUa1bkimxYn
	 LjJRIbM66S3jA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B6D43809A23;
	Wed, 10 Dec 2025 21:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] unit: reduce macro expansion volume
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176540280504.733730.10284047710695566137.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 21:40:05 +0000
References: 
 <8da87c1000bbbb062d302b74518351a8ba65075f.1765310255.git.pav@iki.fi>
In-Reply-To: 
 <8da87c1000bbbb062d302b74518351a8ba65075f.1765310255.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Dec 2025 22:26:11 +0200 you wrote:
> define_test() in some of unit tests expands the long command sequences
> three times.
> 
> Make it expand only once.
> 
> This reduces preprocessor output e.g. for test-bap.c from 23 Mb to 5 Mb,
> for faster compilation.
> 
> [...]

Here is the summary with links:
  - [BlueZ] unit: reduce macro expansion volume
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fa6f1e942cee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


