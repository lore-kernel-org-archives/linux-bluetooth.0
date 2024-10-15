Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B621B395E
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009821; cv=none; b=mNUOmh/tL33g3YntzvmV1urkVSYXR65I7c3nJ59P02tg0062zgff8IZCdjXUZi8qm7/qStSHIWvFpu7UL64YIRm1WxqF1KWjuQHthXStSFQny/QwFcFn7txA5/9eTp+BzevVxJr4mdMr9BpBIQFLqAUIFn2h4CaZ3tOYn+2HSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009821; c=relaxed/simple;
	bh=FgON5Om3rKaoN4TKocO7hZ9b9nRLVEFWYhnuAVb718g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fomhl9QwDGqlAtYlIY8VGdC/fsouSxYr1yT+gQO0HR4k0WTHBCvoerKR8GIB8ipMA2fvo2WA8g53Zecb4B5EXnAnupxdfnN4e3WwGxWLkZ1HdQ8GllE9ndgvtnJNvM8BO6J2oPxs7GSUZIPZ4UAGTVGaUQu/hWbxzNAByeCb9tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFpiTghj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFpiTghj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51960C4CEC6;
	Tue, 15 Oct 2024 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729009821;
	bh=FgON5Om3rKaoN4TKocO7hZ9b9nRLVEFWYhnuAVb718g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iFpiTghjGy4t9vuOsBP9O+zK57td+5/sAUiC03kVcK4T/wG6pARklbyrQe5U3FXDY
	 fdhZdGBZUTh7+8gcBbCKvC45m9HMjBVR412OEgqvy2ndraMlyEF4+x3Cn4TONdFKiI
	 j6PIZ9ef4AmZU7zw/4nQGJUV5tyE0SLcHTg/A+7CNUh2fX4ywXsZpbmRK0FU3Exe3U
	 SoWn/wIsjLhryGMoRhNpVOnroVXDttfk62hRbvu1I74bIvFpQV8vwTK1WsKSY5dfvH
	 UCW3YF/Mi+Bw3YfaD3bnhxBJMWc2suftkaCqZfH08XHOfh0+GpuFJ8hg6opUvosslF
	 lU23TDG2hmC4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE183809A8A;
	Tue, 15 Oct 2024 16:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] Bluetooth: btmtksdio: Lookup device node only as
 fallback
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172900982650.1218646.12147169588333175190.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 16:30:26 +0000
References: <20241008082721.4004100-1-wenst@chromium.org>
In-Reply-To: <20241008082721.4004100-1-wenst@chromium.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, sean.wang@kernel.org,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Oct 2024 16:27:20 +0800 you wrote:
> If the device tree is properly written, the SDIO function device node
> should be correctly defined, and the mmc core in Linux should correctly
> tie it to the device being probed.
> 
> Only fall back to searching for the device node by compatible if the
> original device node tied to the device is incorrect, as seen in older
> device trees.
> 
> [...]

Here is the summary with links:
  - [RESEND] Bluetooth: btmtksdio: Lookup device node only as fallback
    https://git.kernel.org/bluetooth/bluetooth-next/c/cbb516bbcdfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


