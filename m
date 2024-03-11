Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C382454FB7
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185964; cv=none; b=k2pmqulKBeSmGkR2hJzelwRIL5aeKFJ+YnRPeb9LPeBK1VDx4B0sVsQDgGMnloCikZlVPvbE50FYGCmXWACEOwUzvU459qeLTj9rYNqXaJ3Llf4QM1g6/n+cZRjnfdOwqHt3DvsoVxQyrJ9uazoiRDmhNf440CjGOjy93CXUOZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185964; c=relaxed/simple;
	bh=8zurnbsBrKeYuLw03aT4mEoKW4tDjZ0HZCC093FPcGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A0u1n3E3za4RHemVrI7Bp1BXod67CmQsngVb3H51s8Penqenf6VDuk5dTiaG5tuYtCjlrzhR5FJXsPuQgiVgS/SBhoJTIyRoLxJu/BANbg+Ku+1qpDYIe8zSOg7n+WryeOFDBdTRqzhldmccFWG0CnKWGoiXzDAHrLuyrDp8UEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcEytSWh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcEytSWh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1754C433F1;
	Mon, 11 Mar 2024 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710185964;
	bh=8zurnbsBrKeYuLw03aT4mEoKW4tDjZ0HZCC093FPcGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pcEytSWhTjp8/D325gjYo8MzChrrIybavYg9qNsettVivqT9YYXWw23NG8G4BkH9l
	 2Bc18LvXIX6pd8jLBEPoyhP/tSFRCjhsXeZDBM4kVe2DrJnV9cXhhLSkMpAgDprUg0
	 52JRwBBOB6Bht+p+5INBbxW+MzPktAfJpQkCx4Q1CyxvmIfWlNmBxFdIHcw+ggvvJB
	 NIxpSHkFEcp00wItS1MHyiBaE+nWEGoGNfKK5wB+IGlIPbB0eTsOREMDMMqN2Gl8K2
	 qcistl617gF5G455jOLIOGFdrh5bI/72KtrNz95EFu9MwGcyimMkKNQDrdbXjZV6iJ
	 053nsYKwus81Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F5FEC39563;
	Mon, 11 Mar 2024 19:39:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: fix setting io on linked stream
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171018596458.1144.2556648186900706094.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 19:39:24 +0000
References: <09755693e7900757286d3dc9fd181f8591c21a19.1710099560.git.pav@iki.fi>
In-Reply-To: <09755693e7900757286d3dc9fd181f8591c21a19.1710099560.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 10 Mar 2024 21:40:33 +0200 you wrote:
> Fix the second bap_stream_set_io call to set the io on the linked
> transport, as it's clearly meant to.
> 
> Fixes sending duplicate stream stop/start requests.
> 
> bluetoothd[588207]: < ACL Data TX: Handle 2048 flags 0x00 dlen 11   #492 [hci1]
>       ATT: Write Command (0x52) len 6
>         Handle: 0x0098 Type: ASE Control Point (0x2bc6)
>           Data: 04020505
>             Opcode: Receiver Start Ready (0x04)
>             Number of ASE(s): 2
>             ASE: #0
>             ASE ID: 0x05
>             ASE: #1
>             ASE ID: 0x05
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/bap: fix setting io on linked stream
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c9dddb642663

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


