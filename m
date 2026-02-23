Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D2237C0E6
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887371; cv=none; b=PCMmM60gU8iISGfwT/kJxIVHWTLlao/w3HSvylIvroOdj/wgeuDhvdZ1YaUf9+TCESCS5DW4yawZAXIIRMdDsy8EID9R8c8xtKTJMHWblofBZwOsom5XGAXr9IClXj/sJJKeK+cRNJ6xChwek97KqANnl43RZQIG2VGkeTTpuXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887371; c=relaxed/simple;
	bh=hXjo3gfjHuqNWO9+gAofisf2TSZgfL4gnkkUtSIiIAM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sx/tgdCNjolJyEKJeJx7P2LVxxWDmUb3DMDlDJpubShPipQUKCvkIEIkcR0wKI63GlNSw/9eBPIFM/v6A0ZDjN3bwHkmYoudAcv4c48appOyrpVpCmIZZ1eTaqAXlp/yuI7hNok1lAWWZV8FcuYAHZCIfM+Y18c83AEPSIbOR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOwDhrNL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOwDhrNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643BCC116C6;
	Mon, 23 Feb 2026 22:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887371;
	bh=hXjo3gfjHuqNWO9+gAofisf2TSZgfL4gnkkUtSIiIAM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fOwDhrNLdqFGzWczxSAvNyRFX5Pvc4yyC9JhIgefXqVE0n+srPSMe2Vcx6qg7Di3F
	 iagrjdQDdIVivHThQMtT098zhp2aDTglrpo296ose6SWJMxfQToEG7o8csKyqvwl/8
	 29N+e7/QBAX5ONJuFOa3Pyify+rTtNZuw5MRITVy/Y6C77+85nL9kP6/K/5N0ov/2c
	 /YY1KMVaIfi2h6gFge8cjK4p0C155AgPThfQn615vV/Kpps9huURryAcqk6P5ag+HR
	 GWSdl+B2ZI19MmLjhi0ZZwgJEo5jdK+RG0w4H+hE2ImI4sS8MuuShP9FayUsoSLw6J
	 ci14rR8gXisSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F113808200;
	Mon, 23 Feb 2026 22:56:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] l2test: Attempt to use BT_SNDMTU if output MTU
 has
 been set
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177188737728.2662735.10739666292740323200.git-patchwork-notify@kernel.org>
Date: Mon, 23 Feb 2026 22:56:17 +0000
References: <20260220200850.3460177-1-luiz.dentz@gmail.com>
In-Reply-To: <20260220200850.3460177-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 20 Feb 2026 15:08:50 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> With the suggested fixes for L2CAP/ECFC/BV-27-C the kernel shall be
> able to accept setsockopt(BT_SNDMTU) in order for an applications
> to require a minimal output MTU greater than 64.
> 
> Fixes: https://github.com/bluez/bluez/issues/1895
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] l2test: Attempt to use BT_SNDMTU if output MTU has been set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=290f9973c906

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


