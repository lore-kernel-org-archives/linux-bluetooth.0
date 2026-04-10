Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5083A75B9;
	Fri, 10 Apr 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837217; cv=none; b=NfcHs9eCweC7zEdANuup5qcpUcMVsEa5fU37qY3mxZplO8JkP5SwG/zG8QGrhIJhWZa/p72DrHMVQY2WnhAY2yw8LIZnIzMx1gq0s+YfCCNSS1N28uVCcvAIQ4Mzwk4dq3VrQfQm/LDKVUsLUPLJK3HTHLHIMhgHPTKK+Uy8pjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837217; c=relaxed/simple;
	bh=InBJWG19h0+ocfWhzOz5yXHmGn26YdyrjOCUIv8oAQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fqtmoMGiCOunl35Vhexm7CIyaXZcoUQ7QzjjOLG/CcQ1apY61rxPnkada6o9VHNUVHFdz4ohK0VaViSOJdYBjb7Hg1nFdAabhdE1hTa/FjEQU0bFBOPx+j8Hlmh2nC6BYSOhfdZEvle4wzZref81+3CRYNOKbru4SbExhGClON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/iEoR7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/iEoR7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC58C19424;
	Fri, 10 Apr 2026 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775837217;
	bh=InBJWG19h0+ocfWhzOz5yXHmGn26YdyrjOCUIv8oAQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O/iEoR7q5dHHj3xFLfWvvDYNxicAeYLLXMR1Y6Vpcrvc2qeKOuw1xzL09mFJZ/Fbh
	 FLdsH9dhbHVNBZDwGIaRTmaiYrDDxFrKFsKwqKPjafN/XA2Q3kVYC1HBoTPd2++4aC
	 q7l1PhRJF0E7Wr6ZRkMAsLMeyOpj1TbKpe8kfIFibS1vgPhjrZA+BTm2hIk8kQz7sj
	 eXHDpj7Ki5psNpNN25XiVN166bUWGpVw8o0h2PKN6HcTqJwb4VeBXUPNrcpmWOln8Z
	 XP1CHiJrjY+NGchAlyl/XdhBQ+LT4gkZmmuv7gsh0uOwhXoF8I7p/nvMmcrfNbXqS3
	 PEG2yE2y932Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CE13809A87;
	Fri, 10 Apr 2026 16:06:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/8] Bluetooth: Add MediaTek MT7927 (MT6639) support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177583719178.2534919.12672771691448146176.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 16:06:31 +0000
References: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>
In-Reply-To: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>
To: Javier Tia <floss@jetm.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, xelnaga@gmail.com, jnetto@mineiro.io,
 melinko2003@gmail.com, chapuisdario4@gmail.com, 3193631@gmail.com,
 nitin.reddy88@gmail.com, tibo@humeurlibre.fr, lubnin.ivan@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 31 Mar 2026 11:09:30 -0600 you wrote:
> Add Bluetooth support for the MediaTek MT7927 (Filogic 380), a PCIe
> combo WiFi 7 + BT 5.4 module. The BT subsystem uses hardware variant
> 0x6639 and connects via USB.
> 
> The MT7927 is shipping in motherboards and PCIe add-in cards from ASUS,
> Gigabyte, Lenovo, MSI, and TP-Link since mid-2024. Without these patches,
> users see "Unsupported hardware variant (00006639)" or the BT subsystem
> hangs during firmware download.
> 
> [...]

Here is the summary with links:
  - [v5,1/8] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
    https://git.kernel.org/bluetooth/bluetooth-next/c/2e16247422fb
  - [v5,2/8] Bluetooth: btmtk: fix ISO interface setup for single alt setting
    https://git.kernel.org/bluetooth/bluetooth-next/c/798c2ba5006c
  - [v5,3/8] Bluetooth: btusb: Add MT7927 ID for ASUS ROG Crosshair X870E Hero
    https://git.kernel.org/bluetooth/bluetooth-next/c/3e148151bc75
  - [v5,4/8] Bluetooth: btusb: Add MT7927 ID for Lenovo Legion Pro 7 16ARX9
    https://git.kernel.org/bluetooth/bluetooth-next/c/fa528d431d10
  - [v5,5/8] Bluetooth: btusb: Add MT7927 ID for Gigabyte Z790 AORUS MASTER X
    https://git.kernel.org/bluetooth/bluetooth-next/c/a4a3b78a8b3d
  - [v5,6/8] Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace Max
    https://git.kernel.org/bluetooth/bluetooth-next/c/b8185eff87a7
  - [v5,7/8] Bluetooth: btusb: Add MT7927 ID for TP-Link Archer TBE550E
    https://git.kernel.org/bluetooth/bluetooth-next/c/54834ec3a5b0
  - [v5,8/8] Bluetooth: btusb: Add MT7927 ID for ASUS X870E / ProArt X870E-Creator
    https://git.kernel.org/bluetooth/bluetooth-next/c/b816ef8a31b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


