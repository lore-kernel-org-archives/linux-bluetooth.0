Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869243F3280
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219122; cv=none; b=J1g2HV6TgoST5GmMhsQTfCUDcCR5MzdYz/gEzBbPbQ+3PuYIJUQ/3AwDZcFWGNPWHERWaYufu8K05zofry21C4NRFWOnQbL2LTfdWpHr8ARAIO+9Aozkg2r1Xre1xmB/A4bZnozRAHxtpdfTkKc7BqINDPigEuPRHzHeQILM7EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219122; c=relaxed/simple;
	bh=6CtzskXSLgZrYujMP3AlnjS4NSk0BroRQJ9VxlyHlFM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gpVSiG/Eg72i45+hLd/vvoErFyfSfaQRKj4DHVvotUKcZ+t5lMKF8kiGtww264bb/xFhZxirf+Ej3N7tHBOxFyVNAy4hPwW7Jq17j06QznQ7/QPzut8Yc36HGPJLg9Sr84cfVBIY7bZnWyH0IRBI7nlEIlyHtTdRr9kKCp0pyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8356E3EC5A
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 09:45:11 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] bluetooth.service: Fix ConfigurationDirectory warning
Date: Thu, 20 Aug 2026 11:44:46 +0200
Message-ID: <20260820094503.1779779-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTEL90ZtQsHMj6WU/2i9ci8dAEJiei4S1ZWQuek8IV10oakcXLRG7OH1u6pbhTxwvMhQ8/qBWgNMikCZPD92la1B45pBIjRxpNFL5tPgTy7adBCVF6cWD6RmPFhByYd6MWqgpMtg6rA/MBYv9helMsBYr+V/XqHY/vOIHPAs4qDKN1ooMFSDEb3bD90T4ChLXuQ23/JpNPIHPY7xs8RQB3mx/wrnQFFoJIwaXVU2Y3HuQIHVn+PHNilfOPoZChYMBnDw9mtWJQe+wJuT23mWpGpU7aSJTz/2qc2LIgUqLXjYHzOGuvpTaJy9AXoMWzpoSVjNYmO8/bsvqg4Yd+kHyNO1Tj7Ki/XpMA6FOoXYjSUU8IC0VUcQddFpJBO098BOwguboTFQqsplPDSbqRm/N2bBFtxJxJ5shHJavdXP/VuywvoRidk4AxPxjQdzxhnIikzoAmmE0AR0n41My90Q4OgT8g7PE8/kkv+mZJB3/F8TjFWkl/3oOMOrzrbH+8CMZptKK3tCieH9YXotx8+9Py5GQdLCZ0G0ioC4X9WtEiPMuS2jfGVnWELQBX0GK5Qyhd3hKhfwerHH0ORnZEb5KlM9xkU8GNFtGqbpJt/tULTrOoMOqx5B0Jnc8J5dBpkp8wNXD3AJRCcaGCEWwgkPD/LukgQXdGNb7p5q20iYXEZA0Q
X-GND-State: clean
X-GND-Score: 0

When running "systemctl start bluetooth.service" on some systems, this
error would appear:
systemd[8067]: ConfigurationDirectory 'bluetooth' already exists but the mode is different. (File system: 755 ConfigurationDirectoryMode: 555)

ConfigurationDirectoryMode was mistakenly thought to help sandbox the
daemon, but the service configuration already sets ProtectSystem=strict
but "If [ProtectSystem is] set to "strict" the entire file system
hierarchy is mounted read-only", so bluetoothd can't write to
/etc/bluetooth anyway.

Fixes: 00cfb36e20e3 ("bluetooth.service: Set ConfigurationDirectoryMode")
Closes: https://github.com/bluez/bluez/issues/414
---
 src/bluetooth.service.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 8dcbde2367fe..4d5ae568bee4 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -22,7 +22,7 @@ ProtectControlGroups=true
 StateDirectory=bluetooth
 StateDirectoryMode=0700
 ConfigurationDirectory=bluetooth
-ConfigurationDirectoryMode=0555
+ConfigurationDirectoryMode=0755
 
 # Execute Mappings
 MemoryDenyWriteExecute=true
-- 
2.55.0

