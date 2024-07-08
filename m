Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E33BB50
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470631; cv=none; b=IizwHpWATJvXXIyYkWCGgmNtXXO7VEDBWI71Z5lPycG8xasy7+x6G6zQXEGvBeNYXLYIf5s7yHL5ZFygLJpyHHlPddAHZxh9oBtAdRrpKNPkjT57G5UpEP1bRsyhAEM0MwbbxxBrxdjyBz5rn27wBTO94p/UYc4lGrb9Hk0b4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470631; c=relaxed/simple;
	bh=Xjh6VC8CfZH5Gf2TvdU2z/BHpMsmvC5PYg70rTOoHD4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QxVG4tmBVGtzHTRtsEgqP555EgmSi+OK2LVx3CqlF6edXlsqsomHeUO3E+bYQHpGqu1DpgiFAa47VlIZZcfx/HANAhpvxsK0VLgu27medtSKt/JIfwKSN2pDvqiVbBH95tDA44QjLIMeZzs33VXFc9yay4YTCpaYG/PsiwVq7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6bAFMOO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6bAFMOO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82C69C4AF0C;
	Mon,  8 Jul 2024 20:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720470630;
	bh=Xjh6VC8CfZH5Gf2TvdU2z/BHpMsmvC5PYg70rTOoHD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m6bAFMOOCZKciICnlzB46kTG9gVbiMNoq3WcduHjV5X9dGHYyFYSvKbng5RFAkVZk
	 dz3JGKuQZTsGxPygr7FRPqOT/uiFB7i76XcSxGt47xHd/FCUB19NIqxyKfWFFWlAP5
	 Mw+t/wraev7rDpObZ0nRZsUK0IXP52YuGfSxd6BOmiWhaoy2Y4PfbTT8nWbAqEtfmR
	 kY16kuNnLgkOSAQ2qRTx/MsPncynL42oZHxHNvSvNjveQ/X1QWrYukIO1tmETQzr/C
	 leyhEe2Fr5sF+3N6tn9jHp/WBQmdzwxzSlmkqUOKeaZr+XoJAXLI8y0OWT47GOGpzw
	 6eDTly9rGAbCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 786FCDF370E;
	Mon,  8 Jul 2024 20:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/gatt-server: Fix not using correct MTU for
 responses
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172047063049.14874.5052660184982030380.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 20:30:30 +0000
References: <20240708152823.2726052-1-luiz.dentz@gmail.com>
In-Reply-To: <20240708152823.2726052-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  8 Jul 2024 11:28:23 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Responses shall use the bt_att_channel MTU not the bt_att MTU since the
> response shall be send over the same channel as the request.
> ---
>  attrib/gattrib.c         |  8 ++--
>  src/shared/att.c         |  5 ++-
>  src/shared/att.h         |  2 +-
>  src/shared/gatt-client.c |  2 +-
>  src/shared/gatt-server.c | 91 +++++++++++++++++++---------------------
>  5 files changed, 53 insertions(+), 55 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] shared/gatt-server: Fix not using correct MTU for responses
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=110a8b47a4f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


