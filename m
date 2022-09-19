Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48A0ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 18:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiISSKx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 14:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiISSKX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 14:10:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA4145F59
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 11:10:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fv3so504119pjb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=BibEYMr1aP6AHThrHqt8q9yJYtigZ6uqEYQqy5sp3PI=;
        b=E8G3dz1RsKmHHQdLVOGBWw84tsnGdJbG0u6qLuLfHfYn07DTgxeMbnfHmLFNDAZirF
         GpvPI2I0FbllVzUS6mLoRG10WYkqK5B2gDcqcZonAD4KBhDqLvit/Jctw5LYzU5uKwyY
         De2eio3PDViNFXuejLs/5ErA4gqnGF5s6uVwdCQgp+AaRFhZJBHNgobIuhHO3hLtelhl
         r1wtHq7jGCyZ4Txhu/guCXP6/Pal7fgDP9S1P8s8HT+zvubS1c736/ZU6gnyCRVZYX1t
         eTqB21WTV+uHfxdMfO/Cf/bS7UHyGfUaskZcRlxTyTK8gg+cgOVXM+y7NghhYI16V4Rs
         Ennw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=BibEYMr1aP6AHThrHqt8q9yJYtigZ6uqEYQqy5sp3PI=;
        b=hlusFwgBMqs3hqY7ORnxFsRqk3tgPp38FgwB4/meFiYXjPjsLbprQ9/QdI7u3Rts5t
         7/JjPQsOYj20qaxIdKz0v5eVWbzgJNIiqJMqwBjMCYs7NmhbFMgadVIwkGlkMD3077Xb
         YQMZTspmQb3MVkryNIOeUVP84Al1D5Z9Kmk8x1SuCiT8mPEBAYJWjvOagERlXTrk65xe
         OIqklWw8o9TZ6+idDnkK79xTO1G8XOt9RCcC1buo7uy4PjEplHUkj3tLwk9XT1AMzJE+
         mesCJp8O1DbR6AwGBxEoXxgBMqFw+NLfZxvSj5xAE47fJP96sYgN8JvQ+Qi543DdUqQB
         zWew==
X-Gm-Message-State: ACrzQf2JYXBTzJozYRbvolk60AznyZJFKIfyzyUwrllqbp5VU4nP1aP9
        q90PpWk00R5V0S27Mdh3EpWIJ6hGG1w=
X-Google-Smtp-Source: AA6agR5uiLpMiSVMEVs3mHWzeU3wWHo74NWxwu9VJ3MysGXfUef/AuFzuELW0vnu9jiPZ7s/rxD3Uw==
X-Received: by 2002:a17:90b:3808:b0:202:c5ba:d71b with SMTP id mq8-20020a17090b380800b00202c5bad71bmr31707134pjb.18.1663611019235;
        Mon, 19 Sep 2022 11:10:19 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b0016c78f9f024sm20888307pln.104.2022.09.19.11.10.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 11:10:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: Make sure ISO events don't affect non-ISO connections
Date:   Mon, 19 Sep 2022 11:10:17 -0700
Message-Id: <20220919181017.1658995-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ISO events (CIS/BIS) shall only be relevant for connection with link
type of ISO_LINK, otherwise the controller is probably buggy or it is
the result of fuzzer tools such as syzkaller.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ed3e5b251af1..faca701bce2a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6791,6 +6791,13 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	if (conn->type != ISO_LINK) {
+		bt_dev_err(hdev,
+			   "Invalid connection link type handle 0x%4.4x",
+			   handle);
+		goto unlock;
+	}
+
 	if (conn->role == HCI_ROLE_SLAVE) {
 		__le32 interval;
 
@@ -6911,6 +6918,13 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	if (conn->type != ISO_LINK) {
+		bt_dev_err(hdev,
+			   "Invalid connection link type handle 0x%2.2x",
+			   ev->handle);
+		goto unlock;
+	}
+
 	if (ev->num_bis)
 		conn->handle = __le16_to_cpu(ev->bis_handle[0]);
 
-- 
2.37.3

