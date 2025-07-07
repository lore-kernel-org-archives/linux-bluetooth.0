Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1235D29ACD4
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899783; cv=none; b=SyhaB4QI+WVeL3Qu0mN86O7vx+ZNHV69LsSqXNhglTN5THXTStwmdBATUFiCTs/0RsnRrfXGSBZSqjAK6ylqzyzSwDobrDYsWHyD0UsrbH2A7IATUbo5MYx75XuJAxY0O84xdNa6C8nr5wfsjvddrMcstVu2ZfbpVG1zrfnEJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899783; c=relaxed/simple;
	bh=HEv42tSaQINUrJsY32cZjnPkxACo8gygn9yHgHNGAvI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=THIXxRU9AVTqHuGsHj0QVPzeAtcOnWXZ9AzZlil5N42xUDmz0nfSO0z1DBNQ5mQdKRoDVZDb53AZdV9denxrPBdfntiGtHxDw22O5OD+xR8rY2DjQVgti8hwFyLzVBeRsnQhsOswYQ7OFwjZvoNOcyPC4SHRZ9ksuIedE34SPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYmDqoEQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYmDqoEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87821C4CEF4;
	Mon,  7 Jul 2025 14:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751899782;
	bh=HEv42tSaQINUrJsY32cZjnPkxACo8gygn9yHgHNGAvI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BYmDqoEQXCizZCxz7LwOilB41O2S9uC8wi7tdI3VRCRZeRcPkzjQTqKbkm+z/Z+zd
	 Iowj/a8aaJjnTuNB5xyiXxXa35nHSvdCAGcIX7td5UqJ63fTe1wi2oUSvz99m+7CvX
	 TSClz8oqiK/RDviVlH1r0yPk+lge0qgKseuwBPhu/VJaLItcKXgRd2CBYgQTTcBmyX
	 +FdfqMgv4z2tf0Fqn0bt8VybLVOkd5+Zou97RU1PFVCktCbzov8fnSXc83UgAphkZV
	 rVgji3vGSpPiXANPD0sJMwSEp1R//7bilpQy6TvrPf1r2xxjnCxwsK4kJ8IBY7MXs7
	 NI6E2wl0GBTpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1EE383BA26;
	Mon,  7 Jul 2025 14:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ bluez v4] shared/bap: Add stream state check in
 stream_disable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175189980579.3319521.11142129372723685327.git-patchwork-notify@kernel.org>
Date: Mon, 07 Jul 2025 14:50:05 +0000
References: <20250707-bap_for_big_sync_lost-v4-1-bf667d839b72@amlogic.com>
In-Reply-To: <20250707-bap_for_big_sync_lost-v4-1-bf667d839b72@amlogic.com>
To: Yang Li <yang.li@amlogic.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 07 Jul 2025 14:00:36 +0800 you wrote:
> From: Yang Li <yang.li@amlogic.com>
> 
> Add BT_BAP_STREAM_STATE_CONFIG state check so that stream_disable() is
> a no-op when the stream is in CONFIG state. This prevents unexpected state
> transitions or redundant operations during cleanup.
> 
> Error trace:
> bluetoothd[2313]: src/shared/bap.c:stream_io_disconnected() stream 0x1f9fc20 io disconnected
> bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream 0x1f9fc20 dir 0x01: releasing -> config
> bluetoothd[2313]: src/shared/bap.c:stream_notify() stream 0x1f9fc20 state 1
> bluetoothd[2313]: profiles/audio/transport.c:bap_state_changed() stream 0x1f9fc20: releasing(6) -> config(1)
> ...
> bluetoothd[2313]: src/shared/bap.c:stream_disable() stream 0x1f9fc20
> bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream 0x1f9fc20 dir 0x01: config -> qos
> 
> [...]

Here is the summary with links:
  - [BlueZ,bluez,v4] shared/bap: Add stream state check in stream_disable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=168377c0c8e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


