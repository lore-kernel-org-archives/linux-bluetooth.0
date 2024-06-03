Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB96405D8
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442431; cv=none; b=dq8h1wdov4AgK85dZ99V9IBemGHG9Z1ZYl+6zegK+Vet8q7l+wywJt07eFevEa9+k6U2qOX03jdARoDrZLnIMCPdz2qAKEGuEh7lpiRoPrdK0uOntYq2QRhJph3+tmDW6SDAAsyMghJLvxNRsClIsUAe2Yvi4VE7dVngNESaXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442431; c=relaxed/simple;
	bh=nog+91wN50PlxmPtW65u+0eM/JzsVdW2ITXsFC+4rGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TaD7b43dLvMVEwcFHBZuD/BnkxVgcoXaKmUsM4ugCYrC0gBeBY8IH7I+hr7yuxpYx6bkmree1OQJYnDt/A0yPrZSScrTteWvnxt2NYoKzhDaDKbTuUxL35WHBPJx9ukziLJ5oRBPqlVuv1VJrTcXi8e9SvEWLJg/77aeIPgLjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sie4ng3B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sie4ng3B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F893C4AF07;
	Mon,  3 Jun 2024 19:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717442431;
	bh=nog+91wN50PlxmPtW65u+0eM/JzsVdW2ITXsFC+4rGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sie4ng3BAzLZcWU5CoE0NFS9qw5s8Lq93Xxx3iPu6T+b+nbDSWSxqxMF2vM2ZWcfm
	 49C00ddxxx83T3uDobrI8oCsfkFJ1TDaDhCcg8nsdCDW2nEC2ixJFPaVCaYpdVLT8S
	 dfhjkYl1d6TUoQvdZ/FtA2ZMmIyb48kob2cJIZFKW3JZ+b+JW3YwlhO7QQGDK+UVmJ
	 6Pz9DzmsR6Mnl87opIlfnqSs9F+F8OSL/0X0Qxf04H57iVasJEcPFyI4zXSUVyWVMx
	 MLf4f4VxsAFAz2mq3MV9W7sqeFg2D8UoBMQNb2iZBHB0M/ZUZ6vDh8EppORTpUDabp
	 SAzXnWIbD+B+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43729C43617;
	Mon,  3 Jun 2024 19:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ 0/9] Fix a number of static analysis issues #3
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171744243127.17125.6571783732357865049.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 19:20:31 +0000
References: <20240530150057.444585-1-hadess@hadess.net>
In-Reply-To: <20240530150057.444585-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 May 2024 16:57:54 +0200 you wrote:
> 14 defects fixed, and 1 error check added.
> 
> Let me know whether there's any problems with the implementation, I'm
> thinking in particular of the avdtp changes which are pretty invasive.
> 
> Cheers
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/9] rctest: Fix possible overrun
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=24cf04939502
  - [BlueZ,2/9] mgmt-tester: Fix buffer overrun
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aa54087f13d5
  - [BlueZ,3/9] l2test: Add missing error checking
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ccec5e8ef171
  - [BlueZ,4/9] rfkill: Avoid using a signed int for an unsigned variable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c9fcea121f9a
  - [BlueZ,5/9] shared/mainloop: Fix integer overflow
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6cf9117bfd3f
  - [BlueZ,6/9] sdp: Fix ineffective error guard
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bd954700e631
  - [BlueZ,7/9] obexd: Fix buffer overrun
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1764cea5c7fd
  - [BlueZ,8/9] bap: Fix more memory leaks on error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cc8e6ef63509
  - [BlueZ,9/9] avdtp: Fix manipulating struct as an array
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


