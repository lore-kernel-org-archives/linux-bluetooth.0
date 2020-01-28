Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DA6C33CB7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 02:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43E02467C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 02:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IXEnWsaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA1CFO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:05:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36946 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1CFO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jan 2020 21:05:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so5824144pfn.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2020 18:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1iYWOO81m2b+NFhF6XQobXZiUwHPHVTOJQnybZDmPQ=;
        b=IXEnWsajud5hk6koP89pU/T81PXmbkMtBjs78rQs0QUOK7l9+Kcxvs8ivyTMWBbqGd
         ZbbHahtZLOhgRnZvOJTS7//PM/lugRfxYZ9IFIT0axRBU2On4edZYO4enrf4eG5N7OCH
         PMh2tS1Do4o8jnntL4p5MQi/DwdNp3bNczWV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1iYWOO81m2b+NFhF6XQobXZiUwHPHVTOJQnybZDmPQ=;
        b=GXtwGuY8ZWgyVtXujNG3IIDIyl23gGpOS4yREOmy4NlOABdWjW11yKEXZFb2AeaOFD
         csHr/qHHsFm1Kl4++erAi1Yaogj9flyyvd2AleX211i2+RO9Kl0BxxKJPDRmurox27/3
         cH3AEc1V1IjlzLAfI5M5pPYVI26cY++Cy5Uy6SGXmQ8RXU9xxmP9M841KY8owp7SZwFD
         a4Sj1zHtYLcUUswms51T0pQ+WA+i6nlJC3Kfh/5/lTnbL2Vx2dBm4PqYzfcNWwK9tYa/
         O2SoWnXdH5RurBAUre/Upu5aXm51qZryyM1Z0xJ5Tpk+t1riYuNHtOapOO2xjeEJn9Gz
         /a8g==
X-Gm-Message-State: APjAAAVjU1Z6y+WjibRKccLaPoz+N8O5DXn2ambbSYvBrl9JghyuUKnF
        NxOEgOOfVgnKBEFc01+Wbd/Oow==
X-Google-Smtp-Source: APXvYqzXk/dz0C1A7uC4N7I8WGHz5Kp7x65zaIravhwcyOWuQjYfHGGgquTi9kpnGlTu2djd6QTRzw==
X-Received: by 2002:a63:358a:: with SMTP id c132mr23193049pga.286.1580177113667;
        Mon, 27 Jan 2020 18:05:13 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id z19sm17119015pfn.49.2020.01.27.18.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 18:05:13 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v3 3/5] client: Display wake capable property with info
Date:   Mon, 27 Jan 2020 18:05:03 -0800
Message-Id: <20200127180433.BlueZ.v3.3.I80d0e557c53f464415742324eb3ff2cc4cdcbc2a@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200128020505.239349-1-abhishekpandit@chromium.org>
References: <20200128020505.239349-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Display whether the device is configured as wake capable when queried
with cmd_info.

---

Changes in v3: None
Changes in v2:
* Newly added to show whether device is wake capable
* Removed automatically setting wake capable for HID devices

 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 8bd0bac9e..5c53fe08d 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1609,6 +1609,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "Trusted");
 	print_property(proxy, "Blocked");
 	print_property(proxy, "Connected");
+	print_property(proxy, "WakeCapable");
 	print_property(proxy, "LegacyPairing");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
-- 
2.25.0.341.g760bfbb309-goog

