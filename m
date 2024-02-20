Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4D134CEC
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456229; cv=none; b=G6iTt92cX2sMIUI5KdnDW9khpDR2rYAXidwLAniesXAHzlNngHOCHXgstrj+NMFdPrxOJra0DtgEPj2Dz62YYhIjurGdd/Q1nXrECyMmpSrFQXDnKtbrtwk+BdYrGY1pfp/qxH4WaUuf0Npin7TVsmSJxw65XISUiPSR0SAiA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456229; c=relaxed/simple;
	bh=p4+bl7DCl6RioYKfHOs8F7tSIkUc4dPBcVxLO7XhFj8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dYl2WdtEXVLUzV3m5HHvENK/UONlVMawQJ2fGxQBM7Gsh4VMAQZQLWQ+85LwpmSs3uaoPXB1b/mkD8tjQJoZQSabvD0S/+jxVYZ+SSZv3UaAK7Ga6jSgfqOQRzwIqXBenDvKtdTQKOFtUTgrGMNeJMH5QcgPP+UxJ5imTwnFgAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhl0Mkqh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhl0Mkqh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 732A2C43399;
	Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456229;
	bh=p4+bl7DCl6RioYKfHOs8F7tSIkUc4dPBcVxLO7XhFj8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fhl0MkqhP0YzmDxMAGH6Fdx/3m9NklZ8EWGVJkDvM7t1v10Uk6lTZYmWEh5QDH2ya
	 OWlmB5HIBJMyPlJeeA6S1KdFKNarRAmGzSGhQmmTF1tDHc/zR1GDNTTCTgOoDtsxxX
	 hxhdXoVfq0EdeYSZQf0TspqHZL3q9lsN+THFmOJy3kvhuqYjHHPMU6ARPWHP62pEub
	 oCDYLrZaHk2TgljeLrK1tAL3PU/0FZ0jLpNqZ2qG5/vcRMbVFYHhIePpQCJk9j0PLK
	 JlEUYn+o3wCKT7RphUp7asrowqNWsMKAm2jmM28Ey6kZKdiE4fO/YzxXA111D80Obk
	 t4HMmEDz0hVjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5090FD84BC4;
	Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix overwriting request callback
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170845622932.2554.1081133820469371235.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 19:10:29 +0000
References: <20240220163141.354936-1-luiz.dentz@gmail.com>
In-Reply-To: <20240220163141.354936-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 20 Feb 2024 11:31:41 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> In a few cases the stack may generate commands as responses to events
> which would happen to overwrite the sent_cmd, so this attempts to store
> the request in req_skb so even if sent_cmd is replaced with a new
> command the pending request will remain in stored in req_skb.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_sync: Fix overwriting request callback
    https://git.kernel.org/bluetooth/bluetooth-next/c/df90bef42e65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


