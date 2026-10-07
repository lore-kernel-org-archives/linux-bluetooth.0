Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126BE4D09ED;
	Wed,  7 Oct 2026 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394222; cv=none; b=TX0Sfz6fFaa2E2nnEvhqL+chhooBgKGX65ngAjQJnYPdNmO7KDFIAyAyl0Le/E6CuBlHGemm7tOWkwr0tABGpckLygKgXhB9Jg6+c9UUjuuF2t/Y+HeQ2ecuQ1w9XQplExi8An0GkAzHODuIRdzeJ3iymuxm+0z5XVbm3jWsxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394222; c=relaxed/simple;
	bh=9YmgAWEg10TSbGDkVnZAqHMgI1azaMsjB7kfLSt5jgE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=esYtHVrLo6Nq9oQLYUFCKR7qCZXK6FC56YcIg7B/iqPfUoPyaPEs96HvYp3gf3p30HJytfT5NeBv9dZyl9q/bMUawg4newdDxHCi9KFq8e0/7KjwiQaHlC6zGwgeQUSf8K0qiUlS8f8v4EtCsy+zRWM3moHu5X2cXYxjVQyK2Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f56qezXL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f56qezXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1D41F000FF;
	Wed,  7 Oct 2026 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791394213;
	bh=wYu4xDzZoq4lXLAjhRuwZxR7y3TPY5VA2kmOm2w8lf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f56qezXLNPsH/Z+33kfOXPPmvDQTLOD/X/o/U30nHrLRZoeUKbAQka4voaqrU8hvB
	 AF87bFSXaj0lSGqevb9D1ys6L6T9gHkiTneH9Q2YBdHFc2hXWvDfMG9Cg9FtPeTaJb
	 Ms+I4AMp72idCI28fpgGJ3Gd2jHwVhvvonTaKHF91NeyUUj0lIlTxtKyUjda33xLFQ
	 1+dWJ0UO1cIgia3rhy3Pw4pjjet6UF6eiOPNM3iby7+iZy0iTd8kkFHEJf2/RN4swP
	 gVvyIL/pRoB0/3PFLfznawVVpVoAEOha6+PwOJ/sCWwXLonxzqtHLtj2+J7m7PDLm0
	 EFvVpvoLXXVKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43973808209;
	Wed,  7 Oct 2026 17:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Serialize devcoredump reset during
 device open
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179139421227.3628206.5217968051871081602.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 17:30:12 +0000
References: 
 <pm-bluetooth-objects-candidate-0250-v3-f85e5bae9c76348c88b7@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0250-v3-f85e5bae9c76348c88b7@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Oct 2026 22:39:21 +0800 you wrote:
> An ACTIVE devcoredump's buffer cursors must remain valid from the
> packet handler's state check through its copy. hci_devcd_rx() holds
> hdev->lock across that interval, and hci_devcd_reset() requires the
> same lock. However, hci_dev_open_sync() invokes reset without taking
> it.
> 
> A registered VHCI controller can collect a dump through its debugfs
> interface while the controller is down. If a successful open overlaps
> with handling a nonempty dump packet, reset can run after the receiver's
> ACTIVE check and before its copy:
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Serialize devcoredump reset during device open
    https://git.kernel.org/bluetooth/bluetooth-next/c/860b93123309

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


