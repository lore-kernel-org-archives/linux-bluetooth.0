Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501037FF70;
	Wed,  3 Jun 2026 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509009; cv=none; b=fVumJkrRk045tFOKjbDFJyd0C8y4GIcXLyufQHNcZsnqA0ArQCpiVUwU185KXW5DQemNPOCbApdK0Rlk8pKIXnZm3yz3TILHl4W5m2zJDgKln3RYuUzHmTYAfG3WbXFpdSqNZ08A2REJEfr+qq8n+KMJWaxWGLTjcFK0RIKsjzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509009; c=relaxed/simple;
	bh=veRoc6qD+O+rcbCVkO8SoYIFfiko9z7sfK4MBENeVus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pcLbYVHxtdlZU5z9xznz0oB629txByUcup8+Yw5hG6goP0sUxFGSiIkfz/Nt0NnQ85Pt1ERwoJWvBa2v4KRFRB0gnZ+yHzk6EVckOypxAIlvbRmID4YWTqhZAW28M0iQukxajKKrfFo86lGQ8IerqczEwICkv/Ib3vUuE+VURAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOWkSu8i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOWkSu8i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E25B1F00893;
	Wed,  3 Jun 2026 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780509008;
	bh=VAmAKTLBNRJ9FRRN5l3KI2wgIHr3wbyP4/SwyyoEJI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oOWkSu8iPW5fs5HBJpNB16jCzuxel8yzyzIt1xR3+SPXuzsfJoOxbMRs/5lVTAqB9
	 FcwswdM37rN+5+HRNAjpXn5MGhMMm+Q8UiSrtuFB/1K035YybIFX1LQ4qeAM89AkkZ
	 04mfdShWjl0tNUb92/9+EFZVdt/VH6FLp1IOuqyBCbOAxLwTf11A4ilRTGP86HiwI9
	 K+OkQqk8gwTSBwGbp1S+0BVUWvmIzBRL8sEiLV8I6Yy7c1yPQ89V7YOr/oRtDQq9MG
	 z1QWR7AALssevZxXaazaAZXepBvx9ZQed7qBGJZx05EgHF+d6wMjiOcvUteKaTut5o
	 J+XMPSsxySgwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B8739308BE;
	Wed,  3 Jun 2026 17:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: eir: Fix stack OOB write when prepending
 the
 Flags AD
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178050900939.1520440.11240262653174348549.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jun 2026 17:50:09 +0000
References: <20260602170621.1454711-2-bestswngs@gmail.com>
In-Reply-To: <20260602170621.1454711-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, armansito@chromium.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, xmei5@asu.edu

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  3 Jun 2026 01:06:21 +0800 you wrote:
> eir_create_adv_data() builds the advertising data into a fixed-size
> buffer ("size", 31 for the legacy path). It may prepend a 3-byte "Flags"
> AD structure (LE_AD_NO_BREDR on an LE-only controller) and then copies
> the per-instance data without checking that it still fits:
> 
> 	memcpy(ptr, adv->adv_data, adv->adv_data_len);
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: eir: Fix stack OOB write when prepending the Flags AD
    https://git.kernel.org/bluetooth/bluetooth-next/c/83dc982fad52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


