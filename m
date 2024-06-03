Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5301E4A2
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422631; cv=none; b=nSBvKJAwvdjghuz1mBu5NTilRlloG7+qr7la9iwFJ+yiahsXt5TDsi2StJ4XZp0/x6pZ3uarVEBxUt54VX2+EOuGlWxkSuDva03KL5TDNKyb2W+FZ3budHV9ZeX0AIZFHXq5lRxdZiTfnYbkagQirmP80RzYdnhoRbnWKKfPNPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422631; c=relaxed/simple;
	bh=KAXqe1HSOl8On+9C0Qvq/ONlmE46YbLO/86WT22Qyd0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P4jnwF6aWP+l3GCXHORwRvjr9KLMbqn0iXwWTwepE1+vczVAP3NxXhSNHfu70Qcc0o13JwIdUxR59GNFW6UmZICvzyvRNPJuw9ynEixmGi2IYWUG3Fu4a79yW/0+nzodpP6ZQItikTlNjjq5V5G5uZUtbSO/G1iAfOdwg+bWIqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXXu5ik9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXXu5ik9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DC65C4AF07;
	Mon,  3 Jun 2024 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717422630;
	bh=KAXqe1HSOl8On+9C0Qvq/ONlmE46YbLO/86WT22Qyd0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eXXu5ik98CenBsvy6a0fEmoWeUEEWeJ1nJfzWd92tH0i7I16pkU7xRR/1UhC00/GS
	 PqUFVhYvO5AvCao6ihI1UpmDGkjSPOf94QyhyX4upUhcMvOdQ/OCorYzmkQhBObPb5
	 uNjbLJIyD7woN57unz9nL7Uj5lWb37xUfkicphcYjdHMu9ROU43XardjKcgNQhnA3g
	 WwB/Up2o7C5f6sjtlPCW7X/4Lv8OqSKpjBOs8GAvQvA9mHzAdVfIYvFB2AwF6Q+s42
	 IMmhHpHpQIwue8l5gDLcPmWxatslLyJ3sQ+LfvQupOXbwFajNUMa1WTwVwj0HlJxVT
	 kkzxG+UHTQuvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B1EFC43617;
	Mon,  3 Jun 2024 13:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/6] Add new BAP BSRC/SCC tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171742263036.17260.11390200178623096049.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 13:50:30 +0000
References: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 May 2024 10:54:16 +0300 you wrote:
> This patch adds BAP unit tests for Broadcast Source stream
> establishment (BAP/BSRC/SCC/BV-35-C [Establishes Broadcast] - page 175),
> stream disable (BAP/BSRC/SCC/BV-36-C [Disables Broadcast] - page 176) and
> stream release (BAP/BSRC/SCC/BV-37-C [Releases Broadcast] - page 176).
> 
> This patch also adds shared/bap fixes regarding broadcast stream
> management, required for successful test implementation.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/6] shared/bap: Remove DISABLING case from bcast state cb
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=491e5b353700
  - [BlueZ,2/6] shared/bap: Fix potential stream access after free
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=af2873b26912
  - [BlueZ,3/6] test-bap: Update bsrc_state to just handle CONFIG state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6cb268f47f47
  - [BlueZ,4/6] test-bap: Add Broadcast Source Establish test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bb30b1990154
  - [BlueZ,5/6] test-bap: Add Broadcast Source Disable test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=06a905d6b8c8
  - [BlueZ,6/6] test-bap: Add Broadcast Source Release test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3f747788c1b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


