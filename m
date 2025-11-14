Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C82337B8A
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140358; cv=none; b=OhSjzZm1+CFeY8vLvPbuZSWACAxQgZ6/4xrvP+E5uJArIfUnm/0WAnypbwSGd1rmAWY62WF08XMr+rd3ARdhh2J9YDjD9MmPrINbtz7Gd/IHPtUP3qy+NkzvFWLa9EGq8kQKeU2DRzywLhloG7nDRhAAKKvw1pDjk/xhmCwzFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140358; c=relaxed/simple;
	bh=03Sl3GTwQBW34XpiB9q9v9fY+vRMAa+Ky6IAAnRmVts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dpsVznVRtDNxtobWmp8RmcFyp0DUtRUhLY6fZGNYY81s4L6fpagff9sSjJYtUn1xeFibhHyPHRlgptJwyax5xEaF9a9TA3B8SVa3zVNbStQz4xKqCyo6R1mRlKnnKNAPtJKdFl+lFmoYfSzs/+oosf8+Q9+yJrQWiMlYziFwIyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfRXkokj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfRXkokj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2B3C113D0;
	Fri, 14 Nov 2025 17:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140358;
	bh=03Sl3GTwQBW34XpiB9q9v9fY+vRMAa+Ky6IAAnRmVts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CfRXkokjyT+9tT7v1MJN/owC1Tuet/IHVsUPnn7ul/5AwI0JAHJC9Ahj07LKM5lvL
	 ItQri0f+Bf0lw3MvuaG7/QM9uEpV30q4ldvjg1LuQVriZ/nKmAFRD5vMJLEJxlHP3D
	 p5xpEkZ//74yHkF6O6zUGN5MjpyCeJWkc9SFj+l1fAj6M1jHcNImCBNSFAwM6hmHMy
	 3oqemNpK2wg01dVMDjmymMkWi+Js++KpegbpU92Y9n8zugw1RRb9PH/UnX1+RMH3Hw
	 0f0Wwh4ia6ezhRgrh8iZym+9VC/N7txhHfRONAdJCNYu5IzPxn/ooM2zklb82g6QsD
	 sUJt5j6ZmXuCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0EE243A7859C;
	Fri, 14 Nov 2025 17:12:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] monitor: Add page information to
 print_features_subpage
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176314032674.1740925.17555659694388224656.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 17:12:06 +0000
References: <20251113155818.2628720-1-luiz.dentz@gmail.com>
In-Reply-To: <20251113155818.2628720-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 13 Nov 2025 10:58:17 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes print_features_subpage print the page they belong:
> 
> > HCI Event: Command Complete (0x0e) plen 253
>       LE Read All Local Features (0x08|0x0087) ncmd 1
>         Status: Success (0x00)
>         Page: 10
>         Features[0/0][8]: 403900f301000080
>           LL Privacy
>           LE 2M PHY
>           LE Coded PHY
>           LE Extended Advertising
>           LE Periodic Advertising
>           Periodic Advertising Sync Transfer - Sender
>           Periodic Advertising Sync Transfer - Recipient
>           Connected Isochronous Stream - Central
>           Connected Isochronous Stream - Peripheral
>           Isochronous Broadcaster
>           Synchronized Receiver
>           Connected Isochronous Stream (Host Support)
>           LL Extended Feature Set
>         Features[1/0][8]: 0000000000000000
>         Features[1/1][8]: 0000000000000000
>         Features[1/2][8]: 0000000000000000
>         Features[2/0][8]: 0000000000000000
>         Features[2/1][8]: 0000000000000000
>         Features[2/2][8]: 0000000000000000
>         Features[3/0][8]: 0000000000000000
>         Features[3/1][8]: 0000000000000000
>         Features[3/2][8]: 0000000000000000
>         Features[4/0][8]: 0000000000000000
>         Features[4/1][8]: 0000000000000000
>         Features[4/2][8]: 0000000000000000
>         Features[5/0][8]: 0000000000000000
>         Features[5/1][8]: 0000000000000000
>         Features[5/2][8]: 0000000000000000
>         Features[6/0][8]: 0000000000000000
>         Features[6/1][8]: 0000000000000000
>         Features[6/2][8]: 0000000000000000
>         Features[7/0][8]: 0000000000000000
>         Features[7/1][8]: 0000000000000000
>         Features[7/2][8]: 0000000000000000
>         Features[8/0][8]: 0000000000000000
>         Features[8/1][8]: 0000000000000000
>         Features[8/2][8]: 0000000000000000
>         Features[9/0][8]: 0000000000000000
>         Features[9/1][8]: 0000000000000000
>         Features[9/2][8]: 0000000000000000
>         Features[10/0][8]: 0000000000000000
>         Features[10/1][8]: 0000000000000000
>         Features[10/2][8]: 0000000000000000
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] monitor: Add page information to print_features_subpage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f67b72b4cc39
  - [BlueZ,v1,2/2] btdev: Fix set_bredrle_commands
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4bf47f880d06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


