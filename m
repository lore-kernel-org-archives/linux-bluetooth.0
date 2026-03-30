Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C538425B;
	Mon, 30 Mar 2026 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774902022; cv=none; b=XbI8essX2wYMEbALKyt42rEmef7MNmkqfsIJCitakBBGXwoEW5G3dWm1s/SsJ+zp2rqZEN7INjg5X5oWdr5ULFzoRp4BmamcP55ZtNvriTA7IJTjI1KR1OUrdvZcn0iBCRKXmWRdNCZLYffLs/HgOMjhKhGQiupPn/8zLGu17ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774902022; c=relaxed/simple;
	bh=Z74GH4Z7tQxKEodzrIL7A8Zfa5+PbVeIbHIJfXaPLM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d3SPcGwTcid8WTRKrZTv+xbROQZWt4BP+paFOhj8yje0PV+C8uxVEG2VS5F3QAS8A1mBim4z70vZN8rVxX7ModZz+Mw7KYOpYJdoQzjqSg2uVrE7VQVXneYdk9F4W9BuZRoXMOh++AF8HLMMZhwYwEGefcXcommK9i2YUrjEAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvbFfUUM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvbFfUUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742C7C4CEF7;
	Mon, 30 Mar 2026 20:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774902021;
	bh=Z74GH4Z7tQxKEodzrIL7A8Zfa5+PbVeIbHIJfXaPLM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EvbFfUUMsKsrkJ2FGykFI7D7Yo4DX6SruDeMlBOu/NedGjpc/HCx0WGsz5TaU4+o0
	 V4sg8ojoosksXoXYBnPfUdJNu4dh9cLwusZ64XJuQxXIgI3Dyp/YxUgque1Wv6+4rN
	 MTrEGI2zNWZsGKYdRECaPEDUM97HW+ksg+CWJ64Rc3/aViRXNfsEG57pvBfQNy8XgY
	 Qp22GmIdj9xX7VWfSLM7clT2/Yz+vEFGKudeqEfmlgqVAd/zQqDHh9Sf8jQBiNsQg6
	 Q+qk13f50SymfhnbZAIq6zaSzUgZTLhdV/29d3PESeuqRXeJFDum79ZDSlvrIB0NoO
	 h+QwTBXLnLMJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B23CF392FF83;
	Mon, 30 Mar 2026 20:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: validate LTK enc_size on load
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177490200553.1507090.8760884418467627395.git-patchwork-notify@kernel.org>
Date: Mon, 30 Mar 2026 20:20:05 +0000
References: <20260328084648.51158-1-keenanat2000@gmail.com>
In-Reply-To: <20260328084648.51158-1-keenanat2000@gmail.com>
To: Keenan Dong <keenanat2000@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 28 Mar 2026 16:46:47 +0800 you wrote:
> Load Long Term Keys stores the user-provided enc_size and later uses
> it to size fixed-size stack operations when replying to LE LTK
> requests. An enc_size larger than the 16-byte key buffer can therefore
> overflow the reply stack buffer.
> 
> Reject oversized enc_size values while validating the management LTK
> record so invalid keys never reach the stored key state.
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: validate LTK enc_size on load
    https://git.kernel.org/bluetooth/bluetooth-next/c/2ba40afb67d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


