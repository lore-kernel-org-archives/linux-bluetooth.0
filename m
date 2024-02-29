Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB6E41C77
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225735; cv=none; b=Lb4zU6A6lJA2y2PAsdl8lsHso32Gqz2U2+qyd7GCwZsvTNHfWShLb2ZOxUNNCUNcL6SyZ/NAmEb3cT4ZsX0gczPKgUCzM5KHvHQqm/td9yodj5ratNHTXtlOPznA/WVbjRqclm06g2jKpQajkSTWn1Yr9qyEAmKDtN0ChI7pQJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225735; c=relaxed/simple;
	bh=7gUIpL4jSZ3Zwe8HxthkeDpVSgu6jynmTZzfRmv/Gh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n7Q1JNoqPf2zPtNIQ2WL10dhvduEm5F2Qe2BiczlqxQdPTzftGNIvqDZLkmhN/mTgvp18KVDaWbtLMHxkhJeAA3FEtsUGZ+3EfFz/7HpiyW7FmCb+CdK2fOC7HqOsF+yCPj9BdSuO666QwwVFKAkLh6zjwkIeZ1kPGrzC3YUuB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=CjxURkPe; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="CjxURkPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bCZXK
	iu56B+bwe6vJ63qmch8dj3KkivIMKRand9NPCA=; b=CjxURkPeALBrprYm9YUso
	6HAAr9Eq4uZxtjt6DBnWuwbicusIUvIeXRi8V0VpBkSvPTMDtPBigCpA3hqD1Biu
	K6GbdRSxfcSn1Uvf0g51n2oIzB27emi1RrxS2mQfDi5cZbAn//qLEjYZemwFAYa4
	V8QT2TxIwo6bELpq+4k5aA=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wBHz19YrOBlKfvYBA--.2067S2;
	Fri, 01 Mar 2024 00:10:01 +0800 (CST)
From: Xiao Yao <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: Xiao Yao <xiaoyao@rock-chips.com>
Subject: [PATCH BlueZ 1/1] avrcp: Add strict checks for supported events
Date: Fri,  1 Mar 2024 00:09:55 +0800
Message-Id: <20240229160955.530638-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHz19YrOBlKfvYBA--.2067S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw48XrW8Zr1rZr1rXryrJFb_yoW8Kr1UpF
	W7WFy3KrZxJFs2qr9FqasYg39I9FW8Cr929r15Xw17Zr43GFy5tF10kF13ta4DZrsFgrW0
	vF15tay2va1UuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USeHgUUUUU=
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbiEBqT1WVLaHwA4wAAsV

From: Xiao Yao <xiaoyao@rock-chips.com>

In some resource-limited embedded systems, if the player is not
registered, but the supported event contains the status/track/
settings events that need player support, it will return some
unreasonable values to the peer, which will cause confusion on
the peer device and cause some unknown problems.

In my test scenario, bluez was the role of the source to connect
the bose speaker. bluez could send absolute volume to the bose
speaker, but it could not adjust the volume of bluez. By checking
the btsnoop, we could see that bluez had registered volume change
notification. When I removed the events above, everything worked
fine. I also tested on iPhone/Android and everything worked fine.
---
 profiles/audio/avrcp.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 36ce01a14..34fc23306 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4152,21 +4152,26 @@ static void target_init(struct avrcp *session)
 
 		init_volume = media_player_get_device_volume(session->dev);
 		media_transport_update_device_volume(session->dev, init_volume);
-	}
 
-	session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
-				(1 << AVRCP_EVENT_TRACK_CHANGED) |
-				(1 << AVRCP_EVENT_TRACK_REACHED_START) |
-				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
-				(1 << AVRCP_EVENT_SETTINGS_CHANGED);
+		/* These events below requires a player */
+		session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
+					(1 << AVRCP_EVENT_TRACK_CHANGED) |
+					(1 << AVRCP_EVENT_TRACK_REACHED_START) |
+					(1 << AVRCP_EVENT_TRACK_REACHED_END) |
+					(1 << AVRCP_EVENT_SETTINGS_CHANGED);
 
-	if (target->version < 0x0104)
-		return;
+		if (target->version < 0x0104)
+			return;
 
-	session->supported_events |=
+		session->supported_events |=
 				(1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
 				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
 				(1 << AVRCP_EVENT_VOLUME_CHANGED);
+	} else {
+		if (target->version > 0x0103)
+			session->supported_events =
+					(1 << AVRCP_EVENT_VOLUME_CHANGED);
+	}
 
 	/* Only check capabilities if controller is not supported */
 	if (session->controller == NULL)
-- 
2.34.1

