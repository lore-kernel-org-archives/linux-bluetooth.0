Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6237C255E34
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958523; cv=none; b=l6wJysnH2S7/Wa48lYx7q8vgoXD4LgVn+/8R9GBWPERkDzqTzIZkNCv1S6JWcQ63/GLM28UnhMTmHSA0KJqNgAiplTAMrOxTSwQcjCfveV4b7PM26jSQFQoRpCxadWqdkM0M3yuYLGw3JDwjI8bKR1cFmL3cugzpdUK3gq9393k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958523; c=relaxed/simple;
	bh=WD+SsCdGGiHuDo5nYQDWyWYPA/BpfVVTRHxYlb48C2g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Type; b=erJz3M8cgjRBOaWjMvEHgimprcSNx2Iga+VlIxstiscL28QDdXdfk03vJ39+9FALrmjReRpgyxu4BP2by0Y+Lbug27+MKdnzIscPfce1sjkp8/fFL6pOeeVea4It5OVjjiBK9AlR80xgS88vjuh/XJZmEkH/oqM4vflUEQsMcyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ly0m83M4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ly0m83M4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751958519;
	bh=WD+SsCdGGiHuDo5nYQDWyWYPA/BpfVVTRHxYlb48C2g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ly0m83M47nGSvt38dN2HInRFlA6yytfyAQYcc1EIqtP9Oz8isjoXkgSvdhXhIoLHg
	 ksnUQU7NrwJDCYF7EoPXZs2N/63zEyyvw6MdbIiw9FZmz+70LZUM0hGxr4OwCsDrIx
	 Xnd433qnmG9d3OWNAh8NIddBw6KBcA6Kx+H1lf+KTCsWVRSViqCZXl+9x7LaQBbLa/
	 WNi9wlXkNxZlhT8dICQlTImIX39j+tQeh4nf2mWfUonKLEsIOmuAaz8ExKhVobQrEt
	 Vq6BSB584m7JK1Og5zrsEZXwJ36KnX+zFmIlmCWBaGLgHNboCbLcLLCdrs6qtzkwHf
	 R485SDnePzJSg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-A903-AfF7-D14E-7699.rev.sfr.net [IPv6:2a02:8428:af44:1001:a903:aff7:d14e:7699])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 41CDB17E099B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 09:08:39 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] audio/avrcp: Fix crash with invalid UTF-8 item name
Date: Tue,  8 Jul 2025 09:08:19 +0200
Message-ID: <20250708070822.185375-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708070822.185375-1-frederic.danis@collabora.com>
References: <20250708070822.185375-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

As stated in AVRCP 1.6.2 chapter 6.10.2.3 Media element item, for the
Displayable Name Length property, the target device may truncate the
item name:

  Length of Displayable Name in octets. The name shall be limited such
  that a response to a GetFolderItems containing one media player item
  fits within the maximum size of PDU which can be received by the CT.

This truncatation may occur in the middle of a multi-byte character,
at least with Samsung Music app, which triggers a DBus assertion and
crashes bluetoothd:

  profiles/audio/player.c:media_folder_create_item() Din Dhal Jaye
      Haye with lyrics | "दिन ढल जाए
      हाय" गाने के बो� type audio uid 1
  profiles/audio/player.c:media_folder_create_item()
      /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
  profiles/audio/player.c:media_player_set_metadata() Title: Din Dhal
      Jaye Haye with lyrics | "दिन ढल जाए हाय"
      गाने के बोल | Guide | Dev Anand, Waheeda Rehman
  …
  arguments to dbus_message_iter_append_basic() were incorrect,
      assertion "_dbus_check_is_valid_utf8 (*string_p)" failed in
      file dbus-message.c line 2775.
  This is normally a bug in some application using the D-Bus library.
---
 profiles/audio/avrcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 831f1dc8b..30997335a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2595,8 +2595,10 @@ static struct media_item *parse_media_element(struct avrcp *session,
 	memset(name, 0, sizeof(name));
 	namesize = get_be16(&operands[11]);
 	namelen = MIN(namesize, sizeof(name) - 1);
-	if (namelen > 0)
+	if (namelen > 0) {
 		memcpy(name, &operands[13], namelen);
+		strtoutf8(name, namelen);
+	}
 
 	count = operands[13 + namesize];
 
-- 
2.43.0

