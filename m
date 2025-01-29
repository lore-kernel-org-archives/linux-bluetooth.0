Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6CB1E3DEC
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738182008; cv=none; b=tWUV0dE1KbbRXDBKTH2oT60dpLwX5esHkkwZaHT69eVhns6SsgHobiWbqoFsvUoFNacb4F+ca4eFhi7fiRCYlIRrkFqnytn55TBwbua0JwhBUdAOg9WysmDZ0jHg+0NK7ZA1lJYVag5c6joCfsjs4o4a56SA0s4W953Ev/MIv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738182008; c=relaxed/simple;
	bh=KSa1sgzUSbNX9DVb1El71gya0GvZ261cXWtrmxesjuY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BpKNm+BXtyd7qKJ8G01efn98gnch2EV0O/PRA0pdgglLyA04XQMmqhSxyB3g2pJLPVKd6tF5RZpcWqbxMYeOFH7mcpLDAT3IFsYMiyvbWNos8DVhvY/aa1jwfV5omGa+iBHr2HSb+rbMiNHb0jbMzuvlInLjeHV1HHlGGHVHhLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/oYxQ64; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/oYxQ64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC08C4CEE2;
	Wed, 29 Jan 2025 20:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738182008;
	bh=KSa1sgzUSbNX9DVb1El71gya0GvZ261cXWtrmxesjuY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P/oYxQ64Horkgnw7+dmy2D6bpw2VpepIezBseoAxBuLjsJB2nIqXocFHmRw9KLF8h
	 D3ghZKNfoE1vQyw9xRYLp1dzrUd57xha37OPGegC6i29qD3SmCSngvkcBCEDSD0nsX
	 9lqFHYUoJLE3YHfnXOzh0o/RcH/+kvqpbFc5P7mQ6KQgSpaJC8dKFPfPwL5s/Yzkzn
	 Mh38AcXQ6Dg2z5lgLwUMHYjcx0yhnYswekyGvIweMK4vcNXZyswA5V6OxcGZBbtrba
	 7k+A12E/oYF0nVAuhydPlY98NMya7ytpwmU+hxXFx7mrbUXeR7cc7VfyIplAl/Y77G
	 CQoSQpf/ydo2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC1C8380AA66;
	Wed, 29 Jan 2025 20:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Remove unnecessary braces around single line
 statement
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173818203451.417583.18171004331394468635.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jan 2025 20:20:34 +0000
References: <20250127221052.197899-2-deaner92@yahoo.com>
In-Reply-To: <20250127221052.197899-2-deaner92@yahoo.com>
To: Jeremy Dean <deaner92@yahoo.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, markus.elfring@web.de,
 patchwork-bot@kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Jan 2025 23:10:37 +0100 you wrote:
> From: Jeremy Clifton <deaner92@yahoo.com>
> 
> Warning found with checkpatch.pl script. Remove unnecessary braces.
> 
> Signed-off-by: Jeremy Clifton <deaner92@yahoo.com>
> ---
>  drivers/bluetooth/bfusb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - Bluetooth: Remove unnecessary braces around single line statement
    https://git.kernel.org/bluetooth/bluetooth-next/c/a2a245849af8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


