Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F242045
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327436; cv=none; b=TgNHnrGXKyyhq8tc9vm+N9eoPL9ekXB+TJ+CBnaL+rKuJ53uj66mF08nDJ4fWHGLMCEd+gIkOJRUcWFc8Ojn12lvL/fAeMsF18pGx5ANJa5IZXCnAyZLERMZsQWRYcJxIR/z0pUVZbJXg4q++J2NSbLSsSlc7XAyQXdxlsTDXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327436; c=relaxed/simple;
	bh=Z/gVuUcr7G+8Vfo4pyv6wgC5nmst4z3wYqCcY1gGVO0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LhqwIOmE4CuRniD6XxW5xyobmH9dv2AP3UlYRbF/qtgSkBZ3+MJ23dpV/8IoumXJlFEzrt5bqger/JnRMV9i7K6+qYq4XgKYvrSENnZvThaQGxeYgdRdQ/eYq96nszNTKWnU1I+1ESWHwqln+6uVqbCHHwolLbVLIGPfm5ETbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xqz+3zMU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xqz+3zMU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E50D0C4AF0F;
	Thu, 18 Jul 2024 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721327435;
	bh=Z/gVuUcr7G+8Vfo4pyv6wgC5nmst4z3wYqCcY1gGVO0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xqz+3zMUbu+Z0in5xu1vkmw/lTZFxurmdmWpeFFbPQinhTp6yevfcywRDWAAzDpxI
	 4Em6KN6DbEEXrXKcYw/Gcxc05dpLJHqSgkoGt0asefkkl+1iRymFS0RCzFxlnm1Qld
	 6FvkoD1Vqvez5E+qw6QSc+q8OJKtFUml9pAbNz6BW0hhvIBiwz75G2Rp52Zt5t9Wes
	 dRB1/B1804IPwjoadHw2KjzcLx7insbZJtGpxo1I/uflJnSYwzCNFuIGX0XzDMXy0N
	 uTpM1TKk+EqfEtgtXIaOEEfCTzGlQXj2NU1Bv7223+sJ44a3s405tcSA5A+sa1T16T
	 zAou1zfdozKGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF0F1C43443;
	Thu, 18 Jul 2024 18:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client/player: Add support for name custom presets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172132743584.20188.10826744795415360673.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 18:30:35 +0000
References: <20240718180059.1159551-1-luiz.dentz@gmail.com>
In-Reply-To: <20240718180059.1159551-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 18 Jul 2024 14:00:58 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for naming custom presets instead of always having
> just one "custom" codec preset which needs to be overwriten everytime
> a new set of settings needs to be entered.
> ---
>  client/player.c | 130 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 87 insertions(+), 43 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] client/player: Add support for name custom presets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=025f07ec0d0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


