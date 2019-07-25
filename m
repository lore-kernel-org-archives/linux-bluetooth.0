Return-Path: <SRS0=LIv6=VW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A687CC76191
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 19:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8AA218EA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 19:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="V50dBrLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfGYTts (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:49:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45599 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfGYTts (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jul 2019 15:49:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so35376835lfm.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 12:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QpkYN7FS0vv7AK1SdnAf8oOSyU+XRiuQBNES0LDTrxg=;
        b=V50dBrLS9WLQx5rOAzapvtheAEUw7txzXbe1DHGIj5mz1+NBnv7uylHfOoWHis333u
         tsMQy8O9NjW+o11wppfzQaBAofL5kzc5MzgR7vRoqGnurePlJcGhQxIY+hJuFtmV92tL
         apByd2EEq7eqvFxMdWUC93lnKmAfeJoV7bfATyUlJENfMbyVxT8pzvhpEQIspWBEGXun
         Qghe+LkG3soLN2AnIs7/wi5E6tlAQACK5JJcnkwmjaDiFRzcAGvnXQGK1jh6RrSYrWwN
         ZmQECaclLcqLFoTHzur8QmNTXL1a0fZLihT3tOEvWJZ9dbLi9iOOhLmlfcOBci3nsbmL
         e1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QpkYN7FS0vv7AK1SdnAf8oOSyU+XRiuQBNES0LDTrxg=;
        b=A7DJM38BWILjz5erwdVjg/VGpyyOAfSn9gAMIV7mcOqOyDk6lzj8qiYRdJQi6MFe0N
         YJG4B+g95iXcbAHlcXTOC4lQI/8hLWr502uxR3WEx1HPqbp03pUBz7ZC115DnNoCPp0W
         x1MAfYb4/hqexXfFuD6CiTm0gmvsrRRM8xyMAkAD5ZoYxTPapYPohBVgs6599BlRe6rK
         dlNJKhFRgL/FdKiVipK7zRUYMQbDQwDkEBuikPIC8wyVURkmXD+LvY4IU/9f0mjcRQNj
         I8nbWOXr68iFy0TL+s1AEY7OgUTh1qrVwy+g8Y2tzsO1fSAXoIlYRc+xB5U/vFaNUgW3
         hNXA==
X-Gm-Message-State: APjAAAVJ9zMa9GygZ5D4dRUQzZ9wnSZBRc4mOoiVmrbkO1MXUB/rER3t
        PCRKpvA4tI+p+w/YVmufpB4pgdzxmss=
X-Google-Smtp-Source: APXvYqzpR2bsXzSjv0MO/p5wX0zjgqKSHQoYSQ81GD0mQNNL5ao6O0hDNJVLORr8fHVZnXsPl4HOwg==
X-Received: by 2002:a19:80c4:: with SMTP id b187mr40569154lfd.122.1564084185907;
        Thu, 25 Jul 2019 12:49:45 -0700 (PDT)
Received: from kynes.internet.domowy (apn-95-40-32-72.dynamic.gprs.plus.pl. [95.40.32.72])
        by smtp.gmail.com with ESMTPSA id e62sm9327693ljf.82.2019.07.25.12.49.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 12:49:45 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 4/5] mesh: Check that element indexes are consecutive
Date:   Thu, 25 Jul 2019 21:49:32 +0200
Message-Id: <20190725194933.7321-5-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190725194933.7321-1-michal.lowas-rzechonek@silvair.com>
References: <20190725194933.7321-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/node.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mesh/node.c b/mesh/node.c
index 68cce7baf..1709a25ba 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -898,6 +898,7 @@ uint8_t node_friend_mode_get(struct mesh_node *node)
 uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 {
 	uint16_t n, features;
+	uint16_t num_ele = 0;
 	const struct l_queue_entry *ele_entry;
 
 	if (!node || !node->comp || sz < MIN_COMP_SIZE)
@@ -935,6 +936,11 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 		uint8_t num_s = 0, num_v = 0;
 		uint8_t *mod_buf;
 
+		if (ele->idx != num_ele)
+			return 0;
+
+		num_ele++;
+
 		/* At least fit location and zeros for number of models */
 		if ((n + 4) > sz)
 			return n;
@@ -997,6 +1003,9 @@ element_done:
 
 	}
 
+	if (!num_ele)
+		return 0;
+
 	return n;
 }
 
-- 
2.22.0

