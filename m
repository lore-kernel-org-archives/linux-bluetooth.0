Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410F1F419C
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001800; cv=none; b=Z/OmvUVWzNZHsND+rUhcXJrieE4Q1LT4l/Kd4GSwfXIF3sYKX3e3npnEPrN68uoE7xA2QBREbMKLYhPuw0CTrudFysTuXo2Hjio7SHHzwz1dqfDjxK8cok+I44g9XJFcQKPKmTYHrXVsFLd7IcWejHn0eBHGsxAJ7OQ+Q6is32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001800; c=relaxed/simple;
	bh=gSjwzyr5Ier/hQCSOuNhCtlsQrYFCGbaPHEbL7w2Ktg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i64xwZ5BHsrA8C/MkGiWU9kuXSoTs6m7W4GRpp6PmFYEONjexpGvJItiZqk2sLeKba/jxYR/zJAw/63/uH/oGN1qgBFZtbs5iFC/+OIVf8s6V/Dv4tGGfA7+WUhatV4CyhH/+h1tlOzG6m1av4VLnlrX0zm9kRvyknSyt44ROgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs8rlYKk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs8rlYKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B3EC4CEE2;
	Wed, 26 Mar 2025 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743001800;
	bh=gSjwzyr5Ier/hQCSOuNhCtlsQrYFCGbaPHEbL7w2Ktg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gs8rlYKkvHDMlbwfLyxT/pDCKrMvKY1TRtgvIltat+ZOfTGSCFEV88SuUq9h9YtX8
	 1bQ3dPWyRr9z+RYeW/k1K5yBJl7bNeIrLGh3NdqOlXPyVk+qBx4+K7wJS+ZxN4D0RZ
	 vXm26BJHPuXpFaCMOEh6KVoFC2Ui1ZB8SNR8SdgGTuEcXbFyAoV5Q7TXnGDB7jjZva
	 3vN7lYSpV30dg2K77nPPtdWcyIHHjwzNEDHaFnM4HLa4OnG7ndSy8NyVIHiiOpnVix
	 BIMeQBRSFYxWPwdpMb8pJYecv3yzEoNSvaBIvwY7tsvHUhTv0W5BKxsLfmcuLyVy6k
	 tLYF4Q2QQ4aEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF60E3810901;
	Wed, 26 Mar 2025 15:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] Fix wake_allowed reported error and not being set
 after pairing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174300183650.1347744.12595014865488255109.git-patchwork-notify@kernel.org>
Date: Wed, 26 Mar 2025 15:10:36 +0000
References: <20250325172846.139431-1-ludovico.denittis@collabora.com>
In-Reply-To: <20250325172846.139431-1-ludovico.denittis@collabora.com>
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Mar 2025 18:28:43 +0100 you wrote:
> When a new HID or HOG device is in range, Bluez reports the following error:
> ```
> src/device.c:set_wake_allowed_complete() Set device flags return status:
> Invalid Parameters
> ```
> 
> Also, a side effect of that issue, when pairing a HID or HOG device, the
> wake_allowed property doesn't get enabled by default, as expected.
> It requires a Bluez restart in order to get that property correctly set.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] adapter: Preserve pending flags when setting the Device Privacy Mode
    (no matching commit)
  - [BlueZ,2/3] device: Preserve pending flags when setting the wake allowed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=41cfe55ea759
  - [BlueZ,3/3] device: Try to set the wake_allowed property only for bonded devices
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


