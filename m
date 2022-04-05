Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AEBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Apr 2022 02:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiDECCJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Apr 2022 22:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiDECCH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Apr 2022 22:02:07 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FB245EF99
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 18:19:06 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a11so9258157qtb.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Apr 2022 18:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NUrAkQGQKdkGdKx4fXOK8rdMdpWvdngYYC4kgGVLqhE=;
        b=J+Wufke3aVHX3YAVcnwLqnyWJBNQ7pWVQd3/V93PrvVOnligj0JQsdX9aHUNaUpzP+
         v04bkGO9iwLritGAbm333bLmKeSYY9S0vhnGNZCV/r7oyvA9B9djrkTBcVMSQWG4iZcf
         j8uGqmPmXfhoH3apvWvFJO8VUYlqVqt7fYQKGq8QP4DqDs0f0KdKTBFrj4Hbl90tjZpG
         3zhVRec/wopdNOma/NTQv9j7gkx2AkZLWu3LfFdLo+NJziwwFdQ3ueRsR6+bpEy1xIeT
         nVPkDRKhG2VP/hp5icEd8+EgFL3pLzFSdsexxr2NC6fmmbNwrAaJmbxFN3kkTmIJx5CE
         J8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NUrAkQGQKdkGdKx4fXOK8rdMdpWvdngYYC4kgGVLqhE=;
        b=zRfMM7/ZKcf1AxCPvnIuRnXUr38kqf2ATkDf0Kqvwpl9SjRxuRIDZ56DUMzijaFRwK
         KA2u9PeBQcZoAxhjVkxByG4LdnkZyJe7DVoIHNOy7aIucEkgeMN/2N9BzyBMNxXY5Glv
         nX54YNTL70Z77MqGqUwsCDlxSdGu4JGYLPqrlQSVUJ1GmO4bcvTIPw/bkWuRcq6rUjFV
         AT1WFFhOSKggw7Wsrib5uJ/dzDL0BD/NUTghewVsbGhmVKrstz7+bmGb3fSI0T5/TNVC
         sAgoNkNYSi0Zfe6JaWxbMcITOydYrbQySi9T9EJySPqawtIxKn/LYk5erF4Sz+XxjaGB
         6G7A==
X-Gm-Message-State: AOAM5330j3GWGzvanHbsVUuIjGHo+mP6cTy9VDAIjiJpsUF4dt0iHJGk
        +bi9YDaRVCSDs1UoYE59QlYkjJASqok=
X-Google-Smtp-Source: ABdhPJzy1dNTI3Shj9CpiKbzdL/D6Z298EFxZsQi0IcrlCO/8CALC4LyqMey5vyCEuny+RHQSLGe/A==
X-Received: by 2002:a05:6638:4122:b0:323:d3db:2bdc with SMTP id ay34-20020a056638412200b00323d3db2bdcmr556326jab.121.1649119335717;
        Mon, 04 Apr 2022 17:42:15 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v9-20020a92c809000000b002ca351aa12fsm3266020iln.70.2022.04.04.17.42.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 17:42:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] btdev: Add support for sending LE BIG Info Adv Reports
Date:   Mon,  4 Apr 2022 17:42:13 -0700
Message-Id: <20220405004213.1164595-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405004213.1164595-1-luiz.dentz@gmail.com>
References: <20220405004213.1164595-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for sending LE BIG Info Adv Reports if LE Create BIG
has been called.
---
 emulator/btdev.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 9dc7b1e90..2ee39ab0b 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1139,7 +1139,8 @@ static struct btdev_conn *conn_add_bis(struct btdev *dev, uint16_t handle,
 	return conn;
 }
 
-static struct btdev_conn *find_bis_index(struct btdev *remote, uint8_t index)
+static struct btdev_conn *find_bis_index(const struct btdev *remote,
+							uint8_t index)
 {
 	struct btdev_conn *conn;
 	const struct queue_entry *entry;
@@ -5105,6 +5106,40 @@ static int cmd_set_pa_data(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static void send_biginfo(struct btdev *dev, const struct btdev *remote)
+{
+	struct bt_hci_evt_le_big_info_adv_report ev;
+	const struct btdev_conn *conn;
+	struct bt_hci_bis *bis;
+
+	conn = find_bis_index(remote, 0);
+	if (!conn)
+		return;
+
+	bis = conn->data;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.sync_handle = cpu_to_le16(dev->le_pa_sync_handle);
+	ev.num_bis = 1;
+
+	while (find_bis_index(remote, ev.num_bis))
+		ev.num_bis++;
+
+	ev.nse = 0x01;
+	ev.iso_interval = bis->latency;
+	ev.bn = 0x01;
+	ev.pto = 0x00;
+	ev.irc = 0x01;
+	ev.max_pdu = bis->sdu;
+	memcpy(ev.sdu_interval, bis->sdu_interval, sizeof(ev.sdu_interval));
+	ev.max_sdu = bis->sdu;
+	ev.phy = bis->phy;
+	ev.framing = bis->framing;
+	ev.encryption = bis->encryption;
+
+	le_meta_event(dev, BT_HCI_EVT_LE_BIG_INFO_ADV_REPORT, &ev, sizeof(ev));
+}
+
 static void send_pa(struct btdev *dev, const struct btdev *remote,
 						uint8_t offset)
 {
@@ -5135,7 +5170,10 @@ static void send_pa(struct btdev *dev, const struct btdev *remote,
 	if (pdu.ev.data_status == 0x01) {
 		offset += pdu.ev.data_len;
 		send_pa(dev, remote, offset);
+		return;
 	}
+
+	send_biginfo(dev, remote);
 }
 
 static void le_pa_sync_estabilished(struct btdev *dev, struct btdev *remote,
-- 
2.35.1

