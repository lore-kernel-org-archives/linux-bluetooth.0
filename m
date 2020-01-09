Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47B9C282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 12:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773962075D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 12:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="WJOLmYOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgAIM7I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:59:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37509 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgAIM7H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 07:59:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id o13so7130616ljg.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jan 2020 04:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxE98GUlWxAi1TfQbwxjzpPgJatrskDS49HT8RDKdTU=;
        b=WJOLmYOBFC4QMBbAJvglCcEiUPzsZ/BD9ObnJWLWsi+Rzqq+Vns0XsyelW6uFpZwQ/
         ZXALiFmO5md5zmso34HdKiskzEy1lBUmy2P6Ftl1A9yz/PYsqiZW20ThzS6IVzWc8xmu
         UiGFsEz3ubpaJFg/4uI4Q/6aYgEP1s1hbTAL4Hk8Ad33qVIx6QX2H5Fu0zIQk1+K8T4y
         JzUv1aaA03UafmCk0bx1lytK4RRWZ9RwAbrw2dKPYwggu+UQzilR0Fg71u+e9VOEcM1l
         DbMc/0OvQMcWSp9dV5gsQkV0JSdANpQj4YSrAOBDEzwHcNxT/RovG7Pp2+xi9XUoW836
         bUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QxE98GUlWxAi1TfQbwxjzpPgJatrskDS49HT8RDKdTU=;
        b=gAB8Tn3rvLajJajmxHLyzZQ5GV/BoYm6sV988SEqzwbUaM60Sqlv4JocLOcczeeplj
         GiOcrKC1XbOUh2z8G28HrOeSCgLjX2pemF2FPBEIZWTcHxbrxhIiVypfLAQv58D0YQRD
         rjrKOUOi0SGe+xEEo3dq9G938wbsq+U1aDuWQLzRa4A22V53YKXLKyLEPuRtO4yclJIN
         QFqTZ6clEUAaRJr5oYcPkNJRssHN+CABKYla73vRWo90tM7jz3vT1frqdTk8KxsU+tm2
         QVyo5wmg1SfoyzTYFkTzvNeFolTUHgUI/jUewKwPi4KZEW1bMe8OEDcxd1GQxf9ud991
         mBDg==
X-Gm-Message-State: APjAAAWG45Fz2OKxEyoA5crC6XXCOkB/iepxHi5P5gVZ9MVBfJZIDnju
        /Edq0aMKcSotg+qUX8tei0sOKSb5e7w=
X-Google-Smtp-Source: APXvYqwxjVYNmPrGOZ7f1kaB1eqsW3yZ/7cbvDXrQEgigCRuWmTpeQbCDUCpqY5sOQylyW75UjhxtQ==
X-Received: by 2002:a2e:3005:: with SMTP id w5mr6603207ljw.184.1578574745125;
        Thu, 09 Jan 2020 04:59:05 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id u3sm3033171lfm.37.2020.01.09.04.59.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 04:59:04 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix exiting IV_UPD_STATE when receiving first SNB
Date:   Thu,  9 Jan 2020 13:58:59 +0100
Message-Id: <20200109125859.5389-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

First valid SNB received from the network should cause the node to
switch into IV_UPD_NORMAL state.

Otherwise, it will never try to enter IV Update procedure when sequence
number approaches the IV_UPDATE_SEQ_TRIGGER, because that's only allowed
in IV_UPD_NORMAL.
---
 mesh/net.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 20e9a1e81..bd8826b58 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2688,11 +2688,17 @@ static void process_beacon(void *net_ptr, void *user_data)
 	/* We have officially *seen* this beacon now */
 	beacon_data->processed = true;
 
-	if (ivi == net->iv_index && ivu == net->iv_update && kr == local_kr)
-		return;
+	/*
+	 * Ignore the beacon if it doesn't change anything, unless we're
+	 * doing IV Recovery
+	 */
+	if (net->iv_upd_state == IV_UPD_INIT ||
+				ivi != net->iv_index || ivu != net->iv_update)
+		update_iv_ivu_state(net, ivi, ivu);
+
+	if (kr != local_kr)
+		update_kr_state(subnet, kr, beacon_data->key_id);
 
-	update_iv_ivu_state(net, ivi, ivu);
-	update_kr_state(subnet, kr, beacon_data->key_id);
 	net_key_beacon_refresh(beacon_data->key_id, net->iv_index,
 		!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO), net->iv_update);
 }
-- 
2.19.1

