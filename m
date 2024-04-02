Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B415CD79
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090428; cv=none; b=DSTVp5cCKxt8Pxm8P/9Fdv2toepoimXMJAvoFRMhYKDY5RcmyCvKk54+qgwRTmGW/dym5IJX9eteKeyr8TIpjutmKf/1PhshSdZiCDtNsv9A1nUlN1aDX82/YZNASgy0tPoIAGEX054iRzF6eNQREuavIvUK5m6tIWadOMQLiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090428; c=relaxed/simple;
	bh=5zF8erpxVWMALXqArawqDPidHvy+E8taJIwnYXCDkLM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LmwfX2cNbaTzX48wYILd/pwnUgjaQxpxp71PXF6oF1AcSDyvY8P5aBiV9bjYBCDFw4h3QasvBBpJYJBd4bn8CgQ32kbJgwwzHNI1bP8aWCR/kz4XkTd6zTJ0S1nrgQCUGNoZN8AHk6tiY8CrJ+nUj6qZjPe+X3FvSLF/5iE6ZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBVCSHsH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBVCSHsH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40BCFC433F1;
	Tue,  2 Apr 2024 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712090428;
	bh=5zF8erpxVWMALXqArawqDPidHvy+E8taJIwnYXCDkLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eBVCSHsHyiX0wzKi4tsrkjpkAjgsE/VQnF4aPLM03o4x+oesNnm+hfWuYpvluARR/
	 lQ7A64VSERQOQJlvMiOWu1TZRnPqKTzdf7L6yWV/ImDp79S2S+oncgu+ljEmeVvaBj
	 U7kw5W5+nR3G+bDlSFBdSOOGBRCCS9Vfe/m6cvlY1Gt09oTTAh060r6wWMZblKCRSD
	 cIsWOQhzkMLPowdXad55LzSNShYGX3xHo8k1IHHzYYEc2DBOG5Vj5fTDs12NcoOHAP
	 2iWREN2ITq+N05VNpKadwVr2ZX3zCtO2XGW7eTmWbyofis5FwIx1YXfKo4stiagGHQ
	 DHpqAbKZuOyCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EBF4D8BD16;
	Tue,  2 Apr 2024 20:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] bap: Fix endpoint unregister for BAP broadcast
 source
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171209042818.14983.3797680434118713340.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 20:40:28 +0000
References: <20240402154955.45229-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240402154955.45229-1-silviu.barbulescu@nxp.com>
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
 iulia.tanasescu@nxp.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Apr 2024 18:49:54 +0300 you wrote:
> Fix endpoint unregister command for BAP broadcast source
> before fix endpoint is not deleted:
> endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x065f9b34fb 0x06
> [/local/endpoint/ep0] Auto Accept (yes/no): y
> [/local/endpoint/ep0] Max Transports (auto/value): a
> [/local/endpoint/ep0] Locations: 3
> [/local/endpoint/ep0] Supported Context (value): 0
> Capabilities:
> 03 01 ff 00 02 02 03 02 03 03 05 04 1a 00 f0 00 ................
> Metadata:
> [bluetooth]# [NEW] Endpoint /org/bluez/hci0/pac_bcast0
> [bluetooth]# Endpoint /local/endpoint/ep0 registered
> [bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0
> /local/endpoint/ep0 48_4endpoint.config /org/bluez/hci0/pac_bcast0
> /local/endpoint/ep0 48_4_1
> [/local/endpoint/ep0] BIG (auto/value): 0
> [/local/endpoint/ep0] Enter channel location (value/no): 1
> [/local/endpoint/ep0] Enter Metadata (value/no): n
> .................
> [bluetooth]# [NEW] Transport /org/bluez/hci0/pac_bcast0/fd0
> [bluetooth]# Endpoint: SetConfiguration
> [bluetooth]# Transport /org/bluez/hci0/pac_bcast0/fd0
> [bluetooth]# Properties.Device: /org/bluez/hci0
> [bluetooth]# Auto Accepting...
> [bluetooth]# Endpoint /local/endpoint/ep0 configured
> endpoint.unregister 00001852-0000-1000-8000-00805f9b34fb-00805f9b34fb
> [bluetooth]# [DEL] Transport /org/bluez/hci0/pac_bcast0/fd0
> [bluetooth]# Endpoint /local/endpoint/ep0 unregistered
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] bap: Fix endpoint unregister for BAP broadcast source
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0d38224bf566

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


