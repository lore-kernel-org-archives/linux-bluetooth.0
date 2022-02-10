Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB419C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 02:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiBJCJ3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiBJCHN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 21:07:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656181121
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 18:02:23 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so4101151pjh.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 18:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+oU1Sm20gn7Wyg52bLkHqmX9h0voV8s3X026nJn6Ic=;
        b=PZBXQ7lb2sLTdpELOM3+N/MmepyLkXiUFr4CUBFwglPfQ4EsA37gLpN+8/Xq5v3B92
         Kr9nwZRR2X5hlcb1ZugJvqPir5cOvoBA+0lSLhRi5E02hwwHJC/PJ6UjyJOohoZhf6YU
         ABIUXQqp7my/nUGdfFz7PTfgsFoXtPkmO9v9WwkqRK2xLBN+fa7zIJNCpE44nZxpu4ct
         aEEsp0tVISvCiKLP/QQj9CRsfxK5NvrjkO5O485fRNVTaxzLrCSJ0EiMfTwNVjfNpyjT
         SwLtsPoPKTETCDO76S8bH+mNzOtL+h3umurj7qumwNONWcbcjU5o0MZulxzXDzHwG9wp
         WuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+oU1Sm20gn7Wyg52bLkHqmX9h0voV8s3X026nJn6Ic=;
        b=2Ky7BEZolH2BrrPm2tUlw6aoICclAI/SornMV+0h9Yto8sUvM20eXL0ah2koXrX1nq
         kNESQ6W4/+ptMof4f/pc7rutTBtLYMwCtfmKQj/+NNezAXnq7+o5ltv5oIUmfctwMJ0q
         5f1LnvbpRvwSiI2heXo5BxCNGfw5SfnrVC7AO/BcF3FvwSdORFXKzHKwNIVTFK0Vs91P
         ueqT5XMqweHLwvYMoi/tTHWIW36j00UP2GxmVs47BDTbSa5KibyULvIqiQ8t0P5JFQaE
         58skr7BPC2gXJAp+Bs0RClo22VisAsZHV9RleGXmRoYkOAnpxdBrc6ZsBttWKgel549U
         FCBw==
X-Gm-Message-State: AOAM5317yUK7KvVB8K5UQkBYoPFcIyF9l4hjISzDpMF9Dr17sFyQqNrV
        ZSLcaXIPh88SiVOlKXu/+oi1GwkAKCiEVw==
X-Google-Smtp-Source: ABdhPJxVS0IAw+VXfU0s+Kx3NP439K9qJSguiS664m7AIkpRcELHNCxILFJU1Lu1KEd293TJYmdWdA==
X-Received: by 2002:a62:b605:: with SMTP id j5mr4925313pff.25.1644451744871;
        Wed, 09 Feb 2022 16:09:04 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 13sm20484555pfm.161.2022.02.09.16.09.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 16:09:04 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] adapter: Fix crash when storing link key
Date:   Wed,  9 Feb 2022 16:09:02 -0800
Message-Id: <20220210000903.162318-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following trace can be observed sometimes when pairing 2 emulator
instances:

 src/adapter.c:store_link_key() Unable to load key file from
 /var/lib/bluetooth/9C:DA:3E:F2:8E:46/9C:B6:D0:8A:A0:0C/info: (No
such file or directory)
 GLib: g_file_set_contents: assertion 'error == NULL ||
*error == NULL' failed
 ++++++++ backtrace ++++++++
 #1  btd_backtrace+0x28a (src/backtrace.c:59) [0x7f65bb5ab53a]
 #2  g_logv+0x21c (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
 [0x7f65ba3f955c]
 #3  g_log+0x93 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
 [0x7f65ba3f9743]
 #4  g_file_set_contents+0x68
(/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f65ba3dca68]
 #5  store_link_key+0x30a (src/adapter.c:8235) [0x7f65bb61839a]
 #6  new_link_key_callback+0x474 (src/adapter.c:8285) [0x7f65bb62c904]
 #7  queue_foreach+0x164 (src/shared/queue.c:203) [0x7f65bb722e34]
 #8  can_read_data+0x59f (src/shared/mgmt.c:343) [0x7f65bb72e09f]
 #9  watch_callback+0x112 (src/shared/io-glib.c:162) [0x7f65bb78acb2]
 #10 g_main_context_dispatch+0x14e
(/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f65ba3f204e]
---
 src/adapter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a6dcc76de..3ee98431d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8214,11 +8214,15 @@ static void store_link_key(struct btd_adapter *adapter,
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
 			btd_adapter_get_storage_dir(adapter), device_addr);
+	create_file(filename, 0600);
+
 	key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", filename,
 								gerr->message);
 		g_error_free(gerr);
+		g_key_file_free(key_file);
+		return;
 	}
 
 	for (i = 0; i < 16; i++)
@@ -8229,8 +8233,6 @@ static void store_link_key(struct btd_adapter *adapter,
 	g_key_file_set_integer(key_file, "LinkKey", "Type", type);
 	g_key_file_set_integer(key_file, "LinkKey", "PINLength", pin_length);
 
-	create_file(filename, 0600);
-
 	str = g_key_file_to_data(key_file, &length, NULL);
 	if (!g_file_set_contents(filename, str, length, &gerr)) {
 		error("Unable set contents for %s: (%s)", filename,
-- 
2.34.1

