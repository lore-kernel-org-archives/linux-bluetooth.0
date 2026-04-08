Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1B3D903D
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672556; cv=none; b=FeD6GEeWXIZLoNibqzzBN9c4y67BsVPKtthIAonk5zsa0cLhFb+jRr/lCF0C3TO8vOBhMCwmbz/SEbz3IMP26tYRXMbrwU3co+qPy0oUZUdSLDC2V9mdpHJIA55sevkUbAPQitKtvNiW9+W7459jeE0q9rOrb8Utpj0kxs2GlcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672556; c=relaxed/simple;
	bh=vvIVXxuYZA/DLsldw1f1o9fskWHO2iOLMjvON84Jklk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pBbkXjDZxID2gHEkfC+mYX6uN5ASvVe8MdkqIjJ+M34T/gTSX0uRqk/RKnja51SXADobB6lHUrPf9y2olemKL7RB6VCjH2P5WkoJ5Mt6tfsN6iR3pwA2RlPvfmBzF3Tsz0mdl+FZUZX1c7u4quZRMbo1U3IvyT802o5RGRI0vcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ll0EAy1J; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll0EAy1J"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56d9c4f7f0bso9140e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775672553; x=1776277353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W57C0Ff/7KB3BDY19KQrtMw5EvzMtCbi5yFFybKv89o=;
        b=ll0EAy1J8oDji/vkIRaXlqz8urPSJ4JTh52dq4oxwJueZ+vHXqe4i8DJ9cK6leJboS
         uE95uWlPAjF9r1oXA9K35SY2Bke6wcoqF0JiUYpzT2Y4tDUZe93z4TTkOjU782HbRjU2
         x2iddQ0m6WGjLu2GVT1RrwLoJJT1ivtTHXxF/pDgam58HOHuoAnqBxlh/BFcTIy8qXX9
         1SHaWO2uxqvpNFvGZX/Z6vAkE23uUclUz9l+9YDq3qXIyrSw45APxr4KtXnho5hlUe+8
         foy/X5bQjeQMTZYfesAPyHNUfee6chpfNAtfrC20peNf6+6RhQVP4zJJAo7VOkiVXNLu
         tETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775672553; x=1776277353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W57C0Ff/7KB3BDY19KQrtMw5EvzMtCbi5yFFybKv89o=;
        b=kZbJnlc1clP+2zvIrkD77XshEe6JLiCwMIPstvwFzz/xF1BIEBJ5fCwv1qslKI5z5C
         dVdRF5FSenXHv51FXT+R4RHlyIBjjY5VUSkOMOYdXa3gNgeErCqrl/oJSs67QTHrjJGs
         ZiyTnM7r1TzIp400oT3DBqIol+zGBXCNzxkAWSpcSderOeKfYQWfBFC8xZ8jgjIofIlh
         5yhz/9M9+kGy+SkkTSGJ2N13yMbdN6jATVZE8reJM1XDJsIe2WXCCK/RaGcw3vfDaae5
         DPeW6uYa3EnhSvsrT9FJQOwNIj1/CijV3DQ8lLtUe1YobsSC/8MNKrPHr+iYrj1IkTLE
         FfCg==
X-Gm-Message-State: AOJu0YxphH0pB21MMMP7es3eCqe9p6U7FUwxia6RLnHqr0FiT/FFaVRe
	/BZAam3MyBtdlzBD/YZ4IBYUe2coICbZXowgJiWV/tGvtgNNk3QbR1l24M3XBn+784E=
X-Gm-Gg: AeBDieu6oi2WD1QqY9n0OwM5RvmXqLszsJK/rruNBaHaI1F6YiTPTMeOgaEJ2oJCvWz
	6puPShL8g0QhB93qQQcsS54TPxw/Gf+7cAGk8TmBqCV65ZVz+UKrJ9LxlRLAbT8qiDayrXl1mTp
	tH3axyMqVVQ//9PmqFcQUSW+MlDXkBnwCHCtaOhn0EinXPJhvR7I13A7MM0hvyL66ohjruPDTOE
	7/w0fJp3EcQFrOiY7p+24j6onZ0VbsL8y+BYrOuXWB2lvcTu3H9KCTw5pOwCFXHSYc5WVhwprIg
	eMXol2fEpeLCsBPiQ90dErC8BR7o+AF48dBaD5adm69u3Y/s0/RAGHFSO6V+vAloV8kkx0t+a5K
	vrOhFx6REGqf5eSbga31UQrSYehVLdHAj5+V6nwY93EruABkSPFBX5H2yHRKM362hNqxn1IPITU
	INoH5/pa1CJc3jHZJaHJvpfI2NQBdwkWrM0tv2uf+sQ/Enb7iSCDT1zkb7DnhjfP3hho56QrtVq
	317GOkF9dYAuL0XqQ==
X-Received: by 2002:a05:6122:a5c9:10b0:56e:e9cf:7134 with SMTP id 71dfb90a1353d-56ee9cfa0fbmr4908777e0c.3.1775672553425;
        Wed, 08 Apr 2026 11:22:33 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bce02f3sm20486962e0c.14.2026.04.08.11.22.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:22:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] device: Fix btd_device_connect_services not discovering
Date: Wed,  8 Apr 2026 14:22:21 -0400
Message-ID: <20260408182223.295711-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_device_connect_services would not attempt to discover in case the
selected bearer is BR/EDR and once discover is complete then it shall
proceed with connecting the services.
---
 src/adapter.c |  9 ---------
 src/device.c  | 27 +++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 04568dae6e98..46b89526fcaf 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3686,14 +3686,6 @@ struct device_connect_data {
 	DBusMessage *msg;
 };
 
-static void device_browse_cb(struct btd_device *dev, int err, void *user_data)
-{
-	DBG("err %d (%s)", err, strerror(-err));
-
-	if (!err)
-		btd_device_connect_services(dev, NULL);
-}
-
 static void device_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct device_connect_data *data = user_data;
@@ -3726,7 +3718,6 @@ static void device_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	}
 
 	device_discover_services(device);
-	device_wait_for_svc_complete(device, device_browse_cb, NULL);
 
 	g_io_channel_unref(io);
 	dbus_message_unref(data->msg);
diff --git a/src/device.c b/src/device.c
index cfbde307bcc9..e762aea2797c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2705,6 +2705,17 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	return dev->bdaddr_type;
 }
 
+static void device_browse_cb(struct btd_device *dev, int err, void *user_data)
+{
+	DBG("err %d (%s)", err, strerror(-err));
+
+	/* If there are not errors with discovery proceed conecting services */
+	if (!err) {
+		dev->pending = create_pending_list(dev, NULL);
+		connect_next(dev);
+	}
+}
+
 int btd_device_connect_services(struct btd_device *dev, GSList *services)
 {
 	GSList *l;
@@ -2724,8 +2735,20 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services)
 		return device_connect_le(dev);
 	}
 
-	if (!dev->bredr_state.svc_resolved)
-		return -ENOENT;
+	if (!dev->bredr_state.svc_resolved) {
+		int err;
+
+		err = device_discover_services(dev);
+		if (err)
+			return err;
+
+		/* Wait for service discovery to complete before connecting to
+		 * profiles.
+		 */
+		device_wait_for_svc_complete(dev, device_browse_cb, NULL);
+
+		return 0;
+	}
 
 	if (services) {
 		for (l = services; l; l = g_slist_next(l)) {
-- 
2.53.0

