Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0F4BE451
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471618; cv=none; b=nWRcsJ5dUJDXFm2Rahn+oaY3m0ScglnX1078fwGV3l65GvjC7+1bV6KU+XSXFx1AQroe7+kB/bEgXPp4IqRNLuC5TP5MYwoSkLMm8IXz6IwcMNegiGdhwqeasXFYxFMfxt8jxsHjwzE80wgLcu2U3dtMnpSOxfID6zSGGUW6clw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471618; c=relaxed/simple;
	bh=I+Oe97RoXEy7e/eaFKvis11bf6vGKPlz+pbwRBv+HOo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BaqyVFVXrjoexf2yfj0HkkcuXbb6jogh5/6N6JhYenaRliyhBs0K9qnqFnaXMESPsV/DKEA/ddVg4fwUmzwsIvwQRtqkmOpaL19Lh7mfSuvK1zwOTDjnFyDIrNzAcaJcnzTDW/cjv70tFOlIPrn0ivhrWM35JeUoqm35ZQ3rMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJYjls7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJYjls7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838131F00893;
	Thu,  8 Oct 2026 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791471608;
	bh=TVn7J5UJbKuX/8szo5ykzgKE6qCBFTUlYBWsEff/oD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lJYjls7u7y06jjXf9C9cCEJO9Xorof5upvYs/opwWgAwmL3ndFP3zSKDIenSzbNSg
	 wWdJjQeynXEZyUOpTlPpRsR8DqHGSLzHiXBsswMUvfyh7RSWQTx3n0tE/hVgScYhAm
	 S7HxT7n56q8dijEz6zlI26a/1mi15G79dwj0ta+Y9TQV/hzPYqX0C4DZQMRwyL+Kca
	 tNAG9eR2o6DhkL2/B1A033itN0uNINecqhis+mpEISbwiCnzjiZmQLxccuJRz5M4LD
	 hbdwCFf2qH+ITPX0eeQwP5rYaqc61xfnHDjDGrsmMumBCsbJZj9NyEXm2rOgvhK8ru
	 mNKQBMtDRq1fQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7734C380AA75;
	Thu,  8 Oct 2026 15:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] a2dp: Fix crashes around pending
 SetConfiguration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179147160704.307075.10856321040219058548.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 15:00:07 +0000
References: <20261001143436.230557-1-eduardoalves8006@gmail.com>
In-Reply-To: <20261001143436.230557-1-eduardoalves8006@gmail.com>
To: Eduardo Alves <eduardoalves8006@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  1 Oct 2026 10:34:34 -0400 you wrote:
> bluetoothd 5.87 segfaulted in auto_config() with a G06-BT headset while
> WirePlumber 0.5.17 was stuck and its SetConfiguration calls ended in
> NoReply: the AVDTP channel went away while the reply was pending, and
> the reply then ran auto_config() with a NULL session.
> 
> Patch 2 fixes that crash and removes the MediaTransport created for the
> aborted request, so the next connection works. Patch 1 is an older,
> independent bug found while testing it: a rejected SetConfiguration
> leaves a dangling a2dp_stream on sep->streams, which ASAN reports as a
> use-after-free once the stream is configured again on the same session.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] a2dp: Fix UAF after rejected SetConfiguration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ef54133c69e9
  - [BlueZ,2/2] a2dp: Fix crash on NULL session in auto_config
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


