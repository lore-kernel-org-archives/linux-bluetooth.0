Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327011;
	b=28QMwzg8n8VwbRxlCbMAOQc7AC/3OjCTwQ96kraV/OE5Y+B8sk9EytiX9zISpBOIELtI
	 HFOzjj+Aaj5O/5GM21A1bz1vscedxlif+FomqmtOnpcffm0v3mvr4PYK5VOzL7IJD1fJo
	 s1tnihpqoXxEAwwRa4M9X/YEr2GJ7CLF1rCTWQFhX/nNb+fU5K5ei6UHu7OFgHybb+llu
	 9K/N4n3S1yNkwWALtljXYjvLwyRYDOdl2UmgdQSDXKcV6ZqsIsfGrNNokOg16WVWMzT8s
	 Tk2qKfLsMUO8q+AFSGNhh95Bttwa+wqexiSVhvghanRl7ZsM30nE1gIs4zF/bVNMDBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327011;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=3AVhLi3JdPRht/cpEJYLixagKRvqBQRXjmvgnpxDuxw=;
	b=r+ZyFG+z4j6lBcAp8DA+I0cuGQFWiGYGWdSvzvdDY5AgXGBYnA62bTYgKWIFNkvI2rbk
	 WKaU8AxQ1hx7SviBgl9a1gDp/9s0yVHjU57SFHIf8l31ROsxIbws0mXg0Yl1ZNRGGnOWz
	 eTLl6mioRBoVm7hARRx/OV2FSH+f05GzLiOo++C7940JVwk4nFEuc7pcTLUoTrdXLwZDv
	 CnE5MsVQWvJjEyL1Dz76b2+nzZ6Df8YHbsXSB7KWtROBtPylCus6Pnye4R0fxr1CCinax
	 SEUEwnNIN5khciE9Eh9raSvQ0H5rUz8wzT3NbnMV4qwvQ8rKf7+wVfAsUbhNfzsubdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFLzpzzJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C9606A32E;
	Tue, 10 Nov 2026 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFLzpzzJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295601F008A1;
	Tue, 10 Nov 2026 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327011;
	bh=3AVhLi3JdPRht/cpEJYLixagKRvqBQRXjmvgnpxDuxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VFLzpzzJvSBELNeU6bPURuIKEhFaHqaLTU65y9/jZXrOnHBH+aaDtYa9opmiLC9PK
	 YRZfwLAN9aGEkjqI32Ui0LX4SNA+vKx7skikcKyKw8HxB2CuzfyL8Ycw2pwQmprh3U
	 l4BLRHLr0Jv5GUyIGvomG7EvxZsxjXCmQbjP2ue91aI8LD9awc4fRlelv30RLGfCxE
	 tlVnreMnBf4NsrTgNNnwh7aL0ZVyMWn1bTed85DDghNMzxDMO+f2l4dt+YVUn/pZWo
	 4L4zISdFR9yJhvhUq6cdFUsQsqoeH2xOtm1AP2fkxQoRbv0MPBd+izE0eeG1OGgfTO
	 cVUN1IaaiMp0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210AD39D267B;
	Tue, 10 Nov 2026 16:10:11 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: vhci: Serialize packet reception with device
 creation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179432700967.4062787.5840471471606584903.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 16:10:09 +0000
References: 
 <pm-bluetooth-objects-candidate-0253-v6-ffe55995e8c517fb1d86@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0253-v6-ffe55995e8c517fb1d86@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 24 Oct 2026 23:28:23 +0800 you wrote:
> The hci_dev passed to hci_recv_frame() must stay alive until the receive
> operation finishes. __vhci_create_device() stores data->hdev before
> hci_register_dev() and frees the device if registration fails.
> vhci_get_user() checks and uses that pointer without taking the
> open_mutex held by the creator or a device reference.
> 
> An incoming packet write can overlap the delayed default-create work
> scheduled by vhci_open(). If registration fails before acquiring the
> registration reference, the following order is possible:
> 
> [...]

Here is the summary with links:
  - Bluetooth: vhci: Serialize packet reception with device creation
    https://git.kernel.org/bluetooth/bluetooth-next/c/f8ba3e2e82f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


