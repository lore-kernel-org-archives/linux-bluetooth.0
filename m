Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A203537ED
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817810; cv=none; b=rOJJBoGZbqvgHQx6EgHHy2I22aewaEpG1e6L2fSBCZe+gcy/M7mnlHqJz2Oph6P04XtYR/o1pBDM71SpvuLy3jvZllustxfO66Jmsxm0y5RUDRFa/lsX/KVlZcKxtbFJbUFZ0NA2IR6oHsHKc0EJR+J4jG5ZTMN4TkotQtIHvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817810; c=relaxed/simple;
	bh=LLMUhvxB5XONTzozUZrbuaDg4pi4hSVH7NK68zH4phA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LmT0Tx7mx4C3xVlCDVEjsMKbVAKuTFazqrLA1QDOvdtVMRbkNK16D0yH6IlcIpAoxbw0j13r32Sz42STprH2vsL8Q11RIil3QmlXAtFrcrygjXcJc/iIyRo778CEl6DD86Fx7pmpPB+xJfVEZB+IW91wzlvQOcJARe8cM67UNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBNJuEi+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBNJuEi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309781F000E9;
	Tue, 26 May 2026 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779817809;
	bh=IvZ0RcNrW6khbxfa9mthxw9Rtcw4IxsDCBW4V7IkxFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SBNJuEi+sczsKqYuRcgo+ABF49utpyUTfwL6LCbZQCaxQ+rcOANjPS94wUOfwu1MA
	 xDlVxz0uUq800kHoxjGA1b+KSfps39balZe6+KxemQsFSI7oMIRv1wJnnkpK3EJJNG
	 bcfOw8jsTJ8gGeK8xp2f97aQ60nu9MvIfGtGB3+b6aN+xWbMEUYSbNLAZgzfcDTm+5
	 3EP3g0eeVVzix9WJ8aVkag5f6jA5Oh29+6WwC/1iFHRK4jY+2W6GjL+76BvFL5H+4F
	 wK/OCDEPHKq1jsk65uj69EZ0rVyhFeSxyM9Xel7cNX0xH6pJ8+PYuyleq6Pjps/p/G
	 DlOQycJXHXoKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569E1380CEE6;
	Tue, 26 May 2026 17:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: L2CAP: Fix possible crash on
 l2cap_ecred_conn_rsp
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177981781499.3917724.11139763871927688596.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 17:50:14 +0000
References: <20260526152650.3487624-1-luiz.dentz@gmail.com>
In-Reply-To: <20260526152650.3487624-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 May 2026 11:26:50 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If dcid is received for an already-assigned destination CID the spec
> requires that both channels to be discarded, but calling l2cap_chan_del
> may invalidate the tmp cursor created by list_for_each_entry_safe and
> in fact it is the wrong procedure as the chan->dcid may be assigned
> previously it really needs to be disconnected.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
    https://git.kernel.org/bluetooth/bluetooth-next/c/0a39e3eccf85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


