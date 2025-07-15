Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA3719004A
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604187; cv=none; b=nk1rm6oOmy6oo00i1YxwmJvwQ67X75bXi0v3dJR4QNkQL9Co/mQ5CVtm6s5g9LH/MLWt3SAJegKVeARe7TRo4EMzq0n92XaotBYAEF9D7svcfRrLOTJ/1XIve5DBqLWqYZyi1+p2Idrct9ORJUChqosL1LnEdgQAWsHxfZXcLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604187; c=relaxed/simple;
	bh=W201jgQ8fwGzTXPwgDPgEVf/+gbjBiYCHlKD+tSGGeo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iUaLGIR135/xnrGd+4F2e10n84Z69Rz7rLYsc3ITj6H4NgTBp6Vxi7tOg6MNnInbkPgaW1rPIQ34UbfOCqs0JcksbiMklsYdmoYdJig0VESQycCeHGiVEuAvmIZtwlhVeE5pJUhhSFIY3//rufuMuWN7qt6Y+p5HEUxVnds7OzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaKzX6df; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaKzX6df"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FAAC4CEE3;
	Tue, 15 Jul 2025 18:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752604185;
	bh=W201jgQ8fwGzTXPwgDPgEVf/+gbjBiYCHlKD+tSGGeo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GaKzX6dfSyWtQotlK3hOQvUVhtHp1WykQhFgWK2gXtAqVKfLDxASepExQPr3Loqb4
	 7kUbA2DfiORmaPycG7YDPLdwRJW7R5BQYIvE6LDqttCwv3G14KXJrML1gsznhR3NgC
	 GuUbp0n2wMzGwfGGCOMClW4+8jOiRKbGuuYUc1JRoILdrc7JxzAsXAusK2rZtb8m5P
	 ciqKK7l7TJJqEQNPQyhICw/ntiYF+yNjJr/lhrmHaqxelUaLoxo8IrfOSUQ8GCMCr6
	 WGjDSO4BTVE/Y1KcRRXmNRMPSZwjmW5da3jF/E+JUVyv+HFvqwq5dimiuSQwyB25PD
	 v6TE3oKtRoorw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D67383BA29;
	Tue, 15 Jul 2025 18:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/5] device: Add btd_device_bdaddr_type_connected
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175260420626.539908.5604703276901857259.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 18:30:06 +0000
References: <20250714203519.345226-1-luiz.dentz@gmail.com>
In-Reply-To: <20250714203519.345226-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Jul 2025 16:35:15 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds btd_device_bdaddr_type_connected which can return the
> connected state based on the address type.
> ---
>  src/device.c | 8 ++++++++
>  src/device.h | 1 +
>  2 files changed, 9 insertions(+)

Here is the summary with links:
  - [BlueZ,v2,1/5] device: Add btd_device_bdaddr_type_connected
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f406028b5d2e
  - [BlueZ,v2,2/5] doc: Add org.bluez.Bearer.LE and org.bluez.Bearer.BREDR
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8c8b5ed25a88
  - [BlueZ,v2,3/5] bearer: Add initial implementation of org.bluez.Bearer.{BREDR, LE}
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fdfaeddc9c71
  - [BlueZ,v2,4/5] client: Add support for org.bluez.Bearer.{BREDR, LE}1
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f4f8fe3e4813
  - [BlueZ,v2,5/5] client: Rework handling of Disconnected signal
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4c431e5dae3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


