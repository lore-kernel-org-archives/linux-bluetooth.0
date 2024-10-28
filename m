Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3348618FC75
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149225; cv=none; b=PeJMVz56IdGT1BpDm29ltPrAnR5q3Pnj5jSm2L9kRB/Y2c1YsmwUJo/q6A1RsNbLx2KWadFwed5wG/yk7v/Oa9ATGoKPFFfHfcECT/EvobSVuxc67f27JvYzJNz4sk7YOHYdHTJUplGXzu/FAzy2bPRo6/bhlPmhNamkW2+TmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149225; c=relaxed/simple;
	bh=bSJ1/4LGL2AYhvTDH3ONgHfqpVc7cjiSelQiTgmHRJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iqxMiFFR7gxgrRz3yT+rIQtXsxmesQ594YHnFaHywsqQBrVPJ79vd3Se+DRkusn+Gl+EwFnVslUCQFFtXmchIdNLLSTYKqHabtk/SAY6oHQPoR3Uh7gcffDBkhA/LXY3UhzPmms4eZH1RaWAWnBMCgpN96RiICbtE73xFdWjig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnUuuGAB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnUuuGAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81EAC4CEC3;
	Mon, 28 Oct 2024 21:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730149224;
	bh=bSJ1/4LGL2AYhvTDH3ONgHfqpVc7cjiSelQiTgmHRJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TnUuuGABJIRu/90Xw76kyPnGxF5bKcuB3XNvqdB7xcqVZFMNfZAophAQptbB7Hm4v
	 vP5Stb6EG20hRATVQ9eXGPFdVq/z+yCv6oayC3VwY9hxuV67LZDg5ztZRiD3/6TwBT
	 7Ov+Np6LPOTAXj+tCwnViD61ooG9oJl5MHxl6JyWK61jwYpqW9a0SiQCyBBL3M8+c3
	 R7ECiiAEq69b31GcZ/yqQQsF4h9yrlldplwNZa7NdHcPkYrh5+ZNygBPJHhBHRcPyi
	 wyGatVtdXOwFwWdTfuHuAo2483ZXhRPRGojPi/2MIa0v7stYHwAX3aahaH759UdL9S
	 4EMJ9Nu6tJLSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7130F380AC1C;
	Mon, 28 Oct 2024 21:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] sink: clean up outstanding AVDTP requests if the
 stream goes away.
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173014923227.180964.11197247154659321608.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 21:00:32 +0000
References: <20241025202141.158946-1-daniel.beer@igorinstitute.com>
In-Reply-To: <20241025202141.158946-1-daniel.beer@igorinstitute.com>
To: Daniel Beer <daniel.beer@igorinstitute.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 26 Oct 2024 09:21:40 +1300 you wrote:
> If the stream goes IDLE while we have an outstanding request, connect_id
> stays non-zero and is never cleared via a completion callback. As a
> consequence, the profile on this device will never be connected
> successfully again until BlueZ restarts.
> ---
>  profiles/audio/sink.c | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [BlueZ,1/2] sink: clean up outstanding AVDTP requests if the stream goes away.
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fa1f2e5ee14d
  - [BlueZ,2/2] source: clean up outstanding AVDTP requests if the stream goes away.
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d7bb2abed626

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


