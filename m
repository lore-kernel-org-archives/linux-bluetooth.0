Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E5E3D34A8
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370199; cv=none; b=omXMvA3W5LKrPDsgtFGCAjWJxv4tM5Qln0iOteuwP4ZHjOu/WpZe3cnUKGlW8Nsx61d+mBt41f3MGL5msO7FCu5ZOXIlZccOYRssoDl8xxqV5CyBuFeBtWCFgeR2doTNas6DHsFAu+7d2fPBJ/1P8UefOcMo+apgZh82tNQpHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370199; c=relaxed/simple;
	bh=CUTPcbO609FXCT4uoQ0Rj+po8YHvjZffWQW03Jd7WBM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e/AXHKs75N5gqnDOvyUCu0FnOHPVUkdgbIDHmiBHSckt8WHUbxAa2HqQKwtvfajVHRXH3qQ9Rifex7Tey/siUPRojILbxmtb8PRtcmx+7T7nx/D4MZA3bNDT/pGvKzF8q3yM3ekbLRv9FNjx/6rbJdSnQzBS9mR1bYRqfbXCqPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo2VHTHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo2VHTHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB211F000E9;
	Thu, 21 May 2026 13:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370198;
	bh=UE5nXXXgEJgxjC7WqbtTxT+U8WtkY0+rzLVY7c5H4o0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yo2VHTHaYjlWgGFr7GDTgsNaF5lrv0Fvhq2qKIBmA3fTLqmwhGSIWrFTk5Spiz3M2
	 Hp83v75KCLJZBTVqQjT8iyi3OCyEtqPL4vn4lGa47o8BttesU0fnyrOoVluFGraXEP
	 AJ/VtL8PxTEp2CyqZT+A6wiew/bXXfJPP92AuZ2kk4WXrhVyvNxHNZdqEYD85U8Dkd
	 mylRr8ZdcMlE2O/luc5J+IPsCEcrI0pBDkMEh9BLd2UI76sPMI2Q5tG50tXNyhudga
	 /qisJ2nOmsLBUNIgGOe5xmJ8zcv++fZKOwAe4AYdad4oXSW9P71C65yxler2akTtrK
	 2UQPfXwqITzew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198923930DE1;
	Thu, 21 May 2026 13:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tester.config: add missing CRYPTO_AES
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177937020756.309926.1774626011773589967.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 13:30:07 +0000
References: 
 <478a4d370bc0b20b98223507166dfd580ae8477d.1779051031.git.pav@iki.fi>
In-Reply-To: 
 <478a4d370bc0b20b98223507166dfd580ae8477d.1779051031.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 17 May 2026 23:51:30 +0300 you wrote:
> Kernel commit 4a1507625b0 ("Bluetooth: SMP: Use AES-CMAC library
> API") removed CRYPTO_AES from the default Bluetooth kernel config.
> 
> This causes Bluetooth testbots to fail silently with "Not Run" status:
> 
> Basic Framework - Success - init
>   Read Index List callback
>     Status: 0x00
> Bluetooth: hci0: Opcode 0x0c03 failed: -110
> Bluetooth: hci0: Opcode 0x0c03 failed: -110
>   hciemu: Failed to open vhci
>   Failed to setup HCI emulation
> Basic Framework - Success - pre setup failed
> Basic Framework - Success - done
> ...
> SCO CVSD Listen Send - Success                       Not Run
> Total: 30, Passed: 0 (0.0%), Failed: 0, Not Run: 30
> 
> [...]

Here is the summary with links:
  - [BlueZ] tester.config: add missing CRYPTO_AES
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2470448ed9d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


