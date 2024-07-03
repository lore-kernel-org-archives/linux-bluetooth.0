Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2517DE26
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019433; cv=none; b=M4PJl8pUOZ2p1zvu19OCnf9UDOrrGwdE5/soX5hT2KNaKMuV76TdUNUMHHpmziqyJdu2sMR4lPEnueEtT84tI6buktNPsSu9e6d2JFhM34vjmHogZVYApyOBZM88QsOiRLwDKfObWDjSPJuGv4+oQ1Pc4VY4NqpCytryXSfsMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019433; c=relaxed/simple;
	bh=HmU+p5Z7w+WsOGrmdQ67loqh3Megv6e/oilRvgilQj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r4KP+mUuIwJfdcCr0llofVl3e7Gn3Bzx8Gg2EWyM2F/4VU2tCbNBQfGePSmc01qFvbL3MUYe2jpI6T4/aPmOkBI6eKLn61vIFeyiiz8+bPdXGv/QsEiMqvSGftwyEx/lQJmIkdIkvDa/VlvaqW+YVfXjHb40tD+kmy+z/6nywvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aajEq0FB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aajEq0FB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 443EDC4AF0E;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019433;
	bh=HmU+p5Z7w+WsOGrmdQ67loqh3Megv6e/oilRvgilQj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aajEq0FBRU0quY6R4eKEZ4pSvXVKD8+FXFSL6BLlUeRGgXameY6uNpxPfNR/xsAnR
	 suH829nhShIPN+iVRqJ1cmTNT8VTI7ORzDTADkWyay1Xg8fCsA+3DN/ypTg7+Ev+KO
	 kTGlvKHUL6qJWVheqAX1cxwvDMf+MifMWmsEppME7Om6MFRCmHNIvhzj8Scf/ur5Wy
	 6KnFGB7x75tKQHuks7Z+7MJjcMFHXZ8Y/zWxEo/2Yhjseh17Z4U1c0oBeYuIq7bEKw
	 CpDCUFe12eu+w6xmBuF4CGGrSQx6zweszuvUJnnFqzwdx9fbNHzYfyl/yY9X55mn35
	 sGuPEiiaROhcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3544BC433A2;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/shell: add return value check of io_get_fd()
 to input_read()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172001943321.18626.456056721786285037.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 15:10:33 +0000
References: <20240702140313.107131-1-r.smirnov@omp.ru>
In-Reply-To: <20240702140313.107131-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 2 Jul 2024 17:03:13 +0300 you wrote:
> It is necessary to add a return value check.
> 
> Found with the SVACE static analysis tool.
> ---
>  src/shared/shell.c | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] shared/shell: add return value check of io_get_fd() to input_read()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ee46e92bdef4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


