Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16236201278
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364613; cv=none; b=IdE7Wz2iO/zUZrcsOiS80VE/lvkgYS/w1SW6/EdfawZbqDwgSE1M0Rj3s+jSPKd7mBXGAsmNgcn0ezmxRRufD7qxMZZUOvJUvpPsYj8A3JM56HpaUN2qsVguJbSsDmEGx6YZt+OL/8kvcG54mS9qbZiSA6pdAhRd5O9zV6ahGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364613; c=relaxed/simple;
	bh=hjK96lM8n0jwgEarRHoVmHz9d8GTWKKUkuaBDp2r+Ls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QDJkCx90OTwOGCRJea6nnSwU0x1C8E/PzO6uD6mOd0RE4K5ZWREjPo12HzdJ+WyPMP662GoNyFG7BWmBwQO5aDycFjYWhnMcbbkzeZYdGYg5aPixyuLv0uY9fBswQZUb6jRJdLRrSrO+ygtudYnZXOE9zdoa2wbBQ5PYBKtlIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFjLfDyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFjLfDyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F8FC4CED3;
	Wed,  8 Jan 2025 19:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736364612;
	bh=hjK96lM8n0jwgEarRHoVmHz9d8GTWKKUkuaBDp2r+Ls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UFjLfDyJs00Ksx8KJNbsm4eaGxmik+rwx0fpb6d7+6HP3YvT7y2yopdF+rJr7Mqlx
	 3NDiTT6vCdrF5+CtlDKJ1XSsiFDOZPZE1kfQ3FUTDZJxAZ36GulSHFpofigWqZNcrs
	 7wKIILkWmPrMqoJIQ7SgzW74Sbd4f0ysjjsckDtOAcJX9rd7l2ulGdUKIJrQYXa+sg
	 bODNItgplem2kU9bS993pp8BRqBPQR7+ZzKknqd+tGhph9GvQv6AhSJ7AS+5qdDKb7
	 aWOY1WKZOOMGTYMVDbJS70ojWd9vadOaqWT3MlzpC3Ew85cDdT5MkxMgznFNWcAs3D
	 UT7iSzHkBYy4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7119C380A965;
	Wed,  8 Jan 2025 19:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] autopair: Move handling of wii controllers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173636463427.754812.13795283643602698794.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 19:30:34 +0000
References: <20250107154208.1414463-1-luiz.dentz@gmail.com>
In-Reply-To: <20250107154208.1414463-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Jan 2025 10:42:07 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This moves the pairing handling of wii controllers to autopair plugin.
> 
> Link: https://github.com/bluez/bluez/issues/911#issuecomment-2571606630
> ---
>  plugins/autopair.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)

Here is the summary with links:
  - [BlueZ,v1,1/2] autopair: Move handling of wii controllers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c281bc460884
  - [BlueZ,v1,2/2] build: Remove wiimote plugin
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7679c96954ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


