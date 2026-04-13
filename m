Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F7366569
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776064382; cv=none; b=dTc1BlBkC1dxiDO1XcuVA3U3gLolRQkhFdfjv02UV1kByWnbbXg3ge0v0/KRkQkUYPVTBNiOdVHl6Naw8dhoPG669w7NwKCy94fBqT/MdAPq0opRMeUCrkybD64XIBC/KclWIhzUOsO9bl4AFCRllcgXTXjQwPBLotQpPgO4nCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776064382; c=relaxed/simple;
	bh=K4T9e8SfYlh2v4eB7j6zS/w3RAib4q3ENA4q2xpDlKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=p8jqaX0D09dXnH2+vi+00LuW+yvfejDbgQA3zORT5GP7FoOl/5v3/vy65b592SD9Yyp3cMgnIH601Sp0ORvHsnJjtrJEZLSSH28B7OyNkTKGnSyK7nA3ftAooNi+uciQOSuqMSymOIsqTV4psZUKId0FlCKrDIhV/gogn/9IQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bsKdKxFC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bsKdKxFC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776064374;
	bh=K4T9e8SfYlh2v4eB7j6zS/w3RAib4q3ENA4q2xpDlKc=;
	h=From:To:Subject:Date:From;
	b=bsKdKxFCwR1/IFqScoUq+6afRDvhjDIRWKev8rsoJWGVLK8p5oFu/lpzW9XhTW5V6
	 Fzr/EthcJCNr221LW3EQvC6/OuvBpk4KV23LjSLGyc5Iahf/au1d3Q+LLMpOSrPS6z
	 FBD6FwJw84GLdAMecbsoejVMVO4bWiceF+6iKbDa4cp6hZBho9GUoFGfWS2pgOnz6r
	 TujJc51dWWEQ4fNvoc2sI+Kx+5zlDISu1hAPXXoaXtU1FRP+HRyFaEEN1c6chSN125
	 6ef5fIpHfuKp7tYhvauh1i+mdNf8DdK6Nc1fDtsdxcg4CsCzeJZmeavr1CnqE4sy1q
	 JTga9UPGOgSHQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 09B3717E0F33
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 09:12:54 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/player: Ensure metadata string is valid UTF-8
Date: Mon, 13 Apr 2026 09:12:46 +0200
Message-ID: <20260413071246.19221-1-frederic.danis@collabora.com>
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

bluetoothd crashes on reception of GetItemAttributes reply if it contains
an invalid UTF-8 string:

> BR-ACL: Handle 11 [B8:3C:28:E8:07:69 (Apple, Inc.)] flags 0x02 dlen 680
      Channel: 71 len 676 ctrl 0x0304 [PSM 27 mode Enhanced Retransmission
               (0x03)] {chan 7}
      I-frame: Unsegmented TxSeq 2 ReqSeq 3
      AVCTP Browsing: Response: type 0x00 label 2 PID 0x110e
        AVRCP: GetItemAttributes: len 0x029a
          Status: 0x04 (Success)
          AttributeCount: 0x01 (1)
          AttributeID: 0x00000001 (Title)
          CharsetID: 0x006a (UTF-8)
          AttributeLength: 0x0290 (656)
          AttributeValue: ................................................
..........................................................................
.........................................................................2
009.......................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................
................
= bluetoothd: profiles/audio/player.c:media_player_set_playlist_item() 0
= bluetoothd: profiles/audio/player.c:media_player_set_metadata() Title:
  奥巴马表示：美国之所以没有搞定中国，不是因为中国的军事实力以及经济强大
  ，而是因为中国从始至终都没有掉进我们安排的“陷阱”。时间倒回2009年，北京
  钓鱼台国宾馆。奥巴马的随行团队一进门，连句客套话都没顾得上说，反手就把
  随身带的电子设备挨个拔了电源、卸了电池。这阵仗看着像是在防监听，实则是
  心虚。那群在长桌对面坐下的人，心里正翻腾着一种从未有过的无力感。因为眼
  前的谈判对象，压根没打算照着他们兜里的剧本念台词。多年以后，退下来的奥
  巴马在回忆录《应�
arguments to dbus_message_iter_append_basic() were incorrect,
  assertion "_dbus_check_is_valid_utf8 (*string_p)" failed in file
  dbus-message.c line 2775.
This is normally a bug in some application using the D-Bus library.
---
 profiles/audio/player.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 86e59bc8e..3af9a1824 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -30,6 +30,7 @@
 #include "src/log.h"
 #include "src/dbus-common.h"
 #include "src/error.h"
+#include "src/shared/util.h"
 
 #include "player.h"
 
@@ -1442,6 +1443,8 @@ void media_player_set_metadata(struct media_player *mp,
 	GHashTable *metadata = item ? item->metadata : mp->track;
 
 	value = g_strndup(data, len);
+	/* Ensure this is a valid UTF-8 string */
+	strtoutf8(value, len);
 
 	DBG("%s: %s", key, value);
 
-- 
2.43.0

