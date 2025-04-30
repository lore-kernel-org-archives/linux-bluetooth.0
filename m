Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373862DC791
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746020395; cv=none; b=ABTk+9eHn7yl47DOgOn23m8Czm1n2W+RTf5DpM7cIEAJDPMTSgBPPcO1kdvSfhDdH44sLk6mT3dduL6WoSA2ufHK5L8bV/xQysIWiZbvTCdYyCWlXE6WnipFujH/L0kY8GFnFNj3abEr+34uzzFhkckUBM4QMoHFE1rxj57zCI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746020395; c=relaxed/simple;
	bh=hl2wBA5d7AMzBZ1CjOEZsGQhAajGpQlL+MVXf2w7IL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D0Qx1UgKqXukUSIJGkGfnjK3oY5Fhw8I1HdXx+E5Cv2y+BHHXbSIiu6UrK+ngKTJoVESDTiOPl9FU6I+Ps+SwXrS+Hcs1+6zitVzz2n4MgmeYi8YMi8q5wHex/Pgcir87DUuJwDs/tq0fj7LTWPANhqgcHTSLunzQ6tYX+rwcDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hkq1K+qH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hkq1K+qH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B745AC4CEE9;
	Wed, 30 Apr 2025 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746020394;
	bh=hl2wBA5d7AMzBZ1CjOEZsGQhAajGpQlL+MVXf2w7IL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hkq1K+qHKUTYkhPtRcPMFgGUpcghP1dq93W4244j66ZwIPI3l0yLU0DnVNjINYgjK
	 F0KSCh9s+IF6IXqhvTQx0wIUHgXC78ydAB6sSdBvrr3ieZIHaEaMe6uSKgUKuSZdod
	 uIiEpsme0xxZ79BtVGUByNJB4RSWIaA0OnY0+5gKZlgTd+DtJh4+aFhXwvCQ56csGw
	 QLSbs9Jmk1r7vrfN0YTTBKY0lkodjI1zFuuNvDv/Ng4f3VSEYRnOfyPWK+UE9A2lct
	 oLW5EIUO5EtWQuvJcSsYmG3M1xop0F63cDeneFFXDCzjND5CgIgqf/wVTcqAkDiB1J
	 c0o409XmBhdvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2733806642;
	Wed, 30 Apr 2025 13:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] device: Fix not setting DEVICE_FLAG_REMOTE_WAKEUP
 when required
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174602043375.2366402.13977980562378371811.git-patchwork-notify@kernel.org>
Date: Wed, 30 Apr 2025 13:40:33 +0000
References: <20250429163615.2188056-1-luiz.dentz@gmail.com>
In-Reply-To: <20250429163615.2188056-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Apr 2025 12:36:15 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Due to the introduction of DEVICE_FLAG_ADDRESS_RESOLUTION it is no
> longer possible to check if the kernel has support for it ahead of time
> since that would depend on device->supported_flags which is only updated
> with MGMT_OP_ADD_DEVICE _after_ services are probed.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] device: Fix not setting DEVICE_FLAG_REMOTE_WAKEUP when required
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=570a5505fc79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


