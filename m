Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FCC275AE8
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753730391; cv=none; b=BEyH/uhqe/p+zoQ0oculj1i7zsWqYLIQE7GownObfvqYtaUWSZBuRfEb2YdRiO702uAZiGv+SWnUqdm/uSqd8x+FNTCUk/rr+oKrEAdz2dLGCS+E5lc+siWsPFNMN+6ZjI6uMdMP/hYVohVsH7uU3x1hC9lltDMZ3XqcUkH/AZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753730391; c=relaxed/simple;
	bh=PiAQtmS8aOv8S42itpFxLeTFZeX9Zt4K3OZR+4HoUik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ngz7ef+t1tV5z5LoBjvtEbkNB1vPNOJw0/esV6PouNcYP0M8oObi0FbDxA92IW0fOllbhJT0u9COPT6hLyPX3eRNou+BqrzXvI47rCQijVsWasN6HhqkJm/xwETkpnppIYvJNPPa836HcJ5uycXA/QBCBWNnwGRy9Z9aWV+Blmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgCeZj/b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgCeZj/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EEDC4CEE7;
	Mon, 28 Jul 2025 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753730390;
	bh=PiAQtmS8aOv8S42itpFxLeTFZeX9Zt4K3OZR+4HoUik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PgCeZj/bW8t/G2brOhafwOvfFjY/KkAumhoOsc0icNT0JHyMRaF1l8XrM4vkOq5FM
	 xFCHPTqnpPuL+KjMoiUIV80TS15SJX4IW3um6bmLoMC8m/G1gYLv0gqz6hAsoG/AKW
	 851hedigc8qFdnwdzmKY+X/na+RkUObDKOu2XfIllRjtDymyhy7pt/Hq94usLIY2ZC
	 aa5J+mGP4Qdtslay1jbmSvCoiD3/z0t314/jhQAYcYIMBEFtNUaFqgJtZmE3KarlVh
	 mdYvJ9MFfmUiy4VS7AJC/3mhXtEUkj5c/kGdXeFlmZtEWkVN+ThxWB+01RmrTZkKBU
	 Rgmq6PZSDV39A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0FA383BF5F;
	Mon, 28 Jul 2025 19:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] bthost: fragment when sending ISO packets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175373040751.818107.429360590429365562.git-patchwork-notify@kernel.org>
Date: Mon, 28 Jul 2025 19:20:07 +0000
References: 
 <8b803274627f277cdb987b5ea5695f62247b6d3f.1753295558.git.pav@iki.fi>
In-Reply-To: 
 <8b803274627f277cdb987b5ea5695f62247b6d3f.1753295558.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Jul 2025 21:33:33 +0300 you wrote:
> Support fragmentation to controller MTU when sending ISO packets.
> By default, fragment when exceeding btdev iso_mtu.
> ---
>  emulator/bthost.c | 102 +++++++++++++++++++++++++++++++---------------
>  emulator/bthost.h |   1 +
>  emulator/hciemu.c |   7 ++--
>  3 files changed, 75 insertions(+), 35 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] bthost: fragment when sending ISO packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fd80f2354ead
  - [BlueZ,2/2] iso-tester: add tests for hardware RX timestamps
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0084cfe5634b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


