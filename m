Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F75C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 00:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiLBAu4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiLBAuz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 19:50:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC34C727A
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 16:50:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 4so3291667pli.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 16:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rIuN04fzi/QvqGgsYhrpXfuUt7W+BqBRJCjrS+p5YYk=;
        b=AuOSfsUjbbRTE8sWYgzymwnF7TCxo/JK2hNKD0935Cq4vDBjQvzorS8nTiOdXoVUi1
         WX2ob+IgQU6OuICclpfqUYr31bQkkQSKwBg+ANzl+2c7e7jLcXmAKMKF04gykKp5YrtN
         RW2gJ9vhJcmDDb59x6WO/OPwvJF1fUFAhBgn1F1I4mmk/vAK2yrUAJ5sZU3TBh3MOzLr
         vdDWH6w3jvOJqwmXjm2fu4HiZhnD0UOQJZJ66Ffsbupy7lo80JyvrnsljR9d8BKE/m82
         cijd5hnfZxFG/xrVDQq7uOOvSj2lQqWNVzAQA1dxlLIwvdJa2Xjb/y7V7suKXN49q3WJ
         YRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIuN04fzi/QvqGgsYhrpXfuUt7W+BqBRJCjrS+p5YYk=;
        b=DXDv9JhD1YX8fbT71g0OvgPEwGQnZ4bWxI2jVUTpENXLGa1aJXKz499F3Zia4x7Tgs
         H3MRZ0BIazRG5HShBY5ULdCw6DDi4YpHy0IXVGdxGjWGH0isJOBD+hfEMxbyfmhwl/oq
         oBVkwJqnHWPud0Z0x3cVSs0ogm82OUBPeG0fXH04vf1+ajMtKDT4LzExaoMJMyYIjnbL
         IPIiOn7nfSczURftE4D/pTlGiatngn1pCA9zKqmvZTYhgEFd0DLhIsvp9n5P1qECfZM3
         5bRYGPW+rS7wme8Zw8WPi7Z5GzJj75+oY9YfRYM/twiB/+GDH6VY6h4iXLT55zEoPtsx
         BndA==
X-Gm-Message-State: ANoB5plvETCahm46/BqNrHtYhewl+sIVhXlTu+L+dSlEOUExbkquaBnp
        IsQybQ8mkl5bhwXCYNbz9J3d4l0NWDibBw==
X-Google-Smtp-Source: AA0mqf5yUlEjsnF22wdRFcfKJc1l5Pk1n9p3iyJcuVHsmEBO2BFv03WffzARxnOHnoDJNLReOcp9bw==
X-Received: by 2002:a17:902:e849:b0:17a:aca0:e295 with SMTP id t9-20020a170902e84900b0017aaca0e295mr63714984plg.3.1669942253385;
        Thu, 01 Dec 2022 16:50:53 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b0018971fba556sm4246005pln.139.2022.12.01.16.50.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:50:52 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/8] shared/bap: Fix not reading all instances of PAC Sinks/Sources
Date:   Thu,  1 Dec 2022 16:50:44 -0800
Message-Id: <20221202005051.2401504-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both PAC Sink and Source are allowed to have multiple instances:

 - The server wanted to support a smaller maximum transmission unit
 (ATT_MTU, as defined in Volume 3, Part F, Section 3.2.8 in [2]) size.
 Exposing all supported PAC records in a single Sink PAC characteristic
 would require the server to increase its supported Maximum
 Transmission Unit (MTU) size to a value the server considered
 excessive.
 - The server wanted to expose support for proprietary audio
 capabilities (such as vendor-specific audio codecs, as denoted by the
 Codec_ID parameter value) separately from support for
 non-vendor-specific audio capabilities and used separate Sink PAC
 characteristics to expose such support.
 - The server wanted to minimize the amount of data to be transferred,
 when sending notifications to a client that the Sink PAC
 characteristic value changed, by exposing the audio capabilities
 likely to change quicker than others in separate Sink PAC
 characteristics.
---
 src/shared/bap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 21aa8aa6c5ca..7a24824a71fc 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2908,10 +2908,12 @@ static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
 		DBG(bap, "Sink PAC found: handle 0x%04x", value_handle);
 
 		pacs = bap_get_pacs(bap);
-		if (!pacs || pacs->sink)
+		if (!pacs)
 			return;
 
-		pacs->sink = attr;
+		if (!pacs->sink)
+			pacs->sink = attr;
+
 		bap_read_value(bap, value_handle, read_sink_pac, bap);
 	}
 
@@ -2919,10 +2921,12 @@ static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
 		DBG(bap, "Source PAC found: handle 0x%04x", value_handle);
 
 		pacs = bap_get_pacs(bap);
-		if (!pacs || pacs->source)
+		if (!pacs)
 			return;
 
-		pacs->source = attr;
+		if (!pacs->source)
+			pacs->source = attr;
+
 		bap_read_value(bap, value_handle, read_source_pac, NULL);
 	}
 
-- 
2.37.3

