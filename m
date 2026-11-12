Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514806;
	b=Pd1tYao5oH7i8zHDiprdq2RoGfv/WAqfRDb+36okYfstPTU45T0MupSK3SYq5BVrPL4q
	 uMokbPnrmlkTSLuP6m2fhpnzjo51dafIboBB0wWNfE2ynm2F6WGIWXjBGb23KT5xHHuC1
	 6g2PtPGvkemevbkIDCGD1Z79xG+g/xNIDVgd2tAij/MpSJwN/T32l4vRuTYbq4wPld+F2
	 7pPGvy9D3vPOuyISrHuoGxSkiWHbX99g4+qiYWhUWmQHFYm+vHLc5HtBv01+nCpvVy/a3
	 7vGWf58v+tuZEzxqFX8sr8SE+Ho06f0pklMZhyIIq2Qd5tU2O8y7s+2BKLSwQP9Rzfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=sOUSQUlOuiiLtiJvh4uWdl9GFgKpaaJmN5Pvd9I9Y6M=;
	b=Wu/L5tX0dvXhgG+s5Kk8szivvSnU48MTBSvYyYE1LoTh4h8svdw9QhzHn4sISm1B5WwH
	 XhKUIVuX8XqOOl4fA2HEztTligSg6NW6ORe/Fg2HxgDhpC2Hej+AAXTbRRV0zNiOdTPNu
	 4pZM4GZoF8y+6prFPYfgvPVLAWambeLpOUpituMh32cTOhRuSPAtoFIzb0QidMhaF0sCu
	 4cVzmX/8zaQLsbi7JjXj7w8xeKd7Je6kqVSr7Oicd+POMHIRa1/xm/Y4kuveNijHm1851
	 tzKBMbIgpEFNNAeFDhfRF06dC0CI4KUpMr60IvgYgudR4A6XlAKILg3hc1PnEItfaxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XejwkhS1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0696606A323;
	Thu, 12 Nov 2026 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XejwkhS1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426931F000C4;
	Thu, 12 Nov 2026 20:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514806;
	bh=sOUSQUlOuiiLtiJvh4uWdl9GFgKpaaJmN5Pvd9I9Y6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XejwkhS1QUyIww5e4xS7yJFMkye5trk9QlSP2S4k/HQpKb9SNALo/WQv890v/hoyO
	 uEO4SK+KTTuXAROSvfJYPtOd/bH+6tFWEgWBz7pJUQ9qSnY4dnG+lK6L9E0RPwczma
	 Dp8d/jbfilFwFsBNkNjPYHWuclg7Luew+tiCOY73SsfKxOFvvPzOzOXFAiKhq6M0Dj
	 TpWgdagUVIo2miYKSoP9zex7IByXsXllnVg7qZiBxF9Q1U9gaJUlD9jJGu4hxJ0t5v
	 G/lTMj/ZIBf75+F3GAelCl1laGbHTN8vBUEH8pyqIC52j8e8RZ7kmANLoD+k/8tpk9
	 EgeGGSnLqqYrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3693926259;
	Thu, 12 Nov 2026 20:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix size check for receive buffer space
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179451480503.628769.12990613488160990578.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 20:20:05 +0000
References: <20261111214905.518429-1-amirabudubai@gmail.com>
In-Reply-To: <20261111214905.518429-1-amirabudubai@gmail.com>
To: Amir Abudubai <amirabudubai@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 marcel@holtmann.org, surban@surban.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:49:05 -0600 you wrote:
> Check that available receive space covers a full MTU-sized SDU and its
> overhead, rather than just the overhead. Otherwise, credits can be
> exhausted before an SDU is completed. This could result in a deadlock under
> some configurations and SDU combinations.
> 
> This follows the SDU-sized credit policy from commit 96cd8eaa131f
> ("Bluetooth: L2CAP: Derive rx credits from MTU and MPS"). Clarify the
> comment by replacing "packet" with "SDU".
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Fix size check for receive buffer space
    https://git.kernel.org/bluetooth/bluetooth-next/c/3b069de8a5d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


