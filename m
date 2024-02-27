Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58495148304
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044231; cv=none; b=eU0hrD8SaH1uW1gNNtXIri/OcpSEESvcZCABnbuFBx3kmosGN2mOv/+8La0ReU1jx3Gmyzs/hJTlPZhxHnH48K48NrFiqc72E8250p0QXWRfPaE8BDgSn1nSGgQ+84IQSS56VvCR9Cf8OlyKkTpKpoEggE4nV47e9Ip9isVOyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044231; c=relaxed/simple;
	bh=utdwJ+YhFr6UIKi57I1CcERobsPQtomK1kwraHVwrcU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dKQGuDvtxNHaUTPrQ3iMO+qh0pCnjqD2+waNSvxBJ2c7aqLDMFkZfhhNlxUFhF0jzoIPd9jwcwA8dCrgRv9G/d8Nlh9OizF+R8Y3KAZ3PoJrCzjlkCmBeSms7SGirv8InLUq0dC6xDqyPydPyqVNUGx63Uma3AvAOvPcxqoGHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c19VXi36; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c19VXi36"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D897C43394;
	Tue, 27 Feb 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709044231;
	bh=utdwJ+YhFr6UIKi57I1CcERobsPQtomK1kwraHVwrcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c19VXi36ODXmVq0YC6BGBzd2Kb4ALZldt8OHqlgGgdfOsoLFcZwxfHw8tThA1QShk
	 s8JVRQYowTka+IY96HBZAA3cG2AJ4cKi+SC3Ey4Dx+ooFyNwUMdKetQJAYkElGNKQc
	 tcQvYhE1LRbQSdwrcYP/J1+TABB5QqWBy5oFycizoQLiTMa7/MlnWNknHsUUSsdzg3
	 wEb/zrls1ENTPINZR0FAeZutGWA6rJVXqUgpj0NDB4NI0csKZRDeNROY4uP/54Y0vw
	 gV1vweKnpHSD0wK2LBrHz9Ga8sp+NHcoBBocpO+XFNmPrxIYudyGyOsSuLDz8IRBNY
	 +WUc5pNTledkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A966D88FB6;
	Tue, 27 Feb 2024 14:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 0/5] Add support for multiple BISes on the bcast
 source
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170904423110.32001.11874673824840523535.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 14:30:31 +0000
References: <20240223164813.66484-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240223164813.66484-1-silviu.barbulescu@nxp.com>
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
 iulia.tanasescu@nxp.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Feb 2024 18:48:08 +0200 you wrote:
> This patch adds support for multiple BISes in broadcast sources.
> 
> Example commands:
> Create a local endpoint and an endpoint for BIS1:
> endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
> [/local/endpoint/ep0] Auto Accept (yes/no): y
> [/local/endpoint/ep0] Max Transports (auto/value): a
> [/local/endpoint/ep0] Locations: 0x03
> [/local/endpoint/ep0] Supported Context (value): 0
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/5] shared/bap: Fix endpoint dir for the bcast source
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8552e06b6617
  - [BlueZ,v4,2/5] shared/bap: Add state in stream struct for bcast source
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b4f9a9fd7ed2
  - [BlueZ,v4,3/5] shared/bap: Add support to create a stream for bcast src
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6ea7f481094c
  - [BlueZ,v4,4/5] bap: Add a callback to create a new stream
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dd57562760e4
  - [BlueZ,v4,5/5] bap: Set generated BASE on all setups from the same BIG
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=92f3ed187904

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


