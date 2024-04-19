Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817AA23
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713555629; cv=none; b=Gol0lDQF3MBZOhChSGTbNaQvp2lh2YBx3CJug2XH6xnTeiw2J2lGCUQXtdS/TaFuzJMyg++9/zjHycjNFb2YXT/IajmfqD/64SFiL4vmttXruCg6ifs7EcZc4lyK7BZAggT+RY5X9TAVpwGcvlUjnfLWEZlnsSq0lPHHBxABaTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713555629; c=relaxed/simple;
	bh=GGOxMYfUyz5mBNzV8xQPw5hgJqfGZNBqhOzyJ74RBsU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M1FkaCQVTOS3VmEI0SZT9DfH9HqQd+9+6F31cMxaGyXH9XuIrbwGmI2cAXW2qQRkuDPZH7zclPpbBLAuASmFIAVLNwQf0zVsENtxcwUlEq4osqWnV78Cb+m+S/x4/+Q8CxGZpGFEgWmMuohDxMHe6aUeRY3ArM4jY1d7bMNYMFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af0G9hBb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af0G9hBb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5FE9C072AA;
	Fri, 19 Apr 2024 19:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713555628;
	bh=GGOxMYfUyz5mBNzV8xQPw5hgJqfGZNBqhOzyJ74RBsU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=af0G9hBbQkbWX2wNiZ0ov4QMAD2eXNIfi34pL42WDjLoNrwQzZcfbZLTQicw+CqGo
	 Mmmy8qCvsMnO8KTb2FO4MPpLIN7qBYxk1KNr4RKwr1+UO/qoGDsEAUMA94kjzMFD8l
	 nX5tjSiPE7SQZrKwj9F1In8OdHSQhM5BAjXEoXN9VsMCZSRuYqcJyGFeNuTJaerOwh
	 VVa9gA9ZzyyQrpGtRT7a4r6VeSN5FraufsQPUE2lqkq+Mp3P5igIkBudO3+zhGIYr1
	 jeLXJbXwXrJ2aFuZmo/yZdfwJYvXpxz/aSOzZbakuRmMHckrCtwpW0KB41uhesbwZj
	 DlJN+fqTBStvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDB69C433E9;
	Fri, 19 Apr 2024 19:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client/advertising: Add flag to mark if data is
 valid
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171355562890.20392.7629648603176993309.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 19:40:28 +0000
References: <20240419144117.1554291-1-luiz.dentz@gmail.com>
In-Reply-To: <20240419144117.1554291-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 19 Apr 2024 10:41:17 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This allows the use of type 0x00 which otherwise could not be selected
> since the property would not be exposed even though the data could be
> set.
> ---
>  client/advertising.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] client/advertising: Add flag to mark if data is valid
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4dea3fb932f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


