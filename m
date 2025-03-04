Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A520A5CC
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101002; cv=none; b=acwz3MIl7oQytMaSn7yF4XuGIUpUOBqJEe1ISPG5Vhs1Oe+akXWQRrcYf4gN77wI5tOtLsTE2Ko0g4HW2hHS9l6RMmhsJmv6p2ubyuuE/bCRl3CCmNHo/4VXXA+Z4CNjDJzlTV/tAD6nd00FJz5Oze3qEa45dEt7hISSz5Vu/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101002; c=relaxed/simple;
	bh=6xaOlzM1TW9WP17c1IOD2oVCWbiJSZ0UoCG/AClEZKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hLJ9SC1CPq1lczVK0MlDCknT9hhuyUrHR+Av5auKLYDrPmIzUy5Fjm9X1ncYuJwBNq7V7bWDerJuf0Avt2Qi9sZRma/LFpPw87mJqwQbONTavch2puZHoKvN13KKCNrhR937pthALR1amN/0kIYe0SsTRGVhMpfdsCBZlcB1V/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCVJX+Y+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCVJX+Y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D54C4CEEB;
	Tue,  4 Mar 2025 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741101001;
	bh=6xaOlzM1TW9WP17c1IOD2oVCWbiJSZ0UoCG/AClEZKM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VCVJX+Y+UaYLs8GXj861ms7UW+9GYfBEgy+gUt76NdmUAkqOzqiEK2R4dES1Trjkw
	 xDK4OKP2cF0w6hIbHZiwPzxfY5Nl97FuwVo0IL6XQuf6IH8Mq6iS2wF3XqCULFtzqE
	 LlRrRvFdESzMhwvsQpCR11WfqSuHr0vKEFXgyvWooSmMS2PFYENoPtPe9nf3XR1xng
	 Edy8PeWH1cWuPHHfXgJQpSCvRrWAvjbgxvrbQYR+mcSaOqescXX2v0UeZIY4okhH2x
	 BC3vK7vVTlbGQv6uUBAOBSvNAgL/OIpsfODlDOc7DrJCBsaQHV1RCX/+Jps2xSOdRl
	 j6fEImbikqtBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEDD380AA7F;
	Tue,  4 Mar 2025 15:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/1] configure.ac: check for stdio.h
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174110103451.178640.1185827816099968105.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 15:10:34 +0000
References: <20250304005006.32322-1-orbea@riseup.net>
In-Reply-To: <20250304005006.32322-1-orbea@riseup.net>
To: None <orbea@riseup.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Mar 2025 16:50:06 -0800 you wrote:
> From: orbea <orbea@riseup.net>
> 
> This fixes a configure failure for readline.h with slibtoolize which
> depends on HAVE_STDIO_H being defined. With GNU libtoolize this check is
> implicit and with slibtoolize it will fail instead.
> 
>   error: unknown type name 'FILE'
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] configure.ac: check for stdio.h
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b71c53279266

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


