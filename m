Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAE946447
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747221665; cv=none; b=np19UCE/hRDBg8aLjJ1562nfpwUoQ7/rg7RTM7XbmpF1cFMGjRzlMrfopR5mDbVGB64WoSHHpUIs+34Jfgh6rdiWFKvKLTpK96o5zjyDq4HZQAOV/hqew/K0Ai+pSFK57O7tXDxEFh+jlZgfH3rzHISOZNcRVzL3cBZZ+LmIt6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747221665; c=relaxed/simple;
	bh=nTjW2v5IMH2XSa7fyK4qni5zP9uwyNCvXpcqCCVtYtU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aVzEVf05z+4HQYIbEipOIxf8Yt49qM2PzQi8eWNLiM/g87iGXNzD4ZqrmKQZCHY0+Sey2umPvRZegeZZqTfjB+06XHZwxqhTYpHkGbrtQKu4tvixtEgU61MVKPOl5ui6OqtiyOJCQHV1PSOUTV09GxxuvbxlYNTrNgeHn/iSq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lmUp+0qA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lmUp+0qA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747221660;
	bh=nTjW2v5IMH2XSa7fyK4qni5zP9uwyNCvXpcqCCVtYtU=;
	h=From:To:Subject:Date:From;
	b=lmUp+0qAJ6034dus2YYmWCuWzU/GcvX7eQzYP0gwmTNbHgOSuw59Uxa0Yuoy2b72q
	 pehh66M8klcHAVoYHvSE1trPXnwkaVmPXjGZikKUmEAuBH//DEJu7wfviw3jF+vmnR
	 P4zHKvaAGxAW2AsfM2islyD6pxcplzLZqSX7XEeQZ3lgjdsBYn8nclJ5b9WSxQ5o4c
	 ePrg9V3ppmzysJkHXi2uuHlr1yjjHL/i/+uChpXJKyBFpBioE4OGI5HaftuW6Hlntf
	 mpoberJk3ohf3dXffXS+MW2CnHvMD1rxu8PJR9bzfBK2xtIfD+WHqkZNZC1nF3rHzY
	 frgMdKai4SD/g==
Received: from fdanis-ThinkPad-X1.. (2A02-8440-e504-5543-8e09-0b99-cB4C-00e7.rev.sfr.net [IPv6:2a02:8440:e504:5543:8e09:b99:cb4c:e7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6BA6817E02BE
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 13:21:00 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Reply br-connection-key-missing on connection bonding error
Date: Wed, 14 May 2025 13:20:50 +0200
Message-ID: <20250514112050.17438-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently when connection is removed while the client is waiting for
Connect() the failed message is br-connection-canceled, even if this
is due to bonding error.

This commit reply br-connection-key-missing when connection request
fails due to bonding error, allowing the client to differentiate
connection failure reasons.
---
 src/device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/device.c b/src/device.c
index c364d72c3..816282eab 100644
--- a/src/device.c
+++ b/src/device.c
@@ -246,6 +246,7 @@ struct btd_device {
 	struct browse_req *browse;		/* service discover request */
 	struct bonding_req *bonding;
 	struct authentication_req *authr;	/* authentication request */
+	uint8_t		bonding_status;
 	GSList		*disconnects;		/* disconnects message */
 	DBusMessage	*connect;		/* connect message */
 	DBusMessage	*disconnect;		/* disconnect message */
@@ -3636,6 +3637,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 	DBusMessage *reply;
 	bool remove_device = false;
 	bool paired_status_updated = false;
+	uint8_t bonding_status = device->bonding_status;
 
 	if (!state->connected)
 		return;
@@ -3643,6 +3645,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 	state->connected = false;
 	state->initiator = false;
 	device->general_connect = FALSE;
+	device->bonding_status = 0;
 
 	device_set_svc_refreshed(device, false);
 
@@ -3658,6 +3661,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 	if (device->connect) {
 		DBG("connection removed while Connect() is waiting reply");
 		reply = btd_error_failed(device->connect,
+				bonding_status ? ERR_BREDR_CONN_KEY_MISSING :
 						ERR_BREDR_CONN_CANCELED);
 		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
@@ -6763,6 +6767,8 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 
 	DBG("bonding %p status 0x%02x", bonding, status);
 
+	device->bonding_status = status;
+
 	if (auth && auth->agent)
 		agent_cancel(auth->agent);
 
-- 
2.43.0

