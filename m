Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769743;
	b=tnFHNHPpSl2OZX9CFFtc2IC7oDHSVjjou+QaPS3CcFzdGJ1AJXOgIAavCUbSHvfed3CO
	 wxwcaVVKTrCcvzrVBLyy/sRjmPuWYeXuffvgN1xuuSXQknI9pipd2X6s72gsuON1isgBr
	 obFG2+BhNmhCe0bIHK5JefWL0KyUI47YkQo+AYZpN+7os2h6vmaNZS1dKQgrOkxKee9qd
	 FJdyVPeNmuw2JDK76MeAl9GaSwCRnvgkUzYcLmYrbhEYMI67yqVoUcgoaYteINfUwdLmC
	 GyBUAB6gGFqqxcTPSUsHPV1oKTyyjc3L8kLLzoXlEOctQFolw2EcUBqAbJnL696mQgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eaNxglRDpFibUEICNCYvMjBfoeCe1nExjBnGSdVIj50=;
	b=zfGEPWy9uRXDMvz55grIXVREJADOqPABwZ4ys5exqIXbUFtNgTn1Yr27CWT2Q3BUETHR
	 VwMWD/PqElIqnwEI8F/lRJi22gpHtgJjMuJB/B7iGWIvXEcGYGouGPxPAC+E4xlF4xUhW
	 YpL3VIFZulc9UbV9l+cjJu9U9P1as0y9PIFft4bikmqNHwVsX89iv/g0h+egYNoXSAAVh
	 AvLUB2xvhH1QJ57x8i3yGlYRfm70qTycIPcVhkbbKzIqjKCuqa6VsM/n5xwsnPrtJhnd1
	 4bcnZr4vBzKUF6Usnrny3L1XFiwZfs/UXpiHxBGumknPrhsww7QkI5RuHcXG+Fjvm/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HVolr1IP;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99095606A32C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99095606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HVolr1IP
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a68f888a41so7442605e9.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769741; x=1796374541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eaNxglRDpFibUEICNCYvMjBfoeCe1nExjBnGSdVIj50=;
        b=HVolr1IPStml5l5uEOWY5fyv1bxuggJ9MuWTxSXfcD5cXFoWonfZ0ZOUrXZPOj/mNq
         Q3sGMdY5EQk64DtGYzB4CVV0XwBpw/ej05XMQpuL76laiJ64OEiTSldlAOaT6a3dZc/G
         ycb2HYEHtCqNjBR/hOiF4XFhh/s6Bcoyyql2tG/pkwwWQ2aRRCEnebyvB4FKVMYIHmfd
         RrdWF5S0O03X7sx/xPz9kyYRJKW9uZJiz9mU8Sp6bbfXQSc5JAfjbM3nOKf4rTNow9Kc
         bjIb5pUc8Gsx8/HIpWnglu+9Knq/7LobebfkE3ACcMGxQVcME3dXBLhTnlwuUCqyxIkz
         Vj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769741; x=1796374541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eaNxglRDpFibUEICNCYvMjBfoeCe1nExjBnGSdVIj50=;
        b=IWBWbviK0p+Gm6WSp3QmEOq+SZnE61/65ywPT7T+iTDuw2Amz5mYpevM87kDCr2wmQ
         ljlEmJNC0bwSC1IDFnP2t0988LnRX6GOhHUPUvUL9/O76LZ+Fw+8MLcgqjeuVUaxCOf3
         9jllBMJpdnv+CokXXRPlIS44pEiaDqAX6s5olTN1hEmJoHV4L4NwV9SLnYRYRUwwUtDV
         fgVxDji2JFqmJ1nEHbgg8AFxUCXcX/BK3lUiBUJjce/b2qOSlm1kB+a6oO3fn0l+vXZ/
         v4SBR8VkPvuSh76J2LLWa+iWGbR3bisqtbgqunFkP5PUVD+T1uzz0wBA4bPW7XVZjs5j
         AtwQ==
X-Gm-Message-State: APuU4Z8uWVWU/DvsD1wY/gs8faNHkWJCNz2ZyLmiqzVP4WXY7+3EiGpD
	qI4TXmwPSESBaDq6himIh6yDKXBTXeoc+sjNrvM+VBeaG15lh6fQCB7lQW/cZkss
X-Gm-Gg: AZFdTZcIgVDX7iepOyTrNptAUVPyM2g7hkz0snKNLttbZPHXcfwv0fbhs6HQs8NAAHz
	NF4V0MyAsNjv1xEuWBtsqfcya5ikG/0HMMT4sN6GCHeu84HXwDL2BUbdcd6PxmRbtHknMykumgH
	kwOE3Ja1KSjkkh2HZT89kB9JZ4U8mVO2tiNVyw/ert8l44lgBE/w2VTHD4MbneNX7W3t2/mRnrZ
	I0PnBzia1nD+/AFlXpaFZJwZyWpGCY63FgU7hwynlWGMuH8fjHoeCdTvBoQz7RIFOwkQuDKosvp
	nN4+vm2VK4kCtCXKONjyumcRQTKbUzRHPmE3/6gyOGwvPlj0H2QTqw8XKDO7VKBTp7UHsBIHaT/
	cStk7pGK7N1uYGHxm14mP/TPjfaoEXh71I2yVITsxU1ay7ACTnz4aCA1sR67yzfN+X+aX+026B+
	rdCeYxhEm0xk8IhtfivSHtzNxudS4IlM1KZFXFbr+pgfULScMK23dX85+/x8nF0qp5edcI9tlxa
	fRJlps05CEdIp/c0z2HZEXA61HD8FQjqg7b2ArZ8eSMUE+TogW592rM4IO4IrRkeMhnqt45XSEE
	0Kbwq2dMAzetnVBzUO4AdJqkdjtegzfqJ/U=
X-Received: by 2002:a05:600c:8210:b0:4bb:7ad8:99f2 with SMTP id 5b1f17b1804b1-4bb88785da4mr440666165e9.0.1795769740785;
        Fri, 27 Nov 2026 00:55:40 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm739587505e9.14.2026.11.27.00.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:55:40 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH BlueZ 8/9] emulator/btdev: Add Periodic Advertising with Responses advertiser
Date: Fri, 27 Nov 2026 09:55:24 +0100
Message-ID: <20261127085525.264299-9-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127085525.264299-1-rolandschober1968@gmail.com>
References: <20261127085525.264299-1-rolandschober1968@gmail.com>
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

Add the advertiser side of Periodic Advertising with Responses to
controllers of version 6.0 and later:

 - the PAwR Advertiser feature;
 - LE Set Periodic Advertising Parameters [v2], which checks the
   subevent parameters against each other and against the interval;
 - LE Periodic Advertising Subevent Data Request, sent once per
   periodic advertising interval for all subevents while the train is
   enabled;
 - LE Set Periodic Advertising Subevent Data, which takes the data of
   a subevent once per request: before the first request it answers
   Too Early, a second time Too Late.

LE Set Periodic Advertising Data is refused for a set with subevents.
Nothing is transmitted and no responses are reported.

Assisted-by: Claude:claude-fable-5-2
---
 emulator/btdev.c | 249 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 248 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c4ade031e..e13cf4d4b 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -267,6 +267,14 @@ struct btdev {
 	uint8_t  le_pa_data_len;
 	uint8_t  le_pa_data[MAX_PA_DATA_LEN];
 	uint8_t  le_pa_handle;
+	uint8_t  le_pa_num_subevents;
+	uint8_t  le_pa_subevent_interval;
+	uint8_t  le_pa_rsp_slot_delay;
+	uint8_t  le_pa_rsp_slot_spacing;
+	uint8_t  le_pa_num_rsp_slots;
+	bool     le_pa_data_requested;
+	uint8_t  le_pa_subevents[16];	/* Subevents which wait for data */
+	unsigned int le_pa_subevent_id;
 	uint8_t  le_ltk[16];
 	uint8_t  hdt_def_mic_len;
 	uint8_t  hdt_def_format;
@@ -694,7 +702,13 @@ static void btdev_reset(struct btdev *btdev)
 		btdev->inquiry_id = 0;
 	}
 
+	if (btdev->le_pa_subevent_id > 0) {
+		timeout_remove(btdev->le_pa_subevent_id);
+		btdev->le_pa_subevent_id = 0;
+	}
+
 	btdev->le_pa_enable = 0x00;
+	btdev->le_pa_num_subevents = 0;
 
 	queue_remove_all(btdev->conns, NULL, NULL, conn_remove);
 	queue_remove_all(btdev->le_ext_adv, NULL, NULL, le_ext_adv_free);
@@ -6048,6 +6062,7 @@ static int cmd_set_pa_params(struct btdev *dev, const void *data,
 		dev->le_pa_min_interval = cmd->min_interval;
 		dev->le_pa_max_interval = cmd->max_interval;
 		dev->le_pa_handle = cmd->handle;
+		dev->le_pa_num_subevents = 0;
 	}
 
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_PA_PARAMS, &status,
@@ -6055,6 +6070,203 @@ static int cmd_set_pa_params(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static int cmd_set_pa_params_v2(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_pa_params_v2 *cmd = data;
+	struct bt_hci_rsp_le_set_pa_params_v2 rsp;
+	uint16_t min_interval = le16_to_cpu(cmd->min_interval);
+	uint16_t max_interval = le16_to_cpu(cmd->max_interval);
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.handle = cmd->handle;
+
+	if (!queue_find(dev->le_ext_adv, match_ext_adv_handle,
+					UINT_TO_PTR(cmd->handle))) {
+		rsp.status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+		goto done;
+	}
+
+	if (dev->le_pa_enable) {
+		rsp.status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
+
+	/* With subevents: an interval of at least 7.5 ms, response slots
+	 * which follow the subevent packet and a train which fits the
+	 * periodic advertising interval (all in units of 1.25 ms, the
+	 * spacing in 0.125 ms).
+	 */
+	if (min_interval < 0x0006 || min_interval > max_interval ||
+			cmd->num_subevents > 0x80 ||
+			(cmd->num_subevents &&
+			(cmd->subevent_interval < 0x06 ||
+			cmd->num_subevents * cmd->subevent_interval >
+							min_interval ||
+			(cmd->num_response_slots &&
+			(!cmd->response_slot_delay ||
+			cmd->response_slot_delay >= cmd->subevent_interval ||
+			cmd->response_slot_spacing < 0x02))))) {
+		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	dev->le_pa_properties = le16_to_cpu(cmd->properties);
+	dev->le_pa_min_interval = cmd->min_interval;
+	dev->le_pa_max_interval = cmd->max_interval;
+	dev->le_pa_handle = cmd->handle;
+	dev->le_pa_num_subevents = cmd->num_subevents;
+	dev->le_pa_subevent_interval = cmd->subevent_interval;
+	dev->le_pa_rsp_slot_delay = cmd->response_slot_delay;
+	dev->le_pa_rsp_slot_spacing = cmd->response_slot_spacing;
+	dev->le_pa_num_rsp_slots = cmd->num_response_slots;
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_PA_PARAMS_V2, &rsp, sizeof(rsp));
+
+	return 0;
+}
+
+static int cmd_set_pa_subevent_data(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	struct iovec iov = { .iov_base = (void *) data, .iov_len = len };
+	const struct bt_hci_cmd_le_set_pa_subevent_data *cmd;
+	const struct bt_hci_le_pa_subevent_data *se;
+	struct bt_hci_rsp_le_set_pa_subevent_data rsp;
+	uint8_t i;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	cmd = util_iov_pull_mem(&iov, sizeof(*cmd));
+	if (!cmd)
+		return -EINVAL;
+
+	rsp.handle = cmd->handle;
+
+	if (!queue_find(dev->le_ext_adv, match_ext_adv_handle,
+					UINT_TO_PTR(cmd->handle))) {
+		rsp.status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+		goto done;
+	}
+
+	/* Only a running train with subevents asks for data */
+	if (!dev->le_pa_enable || dev->le_pa_handle != cmd->handle ||
+						!dev->le_pa_num_subevents) {
+		rsp.status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
+
+	if (!cmd->num_subevents || cmd->num_subevents > 0x0f) {
+		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	for (i = 0; i < cmd->num_subevents; i++) {
+		se = util_iov_pull_mem(&iov, sizeof(*se));
+		if (!se || !util_iov_pull(&iov, se->data_len)) {
+			rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+			goto done;
+		}
+
+		if (se->subevent >= dev->le_pa_num_subevents ||
+				se->response_slot_start +
+				se->response_slot_count >
+				dev->le_pa_num_rsp_slots) {
+			rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+			goto done;
+		}
+	}
+
+	if (iov.iov_len) {
+		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	/* Data is taken once for each subevent asked for: before the first
+	 * request it is too early, a second time it is too late.
+	 */
+	iov.iov_base = (void *) cmd->subevents;
+	iov.iov_len = len - sizeof(*cmd);
+
+	for (i = 0; i < cmd->num_subevents; i++) {
+		se = util_iov_pull_mem(&iov, sizeof(*se));
+		util_iov_pull(&iov, se->data_len);
+
+		if (!dev->le_pa_data_requested) {
+			rsp.status = BT_HCI_ERR_TOO_EARLY;
+			goto done;
+		}
+
+		if (!(dev->le_pa_subevents[se->subevent / 8] &
+						BIT(se->subevent % 8))) {
+			rsp.status = BT_HCI_ERR_TOO_LATE;
+			goto done;
+		}
+	}
+
+	iov.iov_base = (void *) cmd->subevents;
+	iov.iov_len = len - sizeof(*cmd);
+
+	for (i = 0; i < cmd->num_subevents; i++) {
+		se = util_iov_pull_mem(&iov, sizeof(*se));
+		util_iov_pull(&iov, se->data_len);
+
+		dev->le_pa_subevents[se->subevent / 8] &=
+						~BIT(se->subevent % 8);
+	}
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_PA_SUBEVENT_DATA, &rsp,
+							sizeof(rsp));
+
+	return 0;
+}
+
+/* Ask the host for the data of all subevents, once per periodic advertising
+ * interval.
+ */
+static bool pa_subevent_data_request(void *user_data)
+{
+	struct btdev *dev = user_data;
+	struct bt_hci_evt_le_pa_subevent_data_request ev;
+	uint8_t start = 0;
+
+	if (!dev->le_pa_enable || !dev->le_pa_num_subevents) {
+		dev->le_pa_subevent_id = 0;
+		return false;
+	}
+
+	/* LE Periodic Advertising Subevent Data Request event */
+	if (!(dev->le_event_mask[4] & 0x40))
+		return true;
+
+	/* The event takes up to 15 subevents */
+	while (start < dev->le_pa_num_subevents) {
+		uint8_t count = dev->le_pa_num_subevents - start;
+		uint8_t i;
+
+		if (count > 0x0f)
+			count = 0x0f;
+
+		for (i = start; i < start + count; i++)
+			dev->le_pa_subevents[i / 8] |= BIT(i % 8);
+
+		dev->le_pa_data_requested = true;
+
+		ev.handle = dev->le_pa_handle;
+		ev.subevent_start = start;
+		ev.subevent_data_count = count;
+
+		le_meta_event(dev, BT_HCI_EVT_LE_PA_SUBEVENT_DATA_REQUEST,
+							&ev, sizeof(ev));
+
+		start += count;
+	}
+
+	return true;
+}
+
 static int cmd_set_pa_data(struct btdev *dev, const void *data,
 							uint8_t len)
 {
@@ -6062,6 +6274,14 @@ static int cmd_set_pa_data(struct btdev *dev, const void *data,
 	uint8_t status = BT_HCI_ERR_SUCCESS;
 	uint8_t data_len = cmd->data_len;
 
+	/* A train with subevents carries its data in the subevents */
+	if (dev->le_pa_num_subevents && dev->le_pa_handle == cmd->handle) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		cmd_complete(dev, BT_HCI_CMD_LE_SET_PA_DATA, &status,
+							sizeof(status));
+		return 0;
+	}
+
 	if (data_len > MAX_PA_DATA_LEN)
 		data_len = MAX_PA_DATA_LEN;
 
@@ -6284,6 +6504,24 @@ static int cmd_set_pa_enable(struct btdev *dev, const void *data, uint8_t len)
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_PA_ENABLE, &status,
 							sizeof(status));
 
+	if (dev->le_pa_subevent_id > 0) {
+		timeout_remove(dev->le_pa_subevent_id);
+		dev->le_pa_subevent_id = 0;
+	}
+
+	dev->le_pa_data_requested = false;
+	memset(dev->le_pa_subevents, 0, sizeof(dev->le_pa_subevents));
+
+	if (dev->le_pa_enable && dev->le_pa_num_subevents) {
+		/* The interval is in units of 1.25 ms */
+		unsigned int msec = le16_to_cpu(dev->le_pa_min_interval) *
+								5 / 4;
+
+		dev->le_pa_subevent_id = timeout_add(msec,
+						pa_subevent_data_request,
+						dev, NULL);
+	}
+
 	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
 		struct btdev *remote = btdev_list[i];
 
@@ -8362,7 +8600,10 @@ done:
 	CMD(BT_HCI_CMD_LE_READ_ALL_REMOTE_FEATURES, \
 			cmd_le_read_all_remote_features, NULL), \
 	CMD(BT_HCI_CMD_LE_SET_HOST_FEATURE_V2, \
-			cmd_set_host_feature_v2, NULL)
+			cmd_set_host_feature_v2, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_PA_PARAMS_V2, cmd_set_pa_params_v2, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_PA_SUBEVENT_DATA, cmd_set_pa_subevent_data, \
+			NULL)
 
 static const struct btdev_cmd cmd_le_6_0[] = {
 	CMD_COMMON_ALL,
@@ -8382,6 +8623,8 @@ static void set_le_60_commands(struct btdev *btdev)
 	btdev->commands[47] |= BIT(2);	/* LE Read All Local Features */
 	btdev->commands[47] |= BIT(3);	/* LE Read All Remote Features */
 	btdev->commands[47] |= BIT(4);	/* LE Set Host Feature V2 */
+	btdev->commands[46] |= BIT(5);	/* LE Set PA Subevent Data */
+	btdev->commands[47] |= BIT(1);	/* LE Set PA Parameters v2 */
 	btdev->cmds = cmd_le_6_0;
 }
 
@@ -9159,6 +9402,7 @@ static void set_bredrle_features(struct btdev *btdev)
 
 	if (btdev->type >= BTDEV_TYPE_BREDRLE60) {
 		btdev->version = 0x0e;
+		btdev->le_features[5] |= BIT(3); /* PAwR Advertiser */
 		btdev->le_features[7] |= BIT(7); /* LL Extended Features */
 	}
 
@@ -9381,6 +9625,9 @@ void btdev_destroy(struct btdev *btdev)
 	if (btdev->inquiry_id > 0)
 		timeout_remove(btdev->inquiry_id);
 
+	if (btdev->le_pa_subevent_id > 0)
+		timeout_remove(btdev->le_pa_subevent_id);
+
 	bt_crypto_unref(btdev->crypto);
 	del_btdev(btdev);
 
-- 
2.47.3

