Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282CF14F9D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725832; cv=none; b=NVjiTqYNihUHJMeLDejlSfGSGeqEeB8s/MUU36f6UtPiJst9gcnLByK0iUmXUDgZ/83NmbqB2ER9BnCBTO0L91hkni5GdYBvzyDGYblIKdk+eIHcnQmi68EkE1BFdm7V4IJXVJim0bB6WlG5YOZW+UMZmMwDxDETLx7a0mFvJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725832; c=relaxed/simple;
	bh=1HEI/C0J7KxQZG12BPHoIbJHGhZH0Gq7oCuc4D0IQEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DtQzfw7UJ3qyOIP7Kb+k5wTFqnODyqR0sMOjQhT8HmzgnM57ye+y7s/gCiWU0CtbIw9ut0YQnYIxivVQ7NHW9SGAtmN6KlUWfAIGVrJeAmIp02+qF+0hDBTWVZBkjlCoX5aYr3nuRlNc6B4Ygw5UmsqKPoEb9oDaam78kQlobHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOl1h1bb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOl1h1bb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D7BC4CEC7;
	Mon, 30 Sep 2024 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727725829;
	bh=1HEI/C0J7KxQZG12BPHoIbJHGhZH0Gq7oCuc4D0IQEk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TOl1h1bbEX4KqmPRwDC07GxsUGfapezZGk5qzX1wUci+2efwuANpyJc5v8AOSRC8g
	 Gp0uyNULv971r6VS+dlT+J6/03mAqQpOpYAkjIuXBOEX/EL3A9wC/H6QSaM9n2OMgZ
	 at8fFsRsux9ZWmjbqfUVZtbt+tUd11wcFB701odxT7a3Jg0aV2yqCVsdhYw9bEBx/n
	 2nb8AAhc9ZIE/nS/dmhjOyN2C/wrDyZ795/QCKZ9gW1tz15koLdlU1Iv6vM6n2BRoY
	 ullQ1+FvAT5Z9gDgZQw3I0aIUYmC6oiGSNP2hL3g2d7tPwDZK7RTUpODGPIUdFh9V5
	 e8bpX9HYqmRIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0FE3804CB9;
	Mon, 30 Sep 2024 19:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] device: Remove device after all bearers are disconnected
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172772583251.3906813.2032846696508027106.git-patchwork-notify@kernel.org>
Date: Mon, 30 Sep 2024 19:50:32 +0000
References: <20240929022256.3271298-1-quic_chejiang@quicinc.com>
In-Reply-To: <20240929022256.3271298-1-quic_chejiang@quicinc.com>
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_jiaymao@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 29 Sep 2024 10:22:56 +0800 you wrote:
> For a dual-mode remote, both BR/EDR and BLE may be connected,
> RemoveDevice should be handled after all bearers are disconnects.
> Otherwise, if msg is removed, but not all connection are dropped,
> this function returns before *remove is updated, then after all
> connections are dropped, but device->disconnects is NULL,
> remove_device is not updated. Consequently *remove is not set to
> true. Remove device is not performed in adapter_remove_connection.
> 
> [...]

Here is the summary with links:
  - [v5] device: Remove device after all bearers are disconnected
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=38734e020513

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


