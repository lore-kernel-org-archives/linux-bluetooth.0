Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6001192B8C
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167830; cv=none; b=WFEcAWKuWtAg+1M/IpdiAXrlUwVvg9DT5KPFGmUYwnOlq0tmYbkQYA1AsAUt7eVOwsnRnOX6vm18NEpopi+ns94jNkLUykrgvLphuFcxGC6N6eKDw/unoBzdfJ7iUwVXvSK6vHCcDTC4uVnB+hg039giRG8foorXutSNrG+JbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167830; c=relaxed/simple;
	bh=ro2V6YrCIx3cfARmfVCWIuxC3gyQLI3mW8iLqVig3LE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jFkJnRYi8FaKDqkC9RFNrPAU36Su7D+XAFJ1I6yiJqvSgyt/47CjEnsBJih34vUB445ZEI//UO8PpQ6NYe71oBoJRpTQacJu3seDjHSBVk50ZXzvj2S/Lf4aHVypoqwP3xiIM/1FQ0ineqff12FreB2tGcpUYbWWhEqBvOGg3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMrLs4/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMrLs4/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0D6C4AF0E;
	Tue, 20 Aug 2024 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724167829;
	bh=ro2V6YrCIx3cfARmfVCWIuxC3gyQLI3mW8iLqVig3LE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tMrLs4/SPEqdVFQOPRCGaFoljzQhKCbrwlXzlkQakqTLMoV2a7XR7SXC2jykB/jAY
	 CJeu9vAeQgwY9flH9zcfb1WGm1+zbM2xpIoOu2hFwAaZbcWa6ZElL2f8v6LWtyXhSc
	 0fGgsvbJlRTxmNaPQ/4M9t9pIt1xuKCjoBxxPlfzysVt7gQ9ZiUEKxIz5DXKWOecOe
	 3h80z1qvEfsBMm8Zi/xsBJhLTrEZGk04/De0l3UkXJFCAWN3Br+JOrfD7se+OIRsOb
	 wqdO/HnpgPwd8mkP7ULHN6k5YHdCEcDZkIFkImkMmAeztaACnvI4seeLUgePmLG9D+
	 nK1AAkWj4gaPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341A03804CA6;
	Tue, 20 Aug 2024 15:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] client: Add bluetoothctl-assistant.1 man page
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172416782903.1174012.17648226489742208514.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 15:30:29 +0000
References: <20240820113153.25708-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240820113153.25708-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 20 Aug 2024 14:31:52 +0300 you wrote:
> This adds bluetoothctl-assistant.rst which is then converted to
> bluetoothctl-assistant.1 using rst2man.
> 
> Iulia Tanasescu (1):
>   client: Add bluetoothctl-assistant.1 man page
> 
>  Makefile.tools                    |  6 ++-
>  client/bluetoothctl-assistant.rst | 63 +++++++++++++++++++++++++++++++
>  client/bluetoothctl.rst           |  5 +++
>  3 files changed, 72 insertions(+), 2 deletions(-)
>  create mode 100644 client/bluetoothctl-assistant.rst
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] client: Add bluetoothctl-assistant.1 man page
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2f3f63467d72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


