Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5059F219E0
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812429; cv=none; b=qTtti5TlvWkBVo/GZFKEb5PfFlhDg6rSz4gusu2vO/zG2MEwFXSzhJwfCYoOM1f2BOPuSHYL58qiCE+nG1uUoTPfBlpAGhtMcJRWvYDSTfn+Gl14NH7x+Lxe+F0qMVvLw8gZUJkWqor8JhFXNgVhmmBdCcNAFCfW6nH6RraZdM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812429; c=relaxed/simple;
	bh=2S4ZmwLTTWyqSY/BeUO7d4TQPA9hq7APUgSB899dnn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hwbx+Ag5QMWyQFACPosiTJetcw+HJcsypT+xrlidPASFZG4CmQpwc6843ahGOtxr++WX8suTEKicxtAkn0jrySV63Rm3iTgNgHOzETY7v3l6IvxNAXl9eZfi+23b/oZztAhuQwiEoR2kX+Z3A13+EW5Bpbbp3g1pOjpolIWhrME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQogmj1X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQogmj1X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD53EC32781;
	Mon, 22 Apr 2024 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713812428;
	bh=2S4ZmwLTTWyqSY/BeUO7d4TQPA9hq7APUgSB899dnn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QQogmj1Xw3GJajq/kbVrpwsSTLaYjWTgQRVojap68SbugM6eNuXHuyARDPdso2by8
	 eMMwDWWMeLcz1c+xB3UjNZzFCEXhix6oIaPtBgHcWipSGkOdLlAYh37Bh6Bq2y4AIY
	 cRN2XdUPjy1eq6WlngGVWr5ezhIs6DDQ4n6bBdgZ+jYFEq5pzznGzqEK4JWmVQDWpz
	 ICWapcAEfEP8hcrzPatygahs4vprTi8Okqvll+inD9lwNAiuQwJlYmV7obA0P/oQju
	 rRaxwzZOyvaKP2aowAzbWVhN06qDRZR0CPO62PSumPVb89a2rinaO7K6hRboRbrLiI
	 PEffSTlUhMhSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFFC6C43440;
	Mon, 22 Apr 2024 19:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] bap: call select_cb on bt_bap_cancel_select() to clean
 up
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171381242877.17315.12226090771892122097.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 19:00:28 +0000
References: <7f5110805a5180fb910d735f631c6f3b9a19dee4.1713624621.git.pav@iki.fi>
In-Reply-To: <7f5110805a5180fb910d735f631c6f3b9a19dee4.1713624621.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 20 Apr 2024 17:52:48 +0300 you wrote:
> Have bt_bap_cancel_select() to trigger the callback function with error
> code, simplifying the cleanup when ep is freed while SelectProperties is
> ongoing.
> 
> Fixes bap_data->selecting not being decremented when ep setup is
> canceled, which results to transports not being created thereafter.
> 
> [...]

Here is the summary with links:
  - [BlueZ] bap: call select_cb on bt_bap_cancel_select() to clean up
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e5f3433dc5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


