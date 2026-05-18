Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0339A040;
	Mon, 18 May 2026 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140993; cv=none; b=WqhAeR/8HG4Fpk9J/Fq3IPX8uDDe6Uf/gNOr7aQVmAOxGJXw7x/lutRxjpWzOspckCqLSsfNqVw3O4H1j5hQBYz/X0MH/nWbTMQnDR4+cxR9B3Jv5xYW7xy1TP41BRaGOinpoBIcuWJvNGyGn0EQklhtqyiWDWB0KlAcSLySlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140993; c=relaxed/simple;
	bh=BCGSqu4+tudCgoGPI93aYjf9oZVk8EXFJax6d4C+gqU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VeShf4hsD9R+qds9DFHoP6Xlzyq70VNmLiE7+qyaePlHZoyt86WoBqlRPEqdrUNvIkOjXqweWnbmligKABxsUNyipXnY7n+9EnVVqmQtva3bviZtiEYpRub2yR4aB2EqHATa+gSuBMeySuVGWwq0LJkL0ey78/5qVcely0lQZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVKkLixe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVKkLixe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72344C2BCB7;
	Mon, 18 May 2026 21:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779140993;
	bh=BCGSqu4+tudCgoGPI93aYjf9oZVk8EXFJax6d4C+gqU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jVKkLixeYzQCESMmdpBM9gDq8wylpSSYAhoz/4BwiMZAb+st0HmL67KfdXstWd8CD
	 2yxdvNaCnWIYCq1s5KKlt6IQQWo7HgQGjGiImraJJsCh4TAUlFLsIOeo0ijNv3+jX8
	 JXbydklE6vPhGyZqGnjXnOs6RSgqxv4XAwlWimH2MxbU+LeycUTGdzyYKgciYkHPjB
	 o2QJk940DzsKMmJWidNYaZ3hET/LUpq7wk1LQhpDtMTPNB1OHwXe3GDNmVypt8E+Wl
	 LrIAYUaAA56cHch+H8gYT2S9bUCsv/O4XSfIlc3hSKcQDvqXGBUIzf8w4mch4UGXJV
	 P11EUBVuvYcrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AF23930CB1;
	Mon, 18 May 2026 21:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtk: fix urb->setup_packet leak in error
 paths
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177914100464.1984363.3049951945476473554.git-patchwork-notify@kernel.org>
Date: Mon, 18 May 2026 21:50:04 +0000
References: <20260518022402.20398-1-liujiajia@kylinos.cn>
In-Reply-To: <20260518022402.20398-1-liujiajia@kylinos.cn>
To: Jiajia Liu <liujiajia@kylinos.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, sean.wang@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 18 May 2026 10:24:02 +0800 you wrote:
> The setup_packet of control urb is not freed if usb_submit_urb fails or
> the submitted urb is killed. Add free in these two paths.
> 
> Fixes: a1c49c434e150 ("Bluetooth: btusb: Add protocol support for MediaTek MT7668U USB devices")
> Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> ---
>  drivers/bluetooth/btmtk.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - Bluetooth: btmtk: fix urb->setup_packet leak in error paths
    https://git.kernel.org/bluetooth/bluetooth-next/c/5daf96ab8398

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


