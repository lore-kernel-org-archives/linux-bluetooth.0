Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEA934DCC7
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536502; cv=pass; b=t8I7scC3cCmihoprGJivigepBe5M+jQiwmBrioYMDDT5R0RwXLdVkJBsekfUK1uY+tomXSsM8uHftM4AQDYm196COgaJc/IQFA0haOl/J/mXt6Bu2aXZyHkdkBIty9bh7jh/oM9mi19JRT2NY7dSzj+4RYkZ3ScJ34D4/zl3DPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536502; c=relaxed/simple;
	bh=l0V+DGKiXJCJiptLa5tRp9hbjV+hxTDEcNRHoUztixs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7+LJNAd/fuTGvYqAIQYthugaQ0iH6sSKXnldj3kSUw/Bh9IbuHAYoGqssYWrsaIx4YJeitowXrakRvYV3xl5N6OcfRy6HQXCtSCcwqAIo8SN6v8EQ0e6sNWsueisskN6+9iK55scmI7RVfkCETlQn3Iuxw1ZLGWOBhBWDGIMl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=iy3YmW9A; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="iy3YmW9A"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gDtmq68fbzyRd;
	Tue, 12 May 2026 00:54:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778536491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eLRy1FujxGe5XgQRkPK48pHdd+uw0DD2PI23JshhoIU=;
	b=iy3YmW9A/9sZ2gIQCc+8WdfNpkU+x3KlETvVU1KcURJ+Wy99y08U3erUgy5n0BiLocs1Y5
	2zwbiYGqfgNrtHiY+zTEhkTJQPBiw+WM/zQkfFMsJ0Jvyu7a+IVHV9dp+BhUZ6xHehZYIW
	yQEnPXXpLsX369XmOwDKcCknj5PRwhU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778536492;
	b=yglY4kmCZzwXj1kmNEocAFn14F9/cE0mrYyL55ErYvFsxU6VAE1SDBbfg2zhOn3oozkrx+
	aoiEbELO5b+kKTfv3BZSA9phpx7jLkrc9eW6wOjMgCywa4JBFa1p3bJAWZlpiivoOtuJV/
	B8FZ92YvQqplW8/zTuZ5eMvHLg0CyUo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778536491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eLRy1FujxGe5XgQRkPK48pHdd+uw0DD2PI23JshhoIU=;
	b=KadkknWs3Uz4d8rbx/5SaprXRoawQyhGvi02ZLVoWI+3+ofHcEWn7Tc8Cxm/mOTv5wdAbn
	Eu8lmaECRllxbZx6xFeuI7iD4x2ZepWL9yjr3tyGDuOU6/f3maHXpA9Rz6lOk7+ZPqvVYZ
	hWLxO3nAwLteY9eLYGLqwDL/yWwZeTE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] adapter: add BCAA UUID also when seen device is not discoverable
Date: Tue, 12 May 2026 00:54:47 +0300
Message-ID: <a03d5b481c87d86d2bd2bdb376729ea6c4f992a9.1778535912.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BAP v1.0.2 Sec 6.4 specifies Broadcast discovery uses observation
procedure (Core Vol 3 Part C Sec 9.1.2) which makes no reference to
device discoverability state.

However, if remote device does:

1. Send Advertising Data for some other UUID with General Discoverable
2. Send Advertising Data for BCAA UUID with no flags

then adapter.c:btd_adapter_device_found() creates device in step 1. but
in step 2. it ignores the BCAA UUID since the device exists but is not
discoverable; the monitoring=true special case applies only for
first-seen devices.  Consequently bap plugin fails to pick up the BCAA
stream.

This sequence was observed to be produced by BlueZ + btvirt.

Fix by monitoring also previously existing but currently non-connectable
devices with BCAA UUID.

Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/2812#note_3467783
Log:
--------------------------
@ MGMT Event: Device Found (0x0012) plen 17
        LE Address: 00:AA:01:00:00:42 (Intel Corporation)
        RSSI: invalid (0x7f)
        Flags: 0x00000000
        Data length: 3
        Data[3]:
        02 01 06                                         ...
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
...
@ MGMT Event: Device Found (0x0012) plen 39
        LE Address: 00:AA:01:00:00:42 (Intel Corporation)
        RSSI: invalid (0x7f)
        Flags: 0x00000004
          Not Connectable
        Data length: 25
        Data[25]:
        06 16 52 18 56 db 55 03 03 4e 18 0d 16 4e 18 00  ..R.V.U..N...N..
        ff 0f 0f 00 04 03 01 01 00                       .........
        Service Data: Broadcast Audio Announcement (0x1852)
        Broadcast ID: 5626710 (0x55db56)
        16-bit Service UUIDs (complete): 1 entry
          Audio Stream Control (0x184e)
        Service Data: Audio Stream Control (0x184e)
          Data[10]:
        00 ff 0f 0f 00 04 03 01 01 00
--------------------------
---
 src/adapter.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6df66b3e0..20f7c3e03 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7360,6 +7360,14 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 	discoverable = device_is_discoverable(adapter, &eir_data, addr,
 						bdaddr_type, &auto_connect);
 
+	/* Monitor Devices advertising Broadcast Announcements if the
+	 * adapter is capable of synchronizing to it.
+	 */
+	if (eir_get_service_data(&eir_data, BCAA_SERVICE_UUID) &&
+					btd_adapter_has_settings(adapter,
+					MGMT_SETTING_ISO_SYNC_RECEIVER))
+		monitoring = true;
+
 	dev = btd_adapter_find_device(adapter, bdaddr, bdaddr_type);
 	if (!dev) {
 		/* In case of being just a scan response don't attempt to create
@@ -7370,14 +7378,6 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 			return;
 		}
 
-		/* Monitor Devices advertising Broadcast Announcements if the
-		 * adapter is capable of synchronizing to it.
-		 */
-		if (eir_get_service_data(&eir_data, BCAA_SERVICE_UUID) &&
-				btd_adapter_has_settings(adapter,
-				MGMT_SETTING_ISO_SYNC_RECEIVER))
-			monitoring = true;
-
 		/* If ISO  Socket is enabled, monitor Devices advertising RSI
 		 * since those can be coordinated sets not marked as visible but
 		 * their object are needed.
-- 
2.54.0

