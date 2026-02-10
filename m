Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EF38A9B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746410; cv=none; b=rEuDfRw76fzZMOgr0B1XNwO74YGhfhrivXW8QBKQVv+bHGZ0IlwmMiLCUzKAsEWv8CZ9uiLLJyG8UXEKS9SLlU8sJcKBGzJp0CZarnwF5NfnK221HQqEoquTeEteuXg/MPdGfsZnCuzYp6hLqifKBY+5bvERhMO/YEzdKmvLfhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746410; c=relaxed/simple;
	bh=Cb4+LEPragJuCC/NeKrII2sV/xrrJ0EdXO/IOVfsFfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r9IugKSw30k1QvI2FFHvrCZ6xGWoTi5wAq2I7H/QQJ2Zkkn39kER7FeuNoq9OmKdD9f/tcBaDUUA/QvkZKVKqdyu29GXp8eNhqXhGV1ztrMMTH29Fq7niTLXzwy9ubJzEImUWJ5+wQG4kbpYp7El0HkTPC1eKb+39xjI7hVvXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkJQXYfT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkJQXYfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C15C116C6;
	Tue, 10 Feb 2026 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770746410;
	bh=Cb4+LEPragJuCC/NeKrII2sV/xrrJ0EdXO/IOVfsFfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qkJQXYfT2TXc5gUJpNdbHfbyZxGgVyf8riNOgyUI8DjAdBbi4yvxGPS2mYm/bGTxp
	 ezS3EUbZ5YCuaas5X4J58KNFd1XBdV4fMLKLqssOsfHAxxVbw+n5T27Vlbij+vOJfT
	 yP5JodYbaHLg/kaz1SytypFmUbhk1ynZKMx+w3LHqKSfm5UZHbhASYWJTJjihDSZbu
	 jIz0/mJQ+Ffte37eyRA6s4NZtkHcvVhhKyPcJFueCLby216edMqn/3mH+yLMYnMxOV
	 cqggmduSb9xxEmdXk7/o4CEIgJdhWHa454eTJtSkEJGuN2OTWyDaYsERdPD8H7sIgY
	 HwW1JMQaBi4nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AF1B39E3B79;
	Tue, 10 Feb 2026 18:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] emulator: Fix compilation on big endian systems
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177074640557.3616367.16240515640902857241.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 18:00:05 +0000
References: <20260210093254.3246483-1-hadess@hadess.net>
In-Reply-To: <20260210093254.3246483-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, pav@iki.fi

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Feb 2026 10:32:47 +0100 you wrote:
> This fixes the build on big endian systems like s390x:
> 
> Remove the "static" so the array doesn't need to be initialised
> with constants.
> 
> emulator/bthost.c: In function ‘bthost_setup_sco’:
> ./src/shared/util.h:43:26: error: initializer element is not constant
>    43 | #define cpu_to_le32(val) bswap_32(val)
>       |                          ^~~~~~~~
> etc.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] emulator: Fix compilation on big endian systems
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f1eedda9cefc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


