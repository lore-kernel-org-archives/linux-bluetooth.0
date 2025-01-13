Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEC91C07C9
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2025 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801415; cv=none; b=ckRNc7aUEjsBtTRpfyM1irrUxZ7FRIrDF4w0BCeAqM3pKWVcyRicbRo7bWcqSP7l7EK5FoCnEpkHF5EpfeWKKkeE/SSyljeMKgZJOaZyqWwhRZ8zdQ8KLjyyinzuHyPHZ9h26wbADiE3tyCU5ya4Nqe06euvfOpGEf+KejI1JGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801415; c=relaxed/simple;
	bh=vi6L1GbWogRhS0HctB9Lg5lECqJUJ7sZCMJ90GOf+Oo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JwZtagR2I9yqCL/P2Px5i7DWRLEZrbIx0a9DuEXp64rFNoRUZVleTRx/qXZXXC/41m0n9KnIUHJ0j36LJ6QcjAdPzv4DxAsNUHgVVuwS/wZgvJkZ9qmkb9LgiEBkhQ4h3DKrJD5iDTNJ0O0fX4MZ6orR+Lbovm7vqal3E5xy6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzil/FQc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzil/FQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF0BC4CED6;
	Mon, 13 Jan 2025 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736801415;
	bh=vi6L1GbWogRhS0HctB9Lg5lECqJUJ7sZCMJ90GOf+Oo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kzil/FQcwJYZrcpI2digP1xzI0cFulMtHmefQp/3tuF7uhskGdpbKkesN5X0gtbiE
	 Bj5NNaq+Ycz3CP3fEXfHoVKSKN9KJPYIlmJE6PnlYynog1glTfxoZmSMkrgVtRry5p
	 ofzkRC+rOTo4mBrHf0Bvx6MRGJkc9bXXgF1UrZdhcGQDygtxeW1ckTR0iW3I+CncQ2
	 H3OsfAZ2wQ1H9r/TgTK81KfyHzpPVjBmLq3ph5HDJJkKttxVrjRodVZkUhUQwuFOsz
	 qfleqabrJBKcB+hfLLLvIMiBUbwxZ1jd0COUtG/wzAE+kjjEQrZxhT7pYsdkCfRM23
	 J6N3EVgphB3Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB19A380AA5F;
	Mon, 13 Jan 2025 20:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: Clear pending_wake_allowed on error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173680143773.3628468.4306633095768774788.git-patchwork-notify@kernel.org>
Date: Mon, 13 Jan 2025 20:50:37 +0000
References: <20250110173146.309964-1-ludovico.denittis@collabora.com>
In-Reply-To: <20250110173146.309964-1-ludovico.denittis@collabora.com>
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Jan 2025 18:31:46 +0100 you wrote:
> If setting WakeAllowed fails, we should unset the `pending_wake_allowed`
> property, or subsequent requests will be rejected due to another
> "Property change in progress".
> 
> Fixes: https://github.com/bluez/bluez/issues/1047
> ---
>  src/device.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [BlueZ] device: Clear pending_wake_allowed on error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2ee08ffd4d46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


