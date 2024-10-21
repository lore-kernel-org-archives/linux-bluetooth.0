Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ACD19342E;
	Mon, 21 Oct 2024 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532565; cv=none; b=NPxloTEVt82z8GdcHqhgneGIwtyHfQXHXJy7pQEPiP8DrcPhKBucys2vPp7fAMXROckdj8mhs9dsXz5z6l3iBuPRYXnHlfsQ/Cf5nnrPWaQKxS0W5wzfioesCjC5Qelu8IQdsDGPrhKmjDBbdA7jKuh8gW05n5l8UNiHURGWLMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532565; c=relaxed/simple;
	bh=xmChHbw1/CYaBdNx4kF0TX8OXws82OtYzEZQwXFxW4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vtnw+Wlu0opFVjZZSJuD4ZzHQ6/mQ+28ynBFRyjpX0yaRTzY8z0sRir7Yr9M3U//GyMQbVJJDFgQTgUwuKbJDtEvCtsiIj9pvKJWIqOvSLJYo+zklfY2v5Cn9Qmn+Ug0dgQKOdkbHKLYRkWUBsECfUYlQSA3za9GV1xl+aWB+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtjsF4k5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtjsF4k5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6239C4CEC3;
	Mon, 21 Oct 2024 17:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729532564;
	bh=xmChHbw1/CYaBdNx4kF0TX8OXws82OtYzEZQwXFxW4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mtjsF4k5+AHugZAdwokwJSG4rtEKPWfGnXGkY3PVUKk3H73RI3/H2QC90RYMDtajo
	 zBIH2s+hHOZYHgwSF/rJ8+/aL22aKgyTsuKryyWD7+HogW8Q4qa3NxlFce9cj0sNR4
	 yegCqYr9HFAMHSLBLp2WyuevvjLSu12K62Q/kIU90G/Rl2WhwyENjgl3UKHKFrKbqO
	 7hIbqCKmrWNW64zTf8xKuLQhXlgeR6MNmQuFVrSfUZt/gyTBtPch71FtH/maCfs5D5
	 CAdx3ukq9MGIyMikFM1kFPn9P/bqrjQj/xaJ6YSwWXktTuIuWIBhMP4xpwdjhioQXH
	 maj1w0HbUxTFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1373809A8A;
	Mon, 21 Oct 2024 17:42:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] Bluetooth: btintel_pcie: remove redundant assignment to
 variable ret
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172953257076.356311.8455128525618233771.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 17:42:50 +0000
References: <20241007161035.1205516-1-colin.i.king@gmail.com>
In-Reply-To: <20241007161035.1205516-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  7 Oct 2024 17:10:35 +0100 you wrote:
> The variable ret is being assigned -ENOMEM however this is never
> read and it is being re-assigned a new value when the code jumps
> to label resubmit. The assignment is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Here is the summary with links:
  - [next] Bluetooth: btintel_pcie: remove redundant assignment to variable ret
    https://git.kernel.org/bluetooth/bluetooth-next/c/e14edcbe88ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


