Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlXIbfhZ"
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F38ED6
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:25:31 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d8029dae41so3763880a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702329930; x=1702934730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfJH2vBFvTk3Ec7zxskcSmGRALcmbhg3NKo1nMNN3hI=;
        b=PlXIbfhZo7aplEEcw5iFkYjxhTZ7Sjn7e2sEcdlJQTljBpOT0RYlT4JMrv5e/4yacX
         y6Ua+gU4fD+1rgcW/sdl7yHDJweRrH0dU8ijKrJEJesWlyLrYEgva+XEHJCBmSSB2XcZ
         zsVyGwimqnxcxgg0qI4vDjJ8oAGWrGrznU/YNy0UnvncHepLrUMHSB+Bxc4enzt1EpUD
         o4pmo8LQIaQVhf88UVS5cA2ixfvpjkAKC4y+xGp6v0Q4NTCLsa8wT1ctcN1McqAG3grh
         eZApIH3moFPRbmECHUQf7W68Kmx403V0cWxV1Z0qqYqn/gP5p2qH/iSRdSHrlEx1/0Tm
         94ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329930; x=1702934730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfJH2vBFvTk3Ec7zxskcSmGRALcmbhg3NKo1nMNN3hI=;
        b=XFkfI56FN6rEIJiVEkYfFFWF+YiOcPXJEm2RojV6jYel6ZitNkXRJHIzPGRTPHMjx2
         aPBAVrD46Jyxt9biXyd3UVMZSQEukNlAgTWY2gNXy/iJcP76y7rTkK4hAL/ETgZMw3FT
         VDHJTwTG+MAe+qcCJ01q4o3TWL7Wai9uk9ZM0saK/pPKuRsjEHsE9iHMIn3FsD+qhgRY
         /5NiyeTq6oiIMRgOahXH6F6+A0+q61wLfM3qqQw46kOWJ6eutvkeolHoc03pN4Gu3aXq
         OCynMQ/1mIkiFIhBAsU8cfgCgYHSxsJY0pGbuqA/qUz5N/7AApDx3MPrUN4VFJgHSGAx
         05dg==
X-Gm-Message-State: AOJu0YxxSReTJs1FmHmRCHwUevSJIWPIqvPRS3ZCeWCD3EQacsJkqmYC
	HOw9eMqP3c86EGhguMYddiVlT+U90bg=
X-Google-Smtp-Source: AGHT+IGCmQB5s9jlOn+JSvhLPNm0ZV+7hNLHOMxMNuev0EneFS0YERRQzEEmmYfZaAbsx+Zs167w5A==
X-Received: by 2002:a9d:7ac7:0:b0:6d7:f540:4618 with SMTP id m7-20020a9d7ac7000000b006d7f5404618mr4957647otn.3.1702329930120;
        Mon, 11 Dec 2023 13:25:30 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id s38-20020a0568302aa600b006da11489f70sm873757otu.44.2023.12.11.13.25.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:25:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 6/6] client/player: Use ChannelAllocation given on SelectProperties
Date: Mon, 11 Dec 2023 16:25:16 -0500
Message-ID: <20231211212516.577426-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211212516.577426-1-luiz.dentz@gmail.com>
References: <20231211212516.577426-1-luiz.dentz@gmail.com>
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

