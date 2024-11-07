Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D80215C6D
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016924; cv=none; b=ERDDDQt2tg/CZihADZeje4AzR+Roopy5lP8zWErRvTk2JKJ9bT5VFW3m5VMueegG+SNdjXb/awIc4/nYP+YV5QAoO27jzzAnSHjq86jLh7EQqkHK+jVkicvfciD3u3pbTZxsA/Hgb8qqmbsv57AOwJprZWiBwNXKV0pT0IVRZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016924; c=relaxed/simple;
	bh=os0ujhcmUrgAPL4HBvjnlJlWradZ4LndLKZx/fB+6Uw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GGkVLArO6rCeNf1SsLZOC1osMc9l5D95WPGx1biteGCzKIYpBIPChf6yr1+1NHHfbK4mMryo6ciss1gAKvMTfPJcfh8vgKYaomSVZQQ+y+mykE8jYSC/6N+YCXLHSKPKRYAhzvWESVsnm4GxqcK5W6e8FoYQ5GfdVHOqxHjYEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=oY1h41AB; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="oY1h41AB"
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8EF4910002C;
	Fri,  8 Nov 2024 01:01:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8EF4910002C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731016905;
	bh=ZSTLfko1THR+xQuaGWYGV7vepKrTvfOxwmtqayzm3nI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=oY1h41ABoq/RhCPLTFjJJwkzuCJ7i/u6VOQxxgM/yWA5akpmeAGYL9SVWfIyVG9IG
	 W9O020XDZIZguwDnhrRr40hx8mmiHVvP2hbaZpAzItLUJk8rF72LVUJIQML9IHCD4/
	 VGvJMZOgid7zCyJ5VmmQhM5fVIMGYQto4X33R6rga6iJfkuajMRJy7Jvy6JZNeCS6n
	 z8MpvsrPe4LzoIDF1+kCGIPf/22OHpuKtAYy1hcz5z13/BtNzHLLWCoIHiWCxmzfKK
	 TgYrNNhtXGE3v7BNYdf4yBDiDwJ3EocamoRFJkVaUt128Zy4MsSmqohXzoogvPX7pH
	 B2waIBWqT+10g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  8 Nov 2024 01:01:45 +0300 (MSK)
From: Victor Pushkarev <VAnPushkarev@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <sdfw_system_team@salutedevices.com>, <corvinus.v@gmail.com>, Victor
 Pushkarev <VAnPushkarev@salutedevices.com>
Subject: [PATCH BlueZ 0/2] Introduce option to limit A2DP channels
Date: Fri, 8 Nov 2024 01:01:18 +0300
Message-ID: <20241107220121.97417-1-VAnPushkarev@salutedevices.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189034 [Nov 07 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: vanpushkarev@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_phishing_log_reg_50_60}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/07 18:44:00 #26832432
X-KSMG-AntiVirus-Status: Clean, skipped

This patch adds feature to limit the number of active A2DP connections.

This may be necessary to prevent audio mixing problem when playing from
multiple sources using the A2DP profile.

Victor Pushkarev (2):
  main.conf: Introduce option to limit A2DP channels
  a2dp: Reject incoming connection when channel limit is exceeded

 profiles/audio/a2dp.c  |  9 +++++++++
 profiles/audio/media.c | 11 +++++++++++
 src/btd.h              |  6 ++++++
 src/main.c             | 15 +++++++++++++++
 src/main.conf          |  5 +++++
 5 files changed, 46 insertions(+)

-- 
2.39.3 (Apple Git-146)

