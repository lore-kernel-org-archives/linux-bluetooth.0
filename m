Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D852AD11
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374784; cv=none; b=CzLZtjv7KTcrNfvhAtxUNLxYHSV/nxvZffndZB+litqRJ33YK8iMD+7QiJnqzdRUyHCsNZIIgDcpME157x2OaZBowtRIs4yiJCYzSfxK/Bmj+R6JtVFIXJJCWm43Q9AnJlIXppdOZal9kiVja5VmjzcjTPrSpx8U2yypJ7RnLlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374784; c=relaxed/simple;
	bh=yh+o4OD6KUnRWXsQWFM81m2+re3iLiCxDKpg4nQRkEM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=PCQPFMn3pzwHOkMsVh9of4EcYXU3c8MQpnRZu5ESzXyZf7E+h/HGq7k2tmHjD4rVGOI5z/3bVfEr9WZTGRlmtNYShXXscismkcwjalH0QvIp/GNxErkOVxxxsWN5w9kpP2y8ihbEzbl2HJqSeSS4YmNyejK5Rj9ihZInOY6Ve9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gVd7Ul0q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gVd7Ul0q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734374778;
	bh=yh+o4OD6KUnRWXsQWFM81m2+re3iLiCxDKpg4nQRkEM=;
	h=From:To:Subject:Date:From;
	b=gVd7Ul0qNIJsx7QQ07F1f+bEttKnuFGKgYEvFnE0d8dbCB4EzAjO2i1WRMLbYgIXW
	 j7tecbHkkwW3lcb3JgsY62tYsJgWg1zK6cEL1Qi7vmg9QWdhKCY/AcLl82mH1atnq4
	 AT8ykGJo/7gIna3O8AvVsMdOtyLLQ1Lhg/LjmaHOIPgn7UQhWK99mJ+22jidi8PDon
	 pHMj3kZ9wwUQJBQND1fxF5FoChgy64oFqG/4P46NIvaZyliWeK5uA5jmrUN8ET1E//
	 0IIB1xKvezYI/XCTE7MnrSAhYPJ1VVSe8Wl0jwbqfYOmrgsnlziPjxxwx8SYJimgic
	 IBdqYqPrVUKtw==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9F3E017E37E4
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 19:46:18 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/2] Add constant for 16 bits transparent voice
Date: Mon, 16 Dec 2024 19:46:11 +0100
Message-Id: <20241216184613.135538-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add 16 bits, 2s complement, transparent air coding format for mSBC.
Corresponding commit implements functionality on kernel side.

The voice setting is used by sco_connect() or sco_conn_defer_accept()
after being set by sco_sock_setsockopt().

The PCM part of the voice setting is used for offload mode through PCM
chipset port.
This commits add support for mSBC 16 bits offloading, i.e. audio data
not transported over HCI.

The BCM4349B1 supports 16 bits transparent data on its I2S port.
If BT_VOICE_TRANSPARENT is used when accepting a SCO connection, this
gives only garbage audio while using BT_VOICE_TRANSPARENT_16BIT gives
correct audio.
This has been tested with connection to iPhone 14 and Samsung S24.

This also adds a test to checks that BT_VOICE_TRANSPARENT_16BIT voice
settings can be set and get using [set|get]sockopt().

v1 -> v2: Add test to tools/sco-tester

Frédéric Danis (2):
  lib: Add constant for 16 bits transparent voice setting
  sco-tester: Add test for BT_VOICE_TRANSPARENT_16BIT constant

 lib/bluetooth.h    |  1 +
 tools/sco-tester.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.34.1

