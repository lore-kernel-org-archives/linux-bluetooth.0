Received: from marumie.magnifi.ca (marumie.magnifi.ca [45.76.236.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABDB315D33
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.76.236.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778814994; cv=none; b=YYJ8CJ4XYiANhm1rCcrRx0wbA2Rq57NKJj946vGnFAa421J4Fl0cVfsowL8uCf8iao7Pp6OHQHTDUwDDrvaluKyF9EInWkItcNA1JZh3mG1AT3DbCvgjb3t0WxCKCFy7O1QEW95oDoKicR1XBKIIBrk1AiCHLjJ5adHfA1bmZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778814994; c=relaxed/simple;
	bh=BWbCHHvumKOOVJC5S1tALBtpvdcW5tPe99hcM33DN5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d5vDv2XkB0XEaRJt3paTDslZdG119zHYN8YhxQiX8D/vgi3d3JOUOJm49Jh20hIQttxiPnkqZxVs8PCc9nuLuzrr2/fb6h4WN1NkLnopECbZ1nrKB8lDo4kswkKfKZVlmL8E9OXFSbqrFMGYwQv24kff25MeqYvftDcnbJVs41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=correspondwith.me; spf=pass smtp.mailfrom=correspondwith.me; dkim=pass (2048-bit key) header.d=correspondwith.me header.i=@correspondwith.me header.b=cZMOnGN5; arc=none smtp.client-ip=45.76.236.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=correspondwith.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=correspondwith.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=correspondwith.me header.i=@correspondwith.me header.b="cZMOnGN5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail; bh=BWbCHHvumKOOVJC
	5S1tALBtpvdcW5tPe99hcM33DN5Y=; h=subject:cc:to:from:date;
	d=correspondwith.me; b=cZMOnGN5tYkgW0D7ZGC8N9hpptxmNt0nr1RbmmGZyS5TJ1I
	Up3ghbW3aPxkiEWDY2qB+BWufZ+4vOem75zlBq3dKSgMgqFJkq9DQ7dc5G4Epe9ij0tbAi
	Ju7eVkRTCvyerqgYFxBmB0E3HaJXinXfDb2cY6U56uZm2gDtY4zEbnLRoJxfaFSQZjO/WK
	HrYv/Fexskj7pgPZ7yAviqO8NNib96OWi9lPsmG7rW96kcayUSBdl0GA2vuFNiqJb7IAoi
	cRZ0oyyeSaMKVyLKyyoGBOtsjmBqtrI2tzR4wF2Ph91Jheroi+kXvO/Ydv4BHzKpoIuNHl
	VTPI8C/SXKZhpqQ==
Received: from localhost (marumie.magnifi.ca [local])
	by marumie.magnifi.ca (OpenSMTPD) with ESMTPA id 4043533c;
	Fri, 15 May 2026 02:49:50 +0000 (UTC)
Date: Fri, 15 May 2026 02:49:50 +0000
From: Aaron Muir Hamilton <aaron@correspondwith.me>
To: linux-bluetooth@vger.kernel.org
Cc: regressions@lists.linux.dev, Marcel Holtmann <marcel@holtmann.org>, 
	Tristan Madani <tristan@talencesecurity.com>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [REGRESSION] MT7925 Bluetooth fails to initialize after btmtk fix
 634a4408c061 ("Bluetooth: btmtk: validate WMT event SKB length")
Message-ID: <5i35wmc4z7sz54jo5uj6ywext2enh4ik3oxmfmperqk2v5kc27@ppvm6oodzipn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I bisected a regression on MediaTek MT7925 (Framework Desktop) in linux-7.0.y which appears responsible for this issue. It initializes and works correctly in 7.0.6 but not in 7.0.7.

The bisect landed on commit 70d37a8b9229e394cc17ddad47e90b81d80fcd09 which is a backport of 634a4408c0615c523cf7531790f4f14a422b9206:

commit 634a4408c0615c523cf7531790f4f14a422b9206
Author: Tristan Madani <tristan@talencesecurity.com>
Date:   Tue Apr 21 11:14:54 2026 +0000

    Bluetooth: btmtk: validate WMT event SKB length before struct access

    btmtk_usb_hci_wmt_sync() casts the WMT event response SKB data to
    struct btmtk_hci_wmt_evt (7 bytes) and struct btmtk_hci_wmt_evt_funcc
    (9 bytes) without first checking that the SKB contains enough data.
    A short firmware response causes out-of-bounds reads from SKB tailroom.

    Use skb_pull_data() to validate and advance past the base WMT event
    header. For the FUNC_CTRL case, pull the additional status field bytes
    before accessing them.

    Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c")
    Cc: stable@vger.kernel.org
    Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In dmesg, the failure shows up as:

    Bluetooth: hci0: Failed to send wmt func ctrl (-22)

Cheers!

#regzbot introduced: 634a4408c0615c523cf7531790f4f14a422b9206

-- 

  Aaron Muir Hamilton
  +1 313 240 2152  +1 307 365 7527

