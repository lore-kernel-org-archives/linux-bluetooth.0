Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72429302CDC
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Sep 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115806; cv=none; b=dhkGQzNCqpqEeYiWt9bYhSvqN658AO6SlpcCB27CwJBcz/+G/lqg+9XaYsFPcp2Df2M2TrVDchKeEY1VrgNUFuQ0TIAzy2zeFeniaFd7t+fAY+AnzYGKJFoNgdwddHXE4xgmoYjBE8R8VZPnGdLso5i2pyBu3GhYQpOkFfnMA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115806; c=relaxed/simple;
	bh=F7uNYarpzKYibDbGBqv7HJUzU8mxu82IAbTQ/XM6nqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k0vCoe/wUcmyrZeSwVbvhBP3uQo5YqUzwfibBUlG9j2TegjiL2MH9GmS5s9X6npuXMCDnHCcGMuFylh0fsv365uKTiZlweFKt4L/VE4xEH+97eodpPspy19/VLAcvLmYgOVIhcvj4X9bT3ETS8+qcyLWQLNDHIVXCilHCZluNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWFG1NIl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWFG1NIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FE6C4CEF0;
	Wed, 17 Sep 2025 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115806;
	bh=F7uNYarpzKYibDbGBqv7HJUzU8mxu82IAbTQ/XM6nqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oWFG1NIlqMCLz6voVn3GmkX/fxDVKrsZkONB/W64CuuAYuhbmMqc7RiIMma5bL4Oy
	 zRqOwy0qJmavTCb/HmRKrNlRSliINypb6DNwhJfqD9diEQKvlz3YToNIW0GI9Pf5oi
	 MqeUBkf8vE3dBMEmmHjlNWcRAv0ue0Hwz2hPbYel57dSMrEIdPh9GlONt/FjKPGp7G
	 yQouMcyBtex3+F8Yx41R0v9MZ0zjTrpr+KyZVkbVmYs+ZYnQ7jJtwxH2fd813pHx0J
	 k7vesS9uT9fkxU3fFvdx+WDF9S+JJf2TiyVcYB8P2E40YMtrhoFjpwV92pqtKd4UIJ
	 WWmORZX0REbUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB03139D0C1A;
	Wed, 17 Sep 2025 13:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/4] shared/hfp: Add Operator name support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175811580676.1623615.4409282341891803844.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 13:30:06 +0000
References: <20250915163427.3589748-1-frederic.danis@collabora.com>
In-Reply-To: <20250915163427.3589748-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Sep 2025 18:34:24 +0200 you wrote:
> Send AT+COPS=3,0 at the end of the SLC creation to set the format of
> the operator selection to long alphanumeric, then query the currently
> selected operator name from the AG.
> 
> Register +COPS handler to call the update_operator callback on event.
> ---
> v1->v2 : Move changes from patch 2 to fix unit/test-hfp
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/4] shared/hfp: Add Operator name support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b8d3e4c510b8
  - [BlueZ,v2,2/4] unit/test-hfp: Add Operator name test for HF
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fb32f3a27fbd
  - [BlueZ,v2,3/4] shared/hfp: Add Call Line Identification support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=889139e0a1af
  - [BlueZ,v2,4/4] unit/test-hfp: Add Call Line Identification test for HF
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=430b8b1b024b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


