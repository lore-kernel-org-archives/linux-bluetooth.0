Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99001433E99;
	Thu,  2 Jul 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008630; cv=none; b=gAxSEvF+Q7ZZ0if+6a5SgUL970cmS3KQrnVU7TajlsiO8fw2VWACRWRI8XDg7b94NS2iUCyI0PDWplTR1Q5BzXzPef94N+cr2slzSSSraHnKnSrXeY5xX8FZShCNXBQRV/hxYA31wr/P51YCqiBro6IxHdUQpzamlDfvV6ky57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008630; c=relaxed/simple;
	bh=5/GaBjU1CJkuV77h3qFG6TJXGJXTmJtS9tkt/u+N5xA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rw2qjNb4HJbxoIw3QQQFgjNOrHmKZ+wHo9kdKrPL3kmp2A/aclm/EoBs50nKyDxnlz8K1TgXNqaevaB+RxBlA6Tt84p5VLxgd9xQVSg3xRXLiXmjlrCZsPEiDXR+A7AAzAPk4cYx9zJ4ddn0u0ntkCIyjxXTMCtOupmREZXOV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmRA9ak8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmRA9ak8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8051C1F000E9;
	Thu,  2 Jul 2026 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783008629;
	bh=t2hIc5qW85kJwZDX8ic8kt/ubC/Nj1t6WqjgOQPpi+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bmRA9ak8kYKfSxnYa4nWaqcT0Z4P0k0YMGSFguiA/YuFvfAciknrx+T16EjoCadUX
	 piIWdO1L4/Y43uJBMVHpIdMWSyg7op77cmE6YJWgxAYNASx3b+y4ix75Uz9CxRpfyk
	 YapoT1/AxH+8HtmZpleszA78n3ezT5MwV6ikVG/ir2kIwWdCaMmNzNDCxr6UTRtjur
	 V8CAaiqsm+D65scgjG1pGznVTTTLlE82uvyAInFvIA+uvB95c0gFGcSFUUMMZOowuX
	 zTlSQ643IYMJU87GP4EYekT9asc7mX9AkTaOeEXY62JAo6L0r/0XiItsOc8QbKKPKj
	 V3GBD6D8YL2MQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BA53930934;
	Thu,  2 Jul 2026 16:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: ISO: fix malformed ISO_END/CONT handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178300861213.1757978.17509435332853877219.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 16:10:12 +0000
References: 
 <da68c9b8242e9fbf482b1512e9d612768f2cc7e8.1782920668.git.pav@iki.fi>
In-Reply-To: 
 <da68c9b8242e9fbf482b1512e9d612768f2cc7e8.1782920668.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, devnexen@gmail.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Jul 2026 18:46:38 +0300 you wrote:
> Core specification (Part C vol 4 sec 5.4.5) does not exclude empty
> ISO_CONT, ISO_END packets.  We currently reject them if they are last.
> 
> If controller sends malformed sequence
> 
>     ISO_START -> rx_len = 4, ISO_CONT skb->len 4, ISO_START
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: ISO: fix malformed ISO_END/CONT handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/103ac7b87e1f
  - [2/2] Bluetooth: ISO: exclude RFU bits from ISO_SDU_Length
    https://git.kernel.org/bluetooth/bluetooth-next/c/9496dfbab73f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


