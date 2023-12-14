Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE86ABA4
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpLBLiRx"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-58d06bfadf8so4231eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 12:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702587369; x=1703192169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfJH2vBFvTk3Ec7zxskcSmGRALcmbhg3NKo1nMNN3hI=;
        b=NpLBLiRxS5f6zifCkhy2MyG+BTyxqTzLoFT6tn6XyKgfiT2Fk75o523Z6jrK15yoqO
         wQ1lM1Uq6vFU4oqca0N36WpFGyXg+cQPy2HbMSfc12rmujal3qq+NBpdAkUkNzR9kuha
         KSULNEeBeAaoFjLZaw5wf2CJBP66VVPmSm/aPcmZVp+Pd87OvFRLNEDglbk43DR6lyPU
         smzaL/xNSv28ey8FYq9zqEX2o6x1923SA8RCe6Zt9BVPeeBJzLshV8yvExa2M6+a7FQj
         n5lUAuPJvg9amsLRoHQ21ZtaRpeLr/w/WTWgpvnbZACCG1A1BpGWDFjNTihqVWD5X+xV
         gIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702587369; x=1703192169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfJH2vBFvTk3Ec7zxskcSmGRALcmbhg3NKo1nMNN3hI=;
        b=cj7xFIPFlW2BW/AFlopkZAU4aEYmlVbloWf4nrQHFJZUnatPJfT7enjLVcUB3Xb8qG
         l7b9gZGoWHhnMtjUViZFa8lN3NajgY56NOeb0vwEzuNXqIddhud/gKuqu726YsIkgLVD
         V7J69o0UIGG7q/MGh+5W5VeY7V928+BBMrvdlCmMHFGUNMqc5A0K6UMHr93B+Wzi+T1W
         ZEYuzlFB+7mvt9WXgG+8rqtX9+IDKrMXPSAO/IvXj4xNdCT9R9ZJs25YeaRuu7wUx0nb
         CB9pFfkfUFJODae7M+durifLgBqqlvbYW46cqUyvbrwDIq4YtAknG5SblT5gJwRmds8u
         TisQ==
X-Gm-Message-State: AOJu0YyrenOLFuZjNpSbG25EhWT8JPUjxLBCwWvU6mCde9Z4VfoPcgb5
	AoGo4WkvrVRG9eK4a0fGu7KgO/qUvxA=
X-Google-Smtp-Source: AGHT+IGSqjxcK2wXdGm52QsLQBai7/3mRcIXmWdwFIIinxQO2JevmSooi/9I29cY8PsKB6k2xvir7A==
X-Received: by 2002:a4a:9891:0:b0:590:f911:42ef with SMTP id a17-20020a4a9891000000b00590f91142efmr4863566ooj.18.1702587369576;
        Thu, 14 Dec 2023 12:56:09 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id m20-20020a4a2414000000b005902a5bc3easm3658057oof.22.2023.12.14.12.56.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:56:07 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 6/6] client/player: Use ChannelAllocation given on SelectProperties
Date: Thu, 14 Dec 2023 15:55:56 -0500
Message-ID: <20231214205556.1320286-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214205556.1320286-1-luiz.dentz@gmail.com>
References: <20231214205556.1320286-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of ChannelAllocation when present on SelectProperties
dictionary which is then passed on to bluetoothd and send over as part
of Codec Configuration:

< ACL Data TX: Handle 2048 flags 0x00 dlen 109
      ATT: Write Command (0x52) len 104
        Handle: 0x0098 Type: ASE Control Point (0x2bc6)
          Data: 0104050202060000000010020103020201030428000503010000000
	  6020206000000001002010302020103042800050302000000010202060000
	  0000100201030202010304280005030100000002020206000000001002010
	  302020103042800050302000000
            Opcode: Codec Configuration (0x01)
            Number of ASE(s): 4
            ASE: #0
            ASE ID: 0x05
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
              Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
              Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
              Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
           Location: 0x00000001
              Front Left (0x00000001)
            ASE: #1
            ASE ID: 0x06
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
              Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
              Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
              Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
           Location: 0x00000002
              Front Right (0x00000002)
            ASE: #2
            ASE ID: 0x01
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
              Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
              Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
              Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
           Location: 0x00000001
              Front Left (0x00000001)
            ASE: #3
            ASE ID: 0x02
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
              Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
              Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
              Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
           Location: 0x00000002
              Front Right (0x00000002)
---
 client/player.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index 4d49602c70d7..92fc91f920f3 100644
--- a/client/player.c
+++ b/client/player.c
@@ -64,7 +64,7 @@
 #define SEC_USEC(_t)  (_t  * 1000000L)
 #define TS_USEC(_ts)  (SEC_USEC((_ts)->tv_sec) + NSEC_USEC((_ts)->tv_nsec))
 
-#define EP_SRC_LOCATIONS 0x00000001
+#define EP_SRC_LOCATIONS 0x00000003
 #define EP_SNK_LOCATIONS 0x00000003
 
 #define EP_SRC_CTXT 0x000f
@@ -2104,13 +2104,42 @@ static struct iovec *iov_append(struct iovec **iov, const void *data,
 	return *iov;
 }
 
+static int parse_chan_alloc(DBusMessageIter *iter, uint32_t *location)
+{
+	while (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(iter, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+
+		if (!strcasecmp(key, "ChannelAllocation")) {
+			if (var != DBUS_TYPE_UINT32)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, location);
+			return 0;
+		}
+
+		dbus_message_iter_next(iter);
+	}
+
+	return -EINVAL;
+}
+
 static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 						DBusMessage *msg,
 						struct codec_preset *preset)
 {
 	DBusMessage *reply;
-	DBusMessageIter iter;
+	DBusMessageIter iter, props;
 	struct endpoint_config *cfg;
+	uint32_t location = 0;
 
 	if (!preset)
 		return NULL;
@@ -2126,6 +2155,18 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
 	cfg->target_latency = preset->target_latency;
 
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_recurse(&iter, &props);
+
+	if (!parse_chan_alloc(&props, &location)) {
+		uint8_t chan_alloc_ltv[] = {
+			0x05, LC3_CONFIG_CHAN_ALLOC, location & 0xff,
+			location >> 8, location >> 16, location >> 24
+		};
+
+		iov_append(&cfg->caps, &chan_alloc_ltv, sizeof(chan_alloc_ltv));
+	}
+
 	/* Copy metadata */
 	if (ep->meta)
 		iov_append(&cfg->meta, ep->meta->iov_base, ep->meta->iov_len);
-- 
2.43.0

