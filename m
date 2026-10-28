Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194207;
	b=ZXOkbARTTVONu46sT5pkTlLmIIkepic5wq5ZRObm/9QgC/rIAd+p5ChkQ+tTIYa4jhj4
	 VajA4L0FUctZ/CggS1K83y9n6kgve4OfLgSNufzVVSsPxGVj6/zwSIcIgE8QHwULl52l1
	 UcY1YbZZnVUcj0cpaAU1iHyuY5ADCiURN5JD/NAaikB71qQ6XGA6evZIjD+aQxCOxB93C
	 R8zDngsJA6MJGIADLQ98I1XgGRcLeQk64P2b+icr3qR6VbM3ghn2H62esluYmqvQ1BIDi
	 RSD0Xb0YlVcAuP03nx+KVOqArLmw50aZDMhxOldfVLCLmDNGA18RmWO7JFWNnLJw8sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=tZKFQpiK57+/4eQmybqH38o6eMzHG5OiFs7c6S5yQMY=;
	b=nlncdyLsSw1OhsRXszLTxh1UvtkNXblICf0OVOG0a42fZco2YIGnT/6z8e8HW+Nau2SZ
	 2KsG7G2K5Jhzopi1Ce+EuIlA8jhR9rZcgmHycBptjy4Z6Xu3/pggdoIyYoLAtE3lYLfQr
	 JwrWU5AC7Pat1CkfceUzjOcYryWnEOTnzFYeJaUFhviPtk4AqZZxHb+uIjI8nbcZutCG3
	 kzsSJtd2Psz8YNgcEnXgjjITjrHVWvPKT9M8Zmcb6g10B8+YEuTopuGQ2LkLVc4a90RJV
	 yS4Ki52fCP+P3cWTV/bLWVu0MPJaAMPqwEOsVU2L9iNdX1ZGRqOlQs83OLnsT5J14qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IjzrWIcC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6B606A31D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IjzrWIcC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1079B1F01825;
	Wed, 28 Oct 2026 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194207;
	bh=tZKFQpiK57+/4eQmybqH38o6eMzHG5OiFs7c6S5yQMY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IjzrWIcCaB3AZTn5AJSvTmfO0visIyoYLu3Vx6MZDyrC+2PgyJjkAY+PiUuTdw3rs
	 Rm/lWZbsCM8Yd0SeAd3RsrwcaKb/jO/KarluCJfRa3l6dmLXv9Xf5C/9XDjmKhkj92
	 Tx3d6fEe7NN2e8zOQhOGzKFgRDXvQRT6wU7hNN41ICjcJOEll42EIXTKAzSEv5V8jr
	 8YCmXHbD3ZljCFOUsBRkqidm550hg1oSwzGPampSAMhtOwugJrN7ojVpy0llDVtHit
	 Sh7H3n9+SYmGbJZK4NuDATe9yUWved1dHjOFiR0EjwjfCjdC7WALJZXovQoUkVL/rF
	 ff/2PAkemZczQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 074F03AAA6E8;
	Wed, 28 Oct 2026 13:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] advertising: Fix leaking clients that exit while
 registering
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179319420583.722681.1792431200395296166.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 13:30:05 +0000
References: <20261027051206.92829-1-kevin@simpleble.org>
In-Reply-To: <20261027051206.92829-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 26 Oct 2026 22:12:06 -0700 you wrote:
> RegisterAdvertisement allocates an instance and adds the client to the
> list ActiveInstances counts, but only watches for the client
> disconnecting once the advertisement has been added. A client that goes
> away before that, for example one that never answers GetAll on its
> advertisement object, is never removed, and its instance stays
> allocated until bluetoothd restarts. Once all instances have leaked,
> every registration fails with "Maximum advertisements reached".
> 
> [...]

Here is the summary with links:
  - [BlueZ] advertising: Fix leaking clients that exit while registering
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0d57c12f5aca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


