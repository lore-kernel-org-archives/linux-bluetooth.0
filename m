Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25372367B3
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153198; cv=none; b=iJp25W0Evdr1/0zv1JWHudg2IIOVF9vuzDgWmj8Bv+2BjFhj9HpHa/NrlOgYTNeLn5PyR5dHjCcgTg0wCEO6nMgUaChzB0DLUmhOASqqz5zR96FfHkOk6wxPJwWhA5YVT+FNQurssROs/RyQm7udRwlLxraUcqWiFM5yE/7FEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153198; c=relaxed/simple;
	bh=AzLfCcv909mwzFoADsOom3KD1vIGBa20If8nItesuAE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R4/bkYci1HYYgO/eesIH4UD8YxykwbzNKZk0Aw7TmqobYxzzYKy5KMOp7v6o1OGa4CyT2sw29yeOtukxnDR/PrDAt6N1ujQmk3d9ZxKVpvaZqaEABnw9OFQh42GUXU13323pZNMOyvJwEqtdftG0VghqE2dtw846Bhn5j7TrKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIjxCMLx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIjxCMLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC3AC4CEED;
	Mon, 25 Aug 2025 20:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756153198;
	bh=AzLfCcv909mwzFoADsOom3KD1vIGBa20If8nItesuAE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CIjxCMLxvIZJdUZG1zLXdFCLLxrgNuKTqhvDuekA2LX0hXqd7XVJEeXUHHAW6dYXh
	 f/8qNzAiSUdqEb1G2++xORLR99wjeUqz1Vx05jwtM341E4jRGxN/mWQqHv05mSMHKL
	 PURtk9haOmTnhMphhWksQT64YugUuyJ1JrD9nfZY4r/VWOMyWtOk/oMEsuK5IrZG03
	 lTvFmbVaZAonW7KyLfSy4ZN12+4fkV0LnRAnbf1X3lsvPSNuX/BGkUywZGWLJWwdY1
	 nTjr1uC0ANE9k9ur3GejuBOYcyGl4Sqq+edVy6Xw7Xx8u8nyjVtjvcBc6XVqqA2zQA
	 eEBJ8Mov4GKEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE4383BF70;
	Mon, 25 Aug 2025 20:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] lib: Add missing includes in bluetooth/hci.h
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175615320625.3544818.8738826691872401286.git-patchwork-notify@kernel.org>
Date: Mon, 25 Aug 2025 20:20:06 +0000
References: <20250825183159.340527-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250825183159.340527-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: hadess@hadess.net, linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 25 Aug 2025 20:31:58 +0200 you wrote:
> Compilation fails when using bluetooth/hci.h without other includes.
> 
> > /usr/include/bluetooth/hci.h:310:9: error: unknown type name ‘uint8_t’
> >   310 |         uint8_t         lap[3];
> >       |         ^~~~~~~
> > ...
> > /usr/include/bluetooth/hci.h:383:9: error: unknown type name ‘bdaddr_t’; did you mean ‘daddr_t’?
> >   383 |         bdaddr_t        bdaddr;
> >       |         ^~~~~~~~
> > ...
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] lib: Add missing includes in bluetooth/hci.h
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=61c49dfa2e8d
  - [BlueZ,v2,2/2] lib: Add missing includes in bluetooth/hci_lib.h
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f911b6df4fd1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


