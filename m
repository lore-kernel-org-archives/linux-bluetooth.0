Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017AA43AC0
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470631; cv=none; b=TJn9okeaqjS6V81wLfDvk0KpFkk7Bd6JYRmL5ZPCwIN2PCRxjGRnslV494uMTXCo/pS/YY3KOigq9ovw8rMc96CrwG2xudDUkH74DhXGrn2OVw2P0y9LMdnz/CFc1u8xB1bQa6WG8yI4tlwAkXeJwTK5rGimrAJ6RsNOiG/vE2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470631; c=relaxed/simple;
	bh=NzOAiGZkf+igw0T4Tc1pJVL0uz/Qn6TGvG8OPATDE2A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o7EnzLLdnAhLfwos/e7O0Oe/1txjHSgucALwYyGSCASI9aoYXi3oIsO1sn0tA0EihNvW1+97hsb4CZXOkpDKHWCLj+VTiv9rtok1RVM5+2K+oNqU9arBzFlCUFpgRg8TZFdMW+tCuEdyebTtw9OkX5Z9rIDomyoLLjTDmdV5lv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxtFp6F+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxtFp6F+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F82AC4AF10;
	Mon,  8 Jul 2024 20:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720470630;
	bh=NzOAiGZkf+igw0T4Tc1pJVL0uz/Qn6TGvG8OPATDE2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UxtFp6F+KGuJzMtGFXA85OUuWmUGXNzkqL4tg4bSoVwzd1Zeeaw8JKdvg//BJMyOf
	 7dumy70MiMAbpxiVnQflGyAghwf8URLCPJEIIFRLEvDAAvFkhV8/Jjr7nFYpBqrATQ
	 O/rxl95x/nR/2gfIBRJZ6hdAjeliBHLr0/JvsEA+vRu5sMrRrQdLSREby6C92VD7Co
	 KxU/9x3vNAg2HMPh2x7eTs1gPPt1C5QD/lsL3lILvK0vpL4uFhFl55F11QWV8Lfooi
	 y3e/XQe3eficoSqJtqe3PFozuGyF+hbecq7TWWdx+3v9Df02yXZCMO2u5evM1Sm040
	 fcLhVFJF3rDng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FDC0DF3715;
	Mon,  8 Jul 2024 20:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] configure.ac: Fix --disable-cups
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172047063052.14874.4423923130238229879.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 20:30:30 +0000
References: <20240705114235.553566-1-gudni.m.g@gmail.com>
In-Reply-To: <20240705114235.553566-1-gudni.m.g@gmail.com>
To: =?utf-8?b?R3XDsG5pIE3DoXIgR2lsYmVydCA8Z3VkbmkubS5nQGdtYWlsLmNvbT4=?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Jul 2024 11:42:35 +0000 you wrote:
> or else we get:
>   configure: error: conditional "CUPS_SERVERBIN" was never defined.
>   Usually this means the macro was only invoked conditionally.
> 
> Fixes: https://github.com/bluez/bluez/issues/773
> 
> Credits go to Lars Wendler
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] configure.ac: Fix --disable-cups
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=337cca13037f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


