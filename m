Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954020F06C
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819484; cv=none; b=Hyz0X4BRzwgpbvAB53kCQUtEeRiGILzIrx7UWwg0dZvynRhzmpOsbcKwfJEYRUJzc+8vwZGX0ToFn0Au58hzqa0eXqJ7bYeFBc+CSOMr+46svrlZZEb2MZl716YJSmr6idkQUh7JRgvYFEwrYzmSAwsppDHtpioBoM/HuSH763c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819484; c=relaxed/simple;
	bh=3+SxI0tRGsZen8RqG1GYkdm0sHlmXTSVu/oAkMr6lhc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7YqCxL0qNP/kP0FNn62q182/136hK3ZAqvaDOK5aGxvB4G5toyH6kAJu3iP4MkXpgscTbZCL1OAiuxYxD09wExtYCACiOeel4vs828aBFnKY0jGJeTxhILdn0PTaa0P3XZoLB6+rDLluoAqx471RqBPTCD3Zq2RYIghlyIwxkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOH/ZUac; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOH/ZUac"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-873a2ba6f7cso2646793241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744819481; x=1745424281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFGMeZBaefAMiSCCYV7Imgs0fduQDzHhyo9+GmpG6KA=;
        b=MOH/ZUacwnYJkhKuuEjseTTXO/8uA1B30RVqCCULspjkjNERtB7q/goBtj5OtIIDJT
         wf6W2PStfl5a+P+CwlVhMi0uWg3diM14VmS5XMPQm0KNaWUsby6LnhZVj3yaJ7llmBDt
         Gk0PHBDQ2zN5dViIhCi0xYmXEXXITyAVwwIHrhg94opBY5fgKDi4kC6eL9JAyLfiSMR7
         Prg/bdIUBU7YRIENYl4Fwo3LaBnFis9VbhKffHkh5P5zJ6T2vvfgoHg7kojS3NchiOXJ
         FM9uqPpUiPgNlKuTp/vtJDFXPnNDplLU8EcFh4V09g0sv+zabL06n6DAWQiHyd128hsX
         cnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819481; x=1745424281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFGMeZBaefAMiSCCYV7Imgs0fduQDzHhyo9+GmpG6KA=;
        b=OPe009rhAsYULFU0CPjJFxEWDb78Eh9oej4Vf1T01CCWlIgClxZXZVXHWLIfxnCQrH
         tMCKTNUB46vAZWEzWkgYxMU4MWmFixMHR4IRLTkdHzDWSHsH9Na4l4QvKmIgRvZzk+Lp
         hgWP0DxRKAVAK8ZISYchsdXP/SqSYugfOee3M9a1hVRaLnQThcXwTbhU4k0383fiU+4u
         knmiVaNWN8A/Y8++LfUMoxBUipy2JjiYfeMxPUWHe/zS8hKBUKrx5P0hFWP8FoiYFblF
         RJGwTaSa5KqLBOG1cNhmc4C4vRd8xmhoFHz+TYdsjxgefG9TgJwcC5t+eTbZ9LaMfbkl
         8MuQ==
X-Gm-Message-State: AOJu0YzvhbTB3bx0pFqWhfeHFg1c0ruk30HwSauw3XQlpFkpxlqEfkVR
	9Q30cI0LwmiZTJP61rpBT3jUAYDmR7RKgI7tRNOUoWE9P4Y1nBcn+Q8C6PVE
X-Gm-Gg: ASbGnctRjZ9DdDfoTkd1CFqbIqtkYckfA34HJ9/8P5JnJKRUToHx3zRF8LXgXwXgBp1
	jWFn9mA0NEsrh55V/8vcJlkq1NMlPdXui0h6M/vf2myS3Bg6BB9IqbAxauq3HbSNFVfC1AmRjMh
	5WYVBaOYc+vSwcFqJEoUMT8cpYNhJT1Vwu9T7Z/PffNhBIdxSId9929fhFhqGUGVKw65tkvjLnx
	7ZDBezH3gU0+HRyrbsj63UwthY3EyeuprUMi+SLkSqxGPAIkhXQ+p2P3nCLUraKLW8zRRFJXyk8
	hWgew2yO2SlCpqIsDSaGNFAfqAl1gRHs0UFK0b9mb9wq/9a6ZIzCYMWlX0r+duwETrnxIWeT89G
	rYQvE2WP8wg==
X-Google-Smtp-Source: AGHT+IFDsfO37IggKdfwJcsvFEvBDrVdfqWSBmUKCxDfx4fO/3MJX1RcvV9XPr8ZmHlypu6wumVG6Q==
X-Received: by 2002:a05:6102:5c15:b0:4c1:9159:859c with SMTP id ada2fe7eead31-4cb5920e43bmr1322325137.15.1744819480670;
        Wed, 16 Apr 2025 09:04:40 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c98afd43sm3094029137.20.2025.04.16.09.04.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:04:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/7] btdev: Fix not matching SID on le_pa_sync_estabilished
Date: Wed, 16 Apr 2025 12:04:29 -0400
Message-ID: <20250416160433.1822263-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416160433.1822263-1-luiz.dentz@gmail.com>
References: <20250416160433.1822263-1-luiz.dentz@gmail.com>
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

