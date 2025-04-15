Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D82DFA20
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753703; cv=none; b=lfLYWyiJrq0a2Lujqo2t6lqxLyLGe3hddf7mUXv7LgYM5I759ZxcBqcnLOL4/m1GebJ7E3IS6m5Ak6HbyvTgt3G+Vw8iIVoSj/E4gpeXwc+lIiw4DhbncR5g91M6LwHzcaQY0EOIApfzVrH7PWjfLxRm5DMVUTNY8qXx8lI9hQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753703; c=relaxed/simple;
	bh=3+SxI0tRGsZen8RqG1GYkdm0sHlmXTSVu/oAkMr6lhc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtyCV2gFEWmIBgysCyAl7zVTebboy9vbvXoxhecu4ygeXPuOoDBxkbUDST9/NkPdoQ+YiHpfjUh3pB5/ZBIoVLKR/0YBGv/kAGzNlZ1oszFNxGs3093ZM35GJ6gSG15xpOxPbzITgVKiTKtlii/DF5LcrsXfrq7SByOJnmsv2Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgzK2Qvp; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgzK2Qvp"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-525b44b7720so2409763e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 14:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744753699; x=1745358499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFGMeZBaefAMiSCCYV7Imgs0fduQDzHhyo9+GmpG6KA=;
        b=hgzK2QvpPKIybQ7p4k77cBfxVfqiT+Drm+UeKK+BXV9KV4Cj11w7wY/srUo+bZ7S4P
         ztY5YXyS2YYapBaYGGo3u6YcKhCw2H4JdmYCZV5bJCE60CQjl6bLOSlcT5JawoECpDx5
         Sk1KrFZtrsroteZf0+GkOnVatwQFNK19UWHk4X9XxvbV6U1rzKlEFX2p7MMDVW+IMrVv
         IjPqwGw3DjraBflKflX8G5onUtp9EqiNKuX7jc3MRfJt09XzoF3Hy5Bo8V+egBHl1HXY
         HVTFJT9/ajY3YbEvhzJ313x4FjPguojwOllopaA1vQgTAxX2rqQlbJZ27OoN475A+tCz
         j0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744753699; x=1745358499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFGMeZBaefAMiSCCYV7Imgs0fduQDzHhyo9+GmpG6KA=;
        b=S4R08JuLqxitokjK58EJOEN/sga3uS3sqvdsabt19Oj+m7ZRWQkxPsjOunGSm+O+bJ
         BqsrwXrF9ss9LTWBvpfX7YpMatEDs7MtfgABGrs2iVxFoK644XtADDNc056xwMtgubVY
         HSemXLA2EkwJ6XmZMnL6zyOUjmmsyApH7idFq8hPS3+250pdnWHW/6+4hvTKeIP6guv3
         8anX5UoMQX/XDVb7YwuxmGHdzEKiFo4fIdIICckrP8aXqAg9Ub1IWjnlWXaKCGNLI9VS
         3ne1f8uea6ngPlO45V5/nMR3XXg8XlfAx0iGgzn/hrIc9MdD2Grgf/UV9/+e7S1xSLg1
         mEFQ==
X-Gm-Message-State: AOJu0YxR2JsPcE9NMQ6cD6/kXA/qaXZlq5TRYqU+dUPWqdvNG6zsGBbs
	bNh8Dus6gqzcKx6H5fGdhETqZXuqcqlv0Cf212/aXm3YQRbaXKzW+kLrh15auEM=
X-Gm-Gg: ASbGncu4XdL1qQ7JQOoZydT6IFR9HOJtDLz89zJ5beq3XRtEbc6HWnEQNbv6OD48zzQ
	WjP19x2gqnAUZKRIDxMCG/eszgLr9MP8oCIe4VuSWpM7iGlakuhV/CVl1ulPAfSgqUzEZ4pH71N
	+i6VUn9he0vZwcBR5UHg2ErJp9vseZRFt24u+q8iKnWBtPZhoyVJgjjhCZmfhy25az/iEOM8M81
	rlitUAK6x1Whbisd1U7TrPH1o7DaVK2FG7f4d8DcB/zO6/rVZMDsFRH/ZZSn7Ne/YSFh54yW3vK
	g8mlViqB9JtCennHWcbakQFzXwzvdo5UmgcLDaUWX4OpwlPB+hZb2HNkOrzb/y7pbZ4wulWvESJ
	qsUeefHN9Ew==
X-Google-Smtp-Source: AGHT+IFEXdUgMJjOfzPzyBKTVt9Aps/WjJLwIJBCG0zMHd+FUte0VTPVShld7gnif3KTSqOZHqsqJA==
X-Received: by 2002:a05:6122:a0c:b0:526:19e6:fa34 with SMTP id 71dfb90a1353d-529091060dbmr761537e0c.1.1744753699310;
        Tue, 15 Apr 2025 14:48:19 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8d740sm2844459e0c.33.2025.04.15.14.48.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 14:48:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/7] btdev: Fix not matching SID on le_pa_sync_estabilished
Date: Tue, 15 Apr 2025 17:48:06 -0400
Message-ID: <20250415214811.1677842-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415214811.1677842-1-luiz.dentz@gmail.com>
References: <20250415214811.1677842-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order to estabilish a PA sync the advertising SID must match:

7.8.67. LE Periodic Advertising Create Sync command:

'The Advertising_SID parameter, if used, specifies the value that shall match
 the Advertising SID subfield in the ADI field of the received advertisement
 for it to be used to synchronize.'
---
 emulator/btdev.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index a1c82ae306d7..76bae5ea1ab3 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -105,12 +105,14 @@ struct le_ext_adv {
 	uint8_t scan_data_len;
 	unsigned int broadcast_id;
 	unsigned int timeout_id;
+	uint8_t sid;
 };
 
 struct le_per_adv {
 	struct btdev *dev;
 	uint8_t addr_type;
 	uint8_t addr[6];
+	uint8_t sid;
 	uint16_t sync_handle;
 };
 
@@ -4923,6 +4925,7 @@ static int cmd_set_ext_adv_params(struct btdev *dev, const void *data,
 	ext_adv->direct_addr_type = cmd->peer_addr_type;
 	memcpy(ext_adv->direct_addr, cmd->peer_addr, 6);
 	ext_adv->filter_policy = cmd->filter_policy;
+	ext_adv->sid = cmd->sid;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
 	rsp.tx_power = 0;
@@ -5019,6 +5022,7 @@ static void send_ext_adv(struct btdev *btdev, const struct btdev *remote,
 	/* Right now we dont care about phy in adv report */
 	meta_event.lear.primary_phy = 0x01;
 	meta_event.lear.secondary_phy = 0x01;
+	meta_event.lear.sid = ext_adv->sid;
 
 	/* Scan or advertising response */
 	if (is_scan_rsp) {
@@ -5420,17 +5424,32 @@ static bool match_dev(const void *data, const void *match_data)
 						per_adv->addr_type);
 }
 
+static bool match_sid(const void *data, const void *match_data)
+{
+	const struct le_ext_adv *ext_adv = data;
+	uint8_t sid = PTR_TO_UINT(match_data);
+
+	return ext_adv->sid == sid;
+}
+
 static void le_pa_sync_estabilished(struct btdev *dev, struct btdev *remote,
 						uint8_t status)
 {
 	struct bt_hci_evt_le_per_sync_established ev;
 	struct le_per_adv *per_adv;
+	struct le_ext_adv *ext_adv;
 	uint16_t sync_handle = SYNC_HANDLE;
 
 	per_adv = queue_find(dev->le_per_adv, match_dev, remote);
 	if (!per_adv)
 		return;
 
+	/* Match SID */
+	ext_adv = queue_find(remote->le_ext_adv, match_sid,
+					UINT_TO_PTR(per_adv->sid));
+	if (!ext_adv)
+		return;
+
 	memset(&ev, 0, sizeof(ev));
 	ev.status = status;
 
@@ -5701,8 +5720,8 @@ static int cmd_ext_create_conn_complete(struct btdev *dev, const void *data,
 	return 0;
 }
 
-static struct le_per_adv *le_per_adv_new(struct btdev *btdev,
-			uint8_t  addr_type, const uint8_t *addr)
+static struct le_per_adv *le_per_adv_new(struct btdev *btdev, uint8_t addr_type,
+					 const uint8_t *addr, uint8_t sid)
 {
 	struct le_per_adv *per_adv;
 
@@ -5711,6 +5730,7 @@ static struct le_per_adv *le_per_adv_new(struct btdev *btdev,
 	per_adv->dev = btdev;
 	per_adv->addr_type = addr_type;
 	memcpy(per_adv->addr, addr, 6);
+	per_adv->sid = sid;
 	per_adv->sync_handle = INV_HANDLE;
 
 	/* Add to queue */
@@ -5735,7 +5755,7 @@ static int cmd_pa_create_sync(struct btdev *dev, const void *data, uint8_t len)
 	}
 
 	/* Create new train */
-	per_adv = le_per_adv_new(dev, cmd->addr_type, cmd->addr);
+	per_adv = le_per_adv_new(dev, cmd->addr_type, cmd->addr, cmd->sid);
 	if (!per_adv)
 		status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
 
-- 
2.49.0

