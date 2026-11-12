Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451147;
	b=XtEQ6f8eLhAvoJdg9XoIQZwh6BAz+EaE2xAL9jN9Izw1flmezya58do2sAxmeedCF3Gj
	 MFNSWJMnBcjNQE+pyg5rC+Gdpr5AkO5rHC4+ZfCSiF2BsNbe/zZaBb/nWonreM2ezGMNX
	 iQp7KEbd0Df9z2tx+semdBB7/6fEEJVmdUPTc3Ianq4xGDv5seInDLL4l0Aj2ZaKRtRzp
	 7TfWPDDEDTjub2Kr7pSkNv8wTD+UzJDvk8c6/TbS8SZ/qiVXYEeeKfm0VyvC0+xauoued
	 BH/ZL4o2cqhGu/38dVYPH4RY7q7vs/i8Q9Ps7HeRKo9W6m/5Gku/Ic5TqF8A8prnD+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QZ3rraioebdUeCNwMhzMOUwSr0RCPcqwXnR69Jd2Us0=;
	b=QIrBYHkzCUHpWs5YV4qSqAwLESa3pz/q5RrSduEWqXQJ3fuhGi7jMp7mhct8p6ryI18b
	 hV4hd06O6EpfGYfs991KDkt+3QrNA8+df5ZqFeqXdx7UqnlZJ2K5Z5csvA7Zoq/AJLGjv
	 WaPevgbk8SfeWsqpQ7bDHeDqoIt12Fi5+I69AdDcGfZls9BtVOBvZ00t6zPeS6R/ckaSp
	 maFH+FUuRfFQJCKZdVAUs3PIylgrxdHMZtJN3YGLF/tJ/vvBPbdJi5vb/Mnil5mg0yhG4
	 2sdE8SNmRzJSIMK+7OZ+xDOA9sxD16fEDsPD64OHDhd7jZmcK7serRAO+kHCwLVwGCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QSG6hVw5;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE9A606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 02:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CE9A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QSG6hVw5
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-170135e43c7so2028128c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 18:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794451146; x=1795055946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QZ3rraioebdUeCNwMhzMOUwSr0RCPcqwXnR69Jd2Us0=;
        b=QSG6hVw5XpXr+DiPM15iNrzXRYL2tTTHBiasa0rVaY+/elwJ/+lGWjrCC3gLPvylTm
         yU4wYBL7J7aM9nomjM5qENJeaKu9AVuaT7xJ8oPnWWtsQquUqCI2mQ3TYwRhAQiKpAxv
         wlJXkoomSTIX7+DS3zvd1XXryMN3Rrps9AHLmIklDwakP6WBOnP0/gUzWtFDV7OL+SNZ
         8cXPGucKe6g9dmNr5Viw1xZjfuhFi58e1Jew1JRV+E0HMtQwkG2JRUJoMBNfxSPUeSKi
         QL1VYgFEIzYW0rk8024YCit2NHFUXHlGzRaO6q6Y/0R3+FXHEbmNOegg9H189KloewX6
         3T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794451146; x=1795055946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QZ3rraioebdUeCNwMhzMOUwSr0RCPcqwXnR69Jd2Us0=;
        b=kt8Zh2AuxZQnsA9ull42ECRaG1kJgRkoe+UMjEeQVEhIDfeP02Y7mF8ju2YRh6Y9I7
         vW/HlMWpONzRrGRdIjUYsGZonxXJ5IeQR1u5C5uEX3xyXEJv6f9s6m/uGB2UdwR+nbRR
         jMlE72inLzaxQkx+DsIoQPD5SbH+FrsDWISBCliHac4bmY9IxdTzyM5Fid9On1BBnIl7
         QhLOJvzdSquCXyJZSd2rRk+Qjf2OqAzhpgSCVai5DN3LVEhoSeckfe6LHiz23CQ7SLzQ
         DhELkHaGQClPjWxHZG+lJ0AxFcj17s40zPt/i/URt9vG+lZfejv/rIOcU4eLuLjSZTud
         rSJQ==
X-Gm-Message-State: APuU4Z9aLLzwZBuIKNaiOqDM8HKktBoqgc6AJjgCaHpqIaj4XsewYPam
	l20Airy3JrksPUk49XH3/nWYetJuaE7ncGS/ow4QbxddB26JRN9WiJTlBTj09y3lbAE=
X-Gm-Gg: AYBFou1ZfFW+AddJ7RzmuFMoug8DX/0jVjQRO1CbvKKcVHia/LGoPwAop0tP0BfaVUe
	qmYMsr3IQrM26rTbfVuAvrRuJPhEm17sz7vUa+roPxXADANHdBthstZJBA0W1KvZVMGTVloySY2
	0Uc84kmgca4whNHtA7PS8+ZSrocqeLOqhfJEKyFdg2cuNLAIuWijVJ8f4OB91uzz2F+ZGyqMmef
	yEjNfY71m8BahavpR8e2tczAZDPMFszLh9srrsrGHd3YrOUdWgsJx2wPFfVnFLJFuHAAgy9KMCg
	P2zD2CPWLa4BKOY9uTLCZsmJZgXOysI77R4pm2XSbhdkJAbHkJyhNDCnXbTfupWlC71ciwuu4/7
	zPewxmK2nqiVuc8gy8+lWYNCL/1Nfzk24jS3sbwokGRYYwTI8bY0AUlqTMEmiKAnP0PE8M0qZEp
	S7GjlS0X70BPXIPUAO1JWNLpQuq5rpkdi1Bgf4WYWs8wMi2vJ4a69BvpjRV+tD0gwnF8lbrkpOu
	iefeR04/rUGw7DA6jKe7BiiItLVpOmxoD6iG4s9rTRZ6V6DMQT3dD1TtSpz8BBmU+0Y/6uVzJVU
	dsCBgN24ojc4e61Ywe4AqsxjOVJfIRgZf9h5vrTMC++f+iAkNQXPubAYtfQK57qOzbbQhaLsr+I
	=
X-Received: by 2002:a05:7022:f902:20b0:1b3:a9c0:6a3e with SMTP id a92af1059eb24-1b3c032e5f1mr4385537c88.29.1794451146356;
        Wed, 11 Nov 2026 18:39:06 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4efc2sm17819912c88.15.2026.11.11.18.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:39:05 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weihong Guan <weihong.guan@gmail.com>
Subject: [PATCH BlueZ 1/2] emulator: Set the number of advertising sets
Date: Thu, 12 Nov 2026 02:38:57 +0000
Message-ID: <20261112023858.892176-2-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112023858.892176-1-weihong.guan@gmail.com>
References: <20261112023858.892176-1-weihong.guan@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btdev reports MAX_EXT_ADV_SETS (3) in LE Read Number of Supported
Advertising Sets and allows that many sets. A controller may support a
single set (the command's range is 0x01 to 0xF0), and the kernel then
gives advertising instance 1 handle 0x00, the handle Global Advertising
uses too; bugs on that path don't show with three sets.

Add btdev_set_adv_sets() and hciemu_set_central_le_adv_sets() to report
and allow fewer sets, kept across HCI_Reset as a controller keeps its
capabilities.

Assisted-by: Claude:claude-opus-5.5
---
 emulator/btdev.c  | 18 ++++++++++++++++--
 emulator/btdev.h  |  2 ++
 emulator/hciemu.c | 14 ++++++++++++++
 emulator/hciemu.h |  2 ++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7a8d8a4..d7f9e5e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -280,6 +280,8 @@ struct btdev {
 	uint16_t le_rl_timeout;
 
 	struct queue *le_ext_adv;
+	/* Number of advertising sets reported, kept across HCI_Reset */
+	uint8_t le_adv_sets;
 	struct queue *le_per_adv;
 	struct queue *le_big;
 
@@ -576,6 +578,17 @@ void btdev_set_rl_len(struct btdev *btdev, uint8_t len)
 	btdev->le_rl_len = len;
 }
 
+/* Set the number of advertising sets, 1 to MAX_EXT_ADV_SETS */
+bool btdev_set_adv_sets(struct btdev *btdev, uint8_t num)
+{
+	if (!num || num > MAX_EXT_ADV_SETS)
+		return false;
+
+	btdev->le_adv_sets = num;
+
+	return true;
+}
+
 static void conn_unlink(struct btdev_conn *conn1, struct btdev_conn *conn2)
 {
 	conn1->link = NULL;
@@ -5350,7 +5363,7 @@ static int cmd_set_ext_adv_params(struct btdev *dev, const void *data,
 						UINT_TO_PTR(cmd->handle));
 	if (!ext_adv) {
 		/* No more than maximum number */
-		if (queue_length(dev->le_ext_adv) >= MAX_EXT_ADV_SETS) {
+		if (queue_length(dev->le_ext_adv) >= dev->le_adv_sets) {
 			rsp.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
 			cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
 						&rsp, sizeof(rsp));
@@ -5707,7 +5720,7 @@ static int cmd_read_num_adv_sets(struct btdev *dev, const void *data,
 	memset(&rsp, 0, sizeof(rsp));
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.num_of_sets = MAX_EXT_ADV_SETS;
+	rsp.num_of_sets = dev->le_adv_sets;
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS, &rsp,
 							sizeof(rsp));
 
@@ -8420,6 +8433,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	btdev->le_al_len = AL_SIZE;
 	btdev->le_rl_len = RL_SIZE;
+	btdev->le_adv_sets = MAX_EXT_ADV_SETS;
 	return btdev;
 }
 
diff --git a/emulator/btdev.h b/emulator/btdev.h
index aa04ca6..b40df29 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -95,6 +95,8 @@ void btdev_set_al_len(struct btdev *btdev, uint8_t len);
 
 void btdev_set_rl_len(struct btdev *btdev, uint8_t len);
 
+bool btdev_set_adv_sets(struct btdev *btdev, uint8_t num);
+
 void btdev_set_command_handler(struct btdev *btdev, btdev_command_func handler,
 							void *user_data);
 
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 2f544f3..eb791fa 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -701,6 +701,20 @@ void hciemu_set_central_le_rl_len(struct hciemu *hciemu, uint8_t len)
 	btdev_set_rl_len(dev, len);
 }
 
+bool hciemu_set_central_le_adv_sets(struct hciemu *hciemu, uint8_t num)
+{
+	struct btdev *dev;
+
+	if (!hciemu || !hciemu->vhci)
+		return false;
+
+	dev = vhci_get_btdev(hciemu->vhci);
+	if (!dev)
+		return false;
+
+	return btdev_set_adv_sets(dev, num);
+}
+
 const uint8_t *hciemu_get_central_adv_addr(struct hciemu *hciemu,
 								uint8_t handle)
 {
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index cdf1ebe..7299763 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -80,6 +80,8 @@ void hciemu_set_central_le_al_len(struct hciemu *hciemu, uint8_t len);
 
 void hciemu_set_central_le_rl_len(struct hciemu *hciemu, uint8_t len);
 
+bool hciemu_set_central_le_adv_sets(struct hciemu *hciemu, uint8_t num);
+
 const uint8_t *hciemu_get_central_adv_addr(struct hciemu *hciemu,
 							uint8_t handle);
 
-- 
2.47.3

