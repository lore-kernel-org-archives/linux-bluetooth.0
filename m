Received: from protect.koston.org (protect.koston.org [64.227.100.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934AE35334B
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.227.100.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807815; cv=none; b=bP3FzcdSBizWgGLRKVcNozb4o6IEb/IomxiEhkWycSZS5i72o/HgpqCoytARmY88ZvSmY2/COG+K5VLCvwq7/vCwOMNfcTh9Gxk+Yr4/FrKa+0vUSqovx/PpbIITbSrxBpjx9GhWsQIysAOMc+0qmPlN/krqm9wJw+KbPkjYTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807815; c=relaxed/simple;
	bh=eVYMZxh6w7DnBCMZNbrBRiyLPfopYOawmkZP6P1+EM0=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=C/E+tbVHURaEgfrvzolwmSTL5N3h02wI1XQofAUHnuYysMZnSOcPtxxBW+feDzJbsWoiUY0uBoGVeknfD/HJV3awBOoSnWFCBMRg1YiWkbvkEDamRPIXAKxahsBX/KOwgB6SjIE7iKdZvEBf2o7us+a4uW5WRjRtMIO9+28rcGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koston.org; spf=pass smtp.mailfrom=koston.org; dkim=pass (2048-bit key) header.d=koston.org header.i=@koston.org header.b=FyZzwbjU; arc=none smtp.client-ip=64.227.100.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koston.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=koston.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koston.org header.i=@koston.org header.b="FyZzwbjU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=koston.org;
	s=default; h=To:Cc:Date:Message-Id:Subject:Mime-Version:
	Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GydwSuDpT8rYy2jmR3q6XWLnMde+QrZ27G5Lcsnjr4U=; b=FyZzwbjUFGojZe7IFJIGkwf3lR
	SyGy7i08e8YNWq3hr7LZlt1B5BDyzpt92L7mw4kq31xGfsAxLFmoyHVzWlQCliP5dpUOOPrg4agyR
	LdKCOWBzGBuMgIUnygNZch5EXTaRK8Y+S7qhH6/nuwEduuIYT4uVugtDLskpLtQ2zRseEOFyDVydV
	VEJxn707nmO8Z4hRnM5EbtVNOpqejrsZHAs4Wlz1kBT2J+QiA9qST/8ZMgMNzJQGIHyGy8haSqnJe
	UtklzK3PC5Jisb/86nMe95vhtrCFHyiHGKNPe5fyV2+Gg9gtNBqlndoeDIp36QsRSOJxXFKT8SXKp
	heC3aEtQ==;
Received: from 108-87-95-24.lightspeed.hstntx.sbcglobal.net ([108.87.95.24]:53193 helo=smtpclient.apple)
	by protect.koston.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nick@koston.org>)
	id 1upBjd-00000002XX7-0FuG;
	Thu, 21 Aug 2025 20:18:07 +0000
From: "J. Nick Koston" <nick@koston.org>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: [PATCH BlueZ] device: Fix device removal on
 le-connection-abort-by-local
Message-Id: <6C943D79-4B06-49E8-82C2-EC23F903F91A@koston.org>
Date: Thu, 21 Aug 2025 15:17:56 -0500
Cc: luiz.dentz@gmail.com
To: linux-bluetooth@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - protect.koston.org
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [0 0]
X-AntiAbuse: Sender Address Domain - koston.org
X-Get-Message-Sender-Via: protect.koston.org: authenticated_id: nick@koston.org
X-Authenticated-Sender: protect.koston.org: nick@koston.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 

=46rom fe7e071643a8de84bdc4079551cc0065890c0cbb Mon Sep 17 00:00:00 2001
From: "J. Nick Koston" <nick@koston.org>
Date: Thu, 21 Aug 2025 15:12:39 -0500
Subject: [PATCH] device: Fix device removal on =
le-connection-abort-by-local

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
---
 src/device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 0179c3dab..28803af38 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6271,8 +6271,12 @@ static void att_connect_cb(GIOChannel *io, GError =
*gerr, gpointer user_data)
 	if (gerr) {
 		DBG("%s", gerr->message);
=20
-		if (g_error_matches(gerr, BT_IO_ERROR, ECONNABORTED))
+		if (g_error_matches(gerr, BT_IO_ERROR, ECONNABORTED)) {
+			/* Restart temporary timer to prevent device =
removal */
+			if (device->temporary)
+				set_temporary_timer(device, =
btd_opts.tmpto);
 			goto done;
+		}
=20
 		if (device_get_auto_connect(device)) {
 			DBG("Enabling automatic connections");
--=20
2.39.3 (Apple Git-145)

