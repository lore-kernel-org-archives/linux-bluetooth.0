Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69E340285
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050245; cv=none; b=deNW5PNUp3gFMz6Y2bQpd98pqUt/V6kvaptHZsWfJoD7x9zdbkGY6kGZFhqo8ybXsdfTBvOpFOCc+dzLQ1NoUGugKVVSTsB9l2kQ1FtbSUGNVCOu+ENu6TKKiunm5fAXAtelLn8KnoJXpEO8ejKF7CQb4faGoTmN9ReQjj9M3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050245; c=relaxed/simple;
	bh=h/AGeGUdz/qX8WwDGF5GYhHeVz27ORlJj4J3GDqDKcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vv3bDI463JEg8SFMK3sm4V6Jy807nH0+tayyAefPy08aHMD45Wq6+UCMzrSCSxWAvRDOZfJ02T/yT07HO83RAEtzUwXwFQAAiuIvsI4WhDAwmkSgqWB4sXgGx/CDhBUYJllChR0X2tvm61FF/DPKnztDGk5z5LtInZ4/Bd/KhT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2aIKGDu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2aIKGDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD3CC4CEFB;
	Thu, 13 Nov 2025 16:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763050244;
	bh=h/AGeGUdz/qX8WwDGF5GYhHeVz27ORlJj4J3GDqDKcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d2aIKGDuV4OHUlwyvm6yEGT5ZzkThbF7R1UmpYK27YDAboS5jz/S65DzW5EVaAcU2
	 DwMygF8nskzTnyLQzAHqsVAc7eRJLK0vTL4Lc5k1uf4WutwG5k4b19Yfo0pnQfC2WD
	 vEcy073OjPlILFm3h9tYnncDYivcqr7CZxXmDRjOgLAppwhpGNwaOvbmPr6lOp1tZM
	 dXnJmUQpx/hm2gMvN6+8tJtOBe42qG62QcSYgm7C60Lm5lAlrjYTPmOdg4OOTcuFLO
	 vbKV7mO+0+Os3r5CRyiAjOolAEF0hGWKdDdPzBjwZiVV/Cci0TpqU0ZKk5650QVnYm
	 vzJWDg/6pUHPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E2D380DBD2;
	Thu, 13 Nov 2025 16:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drivers/bluetooth: btbcm: Use kmalloc_array() to prevent
 overflow
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176305021399.908070.10353030202205658648.git-patchwork-notify@kernel.org>
Date: Thu, 13 Nov 2025 16:10:13 +0000
References: <20251111142041.229145-1-ayaanmirzabaig85@gmail.com>
In-Reply-To: <20251111142041.229145-1-ayaanmirzabaig85@gmail.com>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Nov 2025 19:50:41 +0530 you wrote:
> Replace the open-coded multiplication in kmalloc() with a call
> to kmalloc_array() to prevent potential integer overflows.
> 
> This is a mechanical change, replacing BCM_FW_NAME_LEN with
> the type-safe sizeof(*fw_name) as the element size
> 
> Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> 
> [...]

Here is the summary with links:
  - drivers/bluetooth: btbcm: Use kmalloc_array() to prevent overflow
    https://git.kernel.org/bluetooth/bluetooth-next/c/aad8651d0f7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


