Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0553C433ED
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Apr 2021 01:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B5B610D1
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Apr 2021 01:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhDKBfU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Apr 2021 21:35:20 -0400
Received: from sender4-op-o13.zoho.com ([136.143.188.13]:17377 "EHLO
        sender4-op-o13.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbhDKBfT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Apr 2021 21:35:19 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Apr 2021 21:35:19 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1618103999; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bLJYY90KCidQPvZ9YDMrIw3QLs7zN+jhlijJNOPoo5gAhyUkNxhfqPYpBC1IyqXqnCvct6JDclMqRxhxZFrXrjWiuIov6WqYMxAYPfHq4vr5rtmkFtgaRER1TyV/ndqUhZkyMZv4J/TTiBhxRPcv0P2CwFH/cfnqA0rprTBaaw4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1618103999; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=jKmLEp7o5pcOvhFez1HIxlncTaW6WPSxiswq/eBvAR0=; 
        b=OkMighUAQR2GBBWSdsf3Z/TWQ0ElUEQsOgeZkSBP/PpX2JNiXjFZhQlmRpeuVWC2q9zdgi13H/Cx66HciQ8/nQXybnmDyBw1G0zoSHSdHkNUS0a0DMeuwwr+BLznQrw4NbiaCGJZ6Cw9OQOS8m5X7I74i6Mxr/I/qdQF+Z2vuzA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=maves.io;
        spf=pass  smtp.mailfrom=curtis@maves.io;
        dmarc=pass header.from=<curtis@maves.io> header.from=<curtis@maves.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618103999;
        s=dkim; d=maves.io; i=curtis@maves.io;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=jKmLEp7o5pcOvhFez1HIxlncTaW6WPSxiswq/eBvAR0=;
        b=mz1GKDUqiYc21OsLkOZgIUxJPNQLM/2bcnJnzgXi6Nbwbr1lEa2x+YOQo1nH7GzY
        ESCcSBg0RUqAvC1Yd0ggZaToueFZGU4yB5u8zsZFtIHlTBPQpKOQJ3MQwW9iIh+NkaQ
        TXCO1MzMTWC2vSNfkwCS/5N/jaySUV+wnttpkIeM=
Received: from maves-arch-laptop.attlocal.net (107-216-162-79.lightspeed.iplsin.sbcglobal.net [107.216.162.79]) by mx.zohomail.com
        with SMTPS id 1618103996038364.29060430545974; Sat, 10 Apr 2021 18:19:56 -0700 (PDT)
From:   Curtis Maves <curtis@maves.io>
To:     linux-bluetooth@vger.kernel.org
Cc:     Curtis Maves <curtis@maves.io>
Subject: [PATCH Bluez] Select either notifications or indications, not both
Date:   Sat, 10 Apr 2021 21:17:30 -0400
Message-Id: <20210411011730.31780-1-curtis@maves.io>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

AcquireNotify and StartNotify starts notifications and/or indications
by whether the characteristic supports them. Before this patch, if both
were supported, Bluez would try to start both simultaneously. This
patch changes this behavior so if both are supported, only
notifications are started.
---
 src/shared/gatt-client.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 4e10f244d..1ff5e94ee 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1591,14 +1591,13 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
 	put_le16(notify_data->chrc->ccc_handle, pdu);
 
 	if (enable) {
-		/* Try to enable notifications and/or indications based on
+		/* Try to enable notifications or indications based on
 		 * whatever the characteristic supports.
 		 */
 		if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_NOTIFY)
 			pdu[2] = 0x01;
-
-		if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_INDICATE)
-			pdu[2] |= 0x02;
+		else if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_INDICATE)
+			pdu[2] = 0x02;
 
 		if (!pdu[2])
 			return false;
-- 
2.31.1

