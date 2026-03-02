Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [152.89.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18C38F622
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.89.196.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443336; cv=none; b=hrHrKDhNPQbmTsJNuvU2Wy8D+bTrRlp5Pw+5Iu4EfHE3aLIbF8WdgjSoLog/bkVwGS0d3p1+3OBtajRCHMqdczLilbz70INxnz1u/cBmt6O2Z5CjAodxrgQaGFIXjiYA3DCBnulnhsJrk6ZkPEHIi+inbJzDmmcWfl65DSZoXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443336; c=relaxed/simple;
	bh=y52Ptbu7oc7pUYN1GSyheVQoKFkgY8J4ZHk5AELFMSY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNmSgD3Pr7TkpKCcCa8wbErdhXXXLtGfXeddZuHhJC+yYXjxkUOzIw4RVXeeIl3Ez0VVS4pdINzC7XK/DqF6gnhROs/w6F7vpOpC3goH+6hwjdZkxs4t3cBSXd0WE7gdf+DZA0JFM/M+8X2sIX1IRC2AaEyBGrbUjVHOa8KJ4SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=DYtyMzmM; arc=none smtp.client-ip=152.89.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="DYtyMzmM"
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id 3818440003
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 12:22:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru 3818440003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1772443331;
	bh=YDNEiVUyBzYgG4r6acNE7FMyaWK26TwBDqfA+KiBtTE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=DYtyMzmMebBdt5PlzV6MllKWI6te/t5Fk7UssQKoFZZqe9rlficDATn1E/FHbXJX9
	 NfoRHMlJ/rlG5R0a7Zj40ukAVhSlAXdLay43xR6OHBB1y0PtNnMfOwsMKMXLmIeRso
	 Dr21qRR5Zff1Qd6VxVT54vKxNOhBR61TOHIqAiTcL8ZZGtYhwTMvrAp3UbTsrYRAfw
	 bivDkRMsZTvtmTXo9/aY0+ZhcqBTcYSibbGgsYa7PIO4laCozdXzoxdI1ie1CWFIy+
	 xzur+oZf67qJCZsPDgOSXnM+ip8VggvmreRYWdF3s3VbcbkJjEseZoLn3MTgG0Updl
	 ixtQ4BQHPMcVw==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m1.sberdevices.ru [172.16.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (verified OK))
	by mx4.sberdevices.ru (Postfix) with ESMTPS
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 12:22:11 +0300 (MSK)
From: Pavel Bozhko <pvbozhko@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Pavel Bozhko <pvbozhko@salutedevices.com>
Subject: [PATCH BlueZ] audio/avrcp: fix EVENT_VOLUME_CHANGED not supported
Date: Mon, 2 Mar 2026 12:22:03 +0300
Message-ID: <20260302092203.12775-1-pvbozhko@salutedevices.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-s-m1.sberdevices.ru (172.16.210.2)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: pvbozhko@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 87 0.3.87 7430d8ffafccd8879e1d8370e5b501352446c2ba, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 200957 [Mar 02 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.20
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/03/02 07:03:00 #28238479
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

Some devices with AVRCP 1.3 may support remote volume
control—for example, certain TV models such as:
- LG webOS TV UM7450PLA
- Xiaomi Mi TV 4A 43
when they act as the audio source, provided that
Category 2 (Monitor/Amplifier) functionality is supported.
---
 profiles/audio/avrcp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 724b46c59..d501315b6 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1765,10 +1765,11 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
-/* SetAbsoluteVolume requires at least version 1.4 and a category-2 */
+/* SetAbsoluteVolume requires at least version 1.4 and or category-2 */
 static bool avrcp_volume_supported(struct avrcp_data *data)
 {
-	if (!data || data->version < 0x0104)
+	if (!data || (data->version < 0x0104 &&
+		!(data->features & AVRCP_FEATURE_CATEGORY_2)))
 		return false;
 
 	if (btd_opts.avrcp.volume_category &&
@@ -4293,13 +4294,13 @@ static void target_init(struct avrcp *session)
 				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
 				(1 << AVRCP_EVENT_SETTINGS_CHANGED);
 
-	if (target->version < 0x0104)
-		return;
-
 	if (avrcp_volume_supported(target))
 		session->supported_events |=
 				(1 << AVRCP_EVENT_VOLUME_CHANGED);
 
+	if (target->version < 0x0104)
+		return;
+
 	session->supported_events |=
 				(1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
 				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
-- 
2.50.1 (Apple Git-155)

