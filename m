Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B20910A35
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586029; cv=none; b=DAwzAJEqkUhuQwWaZwkldNZU8VM2n5WLgLh5Yroq8qz6wFFvubvEkFhxvDVv2hScapMCbeFLMkUFohfKivsCvi9G7N2DlHWt98iz206F1WtCQrwxu6b6fbiBdVtDoEhLNQKYZsfX2NzHICDoKS/xVBVAuhF4gJkxLOh364BzUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586029; c=relaxed/simple;
	bh=wCnQSDBI5MZ2qv2TWiab4MrbkXGAmdP/Nzxcj7L+SH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e1VjctqTjiJGVNKqFBWSa7J5Rm4tGTpG/MOomZMvz+0tjAxDp/0MVrhvy4XA6wZQsElvZAiA/qH9LBn9LTpgxzJcTZd4evrJEqv0mlEOYlPgtDFTgQfgIUJFDNBM+iKt+rBjHUT+NN2AjJsSsFYtsE2a/ckLYGYFtXX69AcI3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REVnTeMq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REVnTeMq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE8BEC43394;
	Mon,  4 Mar 2024 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709586028;
	bh=wCnQSDBI5MZ2qv2TWiab4MrbkXGAmdP/Nzxcj7L+SH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=REVnTeMqk/FubTSp5hhvkgIncsKIUzGGeZvXQAZ7AKEe4Hn9i1IR5d6aD58Ux8jxq
	 4J6q0AjHE6JJG2PuD0Oa6LnnbmZU4ko0RKPTHxMlMrk+BgIaBxSN05WOPX03avG+4q
	 eGhAZR8/ZdvCqzleFrrbBpjtUBzy0o/Fc1Hc4m5jUYWbFod/gKMjok30zz5oucBE8b
	 LuLbdDwDwKm7ZlfUO55jnCYSNf5JON9kIaGHZiLDOiil+S82tM57xgEQb2UQFN1atu
	 tqXtD8bzuikx9DI+UcjDyT7WHGYFIp2h4aGXYmndUgNFn30PCtishC9VzU1HdwqTKX
	 Tml5NjWZQuQNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2100D88F87;
	Mon,  4 Mar 2024 21:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH BlueZ v2 0/2] Add support for signed write command
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170958602879.11728.9496552961788201433.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 21:00:28 +0000
References: <20240304155839.48888-1-frederic.danis@collabora.com>
In-Reply-To: <20240304155839.48888-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  4 Mar 2024 16:58:37 +0100 you wrote:
> GAP/SEC/CSIGN/BV-02-C request the ability to check that signed write has
> been performed successfully.
> 
> Move the storage of local and remote CSRK keys to the device object.
> This allow to pass GAP/SEC/CSIGN/BV-01-C and GAP/SEC/CSIGN/BV-02-C tests.
> 
> v1 -> v2: Move CSRK keys storage to device object only
> 
> [...]

Here is the summary with links:
  - [RESEND,BlueZ,v2,1/2] gatt-server: Add support for signed write command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=71f0a1e88d9a
  - [RESEND,BlueZ,v2,2/2] device: Update local and remote CSRK on management event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3eba64ba2c85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


