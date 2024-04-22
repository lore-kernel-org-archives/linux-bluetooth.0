Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D469152509
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800428; cv=none; b=C8LlRA+pxZ7vgWiRgeq91GA26cgCq/aMgmLzJM800dVZnMNvjCyYz+0h9OEAF02kEoT6mJZ7OxYytB/B4koHk2PnaHW5BYn6c8c3eQ4SLcCRA0h+ePu/bp915tuN2/reGTnnorx7B2BtYSnXeq7JmJVYvE1/4s1ccofC8Tv9Dg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800428; c=relaxed/simple;
	bh=XcmNOBvIPDo2Y33mP3IZuXl0BIjPwham5GF5LS8M/bA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CbqN94sb1ab9859fgldBTDePxjKocUBgO/4F1Yr1eCjof7fgJmPYSuZ6G9XOTo0l3ZiuROv62gGNAEKHD9/ZXBQ1+d5oktjtk0pBBj6ie7OzhZlnhdKtmcgy34xNVQYoKQZoVQ0eQYbbr2fMscHyxb/d6LUefGLPKgUMlEFz3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxLXR2zR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxLXR2zR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2CB5C32782;
	Mon, 22 Apr 2024 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713800427;
	bh=XcmNOBvIPDo2Y33mP3IZuXl0BIjPwham5GF5LS8M/bA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nxLXR2zR9RN8qDjwCM5luXegcQWp65aU2HYJzMuF991cStDQc05MFU8juQp8PowGL
	 WmPsrWfC1ZBSK6Z+QCtPFkKtjK16cZZTdQcS5hz/PULtl/VKq6XZmVraovRc2FvV3B
	 0r4I/M6sMMHFvEx6lrNJ4uLgRqjvAjGQ0XKiTghFA9kKD4UWu4/W5FQrd55D/ZeKaW
	 OZk2513+02lK1S/Aq5W/azfqQ1JnbRENLdPZ5YyoRLbq34cbct+incfMjD6rMSQjuM
	 uBgXLa4yrs+f8SPj8K8JiqE6XjE5ym6D28biejis45aadcHhgFCh3S3zRl9PgS4218
	 ZzTXI5xwJ3zgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B535C43443;
	Mon, 22 Apr 2024 15:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] gatt-database: Fix sending notification to all
 devices
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171380042763.2328.2575142474480470208.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 15:40:27 +0000
References: <20240418194723.1440686-1-luiz.dentz@gmail.com>
In-Reply-To: <20240418194723.1440686-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 18 Apr 2024 15:47:23 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If notifications where setup with GATT application that implements
> AcquireNotify the code will attempt to setup a dedicate fd/io for each
> device so when receiving a notification over the fd/io it is only meant
> to be send to the device only.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] gatt-database: Fix sending notification to all devices
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a08ec1a4e93b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


