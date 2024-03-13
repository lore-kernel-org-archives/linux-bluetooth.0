Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93173446C9
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359004; cv=none; b=YLgPY3mZ+BrzpgPkRI9sZWo14XdZAmNrL85idfCdeVmR5bvPdFW7r9hULoubWeR9tqNfzfvXmPz67arl0qYTit+M9CdxKwutx5wWOlCHwnuGjVR3Cob1uYVWPzCc6YmcytiIcoKNRxRjzy746j7XzTxTIPVva2YuN6/h1mimcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359004; c=relaxed/simple;
	bh=webspxOA/u6u3QNP3nqrQpRn8ISwU7Z91ZYFrkfXyvQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=P/w9TqW/CE2XT4aTRfDl19RJ+1wruxr8FCZ6WNtBHl2/ak3Jjo4yUy78TCkAnjVztuNI8fgEXemiqi30Z4Hr2nZzrbfvRjzlp5i/AGYX4LNvUarMXQk/owV15vHbSxeXLMqiJl4240dVTDaIgKBgC3hpjPS4w/3c+P31EpPWuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnLhUwnE; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnLhUwnE"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-475767a2a42so448080137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710359000; x=1710963800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IEAF3A8m05rv0jBI1u3aH9jwFP4DdhRk4k2kk5uVb80=;
        b=GnLhUwnEtl03XTQsjM+Px3cyAV/ziMqzIRfLkhZa/Jp2p6hYiReV5W/B0Jmrd9ZVdV
         NtFdd9jPsMjePtEI44sClGAQdnVsx+WUsgt2HU3kV4zUv6l2VV5f+mClWATgXy2hSePP
         X1A2kEN2UJT07HNVLCfCCP5t5HFihzvYG18XzeUnOlUoBHo5Bzs31ITA110mzB/XAY2p
         ueDFfs/JePV4QtO4jSWoYxXc0cs/u20UAgTGyLk0ebbI+41W/R8Uf4uT7BGdViPD2hSh
         CuWJe+6L3JtbSR/hMnst9tjnV2aISvfQ1T+X/2ys4UNQbHgvhT6UEnU7aea/b/vo+IPe
         PlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710359000; x=1710963800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEAF3A8m05rv0jBI1u3aH9jwFP4DdhRk4k2kk5uVb80=;
        b=WBmpRk+nC8M9UrtdeM/z7jL87112cXpzvD5/WCKvOfR8dNpz65GTAN6g1ej0q1VsSb
         1EH3opXSHYSom5/ydPX4rxSVumLlEoNKbcoCTdMLvugqBURGu/sP/+Wi0XP4CM0XOE2T
         6IM5C+42BAqyu3YYS20AjkK37+onHVmulKVVZ31nVvWcr5LvOjw/Ex9lGDlEBD09R9wd
         yVxlToV60hMq2TZrzWuGVFlCi4OmOPJcGgMEL1jCeSRnP2mm0ef7GELhegf/cQU63H+u
         Kki7s3Zk2gZ8eJJVEG8thKSIekyCsyP4TWhPiB0nUXFV7Flmfxfxp9vmSJaxKGkHXFDQ
         RD9A==
X-Gm-Message-State: AOJu0Yy2TEDfaQTxCbo1998MV53ibkQ2OI3u603tHuiUHyYs78KoZRJq
	uZVqjG6ZR0n4wlyGwXVcEYcWrBqXnWuNWzQLQ9t7mOCZQBBS2cSVXtAaCZUh
X-Google-Smtp-Source: AGHT+IEYkhFsjMy8cX4XSAV02AhsoJkGpAzHWAw+FM+tkV2wRsvFl/BngPWOc31qnf2OiKHDWg7Erw==
X-Received: by 2002:a67:efd7:0:b0:474:c78e:cd4d with SMTP id s23-20020a67efd7000000b00474c78ecd4dmr885941vsp.12.1710359000317;
        Wed, 13 Mar 2024 12:43:20 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id iv8-20020a056130648800b007d2dfa739d7sm1473726uab.37.2024.03.13.12.43.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:43:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are unset
Date: Wed, 13 Mar 2024 15:43:18 -0400
Message-ID: <20240313194318.1397153-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Consider certain values (0x00) as unset and load proper default if
an application has not set them properly.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index c8793e57f4b5..d24148ea883c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1451,8 +1451,8 @@ static bool check_ucast_qos(struct bt_iso_qos *qos)
 
 static bool check_bcast_qos(struct bt_iso_qos *qos)
 {
-	if (qos->bcast.sync_factor == 0x00)
-		return false;
+	if (!qos->bcast.sync_factor)
+		qos->bcast.sync_factor = 0x01;
 
 	if (qos->bcast.packing > 0x01)
 		return false;
@@ -1475,6 +1475,9 @@ static bool check_bcast_qos(struct bt_iso_qos *qos)
 	if (qos->bcast.skip > 0x01f3)
 		return false;
 
+	if (!qos->bcast.sync_timeout)
+		qos->bcast.sync_timeout = BT_ISO_SYNC_TIMEOUT;
+
 	if (qos->bcast.sync_timeout < 0x000a || qos->bcast.sync_timeout > 0x4000)
 		return false;
 
@@ -1484,6 +1487,9 @@ static bool check_bcast_qos(struct bt_iso_qos *qos)
 	if (qos->bcast.mse > 0x1f)
 		return false;
 
+	if (!qos->bcast.timeout)
+		qos->bcast.sync_timeout = BT_ISO_SYNC_TIMEOUT;
+
 	if (qos->bcast.timeout < 0x000a || qos->bcast.timeout > 0x4000)
 		return false;
 
-- 
2.43.0

