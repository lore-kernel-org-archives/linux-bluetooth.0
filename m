Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF342337118
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765819721; cv=none; b=ub7JlcOkvoBPhdXXOnBzez+UWyKYrKJvtZzbNYXsS0uCv4XJuhes4gF/PfWVDZ3i2mCUr+IE6ySXHe2v9bNF8/8ZcfteeHvO0NnbAFK8tHdAxRPa1qckATt3tNeVtG2dTNCOgGyehOjPDctlpiTtD+Y1N1zivphUA4LCsqJWbG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765819721; c=relaxed/simple;
	bh=XSj9HZFphARs/ASk9xxKln0Vf/KjpO3uMTrDMlj5zLE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q9EraLjOUJbIRctaQ8B7T+ukKZWkMPQIWl4qINqrunrir3h5sVMgHy8SRHF4Po14ULIPFtB1ZCa0P4mmT45twEIHahCHWQA45qSs4tFNrqgu+2SlToossYGf7qlGQdoc8YdfA5HJ4k7SHn8IV0MzYR2aMU6HlRpB3LoOm+V/BjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKxDWe0M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKxDWe0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3315C4CEF5;
	Mon, 15 Dec 2025 17:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765819721;
	bh=XSj9HZFphARs/ASk9xxKln0Vf/KjpO3uMTrDMlj5zLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IKxDWe0Mfi/ZTxacUTA2uB0tLDpn3VV1W16IqMztQEKF1XtnBdOeAGkJ7P/cqkFeD
	 EKBZVkXFMVAIMulvMDeNLTl6Ozn+w/JXOCrVm784vJuSrYk6BK/LKFudHCXzId6gE8
	 6PY1PtURASdbjQ8oI4EG7ToljrGVwFVo1Yg5xz67thJMBRXxaVWXD0DOnkdlrQDgEp
	 TNw8Jy2g0sau6rgXr9vDxom9X3YS58BSeyZdWnRdnRs2iks/0tihdIWd7q1sRRnXDf
	 lty+QXvopvw7vlms97BUdNHAR8miVpCyShD7VPhc1XWNQNkn1BAAVzdrMZus+OsRIm
	 I9HOzA9uimkKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 788D8380AADC;
	Mon, 15 Dec 2025 17:25:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v7 0/9] mcp: support multiple MCP and implement
 local
 GMCS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176581953229.111127.13320931968033257977.git-patchwork-notify@kernel.org>
Date: Mon, 15 Dec 2025 17:25:32 +0000
References: <cover.1765572338.git.pav@iki.fi>
In-Reply-To: <cover.1765572338.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 12 Dec 2025 22:45:45 +0200 you wrote:
> v7:
> - fix -Werror=unused-result
> 
> v6:
> - use only rewritten bt_uinput to be able to change license
> - make all patches buildable, combining commits
> - in that, split out mcp: add support for Repeat & Shuffle
> - fixup: re-read of values on track change if remote doesn't notify
> - fixup: make sure other values are read only after CCID
> 
> [...]

Here is the summary with links:
  - [BlueZ,v7,1/9] shared/mcp, mcp: support multiple MCP, and add non-stub MCS server
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9027edc4604e
  - [BlueZ,v7,2/9] test-mcp: add tests for MCP / MCS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=90d78210f222
  - [BlueZ,v7,3/9] mcp: add support for Repeat & Shuffle for remote player
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0a4a07d9a1e8
  - [BlueZ,v7,4/9] shared/uinput: add uinput utility functions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=be02c3e92e16
  - [BlueZ,v7,5/9] avctp: use uinput utilities from src/shared
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=174e812b8aea
  - [BlueZ,v7,6/9] mcp: add local GMCS service that emits uinput media keys
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d3089866bd2e
  - [BlueZ,v7,7/9] shared/mcp: on track changed, re-read values if notify not available
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6734c19cb4c6
  - [BlueZ,v7,8/9] test-mcp: check attributes are reread on track change if no notify
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=809091c8b3ee
  - [BlueZ,v7,9/9] shared/mcp: complete CCID read before considering other attributes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2ec29cc98ad5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


