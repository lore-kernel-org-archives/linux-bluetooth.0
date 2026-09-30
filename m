Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C6501F59
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782814; cv=none; b=Sq9YqWxMbnId0VJffww5Rf0MOFXV+rPfhwzaSQNdn/W2uVJ0aXziToPu9MRW+rjX2tYewIj4tPdwZasq8+uIQIl8zACSaudKJlKmp69C0ZvKctXzh25Kk3dy+DPcm12oYpvlzEIrorTxzFIaupxt/BkIrFkh5kKBbOhNQPRLcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782814; c=relaxed/simple;
	bh=uvfrfBSMGuRBTfPsy2k69lOJImJkiwsbip5M9oNDYXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I1L0Awq6SWBiJihvBmmuH8mLJGb1yiCUiZVaSSh2E+TmvWBq0wgXeT/5YcMLO1PLVfdFqqdl3nzah+wyLkNTRyVzdsmm21r18VGoRo6IFOOUwTSkLEEE0ItfTKOgmQa7bHoJWQozIOUSjq1/QxbObQ+8RhXBm/RkRve9k3CVjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7p4OVY2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7p4OVY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C256A1F000FF;
	Wed, 30 Sep 2026 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782809;
	bh=XKQZYJX4wueQKQuJjkH4ozyS4Q0pSbO0WcUS4JW40Ig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H7p4OVY2BOwsIcuUWk6jaHgTwDoXzyXNh/SySSLssM265vb350WUDhV8AueSHyX/w
	 Sw78dp4KdYYGMMrTqStglb04ootk8TTrGwPxGyYIVgsapDZXplrrdhkmHtcAzxhQ/9
	 v+D+iMVsFDSu/32NBzsJW7hv9W13UbGgpNZ3croVK839co7qO0uNXHATh8K0wR3wCq
	 TMOaHINaldH8oHvneB8uXuXZFNXEb3ndrrXlweYr4DJzbNNctOvMZW8Ydg9wxcn+Wv
	 dALfSk7w4MzEyfMUuOnlC6s5lRbILT+PycDgKzLgs/Px8Gl4lPSgqA40lsZDN0gpFj
	 hLeSMz1WsFgVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43433A566E7;
	Wed, 30 Sep 2026 15:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] mpris-proxy: Line-buffer stdout
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179078280827.1986714.14953752400407137061.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 15:40:08 +0000
References: <20260929024530.3978095-1-jmsmg1@me.com>
In-Reply-To: <20260929024530.3978095-1-jmsmg1@me.com>
To: Seonggon Cho <jmsmg1@me.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Sep 2026 02:45:30 +0000 you wrote:
> mpris-proxy reports adapter and player changes with printf() but never
> flushes stdout. When it runs as a service (tools/mpris-proxy.service)
> stdout is a pipe to the journal, so glibc fully buffers it and nothing
> is written until 4 KiB have accumulated or the process exits.
> 
> On a system whose Bluetooth adapter went away and came back every two
> minutes, the "Bluetooth Adapter /org/bluez/hci0 removed" and "... found"
> messages reached the journal in bursts of exactly 100 lines (about
> 4096 bytes), all carrying the timestamp of the flush rather than of the
> event, i.e. up to about 80 minutes late.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] mpris-proxy: Line-buffer stdout
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a086d234e503

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


