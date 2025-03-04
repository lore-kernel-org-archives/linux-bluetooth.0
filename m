Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E34A20A5CC
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101003; cv=none; b=sgXJ2TSblEXWSIVHCPEH7cqgVwz9XiU+xkqa2cdAQz2nctAef82v41CTcKNpf+ynuLf6DeLCoorG+PMcVK157wj2Fqv8x4CpizSkMzuyW82z+rPxWSRIAmfpTHUreX4e0ObxqzvZydXEmbo5mDpJnr8pmbIjX/8juvWmkKchCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101003; c=relaxed/simple;
	bh=5Qj+3KKQMLLAb2HRiY70dcndmOrS4SSYYaou1C5MYfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Phh1C/ANsT1WGtgwNctqmNETJvnU1NKf4g96vOtFdq/3cZpVLtZuC4iuNCapN2mKlYG5b9Y26MVBEgwnDPlM5iGlCi0qfVlamYP2HMbULTBGOXKUIKC+dmMKR+U9Dlg4prE3pMKSNia4Mj9WILwn0XVYj8Hpr9RksTxT6oWjtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8gS/FGW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8gS/FGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6A0C4CEE5;
	Tue,  4 Mar 2025 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741101003;
	bh=5Qj+3KKQMLLAb2HRiY70dcndmOrS4SSYYaou1C5MYfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C8gS/FGW+VCcODnYP7nZ98c5WOKQNikbBXKLKXwDL0yHtFE7QHdXpUqUJzWniykZO
	 4FHyy9az9RRH4kdEpXA3Bl+uLv0Y0sdhTlJJWneSHdYV5US9V62F3lAgS/XSFRQR9v
	 tDLdpKf0nU5kqwPduwmCtyx27RXDsMmmdg5vUZON7xyQ2Q+UqLzJMANs54sfIOr9RB
	 0OhtPxY9HG3HCT+kM5sf06DqdCvq6RycuX3fbyG05rMJmRcJ9z/sUcHaw+dvkcv4Jn
	 aCDLR/QpUOF3h1lwqSf0IQgeBZLAbKjWD/lNKwkWnCwB0tyLFCOwMXrJ202J0URNes
	 Z3UDzaS4yFxTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3464B380AA7F;
	Tue,  4 Mar 2025 15:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc: Fix typo in the copyright header
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174110103574.178640.14318188292747964328.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 15:10:35 +0000
References: <20250303195557.31190-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250303195557.31190-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Mar 2025 20:55:57 +0100 you wrote:
> ---
>  client/bluetoothctl-admin.rst     | 2 +-
>  client/bluetoothctl-advertise.rst | 2 +-
>  client/bluetoothctl-assistant.rst | 2 +-
>  client/bluetoothctl-endpoint.rst  | 2 +-
>  client/bluetoothctl-gatt.rst      | 2 +-
>  client/bluetoothctl-hci.rst       | 2 +-
>  client/bluetoothctl-mgmt.rst      | 2 +-
>  client/bluetoothctl-monitor.rst   | 3 +--
>  client/bluetoothctl-player.rst    | 2 +-
>  client/bluetoothctl-scan.rst      | 2 +-
>  client/bluetoothctl-transport.rst | 4 ++--
>  doc/hci.rst                       | 2 +-
>  doc/l2cap.rst                     | 2 +-
>  doc/rfcomm.rst                    | 2 +-
>  mesh/bluetooth-meshd.rst.in       | 2 +-
>  monitor/btmon.rst                 | 2 +-
>  src/bluetoothd.rst.in             | 2 +-
>  tools/bdaddr.rst                  | 2 +-
>  tools/btattach.rst                | 2 +-
>  tools/btmgmt.rst                  | 2 +-
>  tools/ciptool.rst                 | 2 +-
>  tools/hciattach.rst               | 2 +-
>  tools/hciconfig.rst               | 2 +-
>  tools/hcidump.rst                 | 2 +-
>  tools/hcitool.rst                 | 2 +-
>  tools/hid2hci.rst                 | 2 +-
>  tools/isotest.rst                 | 2 +-
>  tools/l2ping.rst                  | 2 +-
>  tools/rctest.rst                  | 2 +-
>  tools/rfcomm.rst                  | 2 +-
>  tools/sdptool.rst                 | 2 +-
>  31 files changed, 32 insertions(+), 33 deletions(-)

Here is the summary with links:
  - [BlueZ] doc: Fix typo in the copyright header
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=688f5ee80fca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


