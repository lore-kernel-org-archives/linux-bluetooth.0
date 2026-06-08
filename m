Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A73D9DAC
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942810; cv=none; b=bq8JXD0gGeu/29HKb87VrGwZjUxJO93ISlOD8yNweJxknB+aUkXSSRvYbxK6OSeSTMP+f9x8ldJng2Db7SgCsHuISOg8mRqsMNJjkwcv/keV+8pJLLgfS6/YtqgAc9WJXpBBQDbCuqadrH6sFsXf15SqPxC+IaFpDuIQg2JD0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942810; c=relaxed/simple;
	bh=28BQdNNvKvjp4upCczgpiFTvXgXuQTSrVGcIRHcWTj0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p6tKOg79En4mDKjnrdQE42gQ9FSgdGul3xR+HymQOzbnA/jVBpTfLV59EQG2mazK8GvZuZXC+KJwQFWNOtiLKOiDFgZLE9BbXKEgjGO/1U4eh7mF4uEhCZ2j5phWoaSrGoeiy2tu4Jog2Xmk6imWKZ4vLfPePO6pir+/uiD1gVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk/5Uks2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk/5Uks2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40BD1F00893;
	Mon,  8 Jun 2026 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780942808;
	bh=fEfeF/SKPPM0UhW9hVsPD9555r8eDdD9uCS2vSm8Vg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gk/5Uks2+c+hjCnsK2l/M6+ghXid6qMTUp9dR6CzVltzcVvy+OPycv8YREVnOJoT7
	 brYHK0ymEe5JSvhZ6naGPQIIsPXFtinP2x0UNJMe5EKb3ItIrZkpC5lbZ7mKmNJL3B
	 xQG9ike9AFUrGeHIP5MMdGzEd3KAgLc1YvJPDyZE2DmqMq24urBYeIUi0qO2HNbqxI
	 HzbdT4ym3boLSIiH/m4jxAeyQIOQ2YT07e+AcM0Bx93SqO99JLs+xgKcb+Vmv2wlby
	 +mbM9YGb48opIwwD6IUAk76K252DXSEzqURq8lTLX02RKcBSxNg6m/0sSJKvEnzIqU
	 E25Z/WA/wf95A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09223811A71;
	Mon,  8 Jun 2026 18:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] avdtp: Fix GET_CONFIGURATION cmd
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178094280738.1611786.8852810526600157562.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jun 2026 18:20:07 +0000
References: <20260608112923.3722754-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260608112923.3722754-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  8 Jun 2026 13:29:22 +0200 you wrote:
> This fixes AVDTP/SNK/ACP/SIG/SMG/BV-12-C
> ---
>  profiles/audio/avdtp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] avdtp: Fix GET_CONFIGURATION cmd
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=60437c06560e
  - [BlueZ,2/2] avdtp: Fix error handling for AVDTP_OPEN cmd
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7c1c90f7b6d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


