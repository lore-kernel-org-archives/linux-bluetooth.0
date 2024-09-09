Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B71758F
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900632; cv=none; b=cy+cPqutAV9nVGQC6EWDEBCncTjX6kbuuDXGyw79ptY0zqxzrvI/HzcN7cvu3zBbautX9FAUbMJoqoBxkJJk1/CyxRziCAzWRsZ8Loiu0S/uLtfDFUArePnhKaI7q2x4+p7Ak2tXegjIepOBsfvMq9HNCRUCH7fvbPxVdMXXvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900632; c=relaxed/simple;
	bh=yQX8r91dv5ffJWnl9XeMmTmlIEv9CajHP4C3lEPzgUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UsarWZ57bosaAy00eEgb+AAyEjBR6WeZOMHI5VrL5kKxAyw4d1qnEvfVlnK9MKWre+Ugpeyi0+q10OVHDERHNhhJtyn46ilONjSkd1Uvd6g6YoeQaNnGVnjwHsGVIdG2JCeQUel03DDY3dKJKiBezXw52EZCQzbMzlCz7voFmNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owEuQjGL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owEuQjGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801A2C4CEC5;
	Mon,  9 Sep 2024 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725900631;
	bh=yQX8r91dv5ffJWnl9XeMmTmlIEv9CajHP4C3lEPzgUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=owEuQjGL9y72GKrR8WEzQ0WVduGwPPblCEjILqHS4un+u0HQWKdh1j3dZT4lIGute
	 oEQ7B3hli0o65Jda+fLCltSNzWnjGwkYA+5xWgy+A3cB3/m00eisDQHWb/SDj/deSw
	 jjO/nYNXup/H6Hk72VTwLFtY/1F6SAYfn/g7TWHzkrdxc1NZ4YyMkyL8X34IM3uiQV
	 3faotpYfepm1owjoofAYsaJrdBVrSRfy7mcJeAxm4lBqPXBUUTM4cP6Ulgg3/2Sdy2
	 LJbcHONfLopjpUxLZ6l3/YoaTRWVw+oHc0DL73hrEkK7DBqEeNIz45MZFd61hvLe+l
	 XINOTqfRBN0UA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0663806654;
	Mon,  9 Sep 2024 16:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 00/16] Add Scan Delegator support for Add Source op
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172590063252.3857512.9575691357117732856.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 16:50:32 +0000
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Aug 2024 15:49:02 +0300 you wrote:
> This adds support for the BAP Scan Delegator role to handle the
> Add Source command received from a Broadcast Assistant.
> 
> The Broadcast Assistant informs a Scan Delegator about a Broadcaster
> by sending a GATT write command for the BASS Broadcast Audio Scan
> Control Point characteristic with the "Add Source" opcode. Using
> the parameters received through GATT, the Scan Delegator creates
> a device for the Broadcaster and probes it with BAP. The BAP plugin
> will then perform long-lived PA sync and it will create streams
> for each BIS required by the Assistant. The transports can then be
> acquired/released, and the Assistant will be notified about each
> change in the state of the streams.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,01/16] shared/bass: Register ATT disconnect cb
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=38b7dc7d17b4
  - [BlueZ,v2,02/16] shared/bass: Make bt_bcast_src private
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=25119b6a72aa
  - [BlueZ,v2,03/16] shared/bass: Remove io handling
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8abcfd7028e8
  - [BlueZ,v2,04/16] shared/bass: Add support to register cp handlers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=30c190089ffe
  - [BlueZ,v2,05/16] shared/bass: Call cp handler for the Add Source cmd
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0446d1eef9ef
  - [BlueZ,v2,06/16] bap: Add support for long-lived PA sync
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b65767c5dab5
  - [BlueZ,v2,07/16] bap: Add API for Scan Delegator probe
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b8530f0d2672
  - [BlueZ,v2,08/16] bass: Register cp handler for Add Source cmd
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4191ff1c4045
  - [BlueZ,v2,09/16] shared/bass: Add API to set PA sync state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=06d20a80249b
  - [BlueZ,v2,10/16] bass: Add APIs to probe/remove Broadcasters
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f3a43bd0e4af
  - [BlueZ,v2,11/16] bap: Probe Broadcasters with BASS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ea7b69102434
  - [BlueZ,v2,12/16] shared/bass: Add APIs to set/clear BIS sync bits
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c6278d24d9d2
  - [BlueZ,v2,13/16] bass: Register BAP state changed cb
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a032a570489b
  - [BlueZ,v2,14/16] shared/bass: Add API to check BIS required for sync
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7c3821f822f8
  - [BlueZ,v2,15/16] bass: Add API to check BIS required for sync
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=df4e11fab68b
  - [BlueZ,v2,16/16] bap: Create streams for required BISes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dfcbc2d3c011

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


