Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AF83BBEA;
	Wed, 15 May 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715803230; cv=none; b=gMDq8iU/Gi1wLp4w4Hy32TfnfkYpm3oGXIcG7h0U/jYkxiV6V8UzmshmQCBh18vTa7FGmVbXNbEyjb6bWRyi/a2prJadGyCre17WW74vod04Jm1iQLu7dLhwUwoqm7BCpx+EG5mz9eotTHQoeFKYN2UZyw7KBhjU4Tn8ACGAiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715803230; c=relaxed/simple;
	bh=gezJVNyXWrZVZTb8KuqsmOP/7coKyvtbTCJzDLiS+8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pp4Qlx4JiPLXGYXEhbnROzeGSrae72RzVnh5xavxnhJTAhH9tOIkjqRX9li0KWYtwn9yEAOB8qf7dQRIlbJb4oQL347k5Nk/8D4k3JwsDpHiXwlvu2+tIZbHof06pPHphpgxZS3IbdGicW5O7ZYXw7V4gJZFiYaII9PbjNkCCNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkXFeHut; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkXFeHut"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDB0BC32781;
	Wed, 15 May 2024 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715803229;
	bh=gezJVNyXWrZVZTb8KuqsmOP/7coKyvtbTCJzDLiS+8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TkXFeHutZ3eezwOBJsU1SZS1E+JtND1RWFStjVCjjFEhejjd5mbLbXloyoUQMhUH5
	 s6SH/d27oxCM/zwB/6ufYpmqUoE9Vws+DqTrVCfwakryQycGCf5WMPhAAbs2wa+58P
	 FG5NI4npfeT+dOAuojF18IaQ7vf/dDL4jySdWwZV+O/kWPZHidYKZqnQ+6XCZjDbsk
	 z3/duZ8glvt31hBsm/C/tZURZN0gieMUqp4UaQA9LsAiBBneaimjs7ldYo6/63Ex/p
	 DtPwe9V2ssT1Gld9rzB99FFw3GwkRhND3qei28PdHnVgmNf4XaA9hh7KeHucjeXurF
	 tOM2UgW4vwadA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8258C433A2;
	Wed, 15 May 2024 20:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/3] Enable status prints for firmware download
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171580322975.27792.4751752969653585130.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 20:00:29 +0000
References: <20240515070657.85132-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20240515070657.85132-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
 ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com,
 guillaume.legoupil@nxp.com, salim.chebbo@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 May 2024 12:36:54 +0530 you wrote:
> This patch series enables prints for firmware download functionality to
> help any automation tests framework to verify this feature.
> 
> While testing some scenarios such as downloading corrupt FW file, if
> the driver is removed before FW download completes, or FW download
> timeout occurs, a kernel crash is observed due to Null Pointer
> Dereference, which is fixed along with a print to indicate automation
> framework that the FW Download was Aborted.
> 
> [...]

Here is the summary with links:
  - [v1,1/3] Bluetooth: btnxpuart: Fix Null pointer dereference in btnxpuart_flush()
    https://git.kernel.org/bluetooth/bluetooth-next/c/50f1fe988518
  - [v1,2/3] Bluetooth: btnxpuart: Enable status prints for firmware download
    https://git.kernel.org/bluetooth/bluetooth-next/c/aed74319d44d
  - [v1,3/3] Bluetooth: btnxpuart: Handle FW Download Abort scenario
    https://git.kernel.org/bluetooth/bluetooth-next/c/3b42b64036e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


