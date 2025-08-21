Received: from pc232-41.mailgun.net (pc232-41.mailgun.net [143.55.232.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AA222564
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.55.232.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809168; cv=none; b=uj9temAsBP8TFnFVf329fY+JY8Q0wTHDA+gpv48zQB5JZQPO2vs0omsWx3Mjz6XeYYKZBvjRZ8lVfqxlmTXCYlvsLBGihXj9WzmGXLcqTrxcsIbd+452FpqbeNcQIEJoOcrYbR+wT4sckiRZkq8xgKs6Carm5OEcFZAElBRE17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809168; c=relaxed/simple;
	bh=u8OPZDEeCZldTOuP+TfLi3o/2jeAtXx0Jzr65ro5Rtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nlVILoDlgodcJYoDDSsDKxK9wCELEIcXpc3o9mZ+LnxPfW/Df7UjdCC1UjIl82mLhN1mU8z3Yljp4vjATJDdeVBqVK80KooGmfJsF+4uAS5zr70fKnJRgTYnbhwo8O4gla/H/aK4O15dhj44h6CHh3N1A07JN3xwt8T6yIEvWMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=home-assistant.io; spf=pass smtp.mailfrom=home-assistant.io; dkim=pass (1024-bit key) header.d=home-assistant.io header.i=@home-assistant.io header.b=euFuGXtU; arc=none smtp.client-ip=143.55.232.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=home-assistant.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=home-assistant.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=home-assistant.io header.i=@home-assistant.io header.b="euFuGXtU"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=home-assistant.io; q=dns/txt; s=k1; t=1755809163; x=1755816363;
 h=Content-Transfer-Encoding: MIME-Version: Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=SZwCIFOzbLqlQ2COXhJrQhJLvP8yTfbhhh9j323fGNM=;
 b=euFuGXtUna+KXkU5hdfLPA9I0qit/8hLMiIsBwnxtYLkvQb1Lot2lfxFHiVLxRriCbbTRiMGcEA2htXc8ZDgl+y5zPwlcFTKcfzJRQN1VFaeRGWbUDybw0MG+541MSwC4I84Y2uAs1lbQooIf3nEtzFTTAkGc7btmw8o5t9snsE=
X-Mailgun-Sid: WyJiZGJjOSIsImxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmciLCI2YTMxNiJd
Received: from Mac.koston.org (108-87-95-24.lightspeed.hstntx.sbcglobal.net
 [108.87.95.24]) by
 825fb4632810f899c657f6c436237b767a3330cab67a8b6b80c31238f2c57b91 with SMTP id
 68a7858b671b79641e5c4156 (version=TLS1.3,
 cipher=TLS_CHACHA20_POLY1305_SHA256); Thu, 21 Aug 2025 20:46:03 GMT
X-Mailgun-Sending-Ip: 143.55.232.41
Sender: nick@home-assistant.io
From: "J. Nick Koston" <nick@home-assistant.io>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	"J. Nick Koston" <nick@home-assistant.io>,
	"J . Nick Koston" <nick@koston.org>
Subject: [PATCH BlueZ] device: Fix device removal on le-connection-abort-by-local
Date: Thu, 21 Aug 2025 15:45:38 -0500
Message-Id: <20250821204538.26110-1-nick@home-assistant.io>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a LE connection fails with le-connection-abort-by-local, temporary
devices are incorrectly removed from D-Bus, preventing clients from
retrying the connection.

The issue occurs when:
1. A connection attempt fails with ECONNABORTED (including the
   le-connection-abort-by-local case)
2. The device is added to the connect list for automatic retry
3. The temporary timer (30s by default) is not restarted
4. If the timer expires before the retry completes, the device is
   removed from D-Bus
5. Subsequent retry attempts fail with "device not found"

This commonly happens with devices that abort connections during
pairing or when incomplete GATT discovery triggers an abort.

The fix restarts the temporary timer when ECONNABORTED occurs, ensuring
the device remains available on D-Bus for the retry attempt. This
matches the behavior when new connection attempts are initiated, where
the timer is restarted to allow time for connection/pairing to complete.

Reproducer logs show:
- 14:19:37.374 - le-connection-abort-by-local, retry queued
- 14:19:56.343 - Device removed from D-Bus (~19s later)
- 14:19:56.606 - Retry fails: device not found on D-Bus

With this fix, the device remains available for the retry, allowing
the connection to succeed on subsequent attempts.

Fixes: https://github.com/bluez/bluez/issues/1489
Signed-off-by: J. Nick Koston <nick@koston.org>
Signed-off-by: J. Nick Koston <nick@home-assistant.io>
---
 src/device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 0179c3dab..28803af38 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6271,8 +6271,12 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (gerr) {
 		DBG("%s", gerr->message);
 
-		if (g_error_matches(gerr, BT_IO_ERROR, ECONNABORTED))
+		if (g_error_matches(gerr, BT_IO_ERROR, ECONNABORTED)) {
+			/* Restart temporary timer to prevent device removal */
+			if (device->temporary)
+				set_temporary_timer(device, btd_opts.tmpto);
 			goto done;
+		}
 
 		if (device_get_auto_connect(device)) {
 			DBG("Enabling automatic connections");
-- 
2.39.3 (Apple Git-145)

