Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951414FB9C9
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782814; cv=none; b=u3NXxLT13TZL+V92ls22cKpw5bB5aZCTMdTHh6eilcQcjlocFbNmnh7LeizoFtkQ2qbjLS5SQcJYuDeuqoY0JpGPYKxhkWWhIXq8ohVy0RV+0O3z3zrF/OE/Y4tPti4XrfSlZE6zIXLRrszvVa9/XkggiLOodPMnaFGSphS9X6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782814; c=relaxed/simple;
	bh=lzMJNyen0lgNH/8votHKG0HnrLytKYDOKrHxM3vGAdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SVysYcSVRaebcnzH30aA/3uaHSBFb/WjJvL3I9Xj3T6JpuubUl3G7eEY1f5snI5uI3B27o5fmWbFalKgpc6N7vRPOZf5VX0JrRmtiixGLTcdk/6jipZtwOdfTWO6+g/0Aw8+VztMFJbuXUqOcPjv7W7A9u9IMmTrPvZ3X4cOSys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS33Btkb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS33Btkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419381F00899;
	Wed, 30 Sep 2026 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782808;
	bh=yvYRImkxmh0WKApvyOlxCzyJ3AMqIG9t2k5VZdJhMpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AS33BtkbwTBamSAUf2/2VWL8juPlz4mIScY2XE4Et7AWtxL3xIu7Vf3uNETu+YTKy
	 28v7b/aGzVcbemlr/8GRmFFL05ZPV3mp4uS97OgeuLe53+mFdrJ+6qeFM7hIrAAqzD
	 QnvAFtgSA3dvjeps6QWs37mhE3j/tmRha7Oplp6XFopl6aWgAsvuTwmrsKhq2D1p62
	 ariZMNcBx6f95a/3F7dFJX0qc5ObW4G6nsOcESkY2zxeg01LagFNr36kzsKHjTKm5V
	 lyxEbm9vFpKUiKuoDc/axLg/1GWAJQA0Wo7pivMyAQye8rkK1d+8td1NRmcCBrVOUr
	 4hcZWBx8N5D4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A37D3A566E7;
	Wed, 30 Sep 2026 15:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] audio: Fix stale AVDTP connecting state
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179078280703.1986714.6312799631329012580.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 15:40:07 +0000
References: <20260930101242.43592-1-mk02092022@gmail.com>
In-Reply-To: <20260930101242.43592-1-mk02092022@gmail.com>
To: Kun Ma <mk02092022@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 30 Sep 2026 18:12:40 +0800 you wrote:
> When a remote dual-role A2DP device reconnects autonomously, both sink
> and source services transition to their respective CONNECTING states
> upon AVDTP_SESSION_STATE_CONNECTING.
> 
> If the remote device only configures one direction (e.g. initiating a
> stream from remote Source to local Sink), the unused direction's state
> remains stuck in CONNECTING even after the underlying AVDTP session has
> reached AVDTP_SESSION_STATE_CONNECTED.
> 
> [...]

Here is the summary with links:
  - [BlueZ] audio: Fix stale AVDTP connecting state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eda4262191ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


