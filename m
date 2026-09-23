Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F78434406
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155124; cv=none; b=SYIP5Bscz7TbCA3AnmHupn2Nk/9a+sLIDBLMETAYtnh6pfNkFfcZQRxzbPOGyjDyv4GQ5SVYhZK/I3nN4XYAG51o6+NzFzshaN4WMqBgFU7Q0N1rCqt6anPmtUom3Lb0P+dW/neij7fV6NqVWBae12SA7yZfic9PrrcVwk4h8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155124; c=relaxed/simple;
	bh=4/1TZxc2+L8LPE2knHtuG7ELeSsXqYlH8l+FGzRMYL0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h4Uc9LHigSMtEjN2yogHXgcXNXrshFJ7cVeXvNE3MIZJzed9m5G+kYA5+CSawTa7d5Dxk6yJg+QyR6dhsFPTn33byolJGOE6B9/Y8AqEqa2I7ZFz6sHb+lspIaTIjIXTyAdlZmDbZW65/ntmLaDJDzZRruudNN6NCea75plLIbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=GMq27pox; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="GMq27pox"
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id BD60D240021
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 12:18:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru BD60D240021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1790155117;
	bh=cMIMTR4HianHXCTNtwOLMirI5QwcY1J/agbCggzW4uk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=GMq27poxiyD0CcqlpAH/EJ69zS6SGaQhAgSFzjgClMFjs/DnXOwUyVIkGxnySToFz
	 OFSiqYCoZ5CVM2+16pp6RKegDCoavMGURU9ZDutTtxUjb3o0dzjEtJU7j1X/eAeN2y
	 IgbY2CaiKlnbpeYeGmfTRQpPb4gfedyFZ+neFfdWWTsCDZ5zTzizWVMoN+xlWscSnR
	 fM9uAXdsAhtM7o/s1E8DTw5M3jOro5g5IKZ5WGy1pFFf6kmhmeXWCQtWylNvEo6YQP
	 jhpzRTc2mpceEuxZiMnaA2oHBN0q0DB6zDDuDGQvnQmethSnIs2wdrgzBF1//rkuZj
	 lM9579rkIWTmQ==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m1.sberdevices.ru [172.16.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "YR2" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 12:18:36 +0300 (MSK)
From: Pavel Bozhko <pvbozhko@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Pavel Bozhko <pvbozhko@salutedevices.com>
Subject: [PATCH BlueZ v2 0/1] audio/avrcp: Add AvrcpVersion config option
Date: Wed, 23 Sep 2026 12:18:26 +0300
Message-ID: <20260923091827.4496-1-pvbozhko@salutedevices.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-exch-cas-s-m2.sberdevices.ru (172.16.210.3) To
 p-exch-cas-s-m1.sberdevices.ru (172.16.210.2)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: pvbozhko@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 123 0.3.123 0a3d77c148601a24a80cc37b49c8995c1e141098, {diag_burst_silent}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206187 [Sep 23 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/09/23 06:24:00 #28613519
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

Some devices advertise AVRCP 1.3 in SDP but still support absolute
volume (SetAbsoluteVolume and EVENT_VOLUME_CHANGED), introduced in
AVRCP 1.4.  Examples include certain TVs such as LG webOS UM7450PLA
and Xiaomi Mi TV 4A 43 when they act as the audio source.

This patch adds an AvrcpVersion option under [AVRCP] so the local
target version can be raised when the peer SDP record is too old.

Changes in v2:
- Wrap DBG() arguments to stay within 80 columns (checkpatch)

Pavel Bozhko (1):
  audio/avrcp: Add AvrcpVersion config option

 profiles/audio/avrcp.c |  7 +++++++
 src/btd.h              |  1 +
 src/main.c             | 32 ++++++++++++++++++++++++++++++++
 src/main.conf          |  8 ++++++++
 4 files changed, 48 insertions(+)

-- 
2.50.1 (Apple Git-155)
