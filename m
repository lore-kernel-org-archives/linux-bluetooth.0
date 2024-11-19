Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5915359A
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041619; cv=none; b=JQZKXFWVC9drqEFPcqwQwSgtdn9QabPdhsEIwpu6UH6pT1/nQqBG6L4+KeTnoEqOt5gJaBGg2ABUim3BD8Z54tuUVAELkjjWiEayCfC9K9u+Q6TgbNUvv1wmDW8bskkoxNJDioAYfjih/FvAyn5dfn2z60OxtWK0VJ2qYCXNmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041619; c=relaxed/simple;
	bh=TZmY73RZtqDfuhgPa9mJOA5IvkzWDoMdzZ2y5IPZ5rA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZHFfoj28SZuOqJNsnuaShYmvKNBWxCaKnB1jd4+x939IRGVxTCyelahxo0bSyZhEcJ0KCntSJEa29UIjMGHzxgQmFqV39njYnfxm/jNDamDocAM+ZvXFWuxqY6saMJAM+f9TqRK5HaqUMwp8Q3xAmtiUYaKY4sgraqbCbMmmZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8Z564ms; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8Z564ms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35297C4CECF;
	Tue, 19 Nov 2024 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732041617;
	bh=TZmY73RZtqDfuhgPa9mJOA5IvkzWDoMdzZ2y5IPZ5rA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l8Z564msJkeUWRJZyuIPDjKlYsOz8yVhp5A4WXACRJTFnNlQuUHygu5wt9Tr4HtSB
	 lPf319MH6e/Wyag9aq+kzLE4tF7NOMmh6NfgRzAig0821ucFqZs99YLDRcaDmD2/UZ
	 msmbKR1gQtASPZRqXveqa+HiIQTELVEhrs3BLmSapq2PZY7D0PiMJL92Vu58LNM4Fi
	 iCEjTsShSGVWN4HHSKq+J5T60Q9QDt1AYaLJ4E4V6I1TiIEB0lKREdw/+93oETi7/7
	 EHHPD0WaXTw74XQnXyRdJBITf4S9TSMcyC+BqJ1qkMz36liMYsOxHvCCpeSEOZOoXC
	 jlZhm4WsKfvLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACE43809A80;
	Tue, 19 Nov 2024 18:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/att: Fix failing to set security level
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173204162875.645146.10543739494122181736.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 18:40:28 +0000
References: <20241119163731.2767660-1-luiz.dentz@gmail.com>
In-Reply-To: <20241119163731.2767660-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 Nov 2024 11:37:31 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> bt_att_chan_set_security attempts to set BT_SECURITY without first
> checking what is the current security level which may cause errors
> since the kernel does actually return -EINVAL when the security doesn't
> change.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/att: Fix failing to set security level
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5c65356cae64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


