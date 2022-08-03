Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C281C19F28
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 17:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbiHCRW1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbiHCRW0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 13:22:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F0E2CDDA
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 10:22:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so4092326pjh.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PV+sCKGtkIv2NwEB7ylZ5nabvvqIg+B7H5l+4ZRgX7U=;
        b=OY9X2eSGk4O+hQiJMMFWRxdZVSrvB/5borBJCcsjSN+M4r+oUE4FLuD5m2qAz4Kivn
         ZtSOAErAT1OhSnuLv23DWWtzDYQyTsZHHJ7Ph59rVH+o93OzoNrGdyGvxIQ5nQXAQSYe
         hdU25no5upkNPulOLzZKYXzMCHh/3t2zPM/VgjLcJCXyd1LkexMwzcpLYAXsScI7Q4ty
         VrhfCjV58gm7oG2J9Htvl5NdaumBWyyiWMcOZFHvyisrKuOg5aukjhQPLxNRv/jGLciZ
         vSItptlEyAd6W3JvyoUyfAh6VPt3k2jxRpicZiKGPcXZxlxjm4lRT6LMAobXIoWSpamU
         h+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PV+sCKGtkIv2NwEB7ylZ5nabvvqIg+B7H5l+4ZRgX7U=;
        b=w4dx9xsRvJQBwoDwW9SZPab2WprgHue9tQ0rBcZs3KjTVvn1euV/KUuAxyvWvX79bW
         7lqLw0ODHPRPvz2l6Enjq529psor7CQWWgGftCpoAzhWKWJGzLnDd+ENR6l3oL13Zz8m
         fYM5KYPxwsn1sA5EM3Nn82Z/MBRvN7uJUM6ZIX/Vx82n+lllGsROsltUW4dQlrYN3yLU
         gRVREeIpLuHn9AOwOeYHyCSQ7mxlvwLLqrFIJsUNrLeLaT4rX/a9nq54qKI1CjXRQgMn
         aQpu7JNxBh1I/iwYcPoJhDnCFvemLK49IaPVYMcK7JZ9iLjH8/eIcS6rpRxMGTLJhtX/
         Y1BQ==
X-Gm-Message-State: ACgBeo2lmQoQlF9Ticzz4025MpQ1x9+nU6lVBLp6N614MxA6BuKPbDhQ
        pifazgN17005BJzqnHKspYu0ZGKyV7nBOxNs
X-Google-Smtp-Source: AA6agR44FL/ajTgLAGTP74wKmavDaIESdEPecnw90FbBCiEO0YbfUeMNi9sF+U7hdyb0meCK1WWhdg==
X-Received: by 2002:a17:902:ce0e:b0:16c:7977:9d74 with SMTP id k14-20020a170902ce0e00b0016c79779d74mr27322738plg.92.1659547345009;
        Wed, 03 Aug 2022 10:22:25 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090301c300b0016befc83c6bsm2308214plh.165.2022.08.03.10.22.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:22:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] iso-tester: Test BT_DEFER_SETUP works with getsockopt
Date:   Wed,  3 Aug 2022 10:22:22 -0700
Message-Id: <20220803172222.2952373-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to test BT_DEFER_SETUP is properly set when the test has
defer flag set.
---
 tools/iso-tester.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index cae5fb4b7..56c17b78b 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1240,6 +1240,19 @@ static void setup_connect(struct test_data *data, uint8_t num, GIOFunc func)
 	}
 
 	if (isodata->defer) {
+		int defer;
+		socklen_t len;
+
+		/* Check if socket has DEFER_SETUP set */
+		len = sizeof(defer);
+		if (getsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP, &defer,
+				&len) < 0) {
+			tester_warn("getsockopt: %s (%d)", strerror(errno),
+								errno);
+			tester_test_failed();
+			return;
+		}
+
 		memset(&pfd, 0, sizeof(pfd));
 		pfd.fd = sk;
 		pfd.events = POLLOUT;
-- 
2.37.1

