Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540814;
	b=LSp3YjpJU/O00JJKs+H5B4cxsqQioKjrZySv55MqVtpRPJg9KCfeKZzV5SowI/NMdq0u
	 6131R1dMFzMYV7jV9giOnr0GaLTwui9GlDdcV3Hal+ih1DrHybeh/wHmefAGScjZqWJut
	 zB7tAVwKhQkm8p8Mi2k0l2cZLm1Ir4G4DZDtu23X5/XZ+q7If2tNjRundQZr66LM87zCO
	 B+kevIVr1d3Clh+XLuBNJf/sj1o0vJYUrxMZSL6okVUFFwSTBprJ2Lcb5JDFqGgDjJqqo
	 PKlUcC4vyLNySxyCdjW2c7dkBsxY1u0Pn7UjjjRdYMxmz/BR9i8KaAFjhsUWaO3iDGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540814;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=hCuim8keh3BEejSZCZV75/ReorU/DjE6gsujkMJJ8F8=;
	b=m7R4wbmxAxUhQTzHBa/STeCgpGhpgmBx8W7mZ4C3PUuBirVoTggVETheEXyEdifch8vM
	 f0nDLmNPJsmshNWAMEu4U+e8Ow3d1T0ipQXcPRgm5Vi4cRxj3MeJI7cKlTcMznLb4+vfq
	 fe9mfY0XD7M+QmH59fwbF6Ak13wiWr05mI0KwWcD6kB7gsje9n1Zy9AmCXBPNyH8Qf1x9
	 MZo6G7xYiDYeReJVH+lCZ5vQjuhxYjB0Etn1FwtrsUltN3nHDzDuSN0BKsj1Pq758n3Jy
	 FSzSZEa+tb7CNzqm9He0sXiJ09bIIHko6qmDp2h4W8nJIe07R9yKnEPVMHFhisvj0xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJb1aOS6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D7606A326
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJb1aOS6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807B11F000E6;
	Tue, 24 Nov 2026 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540813;
	bh=hCuim8keh3BEejSZCZV75/ReorU/DjE6gsujkMJJ8F8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QJb1aOS6/xE4yQ9GkX/WteJfV496540svoxciLIY7G8/Czqcme5cQB65RLyqh8zCp
	 cnWhYjDFiMyAZaqbzQkpx/CjoNI41yftELLoFm0f9/ZZuDbzFulj/QZq8LHvwD3ebf
	 JtnPXJrGPVw6Cf94o2f2YNlTQStEAKUoku0jCNGWD9mvsOMM2A+vHNWQSj7rIfvzT/
	 PdmXXmrWTcQgfso4DZFvxqJycA8noxCOW8F32ScdgtOCNFmmwkxwXhDOHT+zroAqrc
	 f2S3wcV6JpTMCMSBQVpGFPsATjHJX+iPQNz8fVygEzC8oXnIXCSPnoEWxYyjB+KW5M
	 tNzcwhnj5kU+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7741A3938FA7;
	Tue, 24 Nov 2026 17:20:13 +0000 (UTC)
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
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_conn: Fix BIG cleanup while BISes
 are
 still bound
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179554081201.3669449.1345811024201004625.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 17:20:12 +0000
References: <20261124114010.1696510-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261124114010.1696510-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Nov 2026 12:40:08 +0100 you wrote:
> When a broadcast source BIS is closed, bis_cleanup() calls
> hci_le_terminate_big() unless another BIS of that BIG is in
> BT_CONNECTED, BT_CONNECT or BT_OPEN. Until LE BIG Complete the BISes of
> a BIG are in BT_BOUND, so one that is closed in that time does not see
> the others, and the teardown is queued while they still wait to be
> connected. The BIG is not marked as created yet, so it is not
> terminated: terminate_big_sync() only disables the periodic advertising
> and removes the advertising set the BIG is being created on.
> hci_le_create_big_complete() then connects the BISes that are still
> bound, in a BIG that has lost its advertising.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: hci_conn: Fix BIG cleanup while BISes are still bound
    https://git.kernel.org/bluetooth/bluetooth-next/c/a803233ce7a0
  - [v2,2/3] Bluetooth: hci_conn: Terminate a BIG before its periodic advertising
    https://git.kernel.org/bluetooth/bluetooth-next/c/8b55108e8ebf
  - [v2,3/3] Bluetooth: hci_sync: Fix closing all BISes while their BIG is created
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


