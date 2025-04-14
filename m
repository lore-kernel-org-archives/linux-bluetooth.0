Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE323D287
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639794; cv=none; b=kLjLWeRMPd50vuEOP4vktHpCascdY8bysCIJNEat2TrjZfd5bCoX9pPJdCOedmZ+5ze6EsGHQPmaFEop1bqsIJFWn+WRmLfhxWEO/sBbT4CR4TQKd6MDPTNTh/VuMg1G0UjE7PiyniVK390LdayTGMbaCVCa/DJ/ujZ3cpRh7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639794; c=relaxed/simple;
	bh=dvh1u+7VBkUDFdnHL9B5QLrlEYgfOMV2n8edCYZ5slY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eNesfcAnu2iOzTdPwCIeWGHhg5e+hGNkWo9eB85hlnHb8619et5yA06Kr7cJEX4Q1ieqcPHJxDI+An8HEJuQ5N+T81M6v/JMXs81zQ68k0yaMgF5Tof/RY0yiYPN3vsnYx/HsRteD47AHa1g5NV8ftRmMS3ox6nRch6AjE7f/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytld9Aep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytld9Aep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F8CC4CEE9;
	Mon, 14 Apr 2025 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744639794;
	bh=dvh1u+7VBkUDFdnHL9B5QLrlEYgfOMV2n8edCYZ5slY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ytld9Aep+WosKVUtosMMF6Scwc228BhpK2ujSdw4ZvDu31O4Jxj9fSfw9TH1BwtRw
	 NHHYcz6K9IuVkE2QceDEBFUqhVwwX8wtZBqVP64MacHA8Awf3n1WlC0QB1G1M9Uy0a
	 GX0i8s5LFGWiRxiD+OWKE1Juhfcu2ZKlsejxddwGD4MyL/WceA8zCrBc8EPa30Kx3G
	 89Hftu4sepAoRO19js4DzO9PuqVfRCwUysFWCDE3KsbV9bHgCT5JXNuaLa/y92N859
	 N9PzbM4euXdXGknXBVa8S6AOU3sopg6O20WIX94+FxvzhDVA0lv//ddyRlRMovnHMV
	 ykxjRY9Bxf3Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1C3822D1A;
	Mon, 14 Apr 2025 14:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: l2cap: Process valid commands in too long frame
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174463983201.1914079.8517788977157216938.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 14:10:32 +0000
References: <20250414090815.32366-1-frederic.danis@collabora.com>
In-Reply-To: <20250414090815.32366-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Apr 2025 11:08:15 +0200 you wrote:
> This is required for passing PTS test cases:
> - L2CAP/COS/CED/BI-14-C
>   Multiple Signaling Command in one PDU, Data Truncated, BR/EDR,
>   Connection Request
> - L2CAP/COS/CED/BI-15-C
>   Multiple Signaling Command in one PDU, Data Truncated, BR/EDR,
>   Disconnection Request
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: l2cap: Process valid commands in too long frame
    https://git.kernel.org/bluetooth/bluetooth-next/c/ad5747d4eed1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


