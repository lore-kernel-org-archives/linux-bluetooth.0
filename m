Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688E20EB;
	Tue, 16 Jul 2024 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135726; cv=none; b=dUW46tHbKaOgqMJeaIPxJn2r8kwOs/LqM6JjeQpYjZeNTNhFsBBHXx3MElD1pjYe2DVhAeaNhFBXXlx5gaJw0ur4NTV1iDseDf/TtBeRuV3HZnRvEBjJzhdxVJTDwUo2h31ukkezyLnKFzGE4oo5ubPTz7CFHxcauv96qIAXaRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135726; c=relaxed/simple;
	bh=yFBj2Z3cTt97+mtm5CkIkh82J/HREikyWJ6CMEPIgQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHZvpBJd8poTJOhlth+UY6Us5fUzjG5sz64iZCv8k/9nM1qCaAvlquIjr37hhk1oDEXBwcA/sAYIXHnieKF71CgmbQl3QbXmcyukl5p9v63NGQSNSLczbawd8qbJyKClz/yzwAVmFJzynofNuU+Sf4UWIhIBcOxRgdoCuJ7raIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WVYznPay; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WVYznPay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721135723;
	bh=yFBj2Z3cTt97+mtm5CkIkh82J/HREikyWJ6CMEPIgQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVYznPayrojOOlVqrvSRuo06bXr8xAjqja3DRapcN8Ehf4D7zCWn2CItmGftFXCKe
	 o/AT2SoldnlcENIxJAQEWeaWZz/i1s0zRu/fUMnUaK+RwiS10q3pQLNW68kfLSNdjl
	 MT0iTScsz0DQwaenSwukUk04EIaq5Jbr1ViZI7M2IQmm86UN/xevAaMH/4OntSB3Cj
	 KyJWg/wmoC7XiLcPY/I6/FEiDiWf4rZ1bl6gbcvOVljpWsw0j1S4lmllqrje0reoZs
	 WQGW9hb7kfpOgE+aliD7xx5ORxPk0u4HtAYVW8ytxRsgqfG5sOBOuPTkcUv6COOv5L
	 QT2rBwm54cisQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 883EF3780EC6;
	Tue, 16 Jul 2024 13:15:20 +0000 (UTC)
Date: Tue, 16 Jul 2024 09:15:18 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Von Dentz <luiz.dentz@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1] Bluetooth: btmtk: Fix kernel crash when entering
 btmtk_usb_suspend
Message-ID: <5be71231-9818-479d-8592-c7c3b9722443@notapiano>
References: <20240716074947.23073-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716074947.23073-1-chris.lu@mediatek.com>

On Tue, Jul 16, 2024 at 03:49:47PM +0800, Chris Lu wrote:
> If MediaTek's Bluetooth setup is unsuccessful, a NULL pointer issue
> occur when the system is suspended and the anchored kill function
> is called. To avoid this, add protection to prevent executing the
> anchored kill function if the setup is unsuccessful.
> 
> [    6.922106] Hardware name: Acer Tomato (rev2) board (DT)
> [    6.922114] Workqueue: pm pm_runtime_work
> [    6.922132] pstate: 804000c9
> (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    6.922147] pc : usb_kill_anchored_urbs+0x6c/0x1e0
> [    6.922164] lr : usb_kill_anchored_urbs+0x48/0x1e0
> [    6.922181] sp : ffff800080903b60
> [    6.922187] x29: ffff800080903b60
> x28: ffff2c7b85c32b80 x27: ffff2c7bbb370930
> [    6.922211] x26: 00000000000f4240
> x25: 00000000ffffffff x24: ffffd49ece2dcb48
> [    6.922255] x20: ffffffffffffffd8
> x19: 0000000000000000 x18: 0000000000000006
> [    6.922276] x17: 6531656337386238
> x16: 3632373862333863 x15: ffff800080903480
> [    6.922297] x14: 0000000000000000
> x13: 303278302f303178 x12: ffffd49ecf090e30
> [    6.922318] x11: 0000000000000001
> x10: 0000000000000001 x9 : ffffd49ecd2c5bb4
> [    6.922339] x8 : c0000000ffffdfff
> x7 : ffffd49ecefe0db8 x6 : 00000000000affa8
> [    6.922360] x5 : ffff2c7bbb35dd48
> x4 : 0000000000000000 x3 : 0000000000000000
> [    6.922379] x2 : 0000000000000000
> x1 : 0000000000000003 x0 : ffffffffffffffd8
> [    6.922400] Call trace:
> [    6.922405]  usb_kill_anchored_urbs+0x6c/0x1e0
> [    6.922422]  btmtk_usb_suspend+0x20/0x38
> [btmtk 5f200a97badbdfda4266773fee49acfc8e0224d5]
> [    6.922444]  btusb_suspend+0xd0/0x210
> [btusb 0bfbf19a87ff406c83b87268b87ce1e80e9a829b]
> [    6.922469]  usb_suspend_both+0x90/0x288
> [    6.922487]  usb_runtime_suspend+0x3c/0xa8
> [    6.922507]  __rpm_callback+0x50/0x1f0
> [    6.922523]  rpm_callback+0x70/0x88
> [    6.922538]  rpm_suspend+0xe4/0x5a0
> [    6.922553]  pm_runtime_work+0xd4/0xe0
> [    6.922569]  process_one_work+0x18c/0x440
> [    6.922588]  worker_thread+0x314/0x428
> [    6.922606]  kthread+0x128/0x138
> [    6.922621]  ret_from_fork+0x10/0x20
> [    6.922644] Code: f100a274 54000520 d503201f d100a260 (b8370000)
> [    6.922654] ---[ end trace 0000000000000000 ]---
> 
> Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>

Hi Chris,

thank you for the patch. Please add the following tags:

Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
Closes: https://lore.kernel.org/all/7851401b-e884-4ed4-998d-7651f427ad37@notapiano

Those will make it easier to find the bug report and also make sure regzbot
closes the issue once the patch is merged.

I've tested this patch and indeed it fixes the issue, so please also add

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
