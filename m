Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C351119B;
	Fri,  4 Sep 2026 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541037; cv=none; b=XpahK3LUAo5g9nGjrm/32lizLe3zlNR39zUUC9v2TPnK4OJRFcN1E4/TI4cKnogStY+FHbpASp8yBPSndtTEK6A64BXPf9l4rqR/T1w74N/x8c91lXxxfBrzF+QSmN7zqbmyNv8B5iSEJfYjMoEssbtmvfQgmVMzWXFaEfKFZyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541037; c=relaxed/simple;
	bh=0A0kY24qhixOcsKrUSa5hm9OEdbAjYNC0r4cVAizu5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YDP5WjLKL1JYovEMq/aUWNShBxfNNxbI3fgOE8/1zueyShtxTqUE6siFsYsT93iyAiND1f5WnHJf6PZIZcel4/MzDIj5k1puZjo5iXcMs+kymWcvM31ZgJKoHs7/qs/HU8eTAdAVu/F9F2l4SKwWbBpFn4RSodGUKefL/fn0hTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvZZPv4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvZZPv4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974A11F00AC4;
	Fri,  4 Sep 2026 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541035;
	bh=G17nF1GbmHK3GutCLsnU0LA9bGVlDyT2yDHfa/PHabc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CvZZPv4XF8h1rlY3OHSJ8pstRU+6l3n9ERxC1Jd2x+UIE/qukdNbAxunUZd6Vp09J
	 xE6391Gw/OQFn+TKA0BkZy8Qv+Q9NVlKXswmBXTcdHJ76l14qiKhYR56bY7MXVP0RR
	 EeqrQmm9K4nuyUDqXtbtO/uqO7BWMw98TJcoj7tc+FooJkcLsC5OR6LyawOAcC86Jn
	 2wVzZbOmo8Zl5Fd/a3jzGloy2T987Hi75RnSTFkE+IQRPjuPmIZZV/2jxMNxQuFDVb
	 ApkfF+W0RD33Azqe9Ya6mCgx68Wt3LHKBqMi2LdQ870GayaL+2sJDZYNpVsvXY58xm
	 cGE4jSs92aDyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938163924A50;
	Fri,  4 Sep 2026 16:56:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Add support for the Synaptics BCM4384 Bluetooth
 controller.
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178854097613.344939.278042329764425597.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 16:56:16 +0000
References: <20260817095550.648774-1-kaihsin.chung@synaptics.com>
In-Reply-To: <20260817095550.648774-1-kaihsin.chung@synaptics.com>
To: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linusw@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kaihsin.chung@synaptics.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Aug 2026 17:55:48 +0800 you wrote:
> The first patch adds the BCM4384 Device Tree compatible string.
> The second patch adds the controller support to the Broadcom
> Bluetooth driver
> 
> Kaihsin Chung (2):
>   dt-bindings: net: bluetooth: add BCM4384
>   Bluetooth: btbcm: Add Synaptics 4384 chip support
> 
> [...]

Here is the summary with links:
  - [1/2] dt-bindings: net: bluetooth: add BCM4384
    https://git.kernel.org/bluetooth/bluetooth-next/c/29d82dcf7273
  - [2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
    https://git.kernel.org/bluetooth/bluetooth-next/c/9aa9447804c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


