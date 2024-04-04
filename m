Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711D1D6A5
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256632; cv=none; b=iTQ3awDy2nKZ7bqj8ZesYJxhU5UROxUxljZnTc6qkK/qBkUcR4S434f8uBn2r7Z5SMp0hpvSUHEyoxqAQCLbIbQw9Ot4AaAEF7cyRoOSQ4MFQT6fUadqdwQjlEBYYm9mPDGBuhMRPx6vOdTAfLdWMpW7WT59jXd7VgLLIjk6mQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256632; c=relaxed/simple;
	bh=9dwrKBwyRWRDaC3oELDaLLoxt9NAEG86fkCL4/DtPq4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hNDgFeRMsU8fI6woanU86f3+w1l5AZ3bQwD1WRRlyK/BF8NTgO4uE8uXVBBwss8fIcSwVfluvgHTndY4Vpr9YQM2rtxx1r/nUSNZPKohYSyyjQ/WX48r92BCXBieytaiLbjLVN8Yjxk3VmwLmy61AzcC8AzoRp+RobyhKRwbXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwNsIcyq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwNsIcyq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C12DFC433C7;
	Thu,  4 Apr 2024 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712256630;
	bh=9dwrKBwyRWRDaC3oELDaLLoxt9NAEG86fkCL4/DtPq4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cwNsIcyq8W5TasQcUCKICu+6tSHAwyMHOUr1AQbEtc3QC7e2TBLfnku+R4eP/o5vt
	 KXnoa1sMVZbXD3LoniT8x5YfVN1Eloo09046DHs6s6AyZEmJQPz0hHhkmEEhj7IB69
	 3XjMqketUVsT20bhlNr6dIEGkxVplhXIzqADixtuVHnfRdQMDCFhbzy/4z7RHFe1FR
	 8xHARHwH9zLNk5OauQgfRI+UPN/f+rdkLgYyCeX2rQUKSGkaub+IhAVfkP1ZYfg9lM
	 lSGT14Zjj2CcfuhuAijkw0IRGGSu0KdMHPRfv6IXgJuhd+L29q/y4jQXkPedddu17A
	 F4oRr+9R1wdBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFF5ED84BA4;
	Thu,  4 Apr 2024 18:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] V3: Fix busy loop when disabling BT
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171225663071.19551.11859340308005262666.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 18:50:30 +0000
References: <20240404183050.334414-1-dimitris.on.linux@gmail.com>
In-Reply-To: <20240404183050.334414-1-dimitris.on.linux@gmail.com>
To: Dimitris <dimitris.on.linux@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Apr 2024 11:30:49 -0700 you wrote:
> Splitting the service state test out of btd_device_is_connected
> and using only the bearer-specific test from adapter_remove_connection.
> 
> This intends to fix a busy loop that happens when BT is disabled
> from userspace with e.g. "rfkill block bluetooth":
> 
> 1. Connect at least one device.
> 2. Run rfkill block bluetooth.
> 3. bluetoothd takes 100% CPU.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] refactor bearer connected test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=036583f9bbec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


