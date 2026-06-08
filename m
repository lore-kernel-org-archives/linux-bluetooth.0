Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9D3DB970
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942813; cv=none; b=ezN8KRqwCdsh85PVmD07cttLPFYX/gURBa44cKgWMlxgYhbEtRk2ajxlwZlSqrkdIw9YahDtI97PRP0O6j0it/aNYTKW+f7XqgbI5lmK5C/ybVtHJd7EIu7v8wCoDlafrlkqR2sdKFzaiqq0b4VHbjnlYFRTXYEYTZBoD/RXlQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942813; c=relaxed/simple;
	bh=OeLlWHDbQoqOAqIWk/7U37dXxvcyIKNdpwd5vcsseFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E7Llo4GOu71Eab5gmnkzQ1Vs9sRPjs0xJauQ5WmN5GGw2NNupZzjFcRAgj9Gh+MI0MZAvmc9rC1PSyZlpPKL7uPHCoY/yjPrzp2q/u1faetr1V1lrKcSIHLzH23TfVb7BdxQ2VlIkk/EFbiGEvlZ/nFn3suNj5On59YdGF+R7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGsF851M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGsF851M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47B11F0089A;
	Mon,  8 Jun 2026 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780942811;
	bh=wHwHLRGjlLX0mIg9NJDVJvgQ6ScVky1ZrrCOjlor4HY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oGsF851MEwSG7KDLU6LdKBRG3eodB5BXwmT4e1m90oEv6D0Qd0hUxHgUEadvofz28
	 RAC9FNkKrVoKD+GvE8L9xxvtvnBE3gRLEL1MI4L67BbwLvoZymMSiWsx7bwIQq6oxH
	 CFVvQaY0sSn695rSkTasmS5KZi+q6lNy3B6aGDrqVLE8p/IdPoXWc6Zcj3cC2S8kiP
	 ZRreTBjerxavO6tN3QMn6Qyftq6ahfKxhqoVlRMCJ+GWRl0tT/zsMlrYemyk4ml2Pf
	 /8Mo2ex7VVtgti7YeLL4QgCjyeYJV789A+RpwPCqvnPRPC9CZVJykTPzcvMXtMWi4V
	 7DPOROrh8qZrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09AE3811A71;
	Mon,  8 Jun 2026 18:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: Fix cache update on device remove
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178094281038.1611786.5265137920273668277.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jun 2026 18:20:10 +0000
References: <20260608122713.72681-1-frederic.danis@collabora.com>
In-Reply-To: <20260608122713.72681-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  8 Jun 2026 14:27:13 +0200 you wrote:
> If there's no other group than the one explicitly removed the length
> returned by g_key_file_to_data() will be 0 and currently nothing
> will be changed in the device cache file.
> 
> If there's nothing to write, remove the device cache file.
> ---
>  src/device.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [BlueZ] device: Fix cache update on device remove
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=279c4ac70c77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


