Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BF153596
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661433; cv=none; b=YpUPETXZN5NrNBD4qwztnt/k90QH06FKAfUuBFPA8Dpnr+hABzOW3stSzjSRdegUT9bl17bf1j5dcs0+km8+2wSrLWfsXj/NzmgO7wq2m5wNN/v+6tI1p4VnMnSQhOp3AFuSskOJNQeREAVuJEWzHRHzD/hje6+k1/p1XFq9+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661433; c=relaxed/simple;
	bh=fbqbTpNO9Ty0W0bM1yjXsDRHSubt0ZZfTF9kVef5nko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xk/yNgj6xPw84rhMhASfULj5VDy2PGSSlJ3pVKSZvD4xqJg1fg6WND+nVftnhSIlfYGmvDB+3SUKHJV4iPo+iIezS9y+smLpyHR7uApeuw6mqa4JRgP/rqW1OLk/mshXColUeEkxjp88GGrSfGFjb543dXjnzDdehMzA1LEOF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqkpaLje; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqkpaLje"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16B9EC32789;
	Thu,  2 May 2024 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714661433;
	bh=fbqbTpNO9Ty0W0bM1yjXsDRHSubt0ZZfTF9kVef5nko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eqkpaLjehj7dyqYTSYMxsCXazzRFtp7tE4uevIZQ74tTl0vAfnTsqXp9ioZtVFG2Q
	 m2c1a54B+xuP7zDOeeSQiIxBMBVcTgAC/shJnhhQJl7avkowJZw3HxAHyeLrlzGQS6
	 5lWVS9FaJfIkm0V9C6I1+FPozqDUl1NUb+NDVGCbcpPMHQa03ve+LwRqTXo8YwDjGw
	 AOm0a35K2kdMHI80HvgPHnVt+9JsT9BBTXG+T9Wxbx5dYkhWsIJSnl7PfI2MILEoie
	 X2gsEWIpbV8gIqCYsTDu2SVtDop0Uwhx5ynNVU6bo00POvZNINFNkaeuHy+ckbKQpT
	 8oIFYzs89euxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 007B9C4333C;
	Thu,  2 May 2024 14:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH Bluetooth v2 0/1] LE Create Connection command timeout changed
 to 20 secs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171466143299.15417.862513817450938664.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 14:50:32 +0000
References: <20240502090123.5177-1-mahesh.talewad@nxp.com>
In-Reply-To: <20240502090123.5177-1-mahesh.talewad@nxp.com>
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
 luiz.dentz@gmail.com, sarveshwar.bajaj@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 May 2024 12:01:22 +0300 you wrote:
> Hello Maintainers,
> 
> On our DUT, we can see that the host issues create connection cancel
> command after 4-sec if there is no connection complete event for
> LE create connection cmd.
> As per core spec v5.3 section 7.8.5, advertisement interval range is-
> 
> [...]

Here is the summary with links:
  - [v2,1/1] LE Create Connection command timeout increased to 20 secs
    https://git.kernel.org/bluetooth/bluetooth-next/c/3de7f943c07f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


