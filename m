Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE82E1C65
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989397; cv=none; b=Xzi7Hs2VLtvmEWoJQYBGstTpBnkwk5t83CkEzCJFxsUHfcToQJpP6SpW8HlBKaOpek/gZbwQEKE4OCIJ3Fywrcbap8CzMo4Kfb+NHlEZQbDaptaKNlnfE+7f0h8OAb9AtPUP7muDYEYoopao59sPQa3DOcVsGNHXWG516sremSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989397; c=relaxed/simple;
	bh=WD+SsCdGGiHuDo5nYQDWyWYPA/BpfVVTRHxYlb48C2g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Type; b=m2uAbECQ6gMoKhvOhEuYfJ4M9vRS2Zlc/2MIrYC0cbsRxCWlzOFPOqzfmcy0zwYwG5RX34/OzRcUMkIW1aJkLwddoMPNpTmHi7npozS7qv1ruItAKIJQJhXFmoZ+xwWXRbyUrJieipH5Fdp24aRx5Hg5fUpmUsBBal13argPyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aXcwsjpN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aXcwsjpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751989393;
	bh=WD+SsCdGGiHuDo5nYQDWyWYPA/BpfVVTRHxYlb48C2g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aXcwsjpNMI81D7AXhNWs4CabAxGKXhvJIpy2dUXAU03geD8NG3SqeTF5u3Ff4Gg3f
	 OcuXcMRfQeAFG40O8MU2X9XFAxWHZx5AKa0X3HYp2m/r8r3SFlkL1fOPlGFJALRTkf
	 AHHuknbCO8mHvQw6RgoJnpjU0WXTbsI74odnO+xan0YzXvHhhb39M8Dw78MXm4fNui
	 EeUbOqSk29UV2Mzr5JZDor5lwowPQKujTDPuLMmYmEzEcsCjLYLyQy2xD+GILsqJeb
	 AQVuwB4WMys2xHnDleMTMEZo/VXplwmedrN4I3a689IpEUT0QhSaS53drHawBixCQA
	 pfqsD2rjmk8Ig==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-a903-aFF7-d14E-7699.rev.sfr.net [IPv6:2a02:8428:af44:1001:a903:aff7:d14e:7699])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C3B5D17E1045
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:43:13 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/7] audio/avrcp: Fix crash with invalid UTF-8 item name
Date: Tue,  8 Jul 2025 17:43:02 +0200
Message-ID: <20250708154308.238963-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708154308.238963-1-frederic.danis@collabora.com>
References: <20250708154308.238963-1-frederic.danis@collabora.com>
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

