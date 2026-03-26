Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293523537C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558218; cv=none; b=TXdYIfusKPrlVmJzJAXVvFFcorSwyXq0ZYHbDxrWtopaEsOupBRB2lBZrS2qFZXUZ0HDm0K+PEDPo2z5HWfEzvJyCf69ZV0qa7tdqaXhtHoZkiRWqiO5UZ3bkETUj7SGQ44/kHef3vlxBi3ypk2seGoGXj3Qfuzf+XorZbVtJPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558218; c=relaxed/simple;
	bh=4Iv7EhRrG9tACA1QBkbS1Ay3TSJEngozIeBeKFXlcM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nunF4qTLyle0V1LFBJUsjj+SYSIFDVv4jKu7LpPOKjF4xpoQbTBifjOwlIuUXAAvzSiX09jsFJrZWCtSTmbDpQIp/mtsapyiGwHzk6JifFpDaYKJfZGGuPJ5p4UwI9UVe1qIXAKGBTaa8KIx9sK6qvDYMNPSR5AVST4Nr2oNAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HclCQ+9Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HclCQ+9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B624C116C6;
	Thu, 26 Mar 2026 20:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774558218;
	bh=4Iv7EhRrG9tACA1QBkbS1Ay3TSJEngozIeBeKFXlcM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HclCQ+9YzhxycTGHZo8XTEX6JpEYccCiRbGF6SdWNFe7vJqyqA2aVq+ic3TQeCQWE
	 AIIbrqe2DM9HW3fqWwtxmx7tH0StYnBfuE45SlCiEA7ncrY+XnlI8obUs0K4t6HMst
	 TQjgKQnNcUtB+nwjxywoiY3RNySgWjO9/JiBLuDm/A7HEef2TWWT4PTy8ZRHdDiy1y
	 pNoMsoylsveuj1iXjFe81CNXJhpQeBdhfphbyw/diUe3rVMFrUFuQg1wEeGt3e/RxL
	 SqCO6YZ201e40WC3U7fX7JTJsAd3ro7xmohQTHgQM3t8eEQ9iNgJ+SWjYRHXOkizvM
	 fq2DoXMWajlOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F8439F280C;
	Thu, 26 Mar 2026 20:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/4] Bluetooth: hci_sync: hci_cmd_sync_queue_once()
 return
 -EEXIST if exists
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177455820454.3172002.3692697474035321902.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 20:50:04 +0000
References: 
 <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774465559.git.pav@iki.fi>
In-Reply-To: 
 <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774465559.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 25 Mar 2026 21:07:43 +0200 you wrote:
> hci_cmd_sync_queue_once() needs to indicate whether a queue item was
> added, so caller can know if callbacks are called, so it can avoid
> leaking resources.
> 
> Change the function to return -EEXIST if queue item already exists.
> 
> Modify all callsites to handle that.
> 
> [...]

Here is the summary with links:
  - [v2,1/4] Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
    https://git.kernel.org/bluetooth/bluetooth-next/c/dd97a8c7b305
  - [v2,2/4] Bluetooth: hci_sync: fix leaks when hci_cmd_sync_queue_once fails
    https://git.kernel.org/bluetooth/bluetooth-next/c/0098a022e07b
  - [v2,3/4] Bluetooth: hci_sync: make hci_cmd_sync_run_once return -EEXIST if exists
    https://git.kernel.org/bluetooth/bluetooth-next/c/c246bfe2efb6
  - [v2,4/4] Bluetooth: hci_sync: call destroy in hci_cmd_sync_run if immediate
    https://git.kernel.org/bluetooth/bluetooth-next/c/fdb07d4116bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


