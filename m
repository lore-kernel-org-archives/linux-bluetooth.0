Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D33A221F0C
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685996; cv=none; b=MxlTSOXSCpd1oS7I4dT+XqFWuKQcvGtkeEk1CN27S9yP6Go4eToJEPh2h5hsdpXnLd89Z+/ByEJnLyBGbZQcPngXjUiV9en926a/jp5OUwUjwu1Rp6LP9oBWdAerFjbNbPQP6FwAawCmJp8GMGLm53rrUD02Iq/s+miNdmCDIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685996; c=relaxed/simple;
	bh=gKQRV2/bhx60hRosk8UAx6V54js8sMYXm1w7hbSFbPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d28plMG+gwrHMLWcVmyMF5zcs8W99Ji06h6ez/5gxTw+0NFwS1QsZACzFBrklxkKopqZkm6FeEgIMEfjL1StR42vEB1JTKkiEnzd9OugdmaydznxUvfssbFmHq11KT2s1pL2Ypp5VBinxBykzSYuuia+HgA4HKtmSf+C+p9T9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbqgLAVP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbqgLAVP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8ACFC4CEF1;
	Tue,  2 Dec 2025 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764685995;
	bh=gKQRV2/bhx60hRosk8UAx6V54js8sMYXm1w7hbSFbPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VbqgLAVP50WOostRP92g6FEKfB7+C77W1E1CPG1b0sJsuj8/SFpe0EL2CCbwi2ho8
	 JFBacbjpjqzfyQTItiPz+GO3XFcsp7m6ejajpmqIc76qLZLY0RULPdC7xnr3iDCjAq
	 6PzHZbVdt3tv9pJbDv+YCpGGPQ5UL02AOJYC3L45J/ohVtwFhJwowj+ww3gHnslFfy
	 sXHnuyADnW929vqiyVFimNXqeOqLI4/+PnAtuNgikBp61xEuj0Y1N5St/2pYRKtRpH
	 IRy6RJrPXrQPFs2T8AHyCn+sDbFXHWePayUX9HCRvt3eHoY4qXkrd1ipSPbihOk4og
	 Qh8977EI3a+lQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78A553A54A16;
	Tue,  2 Dec 2025 14:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] main: Validate the AdvMon scan parameters correctly
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176468581527.3250289.688660564783840775.git-patchwork-notify@kernel.org>
Date: Tue, 02 Dec 2025 14:30:15 +0000
References: <20251127124244.410438-1-sebastian.david.forslund@gmail.com>
In-Reply-To: <20251127124244.410438-1-sebastian.david.forslund@gmail.com>
To: Sebastian Forslund <sebastian.david.forslund@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Nov 2025 13:42:44 +0100 you wrote:
> The strings used for validating the main.conf parameters are different
> from the ones used to fetch the values. Change the validation strings to
> match the code and comment in main.conf.
> ---
>  src/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - main: Validate the AdvMon scan parameters correctly
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e898a615cf52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


