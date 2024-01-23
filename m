Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F52525B
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048431; cv=none; b=B+Qj5ERZLg1abF+N3NtCX4yrnh1jrTaxSSOZFAZEDmuInYx5MpDE5tA2/YK2tCoGZVNSXZDtb5SlZ7lLL5e9Q74Yv6A8J/qr39XwdXI84nCjrXqjbwQwU/G7+5AGPxtCSnw0BtJwd6ksxmNuO/BLqRTMaXhEWNYTaVvzFYi30jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048431; c=relaxed/simple;
	bh=USRGgf9SbWejQqzacJqnsOVskpkADYf/FwvpnBdoTl8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DI0PgWFvzvigstikQearTmBsYQI69AqW3LMMSgCZk96epOnLVibgNaW0soruvtCSu+xX2roFm1EXVB6/kNjBAe2vOTWdCNM/dQUAm2GtNtNR+d1iir5QUz7fkiIvOiaZlwToEwrsptt6uBgr9xn/yBVaWOnydajOTEBlqpJbWwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzQGvAB3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzQGvAB3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFE78C433C7;
	Tue, 23 Jan 2024 22:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706048431;
	bh=USRGgf9SbWejQqzacJqnsOVskpkADYf/FwvpnBdoTl8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lzQGvAB3SfdvpruEguygSXn4UObKPbupJe8+pa3GJwqHW490DgIxzPH+Mc/wD2qPN
	 pquS6nh9Cfc3iZzgK9yCdIXm2yGH2OeNg2DTXRO0K6aLM7b9FqHq1BKBwNL0oG6UXu
	 N6QjDc3yzve6JYxUrq7WIxkynqjGBfAVfNrDgxnKpaDV9FI2ff7uOTWOrHP0OROklk
	 nj00OSFJcoGkPzxdoOyyXeuNecNQ+stnwr26X7UJ42ePEkUg/h1yB634RuGJoEImIR
	 LtFUZrgenJslfOgwFVlH2hpWJgJpc+mDJxrhE7yVwHrVeDFk4c8C9uSRHOymQH6Djk
	 MatZdUDVcQXoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D82A2DFF767;
	Tue, 23 Jan 2024 22:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] bap: Add missing Metadata property
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170604843088.27906.18022616923403585835.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 22:20:30 +0000
References: <20240123190427.3031698-1-luiz.dentz@gmail.com>
In-Reply-To: <20240123190427.3031698-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 23 Jan 2024 14:04:26 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds missing Metadata property to MediaEndpoint objects.
> ---
>  profiles/audio/bap.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

Here is the summary with links:
  - [BlueZ,v1,1/2] bap: Add missing Metadata property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=08bf0b2a85f3
  - [BlueZ,v1,2/2] bap: Fix not handling out of order responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d994c9d45dad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


