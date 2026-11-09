Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240036;
	b=mtKaOZtohSfFHa58yvSiVpBHz5gB/uiNbDRhoGD0sqZ2NRgCi+CBJ3bJIuw9EkmQUXRg
	 JcFXIcxfhe/z7lK4JGPoMaglDCHUUU6ppmYeIgErj9qnFptvT0EaEuP4XRz9l8XLF38hj
	 tpWRVvf6Z+QJNgiW+zc0algTF2hewcNEnfP0X/vHZ1dk4KcHFNheOjTBqfhN0P05lSfAF
	 yJUbsE1B2/Gtq7PjLu6JfxrE5QpjNOPL9iTkFZd061o4uZiRlHQwrhVNokDSo7x9IMuSp
	 EbivKwpLwNp77qJEogxHQTLbMitijA3IjnOgLnmwhpeC4rdW66NweoQtgcpBtPAuRhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240036;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=d7OGiecdcd4pje9XNxp/AEns3J55ShoAjvRMG26vN/Y=;
	b=nrCvR1efg6N1CgeyuM+f03gKFGeKvk/dVVdU6Din0HQTCScO4qZc/GuwgaiMObR0L3YG
	 qw3YcyVGlGiHdHS+ll9Beu62bsw5Ny1FnWaI6mmOYd2WES0aBfm/8URyNS7zWNSfwLpLF
	 8TAU9XWYaAa5FK5gBI/1S1T0H9ubB2rRC4PWE6d7wU7pnJBXWgVGc7jC1nVoaBr5/7qkg
	 IoVwgEO7smkM5JXD4j8seMdqjlJ6OWmG9tpQbNt+hOOPycLkv9F4TCKhFHENMcl8OWmvJ
	 8gjUO75P3UCNKqp50jltxIrdnZTSjSfFKV9HgcJUsSppU2dh0IzeZpo5TZYOwd3NBJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kZg5m/W5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4882606EEA3
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZg5m/W5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A58C1F0089F;
	Mon,  9 Nov 2026 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794240035;
	bh=d7OGiecdcd4pje9XNxp/AEns3J55ShoAjvRMG26vN/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kZg5m/W5iaj3s5PtegQatBOFkj9FHvMubqskubTSEuLxUd+xHlFGQEDPiF47u49PD
	 I+K1UOtnSjUUsInTAVcp4DaXI7LroinE/wsLcNAhMnpSRXfcSCpOu/ct94v8xwV8E6
	 mxt7dZ8vs3fLU0gux919zwSWrrccB5bdKhKvPtBvVVSH/UusIrjLPwYN3hVZ9k5KG7
	 ACfJMW2JMPg7Q3f/Mp1B/UElh+4hY23gdCAcDxoFLL6LDYx9XdsrhCsnwUECJkEBCE
	 S5e6Cltu2RJQh+xtFkMD0TUKtaXORbaMu2WlCe47CHGMcmJcsLp0YHMFN3ZWdH5kdb
	 06y0HlR2zZYdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E36E3805CCC;
	Mon,  9 Nov 2026 16:00:35 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ 0/2] bearer: Fix auto-connect handling of LE Connect
 and
 Disconnect
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179424003399.3335769.13828179370784941457.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 16:00:33 +0000
References: <20261107015649.84892-1-kevin@simpleble.org>
In-Reply-To: <20261107015649.84892-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  6 Nov 2026 17:56:47 -0800 you wrote:
> org.bluez.Bearer.LE1.Disconnect is documented, like
> org.bluez.Device1.Disconnect, to disable incoming connections of a
> device that is not trusted until Connect is called again. Device1 does
> this by taking the device out of the auto-connect list, but the LE
> bearer does not: a paired HID device that is not trusted and keeps
> advertising is connected back right after Bearer.LE1.Disconnect.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] device: Add functions to pause and resume auto-connect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=00a473e0ada7
  - [BlueZ,2/2] bearer: Fix LE Connect and Disconnect ignoring auto-connect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=77afa9ee44ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


