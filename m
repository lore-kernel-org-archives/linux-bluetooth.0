Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF0054DACC
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089598; cv=none; b=lBAmPBGAvtt3CoRh2ks7GNb4k5VIhCIe51Rfm+LXF1WFNUOuxYlHT/EKTbhRRWvwOuKfTNaxv0Dbg9KtB9BSUPTrA8olcCryGZjAtNjmnGcMeegJJjvm2rCIhTr4UQWC+jzprRbcCF3UvAIka8ImVx2cOb8hOx7d9wcxDZlYj7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089598; c=relaxed/simple;
	bh=hqRsVus9uMUDdLiRslxAERmgGJK565MHIDIGCETwGow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ByixC5yrWufAuJKsaWbDWlYQhqjTUALzr/kJXHbBTuHrtDcUi0KY9KsGtppOu+WSf3c7ziMqvoPUTqP+2r9+1mNkcjp1k5SPqg8ait7Bf6fHWv7mtmN9aSEm63HJqycsauhbmrVpwzg6B+HH7y3Qp9CXL9TM3yy+kRMbTKBOdjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=mFN9qUA0; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="mFN9qUA0"
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id A1A17240020
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 18:00:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru A1A17240020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1790089238;
	bh=AQqlVriYjKQJrGHf3oPtDGj9OQ2N3mUWcixKjgvRKDg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=mFN9qUA0Z6gctIaV5P9YprB+Xg1Alu8bZUW+bCQ7QEGeMdEgAIZDBmkisQxWlbcOn
	 hKpeXF3TVpq8vXC1ZRhIatzk4OfUi5X7S//NyXXip8A2nl1JgkDoILyukr/eDuvHvi
	 ifvt++7q263xN08nEkyf9NzEj+ONviD4W2DUGGlPPh/J4HVgxc8yMw7u3SkVuL82D4
	 bSwyAccrRhDNb7BwbSNDxOgxWhOYCbhTQ4xoW9hOUoW99WRJUpz2KaeMpn+7g7VrgH
	 rr4Aqm6M6JGCDN5FTTtseyCeRxp9bQ3OxVAuKaoVBy4nKSYQIkuGnkIBVJStXULGv2
	 zK7oIpSXBNpIA==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m1.sberdevices.ru [172.16.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "YR2" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 18:00:38 +0300 (MSK)
From: Pavel Bozhko <pvbozhko@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Pavel Bozhko <pvbozhko@salutedevices.com>
Subject: [PATCH BlueZ 0/1] audio/avrcp: Add AvrcpVersion config option
Date: Tue, 22 Sep 2026 18:00:29 +0300
Message-ID: <20260922150030.26340-1-pvbozhko@salutedevices.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-exch-cas-s-m1.sberdevices.ru (172.16.210.2) To
 p-exch-cas-s-m1.sberdevices.ru (172.16.210.2)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: pvbozhko@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 123 0.3.123 0a3d77c148601a24a80cc37b49c8995c1e141098, {diag_burst_silent}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206173 [Sep 22 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/09/22 14:27:00 #28611256
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

Pavel Bozhko (1):
  audio/avrcp: Add AvrcpVersion config option

 profiles/audio/avrcp.c |  7 +++++++
 src/btd.h              |  1 +
 src/main.c             | 32 ++++++++++++++++++++++++++++++++
 src/main.conf          |  8 ++++++++
 4 files changed, 48 insertions(+)

-- 
2.50.1 (Apple Git-155)

