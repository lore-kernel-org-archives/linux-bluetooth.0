Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595C8302CA7
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314191; cv=none; b=ez5TF7UkafE/Dke5eEa5jqkW91kSqXnZxRJFUBYSsTQiS/mkOdw5PO6x1orGLY3iNWnl8lhJBESGqOFWbbWGIEOfUYbQZKd1J8uJ3dEUJSPmB05q3vJZXH86NBb7ioLmsiLQ62/KzkAm+5OHIv03Qh44LtAHQsW1TYVWLOOoL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314191; c=relaxed/simple;
	bh=Yo5GkukhPu3Y57kgx4Z5YGvsf1tLfEjxB/RL+Beobnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kj2ocbG3i25AUNnz1Jx/amJMjMYBGF3XpP/gpS5SCkInqN1B89eaT0r9X93ONXiutBZ+kHTl4j1vqkJ8pH5DeNDRC4d/Y6uDhMxHFmj/REboR0jwl4agg4u7EHKjOQ1/+cRZkVX4KB4R9yUK0Efj6/tdiktBedw2aqsCXDMz3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDBTT6Be; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDBTT6Be"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC15AC4CEF5;
	Tue,  9 Dec 2025 21:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765314190;
	bh=Yo5GkukhPu3Y57kgx4Z5YGvsf1tLfEjxB/RL+Beobnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mDBTT6BeBTpYgk8GZW8qek6uM7pEPzRJoxS5IF8q+h9zTmhNVzRDjfcjGDxB9SEVr
	 gIff95ucxEGrttDBYhtRHgxjos9hNlrEVh8y26ya+uBSmj3QhM+OKUqyv79krc3q8x
	 B2vM3a6ulVD8+AyCRwnXq622Cdw4DEGiVcyHJ0+ep/QJ19hr9RRVKCt0v4f0Qx6ijW
	 ZeJETz5MrFHgRw/w8RD1Qjals1Ne/PZtbCO0EU/8wzOpsANcL/2C0xlM/F9ZrW70fW
	 RQlv6TNXOBAycUSvsEpdTo9udpYDcreDOVliZRX8JyNlsLpUFix9RDypIq64mwroRM
	 AYZ26s2v2ZFCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F28DB3808200;
	Tue,  9 Dec 2025 21:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: report BIS capability flags in supported
 settings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176531400578.4126948.12507066625688561701.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 21:00:05 +0000
References: 
 <9e5172cb82b9d4d130d83d9fc6beac9e496227c1.1764875787.git.pav@iki.fi>
In-Reply-To: 
 <9e5172cb82b9d4d130d83d9fc6beac9e496227c1.1764875787.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Dec 2025 22:40:20 +0200 you wrote:
> MGMT_SETTING_ISO_BROADCASTER and MGMT_SETTING_ISO_RECEIVER flags are
> missing from supported_settings although they are in current_settings.
> 
> Report them also in supported_settings to be consistent.
> 
> Fixes: ae7533613133 ("Bluetooth: Check for ISO support in controller")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: report BIS capability flags in supported settings
    https://git.kernel.org/bluetooth/bluetooth-next/c/3d55304c6e43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


