Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E7C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 18:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbjFHSUm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jun 2023 14:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjFHSUl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jun 2023 14:20:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86791993
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 11:20:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-654f8b56807so886329b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jun 2023 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686248439; x=1688840439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PVuB3/23DwQdcVUb/m3iNnX2H4EOst6mJJ40Jy3AnJ0=;
        b=UEdIZtI45GZL+5VyiQoiw43LM7Uea5YjQxT5g0wYItLy5JiGgoivMi2H+DblGQGKki
         FZdpdBQoBF85mWzShsJL4yzsLuKOa4u8fEcmksrUBO4jUWIAHUj5Gd/EYwoc1C6RAEeD
         vbnNtlvTytPPc0sddhk9cB8SsTnnR4Rdq1uW3rgeUPn3pSJ3+Fqo0oWQ7pbmqa3dzVTr
         k6CYWfhRZ6LMFahbF2nsrbMp9WXgjQb3SsCHaZC0gyR+suzghp4FiwypP5g2WL9279em
         ZTUz9UyeLArU4CbrdTs7A9jX4AyCVpyBfPkjj2QHVa2La5rJexMYGt3AHOG+amUTCpmp
         qCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686248439; x=1688840439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVuB3/23DwQdcVUb/m3iNnX2H4EOst6mJJ40Jy3AnJ0=;
        b=aTkD30BYBhXJy9AI1pKB5KOBI2hi8KtgZ3vScradIKI7hS4yz3Lw5/ziEBSr9N2PRw
         umBX74bXKet7Rk71VqCxUoJ5wF+ckDMK1raW140GyL0Hn1CGhrghUAq+to3MfNamFDvn
         eWaIGqYVDBZfJ7uK/PE0uEzEgSHOdepzzk+Drk5cZaOGBL8QcBJ/e/2mSyCosmU1Wg01
         dpZYG1GrFqOk1WGHOI0JkGqndUbl6lId822VoOkZa96jPyr1qGnsAjolaS6usSs6WjSS
         xjbQ7qNCo5B9P0NwHLP6MMbiM69X7WaIQ+clTG1b7cRVZJpIpMLb16Pq50Ms48bOu9tg
         C6kw==
X-Gm-Message-State: AC+VfDwwHQN1QZhm0R6EC3WTsGVa5tCNe6iFerHWw4c3e5wBhJwpBRhq
        kKBb+gY7qX8IHYjaffwH7m/fqR/SwFw=
X-Google-Smtp-Source: ACHHUZ72hAnEn+UQmyMIVtqZejSpqzcvk7jXr8VrkanAD50lPkABxoIon7Bj+bgtsUC1UncR2yt18w==
X-Received: by 2002:a05:6a00:988:b0:653:91c1:1611 with SMTP id u8-20020a056a00098800b0065391c11611mr12895160pfg.14.1686248439159;
        Thu, 08 Jun 2023 11:20:39 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id r1-20020a62e401000000b00662b551e5c4sm1428958pfh.94.2023.06.08.11.20.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 11:20:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: ISO: Rework sync_interval to be sync_factor
Date:   Thu,  8 Jun 2023 11:20:37 -0700
Message-Id: <20230608182037.3332558-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This rework sync_interval to be sync_factor as having sync_interval in
the order of seconds is sometimes not disarable.

Wit sync_factor the application can tell how many SDU intervals it wants
to send an announcement with PA, the EA interval is set to 2 times that
so a factor of 24 of BIG SDU interval of 10ms would look like the
following:

< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
        Handle: 0x01
        Properties: 0x0000
        Min advertising interval: 480.000 msec (0x0300)
        Max advertising interval: 480.000 msec (0x0300)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Random (0x01)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
        TX power: Host has no preference (0x7f)
        Primary PHY: LE 1M (0x01)
        Secondary max skip: 0x00
        Secondary PHY: LE 2M (0x02)
        SID: 0x00
        Scan request notifications: Disabled (0x00)
< HCI Command: LE Set Periodic Advertising Parameters (0x08|0x003e) plen 7
        Handle: 1
        Min interval: 240.00 msec (0x00c0)
        Max interval: 240.00 msec (0x00c0)
        Properties: 0x0000

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h | 2 +-
 net/bluetooth/hci_conn.c          | 4 ++--
 net/bluetooth/iso.c               | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 310231e47b3d..34998ae8ed78 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -185,7 +185,7 @@ struct bt_iso_ucast_qos {
 struct bt_iso_bcast_qos {
 	__u8  big;
 	__u8  bis;
-	__u8  sync_interval;
+	__u8  sync_factor;
 	__u8  packing;
 	__u8  framing;
 	struct bt_iso_io_qos in;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7d4941e6dbdf..930fa38841bc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2074,10 +2074,10 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 		flags |= MGMT_ADV_FLAG_SEC_2M;
 
 	/* Align intervals */
-	interval = qos->bcast.out.interval / 1250;
+	interval = (qos->bcast.out.interval / 1250) * qos->bcast.sync_factor;
 
 	if (qos->bcast.bis)
-		sync_interval = qos->bcast.sync_interval * 1600;
+		sync_interval = interval * 4;
 
 	err = hci_start_per_adv_sync(hdev, qos->bcast.bis, conn->le_per_adv_data_len,
 				     conn->le_per_adv_data, flags, interval,
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index b9a008fd10b1..c7db728eb84f 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -718,7 +718,7 @@ static struct bt_iso_qos default_qos = {
 	.bcast = {
 		.big			= BT_ISO_QOS_BIG_UNSET,
 		.bis			= BT_ISO_QOS_BIS_UNSET,
-		.sync_interval		= 0x00,
+		.sync_factor		= 0x01,
 		.packing		= 0x00,
 		.framing		= 0x00,
 		.in			= DEFAULT_IO_QOS,
@@ -1219,7 +1219,7 @@ static bool check_ucast_qos(struct bt_iso_qos *qos)
 
 static bool check_bcast_qos(struct bt_iso_qos *qos)
 {
-	if (qos->bcast.sync_interval > 0x07)
+	if (qos->bcast.sync_factor == 0x00)
 		return false;
 
 	if (qos->bcast.packing > 0x01)
-- 
2.40.1

