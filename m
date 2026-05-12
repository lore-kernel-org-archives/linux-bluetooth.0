Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B13EDE52
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613668; cv=none; b=sbQbC9YYt3kUAltHrAM6oUhrSAboo4jfk/lxxolDvZnxsBXJAGA02HMK2KqOcTgpHjnylZEQqZhWUYyXjSHzwbDo2/pLNbP9QTca6BOUS3DFwtOr9NturMk5JgguVq9+YA/aPiFL7I3wOK2q7Z9NhfYiC5CJgWzcqrUVnPrmnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613668; c=relaxed/simple;
	bh=V+t5IHFcWd5RLgv/MyE9C7P2jp01VOgEohi7MXZkqNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ouQ+EE+E//A7QDZZaNLytmb8Z/4Erww205GmWXXL+PzNbMhGaomvGcoRTfRipLZXSMt3h+dSl9rGSi9BydcLA19ar/w+K9g8OCE8p0/8Hz+kEz1HaNLZxo2ycpPjYxIl698BlALVmqZBBRL8mjMIsHc5+zEfKqz3IRKy8fahXAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlbEuZd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlbEuZd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79626C2BCB0;
	Tue, 12 May 2026 19:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778613668;
	bh=V+t5IHFcWd5RLgv/MyE9C7P2jp01VOgEohi7MXZkqNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VlbEuZd0/rg0GtkK239vnNdOsmigdHQd4l4jnWSGH0myDhJrAjSidVCks4H1w8PYp
	 y8+NqfC4S1vSKKRiomwzJfy3A7L6DyexqD2qQ2Tvy4oquf2wulRMY3z9RyPL242E2w
	 rGlDSiKoPBr5cKIi8lZGbFah+BrkTXzZkFLr9dq5t41wU6FhtZKgbTX03ey8JL1Whd
	 enKgGtkl57T3wr4Ih98ZWPAT17aPAfsApUQXQargaBpTVqf7ZtqpsCkJN84s7XYU99
	 vbA/0IBwb/Z3a0IechFzSnGALBwhj61TYM8cYVWckzBmjokBmF/El4jx6HsDs2xHDj
	 Be3vdmODV6yGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EE33811A59;
	Tue, 12 May 2026 19:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] pbap: Fix not checking Database Identifier length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177861361454.3045511.3786238848818688000.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 19:20:14 +0000
References: <20260512083750.178053-1-frederic.danis@collabora.com>
In-Reply-To: <20260512083750.178053-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 May 2026 10:37:50 +0200 you wrote:
> Database Identifier is supposed to be 16 bytes values.
> 
> A paired Bluetooth device acting as a PBAP server can overflow the
> heap in obexd by up to 239 bytes into adjacent allocations by returning
> a DATABASEID_TAG application parameter with an oversized length.
> With both length and content fully attacker-controlled, this enables
> standard glibc heap exploitation primitives (tcache/fastbin poisoning)
> leading to remote code execution in the obexd process.
> 
> [...]

Here is the summary with links:
  - [BlueZ] pbap: Fix not checking Database Identifier length
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6ba04fad369f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


