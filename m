Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A7152E02
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852392; cv=none; b=aVrXkgldGoS+ujaGTHKsqEYjLdTL/Sqqh3itfTx1mYTNulV9/OryihJFa97I5qdS7HM8gzmXQQh6T2uhiFLP60YwtxImGpHj0xzptMcoq8WaHu80pFRfU5B6GV2tdIh/2Cal2orwn9kMLLBslOyoPssIczgsq+cODfC3wPfosP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852392; c=relaxed/simple;
	bh=FEjA3EoSlo4Ai4pW9aYuUwCLLeEjOD4IIvMGT4NWWBA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C8x3yTvB6mXbrdpitDDV31VGjH+/NRVLC9QvfG36MbNGZ9/SCBwsk1hMJQsGtM+7Ki/HAmmFYo4gohOjxfWx2aadEGIBdb6uaqtuej7DOh2DV4y7D7p3YW/wXkncsnmcnfDsJtOLfZIExqpOfHXk8MBsGrsiOY0mBkNb0dfpr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK6MYuVS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK6MYuVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56072C4CEE4;
	Mon, 28 Apr 2025 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745852391;
	bh=FEjA3EoSlo4Ai4pW9aYuUwCLLeEjOD4IIvMGT4NWWBA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LK6MYuVSz7Wzk12JKDm1npzxjG6TTMMrF2YFZOPevviibFFEi06to6b1Kdzg9zE/J
	 l9ZZQR/IdtCRFUawMbjVO9HvUnB1OMNBpU+iYHlGUogNZ4f8NVoPPMwOYxYPm+U9Wz
	 p/QfbstBq9z1o3xD7Q/gRb0VCbqHwj27kEkqrBnWRfnGtOpCuTqMpvBySV5vHBeEKb
	 vpYpT4gd5A2GRbiYuW/im8RgsiaFGPzq+yLw0mKkaYbi1DoMNVXcK4SAXmE+vhhLQe
	 xCfhT2wE5J2Au8CtHqjE73i6j2xXzK5Ltjsn9hUHK1HEnCceXrP82eHe/BCKsFb7PE
	 jSpx4PI5O/MvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E373822D43;
	Mon, 28 Apr 2025 15:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/5] tools: add tests for RX timestamping
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174585243025.938927.8724583608321001639.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 15:00:30 +0000
References: <b4a9c82f09efddcff2e604546c33e3737d8955c5.1745750626.git.pav@iki.fi>
In-Reply-To: <b4a9c82f09efddcff2e604546c33e3737d8955c5.1745750626.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 27 Apr 2025 13:44:35 +0300 you wrote:
> Add tests:
> 
> ISO Receive - RX Timestamping
> L2CAP BR/EDR Client - RX Timestamping
> L2CAP BR/EDR Client - RX Timestamping 32k
> L2CAP LE Client - RX Timestamping
> L2CAP LE Client - RX Timestamping 32k
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/5] tools: add tests for RX timestamping
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7763584f6d01
  - [BlueZ,2/5] bthost: implement fragmenting to ACL MTU
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a112d4345771
  - [BlueZ,3/5] hciemu: set bthost ACL MTU to match btdev
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aeeb4fd64adf
  - [BlueZ,4/5] bthost: support sending SCO packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=682e9252def9
  - [BlueZ,5/5] sco-tester: add SCO receive and RX timestamping tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f1d167215935

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


