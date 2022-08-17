Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5FBC32772
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Aug 2022 23:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiHQXlz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Aug 2022 19:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242406AbiHQXly (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Aug 2022 19:41:54 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E582B883D5
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:41:53 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id cb8so87838qtb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Aug 2022 16:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=+CslJruZhhH6jfT3eIwvKw88vFc+u4Wpz1EW4s1KON8=;
        b=LFFuaB3WGu+rqCiW7XuEITWCkP7Z8X5GS0nvfpxsRFbHsw461KhrKBtu5EcT+eN7un
         wZdxhgjsyjajy7JWqxJro+acROVVa0Y5DYcMREAxuhFOybeVCTXoiQeiThBqTkGv1uCA
         UHtbKdQIA9jECbC8zKh2iv7o6FbJjjrmW8o4mwatMHIfsVqIMhgVBa6vl6pHfveL1pEb
         IAOpe8Wn1NrwX8156l4h3x3O7bElAQn5opoNoS3fgv5ETkjTtjaSDENiKMhxrs9QsM3t
         xob0Yd50AGKAeDZNfYU0jdOrU7E17l6XMQKeZbd8NFCKSu06hgs8jtBwe4gZ/0hDKc5T
         41xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=+CslJruZhhH6jfT3eIwvKw88vFc+u4Wpz1EW4s1KON8=;
        b=OrIRywH6axrFLESL0zgJ4CmOx/aFXtZrHppxk1NCxvv8Io77+97Dq5kqcJy6MFQLcx
         9c8ReIwmGITMOxollqHZ+6pEaLYqjIR8e1nRwAURy3WbFxlb9SlMHB49//o8/OV7/vNG
         /z+RpCYkSC1Gvg7fKRWvJnSDeK7crg/AQNHOYcoKTCrm+dKs+inE0sjArKUH+Bj/9ef7
         iemYFRhvU1+ypygQm9M2RIpsDP8USEbZ7gtRwDJZdXMfB3TIOV82mEhDcg/k8ZVEV20S
         boU6D01MiEoBYzFLWHh9XQugXfnQdwWnGWJJAMTKs56Luhs1pwmuGFLCASnijr6XY1DQ
         6PJQ==
X-Gm-Message-State: ACgBeo2R9va9Lutmc2iK68amJYvfIuME0RgB+2mxvBlLPdJ8uwdh/TSm
        fgB+KHYjQT5QohzRDiSXO2RjBMEP5LpHdpON
X-Google-Smtp-Source: AA6agR61DkmmtK+Wg3B1Ex7+yAw8l725Ba3eleW+PUuPPGVyvPFuTef4ZAhw7tWO89TQlRYMuKhfcA==
X-Received: by 2002:ac8:5907:0:b0:344:8b29:5e84 with SMTP id 7-20020ac85907000000b003448b295e84mr583545qty.294.1660779712616;
        Wed, 17 Aug 2022 16:41:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r25-20020ae9d619000000b006bb2f555ba4sm189637qkk.41.2022.08.17.16.41.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:41:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/9] lib/uuid: Add PACS/ASCS UUIDs
Date:   Wed, 17 Aug 2022 16:41:39 -0700
Message-Id: <20220817234146.224081-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220817234146.224081-1-luiz.dentz@gmail.com>
References: <20220817234146.224081-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds PACS/ASCS UUIDs which will be used by Basic Audio Profile.
---
 lib/uuid.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 6236752a17a6..cb9294be8c6e 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -146,6 +146,24 @@ extern "C" {
 /* GATT Server Supported features */
 #define GATT_CHARAC_SERVER_FEAT				0x2B3A
 
+/* TODO: Update these on final UUID is given */
+#define PACS_UUID					0x1850
+#define PAC_SINK_CHRC_UUID				0x2bc9
+#define PAC_SINK_UUID		"00002bc9-0000-1000-8000-00805f9b34fb"
+#define PAC_SINK_LOC_CHRC_UUID				0x2bca
+
+#define PAC_SOURCE_CHRC_UUID				0x2bcb
+#define PAC_SOURCE_UUID		"00002bcb-0000-1000-8000-00805f9b34fb"
+#define PAC_SOURCE_LOC_CHRC_UUID			0x2bcc
+
+#define PAC_CONTEXT					0x2bcd
+#define PAC_SUPPORTED_CONTEXT				0x2bce
+
+#define ASCS_UUID					0x184e
+#define ASE_SINK_UUID					0x2bc4
+#define ASE_SOURCE_UUID					0x2bc5
+#define ASE_CP_UUID					0x2bc6
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
2.37.2

