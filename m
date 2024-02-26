Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEE212CD83
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960228; cv=none; b=gayB6iZtoIsZBShUpJEXnDxVeGTp1wlKBDNW9xqJLlFnfrbp2VzV1QXpOLMqOfbbJFBq2bj1djQG3aO0hKXpZY4zT0H5rz0ZElVqeNoHpPlLjZQ2XXDrxU82qfHyraceB2XCyUMD+1Swlm01Crl4y740Sa72tzr4zA4Ob0/4E0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960228; c=relaxed/simple;
	bh=zU0ouy0gtAFOnTxKqRu2MXtWLEeQS2WmZS/9tP+rQA8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fJ8bzTqFt7CwzqqVt1nlsWyuRlN9TVxypAdCE054j0xZsbyxvJzrLIIKtFnnnSjA9ZeO1LDQH+2KnE1eHWglaFZzZIbrMDtUL+31F8QXmH1xZG9P0vYIXbD9B8Rl5zDJXDP0T4ybplOdmTX8gxC2SYHHeg5oB8617g/vVH69F0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6ibTg/9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6ibTg/9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7544CC43390;
	Mon, 26 Feb 2024 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708960227;
	bh=zU0ouy0gtAFOnTxKqRu2MXtWLEeQS2WmZS/9tP+rQA8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g6ibTg/92Q8SvZjVOTIhx/AksSTIwXAYb+P5+lQquo00QFG1jqAx17PsDz2amrvOP
	 zlbqSmT9DCRUcpyTbJhzXGs42b/HzW280UCMyb4ktJjdVqCGub3CxpthUrPMjWowg8
	 Y8nRh9COyvf/gK9WDkP0g5I62MNvmXZGqpG+dzMI62/BUmtG43byvUnbn25EfHIRj5
	 1lCcw6s64gillZP8JxrIBsDPOxyBlKKVtLPJZabmmXDBfb+pZO0fT1zQOFAdGdZIKU
	 zXR3GCHI3j3CehlxbNYErSV6Ps0Pg3q+rqahex7dWlOXI9RtGtEyaMrh5eCeDv+AWL
	 dHfdvLnez3FUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A49BD88FB1;
	Mon, 26 Feb 2024 15:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel: Fixe build regression
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170896022736.15142.5129614275449962506.git-patchwork-notify@kernel.org>
Date: Mon, 26 Feb 2024 15:10:27 +0000
References: <20240223173819.973508-1-luiz.dentz@gmail.com>
In-Reply-To: <20240223173819.973508-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Feb 2024 12:38:18 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following build regression:
> 
> drivers-bluetooth-btintel.c-btintel_read_version()-warn:
> passing-zero-to-PTR_ERR
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel: Fixe build regression
    https://git.kernel.org/bluetooth/bluetooth-next/c/cd41fa3056ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


