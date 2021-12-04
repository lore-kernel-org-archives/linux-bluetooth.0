Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8074EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Dec 2021 00:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383644AbhLDATM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 19:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383642AbhLDATL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 19:19:11 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C788C061751
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 16:15:46 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so3800923pjb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Dec 2021 16:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M+jNHxwfLsPyteI00sSbEWzWWAo2qkIuzfSmXBKVTOA=;
        b=g7q/FXBRr6zko4OnM0m0DiEULYRMO4xUK0gooEVmTlBA/IacmITAWiUQRo5oAvNKal
         xsnSTTt+fNaUid7qD4YoRWToNhBopeIyOabGMFdkLcbcAPaMI+bVkTKssfVMg6iWk/vr
         k6WDh8nTqjLDC1N8stR6MN3DA7eKn27OXUJ4uDofLnBF5Rz8IYIrxYMysN7WcqXv7EgD
         PpmMz73mbGD/NOVZIqFagkYD49f07glSy16cMylBWxkG0oBPhWZo8Ywb9Khg5gV+kVd8
         UiffW4622RywdhrdMx+E+NKky/oPfuKIMQ+SvwcXZnKlMhc3Up5VGnvvDCRAnEbnkFZb
         TG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+jNHxwfLsPyteI00sSbEWzWWAo2qkIuzfSmXBKVTOA=;
        b=KJO8l0IooKIVlPN521pYbzeYAREk49W2iJm8koPirt6SykUbem660fQnD1DZfcL0WS
         JxE6WSJ+3uLj7rhSRaQZp/Uczh3YFBSn/iIfP2mCLPMDQhyg4OFEPPDIir/IMgq95aEZ
         o+ssYmmVKYnQTOllWTHjbQYcVosTLX4ngLxIVrlsp2I5HLRWOxyxhEJHQe0aInBZa9U7
         qRPvilcvy/LDQRe3Wd8H9+a7TPzyZt0W2N6/QqweyD3FGOv8lxIBAiv1PSibezXjv4Iw
         XnMS20Z2LTbh6CG7btCl3qeE4iqqaVuTAMYluD89qoLSw96PkFszJzi5lTq+IG3rl8F6
         eoHg==
X-Gm-Message-State: AOAM533nRLQCExeRNXMdMcJ8I3uHJAFtncgOjkfA8cyPCqFv474tD5qV
        nsDXNzHIoyEILpQq06/HsCTWLXpDbtE=
X-Google-Smtp-Source: ABdhPJwlZ4kNCloIojRNkFRRn+5iVIBjcgyu68awjYB0cS5XYTNoxzCZl6XYKYdbEJBSHX8m0iUfFQ==
X-Received: by 2002:a17:902:e9c6:b0:141:c588:99b2 with SMTP id 6-20020a170902e9c600b00141c58899b2mr26410502plk.63.1638576945881;
        Fri, 03 Dec 2021 16:15:45 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g21sm4381221pfc.95.2021.12.03.16.15.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 16:15:45 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: mgmt: Make use of mgmt_send_event_skb in MGMT_EV_DEVICE_CONNECTED
Date:   Fri,  3 Dec 2021 16:15:42 -0800
Message-Id: <20211204001542.2404778-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204001542.2404778-1-luiz.dentz@gmail.com>
References: <20211204001542.2404778-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of mgmt_alloc_skb to build MGMT_EV_DEVICE_CONNECTED so
the data is copied directly to skb that is then sent using
mgmt_send_event_skb eliminating the necessity of intermediary buffers.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8a66f947c543..cee771516431 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9015,11 +9015,19 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 			   u8 *name, u8 name_len)
 {
-	char buf[512];
-	struct mgmt_ev_device_connected *ev = (void *) buf;
+	struct sk_buff *skb;
+	struct mgmt_ev_device_connected *ev;
 	u16 eir_len = 0;
 	u32 flags = 0;
 
+	if (conn->le_adv_data_len > 0)
+		skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_CONNECTED,
+				     conn->le_adv_data_len);
+	else
+		skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_CONNECTED,
+				     2 + name_len + 5);
+
+	ev = skb_put(skb, sizeof(*ev));
 	bacpy(&ev->addr.bdaddr, &conn->dst);
 	ev->addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 
@@ -9033,24 +9041,26 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 	 * adding any BR/EDR data to the LE adv.
 	 */
 	if (conn->le_adv_data_len > 0) {
-		memcpy(&ev->eir[eir_len],
-		       conn->le_adv_data, conn->le_adv_data_len);
+		skb_put_data(skb, conn->le_adv_data, conn->le_adv_data_len);
 		eir_len = conn->le_adv_data_len;
 	} else {
-		if (name_len > 0)
+		if (name_len > 0) {
 			eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE,
 						  name, name_len);
+			skb_put(skb, eir_len);
+		}
 
-		if (memcmp(conn->dev_class, "\0\0\0", 3) != 0)
+		if (memcmp(conn->dev_class, "\0\0\0", 3) != 0) {
 			eir_len = eir_append_data(ev->eir, eir_len,
 						  EIR_CLASS_OF_DEV,
 						  conn->dev_class, 3);
+			skb_put(skb, 5);
+		}
 	}
 
 	ev->eir_len = cpu_to_le16(eir_len);
 
-	mgmt_event(MGMT_EV_DEVICE_CONNECTED, hdev, buf,
-		    sizeof(*ev) + eir_len, NULL);
+	mgmt_event_skb(skb, NULL);
 }
 
 static void disconnect_rsp(struct mgmt_pending_cmd *cmd, void *data)
-- 
2.33.1

