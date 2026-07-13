Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735835B65D
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973434; cv=none; b=MGTTOVyJK5hICzKXW0p+0r5sTmF4Xzw1Z6IeDNFpfmlumTF3QEwnfOFGhYDfANKCd0bj/1830uvcDdHGZTCv9lbAWyLa85FJxYQn2OSFJqOO5YgoAZGtL6NcdRD/P3qeIP5REv63lU/eImEDIc+p7rQM4U/VtWM68PrOah2UOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973434; c=relaxed/simple;
	bh=YmCpFpIOewr22v7orGG6MHfAfCpJLBu5ZZZNzIFmfI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AiNEkrhUViuuOSKm3ZkcUljC5p5TaN+jcoMChvpRg9G2/N07fBwbY6dtA4GMjikdJGqjYhjLZ9m6SHNE44T+BIgOBHH4rmXcSdqSs6Fb+z3hwxiab4LirFdKCiCVE8xTw6+XUhnRDQa5ScSNiFYS4y6reUEhfCHmJ/D6zC1wmIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8cqc1gr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8cqc1gr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6384C1F000E9;
	Mon, 13 Jul 2026 20:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783973433;
	bh=SNdl1MZYbBU0Mihfj4dnwCRx27+/Lu2QUo/aMz5FpPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P8cqc1grnys316eUDbo8a8OJHzre0F0a1Z9N5jXrT9sTGMit+cbjIrh/Jc80ZZ7tj
	 /bF8t8WNDSFk/ec4/7261ShHO0HIXMTcS9VZul98Ec1/z9hvDEfDR8d6oTyqP1fj9N
	 l5MJEW2c5Hu3y5/GbCLCQDIvfaYdPS8Hef5I4rrQfMbySlg4yhQSrgBGmBZC2R/bep
	 FhA24Fkl4sdxAyB55JkhlyjVgfheK2vDs01gQAKBya+9DcGpVp89hzKOwBGz8renpF
	 2uFRPf3Gtxa8bhyUEvSMpy2OnwuTXNbcI2cpPUL7G0TzKKwK3Eecl4oXKKZFD5jpkx
	 ZKI+XwGUdxQ7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A913924F90;
	Mon, 13 Jul 2026 20:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: Fix rejecting re-attach of the same fd
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178397340839.2830302.14457128904654690553.git-patchwork-notify@kernel.org>
Date: Mon, 13 Jul 2026 20:10:08 +0000
References: <20260711070230.26553-1-ferose2@gmail.com>
In-Reply-To: <20260711070230.26553-1-ferose2@gmail.com>
To: Ferose <ferose2@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 11 Jul 2026 00:02:30 -0700 you wrote:
> When the remote's STREAMING ASE notification arrives before
> iso_connect_cb() fires, the race handler in bap_state()
> (profiles/audio/bap.c) already attaches the io to the stream; the
> comment there notes "Order of STREAMING and iso_connect_cb() is
> nondeterministic". When iso_connect_cb() then calls
> bt_bap_stream_set_io() with the same fd, the guard in
> bap_ucast_set_io() sees an attached, non-connecting io and returns
> false. iso_connect_cb() treats that as fatal:
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/bap: Fix rejecting re-attach of the same fd
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7f826d003ee7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


