Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1A041B373;
	Tue, 31 Mar 2026 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975823; cv=none; b=djMrJWsZc50B9HbNiJRBOInyn+RCadXJqjVUTlE1qLrTFaLI2ECQuTgUL/b0AkBFytwymAapQ2ks/VQnTiWw1Fe9TDXHrCOl6+C1lUY60+rY3UdPmun8TI9Wo50EThUyKNsN39qU78on6YYMIEwu26RYixwslD7u5Do6h6jTEdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975823; c=relaxed/simple;
	bh=cS9OfKUzzwFU9V+lMVEZIVa2iy6qI0oKjaGyR/ydJ/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OYcQTMRWXE9CXzMBgpQX1Uq8i+NL3P90W3nlehDf2u5JLCkuAPMAsevPPJlanZc594sV3LQ03tcHxrQ1uS94Nb6L4heunH71Lrs9FdRHceCbnWj+uB8+Nyunq3Nao/GhJmrOweIdSoLx5s9auLBWA4Zf0Pr3c5ZYtB8MbJgGjhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i49IYVfp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i49IYVfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB88C19423;
	Tue, 31 Mar 2026 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774975822;
	bh=cS9OfKUzzwFU9V+lMVEZIVa2iy6qI0oKjaGyR/ydJ/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i49IYVfpquBKPlD/K8vcg7I3/8rh/QqLRWWaBn6sUxEzdH9POUSooVHmdgcDNerbd
	 Wf3UMa/aABRlu7Q1334hRoAS+b406mQuIYtUvnyDdpIMwihOumNpcYIGu2AIjqFZdp
	 LoaNnowMTvq+lfAK15iQ1pwncQI8goso7JWHX9kMRjdrQDXUaM9raQGWgKttGhScOG
	 QLSTT8V0lyfwQAMSRop9Rn2hVnNVQV/uw14W2XxXYnnxCG3+mRuB5H91rmWFXSWUiz
	 H/We8vBkaiHL+mon+yopcN0Yz93K8k/gZWzh8bh+f3rUeBGmWb5YC6EPYYZA8A4AIa
	 lJJBepPCpIiKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CECF3809A05;
	Tue, 31 Mar 2026 16:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/8] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth
 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177497580604.2805862.8417774878741242767.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 16:50:06 +0000
References: <20260326-mt7927-bt-support-v3-1-fa7ebd424323@jetm.me>
In-Reply-To: <20260326-mt7927-bt-support-v3-1-fa7ebd424323@jetm.me>
To: Javier Tia <floss@jetm.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, xelnaga@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 26 Mar 2026 16:13:04 -0600 you wrote:
> The MediaTek MT7927 (Filogic 380) combo WiFi 7 + BT 5.4 module uses
> hardware variant 0x6639 for its Bluetooth subsystem. Without this patch,
> the chip fails with "Unsupported hardware variant (00006639)" or hangs
> during firmware download.
> 
> Three changes are needed to support MT6639:
> 
> [...]

Here is the summary with links:
  - [v3,1/8] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
    (no matching commit)
  - [v3,2/8] Bluetooth: btmtk: fix ISO interface setup for single alt setting
    https://git.kernel.org/bluetooth/bluetooth-next/c/fe9e35d0b3f1
  - [v3,3/8] Bluetooth: btusb: Add MT7927 ID for ASUS ROG Crosshair X870E Hero
    https://git.kernel.org/bluetooth/bluetooth-next/c/af6731663d8f
  - [v3,4/8] Bluetooth: btusb: Add MT7927 ID for Lenovo Legion Pro 7 16ARX9
    https://git.kernel.org/bluetooth/bluetooth-next/c/70d2954d3051
  - [v3,5/8] Bluetooth: btusb: Add MT7927 ID for Gigabyte Z790 AORUS MASTER X
    https://git.kernel.org/bluetooth/bluetooth-next/c/e4fb2113d5e2
  - [v3,6/8] Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace Max
    https://git.kernel.org/bluetooth/bluetooth-next/c/4be0c8800708
  - [v3,7/8] Bluetooth: btusb: Add MT7927 ID for TP-Link Archer TBE550E
    https://git.kernel.org/bluetooth/bluetooth-next/c/26308f935d23
  - [v3,8/8] Bluetooth: btusb: Add MT7927 ID for ASUS X870E / ProArt X870E-Creator
    https://git.kernel.org/bluetooth/bluetooth-next/c/b65fdb465d54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


