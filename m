Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBD26B2CD
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284001; cv=none; b=Fkt4gwYtbb4hxdH9bqX1f/UStv8B0uts/ap4k7Q6tpy5hLXxKLBBDO8KurS07y9FDNZrnmrganKbVaNznSKY4dU4aNIc1MXlyKik2vMih3iOS7aTrzsg6wUBRayGLB41vFWH83MRZ72tVuStNCaq6fCyaB/MrZBnRfhkPfYTSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284001; c=relaxed/simple;
	bh=fcG+V1EtSdsGPcXVCcuLAtEaQz+hsT9J06ed8IUw0vQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o3x3+ekkUNGwFw9M+eVrXt2fM+ffQTJuBmQW92La6mREpYXBy3qWsKxQYU9yuO792xyt15vSkdxvGLRLLmsoG5DTrJ0GaFByB3G7W2JD6aYN2+r10RuOuGRvs31luQGFgDwZ54P8/WjrVNfSwrf2wwxQLkFop22kMozH+1KOcFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PU6AgfJ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PU6AgfJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D280C4CEE4;
	Thu,  6 Mar 2025 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741284000;
	bh=fcG+V1EtSdsGPcXVCcuLAtEaQz+hsT9J06ed8IUw0vQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PU6AgfJ9ygXQG1OkMnmF5QC4vNNSw1Vn+6tMfpkszAZ6RSBriaSZyEmRB/AcYznTX
	 HnF6S7EAK33unaOO0Vbqw+V5Y/zKgWi2HuSUsvn63D671q2+EAR5vQ9Ollygrrp7av
	 EOvIxS+wV5WIQ2Fqon8n/PFQ2dUj8Vif9ZFQ3jFfzcRrhLS58cYDIcXvS8tMUvVqCv
	 csHtDGmCu5UFeo21Qv05iyr59YtsnHAp+Pwxo+oKKs/n839ntis1+8L1EF9sVSB40z
	 7puNwd5eEkUgnCsPHnQymqvL5sWdnwzSz2foKSiazAn2v+fg9Ai9UrfRfI7V/SlQaS
	 h+FnEBiI6gFrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9A380CEE6;
	Thu,  6 Mar 2025 18:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] btdev: Fix scan-build warnings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174128403376.1690290.13172353770875832681.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 18:00:33 +0000
References: <20250306160003.587816-1-luiz.dentz@gmail.com>
In-Reply-To: <20250306160003.587816-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  6 Mar 2025 11:00:03 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following scan-build warnings:
> 
> emulator/btdev.c:1126:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn' [deadcode.DeadStores]
>  1126 |         while ((conn = queue_find(dev->conns, match_handle,
>       |                 ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1127 |                                         UINT_TO_PTR(handle))))
>       |                                         ~~~~~~~~~~~~~~~~~~~~
> emulator/btdev.c:1413:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn') [core.NullDereference]
>  1413 |         pending_conn_del(dev, conn->link->dev);
>       |                               ^~~~~~~~~~
> emulator/btdev.c:1535:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn') [core.NullDereference]
>  1535 |         send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
>       |                    ^~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] btdev: Fix scan-build warnings
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=04cd5d2a97c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


