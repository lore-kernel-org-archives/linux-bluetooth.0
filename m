Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D3E1E1A3B
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876394; cv=none; b=XbFybnCEI3WnjAEKm8JMuQItOa8YC0rx9/DVlGS5wRt9+7wr7jC0GBzdCbTfSGwqPaKJcwXf/VWAWRd3ynVUKiih9XMwtRSxaa/qfnqxeItcrwKuffbFT8ph48cP+4u1zvCFI5NiMiomTW6OfYyPvl9Xtw+wGdB4xdGz1KhlNW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876394; c=relaxed/simple;
	bh=Jsd742EkeTnhqQnY1PliNUt2Acz+B9G3vqxNh0zthkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RPsCyqaPbNKn8sFfeaJHSWAbxqCh5UmJbk6ulI25nmD+JlOiJ62BuOS5NABaA8mnxLW4bHJqFH2Ip5eWlVf5KzK8fG5u+IUQkc4OqOi5kketzyqznfxNpqFF1o+8sNwQv5nWJ971ZaF3gIsTMA8b/Ww7yPbddYnSITpipKBMzp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVKT0nlX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVKT0nlX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E620C4CEE4;
	Mon, 28 Apr 2025 21:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745876392;
	bh=Jsd742EkeTnhqQnY1PliNUt2Acz+B9G3vqxNh0zthkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nVKT0nlXd8b3EpikiaoOJrqiSOmyyasetza2PFRJKb8iCgYMAMCvZnIJBR+PvxrU5
	 4j6mgwpGe1aPj3FJTgaNH7UFHmGCEMqBrW4KM2WJk9xVEDRN5A8f5YVJh+apIAercf
	 bjb5b3rmQNsBRAmTRP6Jxco48dId1ksjB8GlQgyL6hG1ohpivRPnrQmcFnK2E6Rnqa
	 ayXiUNfwXL2XpJ0RGvmoJi2dFDqhvaKo957d/3pPfVmzLm0r8t8pM96u2FFpv1BvSG
	 rdFSqvtGq1rbUI24A8QJZo4TzUXeMwTYNcUSvTC2QsmkqhZwCym/esTUm1iTU3WInk
	 RX9YGUaZopE+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBA63822D43;
	Mon, 28 Apr 2025 21:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] hciemu: fix accessing wrong/uninitialized variables
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174587643123.1053120.16545118299126028836.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 21:40:31 +0000
References: <1ac4f119e79c10da2da2d41f9458daaf170d466f.1745860619.git.pav@iki.fi>
In-Reply-To: <1ac4f119e79c10da2da2d41f9458daaf170d466f.1745860619.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Apr 2025 20:18:53 +0300 you wrote:
> Fixes: aeeb4fd64adf ("hciemu: set bthost ACL MTU to match btdev")
> Fixes: a112d4345771 ("bthost: implement fragmenting to ACL MTU")
> ---
>  emulator/btdev.c  | 2 +-
>  emulator/bthost.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ] hciemu: fix accessing wrong/uninitialized variables
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2cfc3521cdfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


