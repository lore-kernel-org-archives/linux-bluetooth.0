Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0199935F17A
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Mar 2026 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772974106; cv=none; b=WWb9QeTQjWw9TX+Cf54xTdTEJAfwJ26x7g6NEisVfb+7eW45qekiylGSuucSoLY7GZL016DpwEgVqd7y2qk6HCE+8eGbV+Q67hLoG+86pYefrmuUJbyztEKBFW9CakbVw3/S0OahSRXDMzjL8VUIBLiB5Qq3IjAZkex7bJ0vihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772974106; c=relaxed/simple;
	bh=Y0fWd/7jbrN22NPp2Z/sGpm4LMChK3vJaXvD3yaEVfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVB8Ah5yaXWm6n3htC8nYnnuW3XPlOY4SqFnzkRyRhRpQUAP9oFCej8gz22R5DxRGvqWsBaTr9mDaj3Dlq2p8c9TmvF3YrtP8tXW6F1bYleyTzbYogUwSPKSRclcty8KsNFcg6iOcCNOOUGcVe1hMo7aGFxZoi68vyv2XM0xdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=Qb3g+jCr; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="Qb3g+jCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1772974102; x=1773578902; i=martinbts@gmx.net;
	bh=vXM0tjnJzNciJMb/G2KwPpEp09LpQlWlxwe6UavyOnQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Qb3g+jCrO381JqOfF/JGSWeiqCzqtnoGC3jRtK+0cEP42iXI08IRezN5zk0qZdMU
	 CNYUh3i63CSpKZK2WFOANl8rZPqcRAqsn8SpSsh0YKh7DRkf6WbCTiKQEgTZvnKOA
	 sPYUGC0pvdXPkhpcd6VtZ68CbrN1/xgGJ2rYpj92dUk8FOtRK1qHX2uD5XMGr5eSp
	 2fFTxgysHhYEn2HSe8AnJ18NcXvjNfYUXSaRCR1YB/sTlI1aAQjUmxF+zM/E5xRRr
	 n637gNUAcoqF8Fu0x//HexL7F14HbmSu4GEpAGpKSxrPi6uaBIoQnVkAbxtri6JGN
	 qq91glu95cBHrwMULQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1vI96p0jXB-00divw; Sun, 08
 Mar 2026 13:48:22 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v2 2/6] device: allow skip secondary discovery
Date: Sun,  8 Mar 2026 13:47:39 +0100
Message-ID: <20260308124745.19248-3-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260308124745.19248-1-martinbts@gmx.net>
References: <20260308124745.19248-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M2H0Cx2zGPnzOoLcKO8Nf0GbMbppGkshfNlhX7Qg6zjhVWa0Pmt
 MiyGqmqMPnYQSCaP9tCC5M166NZbmxsPoJkJBferg/4HgUOCtwGpwUAvnzAQZs+SZFbRkX3
 5mohiLWBW8QwWR2ugMrssulP0Lp2Trlccp3RbUhn6xOWpmBUNzRetTW3C4F0nTa8AvalSPc
 Vk7inE/h2XN4wnNoFQfRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wfafIBjeQLQ=;UeICViw1cB0E1yFDESTmqneUPvI
 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
 6AZ+qX8afCyXzOIs4Ggo8B+KAZWPO

* Introduce new btd_device field skip_secondary
* Introduce public skip_secondary setter
* Use new gatt client interface to push device->skip_secondary into
  device->client->skip_secondary after new() but before init()
* Doing secondary service discovery is now a device property that can be
  set by device specific plugins.
=2D--
 src/device.c | 18 ++++++++++++++++--
 src/device.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 3ea683667..4c2c0b635 100644
=2D-- a/src/device.c
+++ b/src/device.c
@@ -275,6 +275,7 @@ struct btd_device {
 	struct gatt_db *db;			/* GATT db cache */
 	unsigned int db_id;
 	struct bt_gatt_client *client;		/* GATT client instance */
+	bool		skip_secondary;
 	struct bt_gatt_server *server;		/* GATT server instance */
 	unsigned int gatt_ready_id;
=20
@@ -5113,6 +5114,11 @@ void device_get_name(struct btd_device *device, cha=
r *name, size_t len)
 	}
 }
=20
+void btd_device_set_skip_secondary(struct btd_device *device, bool skip)
+{
+	device->skip_secondary =3D skip;
+}
+
 bool device_name_known(struct btd_device *device)
 {
 	return device->name[0] !=3D '\0';
@@ -6301,10 +6307,18 @@ static void gatt_client_init(struct btd_device *de=
vice)
 		bt_att_set_security(device->att, BT_ATT_SECURITY_MEDIUM);
 	}
=20
-	device->client =3D bt_gatt_client_new(device->db, device->att,
-						device->att_mtu, features);
+	device->client =3D bt_gatt_client_new(device->db, device->att, features)=
;
 	if (!device->client) {
+		DBG("Failed to create gatt client");
+		return;
+	}
+
+	bt_gatt_client_set_skip_secondary(device->client,
+						device->skip_secondary);
+
+	if (!bt_gatt_client_init(device->client, device->att_mtu)) {
 		DBG("Failed to initialize");
+		gatt_client_cleanup(device);
 		return;
 	}
=20
diff --git a/src/device.h b/src/device.h
index c7b8b2a16..19f270388 100644
=2D-- a/src/device.h
+++ b/src/device.h
@@ -22,6 +22,7 @@ char *btd_device_get_storage_path(struct btd_device *dev=
ice,
=20
=20
 void btd_device_device_set_name(struct btd_device *device, const char *na=
me);
+void btd_device_set_skip_secondary(struct btd_device *device, bool skip);
 void device_store_cached_name(struct btd_device *dev, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 bool device_name_known(struct btd_device *device);
=2D-=20
2.47.3

