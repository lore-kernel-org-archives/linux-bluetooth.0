Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D8CC433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 06:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326B92071E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 06:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YYsjJEJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHZGhy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgHZGht (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 02:37:49 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A0AC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2020 23:37:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 31so529638pgy.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2020 23:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zzoAm6sUSyHag4twlxTUJvc8Ko0bHT2KVfZ37UKyfE=;
        b=YYsjJEJvJh7OGn/tXYsRbZtl7MPAw/IERKcq3mG2Om5PezaBePnLcyFMLg8BD3PTy/
         PcCKIWiw+CkPQ4Xy2pCCaZamo7PP4lztcGGXKy49kJE6ec1XstHskar28SlkEmT1z8SU
         CJoa/NwR7TOk2+DlPe5dJY/qt9G0/AbIgcjqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zzoAm6sUSyHag4twlxTUJvc8Ko0bHT2KVfZ37UKyfE=;
        b=LhcpHrnmGvr4oj8OJIxi11GD9k7/9IpmEI2woOikhkOoHwrorxlltRONrPKBwQsw5H
         Fnk1Ze/KRFok/25l1ExlFjp3vncgcWYZ6fLa6pfkqHNoyI+Ym355YBC0e9JrU7KzdHPm
         gRYlRFwks789tLV2xX/PA9hjx3Zgv/DawXuZQEXjppFCfzQZa+cn+q1+ZwETrUwdS0S5
         7ku/Duh64WpfCze8+7v2OSujyGliJhwnpAK8wY/o8/uE+aTwjBR305Y4B2oCtuO0s9TS
         Ez/gtzRXFwdi71enYniWAq9ERSXE2/6BOsLmq7pYO4bLni0xmVPy5Ek967cTyj0JcEZt
         lv/Q==
X-Gm-Message-State: AOAM532EMIovKfEbj/ZkTXg+nJ3AMHbnBD8kxmq51DYDOU1nc/vXwd4n
        3W1fOsvZ87nkvUf3z4wDo6D+wXMoh2IEQg==
X-Google-Smtp-Source: ABdhPJwAOj3T3sb5HI/2wq6rPObsyEI1fWGlSNQsHCzen/gxESKuOeILNadWdCJz6d/7NKb5SC734w==
X-Received: by 2002:a62:6497:: with SMTP id y145mr10819614pfb.97.1598423868094;
        Tue, 25 Aug 2020 23:37:48 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id c3sm1500852pfd.137.2020.08.25.23.37.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 23:37:47 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jie Jiang <jiejiang@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] gatt: Accept empty array in parse_includes()
Date:   Tue, 25 Aug 2020 23:37:42 -0700
Message-Id: <20200826063742.76007-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jie Jiang <jiejiang@chromium.org>

Currently parse_includes() will return false if the "Includes" property
is an empty array. Empty array in the "Includes" property should be
treated as valid.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

---
 src/gatt-database.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 07d567078..e7e4a36a6 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2008,6 +2008,7 @@ static bool parse_includes(GDBusProxy *proxy, struct external_service *service)
 	DBusMessageIter iter;
 	DBusMessageIter array;
 	char *obj;
+	int type;
 
 	/* Includes property is optional */
 	if (!g_dbus_proxy_get_property(proxy, "Includes", &iter))
@@ -2018,9 +2019,9 @@ static bool parse_includes(GDBusProxy *proxy, struct external_service *service)
 
 	dbus_message_iter_recurse(&iter, &array);
 
-	do {
-		if (dbus_message_iter_get_arg_type(&array) !=
-						DBUS_TYPE_OBJECT_PATH)
+	while ((type = dbus_message_iter_get_arg_type(&array))
+					!= DBUS_TYPE_INVALID) {
+		if (type != DBUS_TYPE_OBJECT_PATH)
 			return false;
 
 		dbus_message_iter_get_basic(&array, &obj);
@@ -2028,11 +2029,12 @@ static bool parse_includes(GDBusProxy *proxy, struct external_service *service)
 		if (!queue_push_tail(service->includes, obj)) {
 			error("Failed to add Includes path in queue\n");
 			return false;
-
 		}
 
 		incr_attr_count(service, 1);
-	} while (dbus_message_iter_next(&array));
+
+		dbus_message_iter_next(&array);
+	}
 
 	return true;
 }
-- 
2.26.2

