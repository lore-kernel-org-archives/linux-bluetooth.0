Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UluTaLa/"
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EB710D1
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 07:28:40 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d7eca548ccso3213745a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 07:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701185319; x=1701790119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMRcStEa6a1gBpdv3t70birwXww/qU1B666I/WHu554=;
        b=UluTaLa/xfRQE/mX0ttJ1aMiT1z1i+t+zl0rtkz409lDkHoKJv4co0Ngw/vv3rBZzt
         F/ouFOcjCiUeFyMkmVOW7jWmRiKPxupi2ES2AWWROvjCnc/xCOb6rFi3eT2sxTlQuUwi
         1f4r2yPPlVhrGVAVvuV+R1HcIoV5XZZXZBLu8wputb3V3lEm+kescFvxbP+RcKacnoAZ
         tAXyXMniEe5PzqM8gpUwHiMPZcvSpYsMGJJ0TCc+y6O9ZpAfL7R+N6i+gHr8pM7jWMB2
         E2Qq+IJXnvG1HDjQBqdcz8Ws+QE4PAnLwYom1RxgHHB49CavElMXP/VlXLe8Klus5PiT
         h+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701185319; x=1701790119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMRcStEa6a1gBpdv3t70birwXww/qU1B666I/WHu554=;
        b=OZViGswUW7F0nJe1XEa1CnhEwRkwldDvnWpHAHS/zw8CucpCq5pJskUJGqcOHFvxXk
         KTS+amtWRyg8a+TQ08ZRX3DGgJUZl2suVzu++Se5IpYJ1iMH4KFLp2pxbUh48+bJZPGC
         JhK7MbIUDSJbRI66VQneTfdmI/aeDRLrFSp9wdXVeDf6xdz2kZnL5r0o2TRWKgmlt70D
         EsCIg4Cz7T/fssud92QCSzjKkwXwzuYaKS2WgVat3FtO8UTh7wdlpZzv4DbZ6v4RNlhO
         9jrPQekFmGm18yqvgRwV7BpeWH/8TLx8DzkAV/j6IjAS7vKS3RIoA273K7hqaRp4HT9H
         oEPQ==
X-Gm-Message-State: AOJu0Yzbt1Cqcn26SBGhN8tIg3mlR8Avp2fExqteIynf3zkdKgo7S0VE
	j534XdpBhECkOUeLbMODzqYkw9XIwKWQug==
X-Google-Smtp-Source: AGHT+IGSrH2TaxydTGLw+KPw88/TqwrYyUYxlJL41FgSfLzdJOJZyvWfn0KcVi5vmHwucDpLGgjUPA==
X-Received: by 2002:a05:6358:3423:b0:16b:f6ba:a03a with SMTP id h35-20020a056358342300b0016bf6baa03amr17743244rwd.8.1701185319294;
        Tue, 28 Nov 2023 07:28:39 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id bf9-20020a056130054900b0079a1018d185sm1660644uab.31.2023.11.28.07.28.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:28:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] monitor: Add proper decoding of TLV for BASE
Date: Tue, 28 Nov 2023 10:28:32 -0500
Message-ID: <20231128152832.1730901-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128152832.1730901-1-luiz.dentz@gmail.com>
References: <20231128152832.1730901-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses bt_bap_debug_{config, metadata} to decode the TLV entries
found in Basic Audio Announcement:

< HCI Command: LE Set Peri.. (0x08|0x003f) plen 41
        Handle: 1
        Operation: Complete ext advertising data (0x03)
        Data length: 0x26
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 10000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
            Codec Specific Configuration: Sampling Frequency: 48 Khz (0x08)
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 7.5 ms (0x00)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 75 (0x004b)
            Metadata: #0: len 0x03 type 0x02
            Metadata: Context: 0x0002
            Metadata: Context	Conversational (0x0002)
              BIS #0:
              Index: 1
              Codec Specific Configuration: #0: len 0x05 type 0x03
              Codec Specific Configuration: Location: 0x00000001
              Codec Specific Configuration: Location: Front Left (0x00000001)
---
 monitor/packet.c | 49 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 87805be0122a..b06f8a5d3802 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -35,6 +35,7 @@
 #include "src/shared/util.h"
 #include "src/shared/btsnoop.h"
 #include "src/shared/queue.h"
+#include "src/shared/bap-debug.h"
 #include "display.h"
 #include "bt.h"
 #include "ll.h"
@@ -3405,20 +3406,6 @@ static void print_uuid128_list(const char *label, const void *data,
 	}
 }
 
-static void *iov_pull(struct iovec *iov, size_t len)
-{
-	void *data;
-
-	if (iov->iov_len < len)
-		return NULL;
-
-	data = iov->iov_base;
-	iov->iov_base += len;
-	iov->iov_len -= len;
-
-	return data;
-}
-
 static void print_ltv(const char *str, void *user_data)
 {
 	const char *label = user_data;
@@ -3435,7 +3422,7 @@ static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 	iov.iov_base = (void *) data;
 	iov.iov_len = data_len;
 
-	base_data = iov_pull(&iov, sizeof(*base_data));
+	base_data = util_iov_pull_mem(&iov, sizeof(*base_data));
 	if (!base_data)
 		goto done;
 
@@ -3453,7 +3440,7 @@ static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 
 		print_field("    Subgroup #%u:", i);
 
-		subgroup = iov_pull(&iov, sizeof(*subgroup));
+		subgroup = util_iov_pull_mem(&iov, sizeof(*subgroup));
 		if (!subgroup)
 			goto done;
 
@@ -3470,29 +3457,31 @@ static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 						subgroup->codec.vid);
 		}
 
-		codec_cfg = iov_pull(&iov, sizeof(*codec_cfg));
+		codec_cfg = util_iov_pull_mem(&iov, sizeof(*codec_cfg));
 		if (!codec_cfg)
 			goto done;
 
-		if (!iov_pull(&iov, codec_cfg->len))
+		if (!util_iov_pull_mem(&iov, codec_cfg->len))
 			goto done;
 
 		label = "    Codec Specific Configuration";
 
-		util_debug_ltv(codec_cfg->data, codec_cfg->len, NULL, 0,
-				print_ltv, (void *)label);
+		bt_bap_debug_config(codec_cfg->data, codec_cfg->len,
+					print_ltv, (void *)label);
 
-		metadata = iov_pull(&iov, sizeof(*metadata));
+		metadata = util_iov_pull_mem(&iov, sizeof(*metadata));
 		if (!metadata)
 			goto done;
 
-		if (!iov_pull(&iov, metadata->len))
+		if (!util_iov_pull(&iov, metadata->len))
 			goto done;
 
 		label = "    Metadata";
 
-		util_debug_ltv(metadata->data, metadata->len, NULL, 0,
-				print_ltv, (void *)label);
+		bt_bap_debug_metadata(metadata->data, metadata->len,
+					print_ltv, (void *)label);
+
+		label = "      Codec Specific Configuration";
 
 		/* Level 3 - BIS(s)*/
 		for (j = 0; j < subgroup->num_bis; j++) {
@@ -3500,21 +3489,21 @@ static void print_base_annoucement(const uint8_t *data, uint8_t data_len)
 
 			print_field("      BIS #%u:", j);
 
-			bis = iov_pull(&iov, sizeof(*bis));
+			bis = util_iov_pull_mem(&iov, sizeof(*bis));
 			if (!bis)
 				goto done;
 
 			print_field("      Index: %u", bis->index);
 
-			codec_cfg = iov_pull(&iov, sizeof(*codec_cfg));
+			codec_cfg = util_iov_pull_mem(&iov, sizeof(*codec_cfg));
 			if (!codec_cfg)
 				goto done;
 
-			if (!iov_pull(&iov, codec_cfg->len))
+			if (!util_iov_pull(&iov, codec_cfg->len))
 				goto done;
 
-			print_hex_field("      Codec Specific Configuration",
-					codec_cfg->data, codec_cfg->len);
+			bt_bap_debug_config(codec_cfg->data, codec_cfg->len,
+					print_ltv, (void *)label);
 		}
 	}
 
@@ -10443,7 +10432,7 @@ static void num_completed_packets_evt(struct timeval *tv, uint16_t index,
 	const struct bt_hci_evt_num_completed_packets *evt = data;
 	int i;
 
-	iov_pull(&iov, 1);
+	util_iov_pull(&iov, 1);
 
 	print_field("Num handles: %d", evt->num_handles);
 
-- 
2.43.0

