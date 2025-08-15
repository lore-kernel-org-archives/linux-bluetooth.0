Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486E14A0BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755264597; cv=none; b=m7fXwIiETt5xv5bL20/wwJ923qo9R3/PKuBGHIoPoxQ3apW6qQFYYzJs4NjQPd4l7Sc+k9CB8kvUpmUdoMMqWdQnQ/Vbn2euppjTGc0UBk1m25vX5BoPTT3Dv8Z3Yc87avlEaQD2B/EelxPGRHrW2UMH/RT8Zy9K9tEn0uD5PAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755264597; c=relaxed/simple;
	bh=StTuglqafWvmM7AjdtBAJujzJOlTTBfJwEkw6bVrV+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uk1vaXWMzcrBq4V4QCiQ9Pj1N9uNddWdvRAL46sk/1SoDuwKupPjitqYUleNNQV1rcEmxpPJ7c3kuywWoJnr7J8Pizebk1ZweOjjcDIWuDrC46AKMZHyRow3yIL5tcCl7sqLJWnqGoVN4lLMfurNqmXAWv5B7WG/d8W0R80wGIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrnPMtMV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrnPMtMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC12C4CEEB;
	Fri, 15 Aug 2025 13:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755264597;
	bh=StTuglqafWvmM7AjdtBAJujzJOlTTBfJwEkw6bVrV+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RrnPMtMVQ20+YYorPbBC/4qlDovfyIW44AVnTzFIxQfZP5nupwo8aYsujHwX9v4nM
	 LuZju62mbgdXBwo6Q+rH8tnecHDbOhCRdSTHVt0/UQGir0NoYoFYGHEDYj66s4l2Yi
	 oNNTHYvZq7o2o0TkUzv4vu++HZVEYuh6e5YRlkGJ2vor5T7maq4SeVn1TOMPMulpJj
	 VWdJCL/tqgJHYe1FvbRSsIahHP/IaO8JbuyBvDsRzT2Vswin3IrAhaS88Wlu1/AmIY
	 EHJEyeMzI13nbXMVopUnoZbBtOG3npZMITyyk0AzsbNqm6aIB2C80cFe7vTYJfCKFB
	 2RBK7iSnde7ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712F039D0C3D;
	Fri, 15 Aug 2025 13:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/6] Bluetooth: hci_core: Fix not accounting for
 BIS/CIS/PA
 links separately
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175526460825.1071141.5339418517624133366.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 13:30:08 +0000
References: <20250814162448.124616-1-luiz.dentz@gmail.com>
In-Reply-To: <20250814162448.124616-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 Aug 2025 12:24:43 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the likes of hci_conn_num(CIS_LINK) returning the total of
> ISO connection which includes BIS_LINK as well, so this splits the
> iso_num into each link type and introduces hci_iso_num that can be used
> in places where the total number of ISO connection still needs to be
> used.
> 
> [...]

Here is the summary with links:
  - [v5,1/6] Bluetooth: hci_core: Fix not accounting for BIS/CIS/PA links separately
    https://git.kernel.org/bluetooth/bluetooth-next/c/3ae443de7edf
  - [v5,2/6] Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
    https://git.kernel.org/bluetooth/bluetooth-next/c/1b773e698ec3
  - [v5,3/6] Bluetooth: HCI: Fix using LE/ACL buffers for ISO packets
    https://git.kernel.org/bluetooth/bluetooth-next/c/bd32dcfede57
  - [v5,4/6] Bluetooth: hci_conn: Make unacked packet handling more robust
    https://git.kernel.org/bluetooth/bluetooth-next/c/cea0c704804d
  - [v5,5/6] Bluetooth: ISO: Use sk_sndtimeo as conn_timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/2ecd48de96ba
  - [v5,6/6] Bluetooth: hci_core: Detect if an ISO link has stalled
    https://git.kernel.org/bluetooth/bluetooth-next/c/64a73bcf8b27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


