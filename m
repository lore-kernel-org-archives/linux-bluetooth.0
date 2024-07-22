Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D88434CC4
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681515; cv=none; b=MRjS1WBCoD3iaOOr4wGuSGTzlyTeegtTTckO6jBjt3ShG+dl8UKFTJbleG4DhuA+gVPhABJXMooG1FV0obsau6pKTNUpcAq2yw95yrixIXfFLrrRssrXClxQWKHsMtnzqFUKEsHxBLawsHJAtxM2gQ58vO/mean12NBcNxIo32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681515; c=relaxed/simple;
	bh=LJ5/f2UMo4MaytBQxKKBIV05iIVcIQN7qgH3JfI8VqM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNyswXxUWtfPpRXxBLA8b8XOUMwAmmwlGBrTDu81Bd5OMsj+1SM/2ZEZ4yzSeZ2G0SQLy+1XLB8Q5fU6L4HsIehpJhTXJdj7kv9UUbt14DTbRTyBdRxnY/RU5uDE7mpZ7WAiiO+hFtQGDn+HsgPGp4OeN8mB1ccftfJdvWnreH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRH78Ljm; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRH78Ljm"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-492959b906eso638756137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 13:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721681512; x=1722286312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZmB/diYCDwSKTljthaaRIP6shijD5EXkmxWi90bHm0=;
        b=QRH78LjmQeqw41gnMmsK2KJXxTXjTOwqJR88A+g01BgUwZ92Knlh3t1j7rPgtbzdvD
         Hz33UE+NXZnvp2iS7OJgQoQNjSaLzpxEeXPvCTLXYW/v+xuIuPYUjLS6PCXDUZez7GgC
         Im3xsLnSeECmwfZ2YeCNJ1WVLOEdOzhVy543BvGCnMWV8sJSksl4bquGHgoNCnU5fqKL
         ujnS/x1EOU//fap9snhjHQ/YVQ4zLO2DUzVneTlNm0DVt4rZ74mYy6iFUAlbkmriWBjn
         7+4om5vDWXwWl42I87tNxtXvthRM7+MbCLZhrGmOeGsgg5CuRtzzBNMBPFlfMClSGDsV
         Zx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721681512; x=1722286312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZmB/diYCDwSKTljthaaRIP6shijD5EXkmxWi90bHm0=;
        b=BHcYFc/eopvqyPsZ6PIXspd6S2swFp+/4w6T7vtV9uR/MEazNV5pGRTZTlbfkZq2X7
         76kcan6WJK114Ln0OFXtLV7a4MtgBubXvIWPNK7FAIbFVWyMZy4gRMgiPz9ggBRxGqDm
         VwvefJh5QW6QyEO9nPfcAAnCDtX7J48aeNyCS/HeIfKumsW3zHZ0Q6kT3PS7ojGf1/mY
         Zs3K2bKtnHM2eVPOANQQGE6/SfM5aFZ2caXwJCPYzIByAbU/S3RljjGHlDLIoCcMyBi8
         W43CaijdpBy1TMb4SnFF1lXNZ17uG6fXkmG7lOjEemICTDRUsca1Wduff4uCoahTxFj+
         zufg==
X-Gm-Message-State: AOJu0YyBTxOF8ZoQU8FN8SuH6aU5hY0tMunM3L9g9GGtmShb6wcMNagG
	ns3LVD91EEM3j7XV5tmJ95/+gXOJUaXS8D9jMVtS1nwA8pZIxx4imQ8nyA==
X-Google-Smtp-Source: AGHT+IHf5ng4TRPyZKvA06E9i34Zo3SOOPXNAvPR+x5kY5HnXTojsfHJ7qe5+8srIljTLa+xj9S1vQ==
X-Received: by 2002:a05:6102:5e98:b0:48f:143a:d8e9 with SMTP id ada2fe7eead31-4928ba6cdabmr9051312137.20.1721681512184;
        Mon, 22 Jul 2024 13:51:52 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4927922bf52sm1946183137.8.2024.07.22.13.51.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 13:51:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] client/player: Add support to enter alternative preset
Date: Mon, 22 Jul 2024 16:51:48 -0400
Message-ID: <20240722205148.2273531-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722205148.2273531-1-luiz.dentz@gmail.com>
References: <20240722205148.2273531-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for alternative preset to be entered so when auto
accepting configuration a different preset can be selected following the
order given to endpoint.presets.
---
 client/player.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++----
 src/shared/bap.c |  2 +-
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/client/player.c b/client/player.c
index 486629a9add2..640bef92a7ae 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1230,7 +1230,10 @@ struct codec_preset {
 	const struct iovec data;
 	struct bt_bap_qos qos;
 	uint8_t target_latency;
+	uint32_t chan_alloc;
 	bool custom;
+	bool alt;
+	struct codec_preset *alt_preset;
 };
 
 #define SBC_PRESET(_name, _data) \
@@ -1969,12 +1972,18 @@ static int parse_chan_alloc(DBusMessageIter *iter, uint32_t *location,
 			if (*channels)
 				*channels = __builtin_popcount(*location);
 			return 0;
+		} else if (!strcasecmp(key, "Locations")) {
+			if (var != DBUS_TYPE_UINT32)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, location);
+			if (*channels)
+				*channels = __builtin_popcount(*location);
 		}
 
 		dbus_message_iter_next(iter);
 	}
 
-	return -EINVAL;
+	return *location ? 0 : -EINVAL;
 }
 
 static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
@@ -2010,6 +2019,24 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 			0x05, LC3_CONFIG_CHAN_ALLOC, location & 0xff,
 			location >> 8, location >> 16, location >> 24
 		};
+		uint32_t chan_alloc = 0;
+
+		if (preset->chan_alloc & location)
+			chan_alloc = preset->chan_alloc & location;
+		else if (preset->alt_preset &&
+					preset->alt_preset->chan_alloc &
+					location) {
+			chan_alloc = preset->alt_preset->chan_alloc & location;
+			preset = preset->alt_preset;
+
+			/* Copy alternate capabilities */
+			util_iov_free(cfg->caps, 1);
+			cfg->caps = util_iov_dup(&preset->data, 1);
+			cfg->target_latency = preset->target_latency;
+		}
+
+		if (chan_alloc)
+			put_le32(chan_alloc, &chan_alloc_ltv[2]);
 
 		util_iov_append(cfg->caps, &chan_alloc_ltv,
 						sizeof(chan_alloc_ltv));
@@ -2035,6 +2062,8 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 
 	dbus_message_iter_init_append(reply, &iter);
 
+	bt_shell_printf("selecting %s...\n", preset->name);
+
 	append_properties(&iter, cfg);
 
 	free(cfg);
@@ -2098,8 +2127,6 @@ static DBusMessage *endpoint_select_properties(DBusConnection *conn,
 	if (!reply)
 		return NULL;
 
-	bt_shell_printf("Auto Accepting using %s...\n", p->name);
-
 	return reply;
 }
 
@@ -4104,13 +4131,38 @@ static void print_presets(struct preset *preset)
 
 	for (i = 0; i < preset->num_presets; i++) {
 		p = &preset->presets[i];
-		bt_shell_printf("%s%s\n", p == preset->default_preset ?
-						"*" : "", p->name);
+
+		if (p == preset->default_preset)
+			bt_shell_printf("*%s\n", p->name);
+		else if (preset->default_preset &&
+					p == preset->default_preset->alt_preset)
+			bt_shell_printf("**%s\n", p->name);
+		else
+			bt_shell_printf("%s\n", p->name);
 	}
 
 	queue_foreach(preset->custom, foreach_custom_preset_print, preset);
 }
 
+static void custom_chan_alloc(const char *input, void *user_data)
+{
+	struct codec_preset *p = user_data;
+	char *endptr = NULL;
+
+	p->chan_alloc = strtol(input, &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (p->alt_preset)
+		bt_shell_prompt_input(p->alt_preset->name,
+					"Enter Channel Allocation: ",
+					custom_chan_alloc, p->alt_preset);
+	else
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void cmd_presets_endpoint(int argc, char *argv[])
 {
 	struct preset *preset;
@@ -4131,8 +4183,20 @@ static void cmd_presets_endpoint(int argc, char *argv[])
 		preset->default_preset = default_preset;
 
 		if (argc > 4) {
+			struct codec_preset *alt_preset;
 			struct iovec *iov = (void *)&default_preset->data;
 
+			/* Check if and alternative preset was given */
+			alt_preset = preset_find_name(preset, argv[4]);
+			if (alt_preset) {
+				default_preset->alt_preset = alt_preset;
+				bt_shell_prompt_input(default_preset->name,
+						"Enter Channel Allocation: ",
+						custom_chan_alloc,
+						default_preset);
+				return;
+			}
+
 			iov->iov_base = str2bytearray(argv[4], &iov->iov_len);
 			if (!iov->iov_base) {
 				bt_shell_printf("Invalid configuration %s\n",
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 0aa89c2781ba..4bec51011469 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5420,7 +5420,7 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 			selected++;
 
 			/* Check if there are any channels left to select */
-			map.count &= ~(map.count & rc->count);
+				map.count &= ~(map.count & rc->count);
 			/* Check if there are any locations left to select */
 			map.location &= ~(map.location & rc->location);
 
-- 
2.45.2

