Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9119E7E0
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504039; cv=none; b=CWJvECpQoD6HNw65ZoZduh17f6TS76u0ObGNAhQcqrwOURa36AIWo+sWti+C0N1HIiKRvEzplhOgcc9a5KykTc1k85VfQ2w/kp6iJE19Pu9P2Y5mZO6qalKUchp1DxcaBhkC9krwBAvCCNEbjMCjpFTJ/DG8J5XbreqK/9Gcfno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504039; c=relaxed/simple;
	bh=t/yr8+nwjfyue9uykz7AdN65V/1t8LUQJLWnppXSIx4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KncksO+dj7jl1rHssOHDg4Rt6VP1PoR9xznNFzR3WNHjNNAD6OS9lheQGRF2MxBJSHavyV9lSYoo04M4V/OGAZCxWXxzAHDg5eVHHwHQgVC0pIO57SguHB7ngiKztp7Bbu4l0S8amku/oZqGUoEdOSeqp/Ko6oEvZnlwedO1CnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx+Hocxc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx+Hocxc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3633C4AF09;
	Thu,  1 Aug 2024 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722504038;
	bh=t/yr8+nwjfyue9uykz7AdN65V/1t8LUQJLWnppXSIx4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rx+Hocxcp8oM3UvOUWWCfWWs6knLx3pPGeOtxRU7v4R40lRZqJj2pfEgSoXxTOpwA
	 b8Ze0aoymwJ/UhpOgnaLLNK/J50lUQKNh9UiACQ3F2x5DOu+qcefKP3o6v+8VTnyGg
	 YcKeyEdnkQv6CMbFY+K7xbts0WQ7frcJdJDE5r9LMsw99BGP4GmNjtcDxA7pFShr+y
	 WPE172hwgmQPqD6UfEDMdb6LL+9N+XPqG+pTEXoq9cixphk2kbWECptHDavFJ85b21
	 IeCp9c700F0fRDh/R1fZFCuoi6piG4016rXk/PhiEUJtdxrhX34De14/XteB75FrOH
	 X9qKcHNPq6gvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA9B2C43445;
	Thu,  1 Aug 2024 09:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/gatt: Set handle before calling print functions
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172250403889.1152.4360610369088404319.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 09:20:38 +0000
References: <20240731102321.700398-1-alexander.ganslandt@axis.com>
In-Reply-To: <20240731102321.700398-1-alexander.ganslandt@axis.com>
To: Alexander Ganslandt <alexander.ganslandt@axis.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 31 Jul 2024 12:23:21 +0200 you wrote:
> The print functions (print_service, print_chrc and print_desc) all print
> the handle, but the handle is never set in the struct object. This
> results in the handle always printing as 0x0000. Set the handle before
> calling the print function.
> ---
>  client/gatt.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Here is the summary with links:
  - [BlueZ] client/gatt: Set handle before calling print functions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=720e8ec9760b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


