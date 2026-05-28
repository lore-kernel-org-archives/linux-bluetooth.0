Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795E31E82A;
	Thu, 28 May 2026 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978003; cv=none; b=g4+y26k5y4rXxFiTNfsSQmWMUnbrTcogl2w+Q+Qyi5kqDWoSAPUarIXFLIh+xdqZU5AphQOQlg/e2KeKok18EXccJPxfLj/FybHc9hMfMIrbWPycNECsxfpgypOjJ8wktdJ8V0tNukMnnrhgryN8Y7jcVEs5hj+QfFS9kgiInXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978003; c=relaxed/simple;
	bh=vNAhtfkL2KXaHItR6JqHYqvQzdMVV1DJxwkMLzUNDjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cz2/S+aWhbU8fYiAnejczSV5I2VG9tfmViDEg4774rhyTn/jro50Yj2VBOh5E9pLReSP/s4R0/HZS8CCNzimbcQovchhI3LGdwr3BGy/6mpeoN8pfh9E/T0NzdYCf64oZsL4Enluj5ro/rsRizWoXDYojOyPu2KuGAqbRalJakk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgAhpr5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgAhpr5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FED91F000E9;
	Thu, 28 May 2026 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978002;
	bh=OzJYXt8AtzKps4WsX5HShtQ/npAyeEc/0ZncFQi3a+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HgAhpr5T4GeiTNc0C54Q7WtFiWBXPY0RQtoHU88qp4Y1uKMVg/hIcLKtOGeiZX1sT
	 TAgGev5Mz9+pqmrcInufjI9Pn8bfKuc9SUc4YL8bc9zi2HV0yhDrk/GOVjW2bjeZpI
	 i3xayRvSAyheUTSPHf3z4+TxJxlbqce7Y+iCD7ijuhuP9aCXUoQmV8YF8E6xkSuR/u
	 y+UgZZQT+F0T4XSxK2yVCE1rPRyBA39TroXXRwvGQg1ZafiJz8XGktM2mkrJFIKDrp
	 iPisESJGxu9QpYPCVDe3wKsIEZEYxFF0XceoHymMmUXsuks4iis2ZOIybjVXxETyzY
	 hc05XPjru2gWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198C6381195D;
	Thu, 28 May 2026 14:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: RFCOMM: validate skb length in MCC handlers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177997800664.948024.5743539938103755383.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 14:20:06 +0000
References: <20260525110443.139485-1-suunj1331@gmail.com>
In-Reply-To: <20260525110443.139485-1-suunj1331@gmail.com>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, pmenzel@molgen.mpg.de, me@brighamcampbell.com,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, meatuni001@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 25 May 2026 20:04:43 +0900 you wrote:
> The RFCOMM MCC handlers cast skb->data to protocol-specific structs
> without validating skb->len first. A malicious remote device can send
> truncated MCC frames and trigger out-of-bounds reads in these handlers.
> 
> Fix this by using skb_pull_data() to validate and access the required
> data before dereferencing it.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: RFCOMM: validate skb length in MCC handlers
    https://git.kernel.org/bluetooth/bluetooth-next/c/a82ccb946ae5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


