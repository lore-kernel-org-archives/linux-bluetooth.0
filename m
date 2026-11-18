Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029614;
	b=YO19w67mumVYNfHnSqUcrPO41dQeM3Z/2x1qF6bzNniCuyQaaMcSIhYs76+1SnyN9mZJ
	 3UhFJsW67sqech9Crhb/79mtER5Kmy+yEogywV8wZEFfF42J2tKBaRvSYWxjJfexBDqpM
	 oVIceJj50Nxdlm9G4r0nNBk++9MitcBKxWjcTmQs+ISoyhECFAD5bM6cGrnmNxL3WYIs5
	 84Kgr5nfr4LbPjbw18foZYY1Xj7LfiNOQ5hyYUnZHNaRDrqZpVqa8l1IJJTZtdpvxV025
	 qDh8QxJGeSMRKRlW+75Xga5UVw+q5jyvyVaE9f4ovBuz0tvYdB6R4WJxMnfGrLQC85g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029614;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=I/j/UO4kBAWTsJr1u8k0XcMW09V2AGCjGW8t8V/U7Xc=;
	b=h2nbZ039505E7dDUxTUzF09ibmZ9bqenVRhuE1KhQjl3Oq1FpNcn5K6+k7H4el3GhUdn
	 /mYcmDOctKOkIw8YwGkN/lipvFzVC3+piTBENAE0OAKW/gWDllfCnzwPPc1jsl8JNB5KV
	 8wnHYePR2nK0kUVHG1sP4N/4OVFmUUuj/ywE6shRUadaWff546409CnzZ+ye7uZ5Un+wu
	 mL1VYwt3XaAfmdUIlZg6y65MuN1jXja8i7wRjFsLRHMNZGxecPK2WZZ4BOsNcV/I/sYXC
	 cR+2GQ6YPvQddVS9B84QkZ/4B6ZPf4qVHW+n2jG7kN8znE94GncbB+JR/aBh5dvMipQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6h4QT6o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CA5606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6h4QT6o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BBA1F000C5;
	Wed, 18 Nov 2026 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029614;
	bh=I/j/UO4kBAWTsJr1u8k0XcMW09V2AGCjGW8t8V/U7Xc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l6h4QT6o+Ly2kCTQVI2b4TcKlf7brL0JlfQqEsC1L1tDuRp/O4IYuoBIkhjanaLtL
	 gxAS9L06/p15AJLPwm+wnNqaALAjPtnBoBjbPXgRKhddNbpi+6hOPhj9uC5uPYK/eX
	 UHCG/1L1JHuoOTJINQiQg5pSjalt/rQ5ciR2ibBLdpeYtO6aqkteYvNgEAI67PLION
	 /KH6V2b1J/vBdhwToJCgcC6l1bZIiCZnfF0nOJ7jwVIlCJ9zkcFBMcD1usuZndbnPG
	 sPqePTesXZyCbQhxeXlCyOXgIkITVIiMFNgtVYSFByzxglI6DXWbhp4MPr5y6fqx5o
	 PcYdbcPKvj9Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4893808210;
	Wed, 18 Nov 2026 19:20:14 +0000 (UTC)
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
Subject: Re: [PATCH bluez] gatt-client: Fix not emitting MTU on reconnection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179502961277.2490531.3324622150540616569.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 19:20:12 +0000
References: <20261114-gatt-client-mtu-reconnect-v1-1-a86edc1eb208@gmail.com>
In-Reply-To: <20261114-gatt-client-mtu-reconnect-v1-1-a86edc1eb208@gmail.com>
To: =?utf-8?b?TmVib2rFoWEgQ3ZldGtvdmnEhyA8bmVia2F0QGdtYWlsLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 14 Nov 2026 10:09:55 -0500 you wrote:
> From: Nebojša Cvetković <nebkat@gmail.com>
> 
> Characteristics kept across a disconnection have their MTU exchange
> callback registered on the bt_att of the connection they were created
> on, so no PropertiesChanged is emitted for MTU on later connections. As
> MTU is omitted while disconnected, a client that enumerated the objects
> in between has no MTU for the whole connection, and one that kept them
> has the value of the previous connection.
> 
> [...]

Here is the summary with links:
  - [bluez] gatt-client: Fix not emitting MTU on reconnection
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cfd87b4970dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


