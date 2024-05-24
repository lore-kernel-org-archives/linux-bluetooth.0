Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486EA3BBE8;
	Fri, 24 May 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580830; cv=none; b=QXvZalSIi3cHXU4qfv0/WVr2OCxSzRT7wuI/rKU+5I6enjr7p1JQm9sR4ozIX5MjZGOW6F1xpPrV970UFy61GHWLyDieSRL3mCc8OfKLlYZtehc40GOxcO59eCdhDr2jJdiTk1ihYHL5a0RY1ccOVflqTA1nJ4CzlOWXvzjLKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580830; c=relaxed/simple;
	bh=r06Ah7YDJnhIxNnpacx35mRIM+8qmbpW+3+eLX93wrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uFyYxottRH+/WnY64N1hlFohn1pU+tzIus54sLgyw7X2xol5YaIWb/5fe6ZL7TEw3YuSb/yYkBrxfozm4N1BLy9O1kS6U1ACRUuoX3+/MVxyN0ZNYsFdVNuvqKuPcautRS5yE3mkhqaYCUJOQywbLGedzjCTJnlU+OLOLUQuwgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG4kaUxd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG4kaUxd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D663CC32789;
	Fri, 24 May 2024 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716580829;
	bh=r06Ah7YDJnhIxNnpacx35mRIM+8qmbpW+3+eLX93wrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oG4kaUxdcn5VN8Q3Sou5qko+NGCqAIFdfEMHjzZRJ5QjsRYGR3py6hoNzjw3EkuZ9
	 R28wInlC7WsL0KU84fS9Q2h5PixVmVjbJ70AVdB5mEjVhNFmf7FNLu+wAEswyOaQ0w
	 8DMJvGqgWkUqZyIdti3aXJrlT2EUPfleM2jir6zogY+d77vkbBO5k/FYCcnsR8q56z
	 634IvM5EybhT2DCoMmbYQXvAx3Mxy3WBAHuxaZTiTvfNLqQtLFHlVzxCBPc+i0O2gT
	 Mi5BnCAEMHJ2w5R0SAWr0USuUkJCa4t2VSD1jqXWhrZ8uam5rELPpM/zteVljfzaWS
	 1gtCk0lgiFYMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0438CF21F1;
	Fri, 24 May 2024 20:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Use sizeof(*pointer) instead of sizeof(type)
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171658082978.8511.5942378609117134177.git-patchwork-notify@kernel.org>
Date: Fri, 24 May 2024 20:00:29 +0000
References: <AS8PR02MB72373F23330301EA5B897D6E8BF52@AS8PR02MB7237.eurprd02.prod.outlook.com>
In-Reply-To: <AS8PR02MB72373F23330301EA5B897D6E8BF52@AS8PR02MB7237.eurprd02.prod.outlook.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, keescook@chromium.org,
 gustavoars@kernel.org, justinstitt@google.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 May 2024 19:11:51 +0200 you wrote:
> It is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not
> change the former (unlike the latter). This patch has no effect
> on runtime behavior.
> 
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: Use sizeof(*pointer) instead of sizeof(type)
    https://git.kernel.org/bluetooth/bluetooth-next/c/3c376f35eb13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


