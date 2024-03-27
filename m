Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF810135A50
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549228; cv=none; b=iWITyFT7fIZArDhVb5gBchUVa7UTdmR6kc0MRvnZEYDAvB2PMdpsF7TUP10/9oJB+TLZTSVyti1ANtAmwduYWYp0IY/LQshEC3lIszPgQMetyzT4/wzmq4+SnS7qkR+3EdQgnlN3WXKFqFzIwtuERMKQunnE9hQ18ez7fAgP8no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549228; c=relaxed/simple;
	bh=BmxVm9NnLz6O7NRTzXfIdC7FSPORp107iolZYbht7Bo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VF13yScTfzZsTFEg8ytavu1+B+ON0QSfyzMaGhBh6AchLccDl4X1VTWwBhhBrT3KQnFPI+UNGt0/+X2sdY3DkN9iAhCQ5rwDCx/Jl8L+2LHSxD6kH0RgcDGbAqyP2V+o6EBxWVFqxkCx267g0Yd5ahIY62TjHYt5mFPkM026hnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5zFutcj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5zFutcj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E1C1C433C7;
	Wed, 27 Mar 2024 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711549227;
	bh=BmxVm9NnLz6O7NRTzXfIdC7FSPORp107iolZYbht7Bo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W5zFutcjWzHMQ7ALjMib28mKNeor6ZWusdOjNyAojQPiQeUTUyo6ZLnwpvI08kSX+
	 jTaMwu2BlepmlAXO9M6hVLiayF6dvkzeXzQhvafnf8l8j/2Athafp9xFl84Yc1mjG/
	 9A63FsIuOuhKXhK2G+KrPXKV+zGzcui5aJoGzjk9eMnTN+/nDwTInokBISU75OmdiQ
	 OxoOWT8CuhUMxCY1hy3GDiMKUnfEr6svvEd8PV7asqlafQKpXfnmIG+Sdlrd7F2Q2e
	 DGU1jm80oCPafwLDdY/+AA/mGLraX6ktAhN5paSkKeMByhtzz1rbCGt1MaYxY/5qxF
	 If4e/wcx1hyMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A15FD2D0EB;
	Wed, 27 Mar 2024 14:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_event: set the conn encrypted before conn
 establishes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171154922756.22863.9413895946699806700.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 14:20:27 +0000
References: <20240327043030.243737-1-hui.wang@canonical.com>
In-Reply-To: <20240327043030.243737-1-hui.wang@canonical.com>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 marcel@holtmann.org, johan.hedberg@gmail.com, pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Mar 2024 12:30:30 +0800 you wrote:
> We have a BT headset (Lenovo Thinkplus XT99), the pairing and
> connecting has no problem, once this headset is paired, bluez will
> remember this device and will auto re-connect it whenever the device
> is powered on. The auto re-connecting works well with Windows and
> Android, but with Linux, it always fails. Through debugging, we found
> at the rfcomm connection stage, the bluetooth stack reports
> "Connection refused - security block (0x0003)".
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_event: set the conn encrypted before conn establishes
    https://git.kernel.org/bluetooth/bluetooth-next/c/60b627756979

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


