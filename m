Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029608;
	b=BAYGFfs0lgn6qSOFYrJblheAd3sH2WkhN17w4QTOP3Egrwoi0P8x7VT7bb8KORlm5eky
	 +CMmUHo/2yJBQy8/iE6DSGxBxb2NAleQAjBxu/1fOXrOb4xBCv2F5/af7GxU2vvmvR+76
	 urS8ErCi3z+4lshRiNeittRfjCIIwDZkrihnPFwxRvUfvF0J83Gh2x5fSkjDKtrGY8EEG
	 v49Hk9Bm+w+Pg7J0vWApEXCEbjJlF7uYv/nSLN9pn/gYwZDzBjOCAFt+vyoEou8MR6TPB
	 M0Tx6TKp/EWN2eEplCuTD43vXgpf7WKRx/AgP24jGh80pTYg1AExVHwSqI81kmBSUVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Mv5RBM8qm1BNltnI+O5XoDTI1+4tCBO0MUK6W+Jf9Po=;
	b=syJ4onfhSGBGnM4OsMVVCOkBs715YQLJue+aAhmQfwRgKGvLynIJEWY9XymaQBnIpb0C
	 gVU1RZ4FY4L9nk/LDC8N+sn8JhPT4clwESIiN6H0g+OKnVESrqcoXW1CwiQeaJXjUPSka
	 0auUkAWSkK+qBRH/YZaf6osqtHDj2l9S/0TjlWi6WW+hN5ZgSouvPZemspUAm3Sjr2yWs
	 QU5LIul7qHIqkRJjszt2k8ibqRSD9cAg9RFrinW35W4XjCIBLCYnGvOtaMeMW2fQYlvJC
	 1Qau/KYp/jrpw1CnwA5SAZAkvMqv3T5vfWrbQ4/SFKdDnTPSV44IKcTUlK9uOmmM0vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7h7147O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B47606A330
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7h7147O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421301F000C4;
	Wed, 18 Nov 2026 19:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029608;
	bh=Mv5RBM8qm1BNltnI+O5XoDTI1+4tCBO0MUK6W+Jf9Po=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H7h7147OlOFkK0cEOGEYOpCnnSpZBQ+zv6HIC/KBRSLJEd3z3Sohx3JD4hnelX94b
	 wlFK6GprW0x+yGd/qYANTEak2/QtH9NMdR4Q7IV1pw5hzPjwEJqBLUMdxg1din2lNf
	 TL9de8QAP2oE9OS7DndTYjpjH70Bu0EgDqyMlQVQ0Y/fy4OLlHcv8PmndKTzzUzG22
	 9GfG8YlZpkNud2zIDdHEPvNSHA1nwqRljRyW2jM0BNiJf+eQcnIBDBdWHSpy2BYrYs
	 jdvZCh0zA1hcPk1jZ6NNCLWZjUiD4hYvZQKW137tVjE6N0Rq/HLKlo+BaZuE5ptN2O
	 1PuXzdQYpQe8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3D93808210;
	Wed, 18 Nov 2026 19:20:08 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v4] avdtp: Fix use-after-free in connection_lost
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179502960678.2490531.3103046334132102769.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 19:20:06 +0000
References: <20261116090719.1226616-1-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20261116090719.1226616-1-jinwang.li@oss.qualcomm.com>
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
 xiuzhuo.shang@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Nov 2026 17:07:19 +0800 you wrote:
> A sink may start reverse discovery when processing a remote stream
> configuration. If the signaling channel disconnects after the stream is
> configured and discovery holds the last setup reference, stream cleanup
> frees that setup before the pending discovery callback runs, causing a
> use-after-free.
> 
> Complete discovery with the disconnect error before releasing streams
> so the callback runs while its setup is still valid.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4] avdtp: Fix use-after-free in connection_lost
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=43de1efcb453

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


