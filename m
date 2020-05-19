Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C70DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A5C20657
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZS9BKLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgESUZ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 16:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgESUZ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 16:25:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7EFC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:25:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so351820plo.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8RsJAFse4tQUTtMZRIGokBhmh9gqfamTDFFuTSZHRkM=;
        b=YZS9BKLm3ePuo/Z5vhCEJG4BDQLcB8N2LleDwdAOCKlSCr3XnHUs2kAPBrkuPANJIh
         i/kO3YCSHVMZf1tVi/9Y2G7NFs7BkEQmQSScRgj1I56kY8+ngcDAr/IQbdooGy3fIb0+
         l8XqFB/xEjf+rwtSJUEeR61FMht8KZUXQZz0kVe/ZIjG6E2YRQsToyiDEk+n3VJ8goUU
         34sinM1pTPjhjyOdf3wNmeQlgQEf+luqPZUjaI6zXg1XO1NGCsYgUUILd8DcWIf/VIH/
         QOsvjRA03e72h4jA3vGVdwi9mXGb7FeqI7S3Bsl4e74SONvoVJ8RDqaHM5gctzN7PVti
         qjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8RsJAFse4tQUTtMZRIGokBhmh9gqfamTDFFuTSZHRkM=;
        b=QUBhpmFUKp9BBoADxnGe5K18ynlI4kEqnPdODfRjbvQ8zTpo2/fO+T5V4m6zDfFgjS
         XPOSJCUvxoLiysdVHummINUpZeMIagwN+3zS3/xc67osDlHLKNNBMm5QXp+bo346jnBj
         75FJi81s+cbmt9ORN+GpMt0ZkStHUt0pBjakPvlYPgV40KA7wdThXSTo/2IB6Q4wmDkf
         w6ArnkB+rL/PahHY86hVLOUp/TtKFqT5cX6C15Uw15pp1TCwiPICDAIvZwSRrFrH4uKG
         ZFPNQVMFBXTv2zMDmIXoSTl0clzdCp4mEv7+ilSH/JiXuiEXD4Z5t+3VQ8XLseo0mOF7
         TAcQ==
X-Gm-Message-State: AOAM532CgsccTGNEIZbSCh+mwh9tnnUWNny1gpGBoSyC4yyVfXDlSffj
        HUyl6DmrhLfSkFoCXag8hobKlxkW
X-Google-Smtp-Source: ABdhPJxMf36CkI2QIqVP9cFYitl6xnWln3A1CdhDsuzvY4a3XOgwbkAtBaxg8f+Zf6vRJkwgiuaHHg==
X-Received: by 2002:a17:902:684f:: with SMTP id f15mr1182373pln.237.1589919925169;
        Tue, 19 May 2020 13:25:25 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c184sm298808pfc.57.2020.05.19.13.25.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 13:25:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Consolidate encryption handling in hci_encrypt_cfm
Date:   Tue, 19 May 2020 13:25:19 -0700
Message-Id: <20200519202519.219335-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200519202519.219335-1-luiz.dentz@gmail.com>
References: <20200519202519.219335-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes hci_encrypt_cfm calls hci_connect_cfm in case the connection
state is BT_CONFIG so callers don't have to check the state.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 20 ++++++++++++++++++--
 net/bluetooth/hci_event.c        | 28 +++-------------------------
 2 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 239ab72f16c6..2fe8a5ca9a81 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1380,10 +1380,26 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 		conn->security_cfm_cb(conn, status);
 }
 
-static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
-								__u8 encrypt)
+static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 {
 	struct hci_cb *cb;
+	__u8 encrypt;
+
+	if (conn->state == BT_CONFIG) {
+		if (status)
+			conn->state = BT_CONNECTED;
+
+		hci_connect_cfm(conn, status);
+		hci_conn_drop(conn);
+		return;
+	}
+
+	if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
+		encrypt = 0x00;
+	else if (test_bit(HCI_CONN_AES_CCM, &conn->flags))
+		encrypt = 0x02;
+	else
+		encrypt = 0x01;
 
 	if (conn->sec_level == BT_SECURITY_SDP)
 		conn->sec_level = BT_SECURITY_LOW;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8c9051ffa665..34d09a084871 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2910,7 +2910,7 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 				     &cp);
 		} else {
 			clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
-			hci_encrypt_cfm(conn, ev->status, 0x00);
+			hci_encrypt_cfm(conn, ev->status);
 		}
 	}
 
@@ -2995,22 +2995,7 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 		conn->enc_key_size = rp->key_size;
 	}
 
-	if (conn->state == BT_CONFIG) {
-		conn->state = BT_CONNECTED;
-		hci_connect_cfm(conn, 0);
-		hci_conn_drop(conn);
-	} else {
-		u8 encrypt;
-
-		if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
-			encrypt = 0x00;
-		else if (test_bit(HCI_CONN_AES_CCM, &conn->flags))
-			encrypt = 0x02;
-		else
-			encrypt = 0x01;
-
-		hci_encrypt_cfm(conn, 0, encrypt);
-	}
+	hci_encrypt_cfm(conn, 0);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -3126,14 +3111,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 notify:
-	if (conn->state == BT_CONFIG) {
-		if (!ev->status)
-			conn->state = BT_CONNECTED;
-
-		hci_connect_cfm(conn, ev->status);
-		hci_conn_drop(conn);
-	} else
-		hci_encrypt_cfm(conn, ev->status, ev->encrypt);
+	hci_encrypt_cfm(conn, ev->status);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.25.3

