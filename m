Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJMKQfir"
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423B2116
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 12:58:18 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5d74186170fso55215877b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702414696; x=1703019496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfJH2vBFvTk3Ec7zxskcSmGRALcmbhg3NKo1nMNN3hI=;
        b=iJMKQfirz6VzmCF/FbxYI1pKFqs3RXvKLF66vRSwNiTjdXStOk2s7fb16chZgd3d2b
         5/QhIJxmIIjOx5Af0zY8h6EWhWkVbto3EuSuTz5SpUnP1dt6oNombvO9hFB4efaPWIaD
         4k3O0WeGnkBYtG3pcXEP4+HrsiyJpS5jyDzzMsT+muYzgWiH67Dt9aTAi/gWm1/fFM4K
         LMFJXwRIRlaelC52jWSMgRXItteyGGjRYPLFLeOScALNtHtLbG634Bp57qwZ/hm1vr2p
         tPQAFH67+1nhAC2sVVr+IszkPqHMdL58JZ28EDYUXHani5dwOERLEtk0lyRJxWOKk85Q
         zfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414696; x=1703019496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfJH2vBFvTk3Ec7zxskcSmGRALcmbhg3NKo1nMNN3hI=;
        b=Cp6x3Jd+q4P4+LuFyeSZ9ZEdgrYQwM32n/mznU3ODA1/5nuEfpXS1ug+SChmiziBfr
         gv3JjI7HzW0n7SM3TJUsAukbW24PX/pm3eGaGVFfoD0WdMQp4Mc+9hErG+BjWVhco6Fd
         A44TTmLA4wU20RG3traU5dRciVtYu2xHbTciXn+P3EBzp6VPa852MD1H7M4cExcuvONX
         zTbhJQz24L5lWk5f5UxaPRqs8i9ZqSbIVC17GZinR5XM/+xZryM5+TOjhKGQwRYIP7qI
         d6ex7JYbRexBPD5qLkTJyn4Xvz4EVaSliSu0eFFCKZdHx8jSj9kEbJoKPRK6JUt92GCS
         QUZA==
X-Gm-Message-State: AOJu0YyzW7QOVTkh/rBjozQJtGKDNj/Qgc2pIJ3tEOTb9f8QC8phrkQ6
	JLa09TU+Sc51FPRCP0p78b/Q3FVcLOk=
X-Google-Smtp-Source: AGHT+IEfrLIon+JYEEUT5695kLmu/FUDfF+T2o9JUM3sRI/TUKKVorOKV12NJbXhlyflmR1IoSLtxg==
X-Received: by 2002:a0d:d1c7:0:b0:5d7:1940:7d84 with SMTP id t190-20020a0dd1c7000000b005d719407d84mr5699294ywd.91.1702414696432;
        Tue, 12 Dec 2023 12:58:16 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id i16-20020a0ddf10000000b005e28951e3a4sm144735ywe.51.2023.12.12.12.58.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:58:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 6/6] client/player: Use ChannelAllocation given on SelectProperties
Date: Tue, 12 Dec 2023 15:58:04 -0500
Message-ID: <20231212205804.881265-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212205804.881265-1-luiz.dentz@gmail.com>
References: <20231212205804.881265-1-luiz.dentz@gmail.com>
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

