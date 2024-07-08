Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E11CD3D;
	Mon,  8 Jul 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473633; cv=none; b=JM1F47VgL4NNYO78YuuN5M3SqbC+9QSZdvtq54K4LWqoOaeu6W+7b1Vymn3xbdXye/D/TT+7regkADtmEH2johAiunhbihww6Jfs1gIMBC3PlolfnjXDKX9l4obmWEjw9CPbzS1l3XwQhEw7OIEoISMsGEgTxJswAjcTSOMTYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473633; c=relaxed/simple;
	bh=UWSUycG/PBa3IFkaEkQfdVNMaUwjTzQgOq0EeeYQahg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AW+0UYntgCrSeVWqg1DtHJcwJscqZsZCT4ixRmvcO7QTXyomIuEMndH3EjA0v8S+8WjNrs9BkH1zrn/PH6TBgn2DuFPE1SYBH9zVpD+yOZxHCVpPK7NV0sCG/cwFmBcZ/xZw+DAlaKU4/c+Ho3EjQTM0EPEA9CuyyGnTo/TbOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tzf3OvlJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tzf3OvlJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FC7AC3277B;
	Mon,  8 Jul 2024 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720473633;
	bh=UWSUycG/PBa3IFkaEkQfdVNMaUwjTzQgOq0EeeYQahg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tzf3OvlJ7VLaI7Cc6adcYuF1tiePYjXl4cOjQ04OvnQMp253PGnyf7Bwb6vRtvFEW
	 Fn57tGkPCruoBjaHyBpKpvww5/isXUak0mbOrx24QvxkssRgHcWIm3SmnT9pNlSvax
	 1sEhKlCwCwgBod7ztWUmPvxEuvdtoGCjrh94WRDjx//T+qPxBYH0Cwsj3hZ0rkJz+S
	 2AAkTVyJvaA+KUavhg81LB+b5xf1dsE38s7UBYlS8Z2/XSKLklhSEeP5c+ksq2CAVY
	 xzM3Rz4me6mGtnDvSJ5080Z8flYjK+hEWhGgcfcTTBBciXcAIo9GixDzdh+sDSUu4u
	 +QGHsMp9iik7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 722C7DF3716;
	Mon,  8 Jul 2024 21:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 0/8] Bluetooth: btmtk: MediaTek ISO data transmission
 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172047363346.9973.16198479983313620239.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 21:20:33 +0000
References: <20240704060116.16600-1-chris.lu@mediatek.com>
In-Reply-To: <20240704060116.16600-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 4 Jul 2024 14:01:08 +0800 you wrote:
> Since SIG has not yet clearly defined the specification for ISO data
> transmission over USB, MediaTek has adopted a method of adding an
> additional interrupt endpoint for ISO data transmission. This approach
> differs from the current method used in the Bluetooth upstream driver,
> which utilizes existing bulk endpoints. The interrupt endpoint provides
> guaranteed bandwidth, sufficient maximum data length for ISO packets
> and error checking.
> 
> [...]

Here is the summary with links:
  - [v7,1/8] Bluetooth: btusb: mediatek: remove the unnecessary goto tag
    https://git.kernel.org/bluetooth/bluetooth-next/c/a06a1458192e
  - [v7,2/8] Bluetooth: btusb: mediatek: return error for failed reg access
    https://git.kernel.org/bluetooth/bluetooth-next/c/ac7daf0f197c
  - [v7,3/8] Bluetooth: btmtk: rename btmediatek_data
    https://git.kernel.org/bluetooth/bluetooth-next/c/dfad4030dcc4
  - [v7,4/8] Bluetooth: btusb: add callback function in btusb suspend/resume
    https://git.kernel.org/bluetooth/bluetooth-next/c/cacda8ed6753
  - [v7,5/8] Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c
    https://git.kernel.org/bluetooth/bluetooth-next/c/39a9e1c69e74
  - [v7,6/8] Bluetooth: btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c
    https://git.kernel.org/bluetooth/bluetooth-next/c/314f1c00d267
  - [v7,7/8] Bluetooth: btmtk: move btusb_recv_acl_mtk to btmtk.c
    https://git.kernel.org/bluetooth/bluetooth-next/c/91d0ac304edf
  - [v7,8/8] Bluetooth: btusb: mediatek: add ISO data transmission functions
    https://git.kernel.org/bluetooth/bluetooth-next/c/7eac027d1b20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


