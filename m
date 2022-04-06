Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA52C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 21:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiDFVtV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbiDFVsx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 17:48:53 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5B213DB50
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 14:33:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id h63so4551707iof.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Apr 2022 14:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6acRurw9fcThdvCEq8EPqqhn0HgWF5uVMUUVD3XDssU=;
        b=OM8grVQRzWq7hTFlTdweSQjFrsAq6II/IBWxUqI4Mu6RNK5RH6117aXCWFMD2K9R3/
         bsQMX3OlJnyKfH2s7j7EUcsL/IQLC21hQmJ7cKf0NNNrKMJG3NryOZOi5uC7ls2dA5Vd
         c+O8w6EZQhgm0tWRa1lojZDBhbdO5mFIxkCD7Ah/4fTGeuzoJReWF2UBUukxgcABpVhs
         ZARavOs59ap4yD/fvWypeWCs+98Zbiw39lHRFGl/TI+GIYIFMToQnbhj/ySSSq/M+w2l
         aJ3UcLc/YBJgtJVMHMankbN3HTk7orfqBq7C3oSYsx4G97ehCrjFuzCG7dYqt6uh/TYa
         31yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6acRurw9fcThdvCEq8EPqqhn0HgWF5uVMUUVD3XDssU=;
        b=nXhErBEKAUV48Y85o2AlUXA1o0V/IFn1prqliVoacSqJpWO4WO1bqE6hLiJfznfyzZ
         eLFYBVWML4BQPoYJVGDGY4IsZhPetNryTVYi/ZR/L0NESuk9m1eqJ6SP+NghDgb6Dg1W
         1PN8CjaPMQA5jAGRcgpV8nOZe8DJEsgdai0fCaBxSi7XyjxxSsXb/WJxPTkizVoyqg68
         7wAC+lIdkD9pSL3yUS4NZG4PnHx4fljhrVZlAfl8w6fXZXhCc2xjNje9cYmr3/ZlpsJ4
         HZNvb7IdfIJXGTZ/KRZA/X3ejSlowWcLOmWAPOzUt79tXgYAZD7HNjRqZ9Eyzt0JY0Wn
         Bt8A==
X-Gm-Message-State: AOAM533ownQSWZ/Fq5d38ns/79poWbfvGA7ou4qK0ca0cf14kRTdw32h
        /g0fOb2KzBVAiAQWfx3jmOIMoXC2Ggk=
X-Google-Smtp-Source: ABdhPJx3AZ/5UDRgNPwnUa8rDditiWtd5UiPDgXdi+rjsgEUsWmqqQzppdOw/PXM1j7MAad+61nPbA==
X-Received: by 2002:a5e:c702:0:b0:64d:1640:9f8c with SMTP id f2-20020a5ec702000000b0064d16409f8cmr524493iop.176.1649280837935;
        Wed, 06 Apr 2022 14:33:57 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v12-20020a92cd4c000000b002ca50ef78e4sm4726322ilq.62.2022.04.06.14.33.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:33:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] btdev: Add support for sending LE BIG Info Adv Reports
Date:   Wed,  6 Apr 2022 14:33:54 -0700
Message-Id: <20220406213355.1918220-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406213355.1918220-1-luiz.dentz@gmail.com>
References: <20220406213355.1918220-1-luiz.dentz@gmail.com>
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
index 6f44103a7..71dbea4be 100644
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
+	ev.iso_interval = bis->latency / 1.25;
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

