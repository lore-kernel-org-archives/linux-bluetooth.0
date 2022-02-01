Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4BCC43219
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Feb 2022 20:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiBAUKk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238292AbiBAUKj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Feb 2022 15:10:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B95C06173D
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Feb 2022 12:10:38 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f17so34211434wrx.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Feb 2022 12:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/QTYMxwWed/jQIivtJaGb3o5ZDyC8gqB+NImkJjoA+M=;
        b=JXN4J+U4ybo1XaOBBo7HQNDnuEVPxKjrN5tdGWzMMbVOLqXoeXyYfGDYu8IvuCDbPI
         ezts9OVNvKXmaOjD6UOM0iGK3/d/o6rvSx6kOctKOOI0rXzhTEv1TqciJLM3BWttb1sh
         vDt6zzeIIUHpxqqqFF9unN05/Y88LcOTq9+JjaO2z6B7coAzYdqXj7IMQoEBuL4NW+e2
         R3A9W0n38KcaQ0U2jKTfBW7LGenqhv+3eP8Xo2OcICfXROXvcEgT9G9PVkA81MHvCXTu
         Rs8+bYjOEHGLKV1bVYUPZQEysdsNA4G/8ObwDARoTdKOu+Slu2FiSVIPr4QKHWsadepk
         DPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/QTYMxwWed/jQIivtJaGb3o5ZDyC8gqB+NImkJjoA+M=;
        b=0okyJhZKEEg9VX1a+mzPBR9lsgK5QTA20+tn+OCboSX5QaoUQVsoPBoUIBQd/jgjX5
         x0o5UFI/WU6lYcThYNmXFKDeeFUSvRHFgB0iIN+2ztWmUle95esYzsGKK3g+8y9rFvhi
         ARblT97RmPniEPPuRoO8an+Fu5sv9sDAJfNve1iQqG73mzcHxwUodcjAE5iyo4SQbE2d
         pLxQ6kaocep8NJGxkJXCcKrScy1PJBY/9laAJxXM8X3B+FyCLw5VgR3ZAoEehi348ya+
         iXPdt5HnOo3HTeNbHOK7Dwr+J0OxQnx8cVO2JRwUCfyJcwtkfaZO5d9X2bEqIHUXUBWD
         TAqw==
X-Gm-Message-State: AOAM530DX5OVN0J00LbnGInBYDeMYZcH+QKWYVLZm1CFzEY6Py9oJPnN
        1mFS1qNcLG/G+qN0jjmZVauL3YxAFWanNVR7
X-Google-Smtp-Source: ABdhPJyvV+VbIFtquoXk4TviqfiJO+m5Z/uMAkZJ0k3dP090sT+BMkVTmEjrX50WEM/5AiXXTbxJXw==
X-Received: by 2002:a5d:598b:: with SMTP id n11mr22868122wri.702.1643746237273;
        Tue, 01 Feb 2022 12:10:37 -0800 (PST)
Received: from biernacki.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id az16sm2797448wmb.15.2022.02.01.12.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 12:10:36 -0800 (PST)
From:   Radoslaw Biernacki <rad@semihalf.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        upstream@semihalf.com, Radoslaw Biernacki <rad@semihalf.com>,
        Angela Czubak <acz@semihalf.com>,
        Marek Maslanka <mm@semihalf.com>
Subject: [PATCH v3 2/2] Bluetooth: Improve skb handling in mgmt_device_connected()
Date:   Tue,  1 Feb 2022 20:10:33 +0000
Message-Id: <20220201201033.1332733-3-rad@semihalf.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220201201033.1332733-1-rad@semihalf.com>
References: <20220201201033.1332733-1-rad@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch introduce eir_skb_put_data() that can be used to simplify
operations on eir in goal of eliminating the necessity of intermediary
buffers.
eir_skb_put_data() is in pair to what eir_append_data() does with help of
eir_len, but without awkwardness when passing return value to skb_put() (as
it returns updated offset not size).

Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
---
 net/bluetooth/eir.h  | 15 +++++++++++++++
 net/bluetooth/mgmt.c | 25 ++++++++-----------------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/eir.h b/net/bluetooth/eir.h
index e5876751f07e..43f1945bffc5 100644
--- a/net/bluetooth/eir.h
+++ b/net/bluetooth/eir.h
@@ -41,6 +41,21 @@ static inline u16 eir_append_le16(u8 *eir, u16 eir_len, u8 type, u16 data)
 	return eir_len;
 }
 
+static inline u16 eir_skb_put_data(struct sk_buff *skb, u8 type, u8 *data, u8 data_len)
+{
+	u8 *eir;
+	u16 eir_len;
+
+	eir_len	= eir_precalc_len(data_len);
+	eir = skb_put(skb, eir_len);
+	WARN_ON(sizeof(type) + data_len > U8_MAX);
+	eir[0] = sizeof(type) + data_len;
+	eir[1] = type;
+	memcpy(&eir[2], data, data_len);
+
+	return eir_len;
+}
+
 static inline void *eir_get_data(u8 *eir, size_t eir_len, u8 type,
 				 size_t *data_len)
 {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 43ca228104ce..4a24159f7dd6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9087,18 +9087,12 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 		skb_put_data(skb, conn->le_adv_data, conn->le_adv_data_len);
 		eir_len = conn->le_adv_data_len;
 	} else {
-		if (name_len > 0) {
-			eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE,
-						  name, name_len);
-			skb_put(skb, eir_len);
-		}
+		if (name)
+			eir_len += eir_skb_put_data(skb, EIR_NAME_COMPLETE, name, name_len);
 
-		if (memcmp(conn->dev_class, "\0\0\0", 3) != 0) {
-			eir_len = eir_append_data(ev->eir, eir_len,
-						  EIR_CLASS_OF_DEV,
-						  conn->dev_class, 3);
-			skb_put(skb, 5);
-		}
+		if (memcmp(conn->dev_class, "\0\0\0", sizeof(conn->dev_class)))
+			eir_len += eir_skb_put_data(skb, EIR_CLASS_OF_DEV,
+						    conn->dev_class, sizeof(conn->dev_class));
 	}
 
 	ev->eir_len = cpu_to_le16(eir_len);
@@ -9798,13 +9792,10 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev->addr.type = link_to_bdaddr(link_type, addr_type);
 	ev->rssi = rssi;
 
-	if (name) {
-		eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE, name,
-					  name_len);
-		skb_put(skb, eir_len);
-	} else {
+	if (name)
+		eir_len += eir_skb_put_data(skb, EIR_NAME_COMPLETE, name, name_len);
+	else
 		flags = MGMT_DEV_FOUND_NAME_REQUEST_FAILED;
-	}
 
 	ev->eir_len = cpu_to_le16(eir_len);
 	ev->flags = cpu_to_le32(flags);
-- 
2.35.0.rc2.247.g8bbb082509-goog

