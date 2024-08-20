Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957461BDA9A;
	Tue, 20 Aug 2024 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724173239; cv=none; b=VCvw4IWqpbcPlvJJVkHmiGzSucoe+8WzexlUXDCEqx65HS8uqm/U5mn61a6jh0na7Ag3haWVAqKPPZbmCLxeLtRjvs7a2MP3ght//YWUYnuO7c/+1iIQRdTn5W8dkxwscrD2wnbdjq01nH4ikEN3JlVhA2XyPgk44G/HhQOPF1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724173239; c=relaxed/simple;
	bh=tF2uGBBzpjRbGxoxEl+9DcbALfLb/EhuBuzFJa4AGvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BBLbB4ow/5Sr3Uh51qjDsQQQyTx/+TubeiFnFWEMiQKirO1I8O9nWk1+A4qnHT09IAad5Y4/v9iR4NbhrIKZ9UgWHEU4N4p/aFuLzyfOT+89/ZSrDdkSM0HIz/PmZ4TxukWymu2ubqsPyy2q+ogy+jeyoSt2AuBY0NqgsE6V7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEpcVZ8p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEpcVZ8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF66C4AF14;
	Tue, 20 Aug 2024 17:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724173239;
	bh=tF2uGBBzpjRbGxoxEl+9DcbALfLb/EhuBuzFJa4AGvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UEpcVZ8ptV3pM8HFc70vXNzlC6UJu/L1BnFmyQNqebTr2C7qG1fQSJnyDW4VKmico
	 3Z1tVE3Gk5U6ruilBIo93f4+RMVcdRvBHxgTYdyQhlzBcRPbODQucjuC5Dg5t6hWPO
	 vHy/SZapoYgTw6ZztO1ZH/zkOTdxdBr/xttJQY/voRw7ZtXj/LUnPL7RTIfAXe+34J
	 ex60+zGJCWuhh/8Y3Oh4U+6RJrusBiQ4hG1fQOU8k/q3dDlwLAA4W/UjU9aR2IsPS6
	 XY2kVmcSKe7vqK7vEtujfDashM8MM6RZ/Jh4EP1kDNotnRDhRtXURoZI/Ai5foOgC+
	 DHCxvVied8v5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD143804CA6;
	Tue, 20 Aug 2024 17:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_conn: Remove redundant memset after kzalloc
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172417323825.1194903.2068866577999998083.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 17:00:38 +0000
References: <20240810141415.124113-1-visitorckw@gmail.com>
In-Reply-To: <20240810141415.124113-1-visitorckw@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 jserv@ccns.ncku.edu.tw, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 10 Aug 2024 22:14:15 +0800 you wrote:
> Since kzalloc already zeroes the allocated memory, the subsequent
> memset call is unnecessary. This patch removes the redundant memset to
> clean up the code and enhance efficiency.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Note: Build test only.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: Remove redundant memset after kzalloc
    https://git.kernel.org/bluetooth/bluetooth-next/c/7a6abe8d0fdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


