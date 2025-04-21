Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423BF2627E2
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234031; cv=none; b=ZUxU8n9Lc/FhitCzZQYG9V3BN433QgcmR/9nnOUadCAJMQAGwbs43kvd86VDPX26RlPVun6/S6E1V/Er7bzY9TVhwGA96uWUjFMWdK04To32UQXIwaI84L/wJdUQN49hFC/Fc0foHYeseYYDpNQ5Vh2wJNEaoLrL4qeudsJnlgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234031; c=relaxed/simple;
	bh=uyiaTkqyRA79UvhhJaU5tQNx2Ty//3tdGJyAtJFejAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsJnUs28CZpjTOfBj4RvB8/KNUnLgiVMaTpD6RBMAzcaj7+fawOpkWYd9VD3QvynqqSuyl0yTuBGGjwFFAX9NRyQh8YZ2rHLe9YxcaDYncKapUKYgxFHZlg+YQwLM15uEISxh3fb3zMkPl7Kv0zsTvoLpcOBNIrkSmwIs3Dhpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U2X30y4V; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U2X30y4V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745234027;
	bh=uyiaTkqyRA79UvhhJaU5tQNx2Ty//3tdGJyAtJFejAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2X30y4Vr7a1DQWVEbcsNWvADcNEwKe9K6rDrTeoxM6u+9H/LUCMF6oAeQfBzSCDZ
	 g7wox0gZ6/lBOhFugOhTiXqL5Lr2BtuUXVwUYWLcKnH/RY8DW7m2nlyne2c9AWzMUG
	 g/JaF66tt2yTbblYqDbI/Jof5AYvm96dN4kFUuXWcv7YVZeeTYPjsu9mR2rYxeJkAy
	 PPR+F6eLNwWvp8PZS7oOpGHqlmO828CeGDs9d+Np/Y4Gqr82eXbdFeLkZF2l4BGbpP
	 +PdRbwB+pgBmPf7TSc3MOqKiELib1w1LvNIRsgwMpmdp9kvc8WrZdSyrO093F5lHQ/
	 NsJc9T+RevNxQ==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3EDB817E09B5;
	Mon, 21 Apr 2025 13:13:47 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ 4/5] input: Start the server with sec low and bump it when making the connection
Date: Mon, 21 Apr 2025 13:12:50 +0200
Message-ID: <20250421111251.108943-5-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421111251.108943-1-ludovico.denittis@collabora.com>
References: <20250421111251.108943-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BT_IO_SEC_LOW is the only way to allow Sixaxis devices to establish
a connection.

When BlueZ has been compiled with Sixaxis support enabled, we start the
listening input server with BT_IO_SEC_LOW to avoid breaking the Sixaxis
support.
Then, in `hidp_add_connection()`, we check if either
`classic_bonded_only` was disabled or if this device is a Sixaxis. If
neither are true, we bump the security back to BT_IO_SEC_MEDIUM, i.e.
enforcing encryption.

This allows supporting the Sixaxis gamepad without having to change the
classic bonded only option.
---
 profiles/input/device.c | 6 ++++--
 profiles/input/server.c | 7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 3627573e7..eb2fb5c8e 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1088,8 +1088,10 @@ static int hidp_add_connection(struct input_device *idev)
 	if (device_name_known(idev->device))
 		device_get_name(idev->device, req->name, sizeof(req->name));
 
+	sixaxis_cable_pairing = device_is_sixaxis_cable_pairing(idev->device);
+
 	/* Make sure the device is bonded if required */
-	if (classic_bonded_only && !input_device_bonded(idev)) {
+	if (classic_bonded_only && !sixaxis_cable_pairing && !input_device_bonded(idev)) {
 		error("Rejected connection from !bonded device %s", idev->path);
 		goto cleanup;
 	}
@@ -1098,7 +1100,7 @@ static int hidp_add_connection(struct input_device *idev)
 	/* Some platforms may choose to require encryption for all devices */
 	/* Note that this only matters for pre 2.1 devices as otherwise the */
 	/* device is encrypted by default by the lower layers */
-	if (classic_bonded_only || idev->type == BT_UHID_KEYBOARD) {
+	if (!sixaxis_cable_pairing && (classic_bonded_only || idev->type == BT_UHID_KEYBOARD)) {
 		if (!bt_io_set(idev->intr_io, &gerr,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_INVALID)) {
diff --git a/profiles/input/server.c b/profiles/input/server.c
index 79cf08a66..73caeb076 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -273,6 +273,13 @@ int server_start(const bdaddr_t *src)
 	BtIOSecLevel sec_level = input_get_classic_bonded_only() ?
 					BT_IO_SEC_MEDIUM : BT_IO_SEC_LOW;
 
+#ifdef HAVE_SIXAXIS
+	/* Lower security to allow the Sixaxis gamepad to connect. */
+	/* Unless classic bonded only mode is disabled, the security level */
+	/* will be bumped again for non sixaxis devices in hidp_add_connection() */
+	sec_level = BT_IO_SEC_LOW;
+#endif
+
 	server = g_new0(struct input_server, 1);
 	bacpy(&server->src, src);
 
-- 
2.49.0

