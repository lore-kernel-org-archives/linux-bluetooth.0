Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFD3AAF51;
	Mon, 17 Aug 2026 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959871; cv=none; b=JEvTEetQim1tGT5ZzCVDccvFvzMn51AMAYPqeoNTbOMiScFZGT+86K+I2jn7NYkRFodW+rY2JNHOLJdAMjjveSTjB5gCS0W/1HRA5D6gCtR/OUGgS+df+k9NsT/E82BT36VTq4nARKQ+JlRSZ0BBasiKpEF9aOp84yShsvxsYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959871; c=relaxed/simple;
	bh=mvaGsE+CnRKAgzAr9lRms4XeAWOTRE7aTUDREwqrJF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kN10XGwS4bOsEH0uC4XiCapn1yxIzyihV1xq7L/UJ6y+lV9r7D0B9QUkF9Toi4wOH87d8/hZQMk1k5fhr2yvNXQ8I2hvkl1wfIbdg9WWGGaOfQ9Nq8uWadxDw+4XJ9tLdpBGq3nnNSvnEPkD7Od2VaOLqBYCaM/5CX8fHDemsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=F9ED7xRe; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="F9ED7xRe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	From:Reply-To; bh=+THMLn1UZx9nf5RAT2P7GzAZnM9DxkEgB9Bh6dff4ho=; b=F9ED7xRebfO
	fpKmtDdJPClyjkM0wdEcvuHinh/JJwYUq/anG2SrWwi7ulZMSHNb5DyOM2paCKQs6s1+1EydqZ7e4
	NguAxHxj5o9yjk+tszmJgayTZR3WRQIqTqYItjv7rB1LVtFRp/MMsfAdN/N8xpAJ/XXwR5y8wzINo
	g59JSsj6T+PpEDZEE88JBG0Ijjuq1T6ySXwPqQ6oRtx4JVd+x6F17ATJTTrWYqaQ1gFofG2TyxvwO
	042PoThldp1pqUi3M8n/FzC+N4+txPch8hazThaEJBW1C+MaKLVWe9bt61FUV0EDNExBsfbCI3cEV
	RZjJS2tHgicIp0AoouP6p0g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wvtt1-0046Zh-1a; Mon, 17 Aug 2026 11:44:07 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
	by mail.igalia.com with esmtp (Exim)
	id 1wvtt0-00AeNY-0G; Mon, 17 Aug 2026 11:44:06 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
	(envelope-from <berto@igalia.com>)
	id 1wvtsz-002qMz-2h;
	Mon, 17 Aug 2026 09:44:05 +0000
Date: Mon, 17 Aug 2026 11:44:05 +0200
From: Alberto Garcia <berto@igalia.com>
To: Rong Zhang <i@rong.moe>
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Chris Lu =?utf-8?B?KOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
	sean.wang@kernel.org, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	Will-CY Lee =?utf-8?B?KOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	SS Wu =?utf-8?B?KOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"patchwork-bot+bluetooth@kernel.org" <patchwork-bot+bluetooth@kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925
Message-ID: <aoLX5TsNv5d9jw0g@igalia.com>
References: <20260603-btmtk-remote-wakeup-v1-1-5c1006442f36@rong.moe>
 <178050901239.1520440.2026593395539384648.git-patchwork-notify@kernel.org>
 <3f9c376a5dbfc9d737e2a7f83c5db8e591fb8793.camel@mediatek.com>
 <17FE08E9-2229-4C97-846F-6FA099E22C90@rong.moe>
 <CABBYNZ+rR71SKUEuZBTf+E3SwRNzV2-s-zt8EwNJM3PSx9qB_A@mail.gmail.com>
 <fd8587e97a48e49332a4ad36e51e18739d000250.camel@mediatek.com>
 <4e96132bcfb267af05c06dc277b5ba6895e3ddde.camel@rong.moe>
 <99fb847b8fdedb1464798230407719912d6585c6.camel@mediatek.com>
 <20260809223320.24431a4a.michal.pecio@gmail.com>
 <868e97331dc74f176db2d3efdd1c579049b8e493.camel@rong.moe>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868e97331dc74f176db2d3efdd1c579049b8e493.camel@rong.moe>
X-Spam-Report: NO, Score=-2.1, Tests=ALL_TRUSTED=-3,BAYES_50=0.8,KAM_DMARC_NONE=0.125,KAM_DMARC_STATUS=0.005
X-Spam-Score: -20
X-Spam-Bar: --

On Tue, Aug 11, 2026 at 04:03:38AM +0800, Rong Zhang wrote:
> I have also seen claims that auto power management is broken in btusb:
> > https://lore.kernel.org/linux-bluetooth/cover.1774348119.git.berto@igalia.com/T/#u
> 
> I believe the proper fix of autopm failure during initialization is
> https://lore.kernel.org/linux-bluetooth/20250319231235.812700-1-sean.wang@kernel.org/

I'm afraid that patch does not fix the problem for me.

With a patched kernel 6.12.96, after a couple of reboots:

kernel: Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20241106151414
kernel: Bluetooth: hci0: Failed to write uhw reg(-113)
kernel: Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.

Berto
