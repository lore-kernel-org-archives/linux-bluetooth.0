Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28323199234
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725832; cv=none; b=DtsPq/YxKZDNUIN1hHbG5a0vxz3bAwD/q3bg4QXQGHvJiYZi5oJDbddWVkWgZ0wWTUtQ7YoaiaYXE3xgQMLS5F23wLSE4KtO8ju9GKPzDh0Tt0rg0xc/Sex4OLIJZuYF5yGNStcOAES+qvpVtBmkmgnKTlnJX3jN95A/giYgjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725832; c=relaxed/simple;
	bh=4OQOq9ZFoQq5nTqIv20nEtJh6kTe/v7zVeTltPsosrM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RXVKF9O3/zpSDW3l9EYkF15/Ew/zaTpfH1Dq/bwVxTspxQu5iJFUXgxprLoJwU4pEEtZGqHJqjtBPXaJ4Nle7caQRcc0T5i6FiRyCSSCQauozLeRoUD5DSSH6pqla6o1+ySDqKUGVcU8N9+XKIt1b359xPXWvPOJueffjXhl7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+5IrOr3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+5IrOr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8B0C4CECD;
	Mon, 30 Sep 2024 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727725830;
	bh=4OQOq9ZFoQq5nTqIv20nEtJh6kTe/v7zVeTltPsosrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S+5IrOr3WjdeC6Bmb06H1jD0ouFGGXNit/7AU0Kx6b87O6kE0J3T79l47Yr6D+PyQ
	 kQK/+rN87cQFKyyOKVZIAGQWMm7oMW+WqlYACYayFyI6v1ZRoAQjGGqR/RBgkJpqD0
	 ppD9RxzCEjJ5iNyhMpJH76hMbvwOFLOemooZLiBkBIaimEqQsyf9KxKjFLffRxNke2
	 VxLg64u30Dzz8K6WKOOMIEHAzw/C6w0i4nioaX9x3BOUlYcg17ISq1h4ifR23ApB2T
	 3yFyA+zRj/manHcjcRzMiD8vBK2A1ntoyYIokiTPLcudEMtPLlssBKHqFEKasfqrDs
	 ZQECet7K1f7Iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD973804CB9;
	Mon, 30 Sep 2024 19:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] client: Update endpoint and trasport doc
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172772583374.3906813.12881901241062641390.git-patchwork-notify@kernel.org>
Date: Mon, 30 Sep 2024 19:50:33 +0000
References: <20240930145830.864663-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240930145830.864663-1-vlad.pruteanu@nxp.com>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 30 Sep 2024 17:58:30 +0300 you wrote:
> From: nxf92481 <vlad.pruteanu@nxp.com>
> 
> This updates the documentation for the use of endpoints and
> transports according to the latest changes in their design.
> ---
>  client/bluetoothctl-endpoint.rst  | 33 +++++++++++++++++++++++++++--
>  client/bluetoothctl-transport.rst | 35 +++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [1/1] client: Update endpoint and trasport doc
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f7028d6a0569

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


