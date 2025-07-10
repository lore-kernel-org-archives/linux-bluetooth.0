Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF051274B49
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160167; cv=none; b=MGoq/GjUPJ4+Yqg4mUUOQbrynXi5hDBAwfxvHQk3x9G2ev9OA9B0dUGrH2vbWYvqBgMR+Hk8KZrNt3wmDqgKlutqb4MuguoIe7HyWaN8sci/3arOOVrZLpsp12dmisu4z9B4Z8QIEObS9IB0uwVm4Ho46xI2NMT8alDkAF1/TB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160167; c=relaxed/simple;
	bh=4tZ2NQk8Mf0V1z01zAlnCDYzxN3AMwtMFIJh5vPnqNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IGtiJAcTVbHh3GlmA98NcjLJTeosvw7R23bgKyq0DoRNDSZ2wibhrxOXA8cjzHTRHKPEFszSq9gUMMeRwyLGhs38Lf+3nKxjdI/8UUm8/MJoGZRCNsbI+A9y2bBPsgkc2vZRe4mmVXudxgLbGwMdkmSbpTA4fI2xlajbRh3O2rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYBp+p+l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYBp+p+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7083FC4CEE3;
	Thu, 10 Jul 2025 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752160166;
	bh=4tZ2NQk8Mf0V1z01zAlnCDYzxN3AMwtMFIJh5vPnqNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tYBp+p+lag0Ks2+Ul5ILsT9bHd33wf/qQmVeXwc+ixzbR3h3UHIJIbAsLMIeaV2Tb
	 iL+PcoUK3T3aISqnd+a8svrkakkAzFNrNaBKMjboq0DSrreuzvFrBfTL72FXE0qdtC
	 JPwAcXeInSG8W/yDL5sJ7Mr4Jmk111EdicN6YC7nPT7YzVT1/pGCVZSZDvyITPyQpg
	 judVJxzoMH+sOOK6B0TI0eKagEd6S+UyZZqZnwQ0XMc6qQtOzHPPvO2JqxRkAD3OY3
	 CoUM/EqZZOezhKWPF1AlroVsrNcVKOYJf6kcJcMC6B7NSi11bEo1IHmaxfpwCMMIih
	 pj7sRDlMjYCEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF44383B262;
	Thu, 10 Jul 2025 15:09:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] avdtp: fix not adding stream to global streams list
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175216018849.1518208.13184049351979947989.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 15:09:48 +0000
References: 
 <987505e5b8dbc97180e5fe8e112c6435f5435754.1752141846.git.pav@iki.fi>
In-Reply-To: 
 <987505e5b8dbc97180e5fe8e112c6435f5435754.1752141846.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 10 Jul 2025 13:08:54 +0300 you wrote:
> stream_new() shall be used to create new avdtp_stream, so that they can
> be found from global list.
> 
> Fix one case where it was not used.  Fixes crash when unregistering lsep
> and then disconnecting, due to stream for the removed lsep not being
> cleaned up when SEP is freed.
> 
> [...]

Here is the summary with links:
  - [BlueZ] avdtp: fix not adding stream to global streams list
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=47a4c73cd553

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


