Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E953081B1
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371226; cv=none; b=oOrv2qArLnifzjto+ehm4zsQB8kLyjTbFrU2UP5hoM7jxXYgxj5lbCYemdSkRtJSK2roeUZ/zTu1hhKxUoT5MTSYatexjHBhyOMDxWAwJl+UZICWSEeVQily/8trk6En2AuyzZjtYSSTMqBuUuXJlnEObt3UpQsZxw1+8nlDPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371226; c=relaxed/simple;
	bh=F5lS0L1Qm7STAQciKudbS0psN6X9GfDY4fMGloEqIU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SBA7ClEiaOITq9ByI4csYfTJaHsgpI2HYN5keI5U/NJ/XZIf7Hjss0SgX3MqqErPozfNHVZtejanaS9hfLuYhaMFoqE5NjZFUshRg4n3cQqmxmzl8lXKkl6yBcTIfnQfTpd8w2pdF+lfKomNz7FVY2i6XagIncfKCdQVFGd2gVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uldiT3ql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uldiT3ql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D502FC4CEE7;
	Mon, 13 Oct 2025 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760371225;
	bh=F5lS0L1Qm7STAQciKudbS0psN6X9GfDY4fMGloEqIU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uldiT3qlV1u1XEWqQ7OdV45zhrLFffrHqTuyoEU0ideGBa7lKr36Ucpu4WIzLZqGl
	 ycLFVPgjoRqa5F7vRf/yimiE1sA5iOE32ZF00AR+QjYQsK4Sgv938Oit65Ww6nbG5W
	 AmhWv/t/GmV5Ap2Xl8YiGC41R3rujX7dNM2dywoc036HBtGtEAELhPCdAkvXNy5aiE
	 rxWzoAecV8Uh4qEDle4NDMtw6Fem3/ftDpk/KrbHveDteWDVFYuAw3J0UqnqKlmCNS
	 6YhANf4YUCP0muPPCcGH145pQbIg3DSSG+l9zM0//Jgh1VM3tbhjq26Tgg6JOpQanh
	 3HB6N3ZMcemkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3D2380A953;
	Mon, 13 Oct 2025 16:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: check pac cc and metadata length before
 use
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176037121149.3108925.10391572919173376224.git-patchwork-notify@kernel.org>
Date: Mon, 13 Oct 2025 16:00:11 +0000
References: 
 <6fc999ce7a1a375d52171f7934dbfff0335baba7.1760208260.git.pav@iki.fi>
In-Reply-To: 
 <6fc999ce7a1a375d52171f7934dbfff0335baba7.1760208260.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 11 Oct 2025 21:45:45 +0300 you wrote:
> Don't read past buffer end if device provided bogus values for PAC
> caps/metadata lengths.
> 
> Use iov pull properly, and also check metadata LTV validity.
> ---
>  src/shared/bap.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [BlueZ] shared/bap: check pac cc and metadata length before use
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=49d69b77fd4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


