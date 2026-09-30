Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131FC4FD7A9
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782817; cv=none; b=PfoFvTItaA5h6YisjMv+s1/HoFMJjwAgg20t1oOQTQbV5o5o3oeh+jRdWMPvBFXTSVzrJdGfUYaPFb2mjXPut3lnK4DS+iIPkbkJvFSOF8K7RWfTlTDemFhKpvYAa6rJ8J7R/MGsUN7mVKVxGvvrLPjDivixYKwtKcKCSvHYY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782817; c=relaxed/simple;
	bh=VX0wKPInhr2AeMupQUq+WKseMxBt5AFEoMEg4NbOSUs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BK7rZkk28GWnTTCYuoN/edi452FEgH57PYw0i20pvuioKCIRFd8IxrA2EG8iOPSec6oT8ZG0QVmpTVBDTPQ+0YE5exvr+/I+LasFvsAmS1YPSLs6nAHSGXjTG9iWDPcgF7HoZHfxbI/NIyGdPC3v/AF84PzeoVdPVEDb8WIvb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTOMhL4j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTOMhL4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420121F00893;
	Wed, 30 Sep 2026 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782811;
	bh=wyshhvIoEryRaR/ka/fwoUj3M5QoR8oC/sXpYkmqMww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kTOMhL4jkCwu2uNBpErWLgtoVAdyeJisbKlWjsJTEZAtI7yB7bO7S6HllGNZcvWo2
	 2OkFglok6nS8qQ7eSNGObAeJgVNTSO2PPEd0oztRw2nl5jov8za3rAyEaI2E+YhDeS
	 hmgxHPemKsJd6sHZRA42iPRzebtSlid2xWX14nh9InHaIm17XdMPxIYYs22MkKVYuD
	 3THMDWA+af5IczNQ+N3vnxVHsCUpTYEiD7NPtsECOHGYfeBLivLb0ebJvUD4Zin8pj
	 8Yi9mcHRdWXZ5AxsBsDyBRUvzgYD4szvsM8znMKz/lPq2yQApoHLfU80wmR82pp2uc
	 t9zGXzUf+5NxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A26B3A566E7;
	Wed, 30 Sep 2026 15:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ranging: Route CS subevent results by connection and
 configuration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179078280977.1986714.4946356790271946414.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 15:40:09 +0000
References: <20260930054528.2258948-1-cheng.jiang@oss.qualcomm.com>
In-Reply-To: <20260930054528.2258948-1-cheng.jiang@oss.qualcomm.com>
To: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com,
 wei.deng@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 30 Sep 2026 13:45:28 +0800 you wrote:
> bt_rap_attach_hci() allocates a state machine per device and registers the
> CS subevent handlers of each one on the shared bt_hci. LE Meta subevents
> are dispatched with queue_foreach() over every registered handler, so each
> CS Subevent Result is delivered to all of them, not only to the device the
> event belongs to.
> 
> The Subevent Result and Subevent Result Continue handlers then passed their
> own sm->rap on without checking which connection reported the event, unlike
> every other handler in rap_hci.c, which resolves it with
> find_mapping_by_handle() and returns when the connection is not its own.
> The Connection_Handle was parsed into the event and never read again, in
> rap_hci.c or in shared/rap.c.
> 
> [...]

Here is the summary with links:
  - ranging: Route CS subevent results by connection and configuration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=05870ea62923

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


