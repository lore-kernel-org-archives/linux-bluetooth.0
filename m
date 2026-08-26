Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF10471410
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762504; cv=none; b=ayN31e8MLrp7IhifkeGJTZYH//2QagC9RCduD1s66NWrKh3n6We+j8kHG54kE1i6t2uDWH2DCE8H6CfTlR83nZIHkmQcbDtHBoRzxQMOflz0u5fLCOQ5HxK+aOcY4UkKEBiAI5mFwGYmHZ280IzQOCpckpUAgBdcixyK+1ELAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762504; c=relaxed/simple;
	bh=T1jYyb8IjeOoXgNMcUpa5XxvUIX6HQ6M02ufdY8gYHI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=u+rbct7C9N2PGEVFmxOIwY+ZkUbJItfPeEa9U9fbkV3Pt4BBzO+kyORAhvE8syt6IN3cETzhSM9DZok5fzW5mCJpyCgn3uGJSew1sS12T4H+yzsjQJVvBmdKs9D2j/lKP9JEM7ojGG7rVi2Fiax6wmUbSIN/HWC4tt247ZI2mVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ci+Bko0i; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ci+Bko0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787762471;
	bh=T1jYyb8IjeOoXgNMcUpa5XxvUIX6HQ6M02ufdY8gYHI=;
	h=From:To:Subject:Date:From;
	b=ci+Bko0i7Ndp1nhxW+CMQHW7D+DQPnbkKFejeI5JpI3zC2vX3obJwbB9T48H65qT/
	 DEcfu5GT30SNXlfnIYjMSaHAuu0NfxIyo3VdrtsLYLPFiIZ31TlgsD/5Y5GiWMMVku
	 i2SlEbTfp6EkiBH8b/P/6IyNKr+wM35Hi93Xbs7glJcaXtznxEJVydH2W0yIuztkLq
	 A4TE4d3e/wxMMY713sKxT44pWANs1RGGxDQ49oY2cW9OyDZTFc7/Y0ejjSFA23IAEx
	 ub6k1CuJpeYFCsfi4HOqVmXLMFF/G2/ZfMANq/JPMGTDMEcvpfqP6cVfbkno6ik0Aa
	 MF6Mf/JWZ6FdQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8E02417E0331
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 18:41:11 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/2] input: avoid NSP1 disconnects caused by Sniff/Exit Sniff churn
Date: Wed, 26 Aug 2026 18:41:04 +0200
Message-ID: <20260826164106.293951-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

We received reports of Bluetooth instability with Nintendo Switch Pro v1
(NSP1), including unexpected disconnects during use. HCI traces indicate
the controller repeatedly requests Sniff mode while BlueZ keeps forcing
Active mode, creating frequent Sniff/Exit Sniff transitions and increasing
the chance of LMP Sniff Response failures.

This series adds generic btio support to control force-active behavior for
L2CAP sockets, then uses it in the input profile for NSP1 by disabling
force-active on the HID interrupt channel. With that, BlueZ stops
repeatedly issuing Exit Sniff requests for this device, improving
connection stability.

Frédéric Danis (2):
  btio: add BT_IO_OPT_FORCE_ACTIVE support for L2CAP sockets
  profiles/input: disable force-active for Nintendo Switch Pro v1

 btio/btio.c             | 35 +++++++++++++++++++++++++++++++----
 btio/btio.h             |  1 +
 profiles/input/device.c | 16 ++++++++++++++++
 3 files changed, 48 insertions(+), 4 deletions(-)

-- 
2.43.0

