Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83E0C35DF9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 07:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5A821556
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 07:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i67hY9nF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgBYHel (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:34:41 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:35781 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYHel (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Feb 2020 02:34:41 -0500
Received: by mail-pj1-f42.google.com with SMTP id q39so906562pjc.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 23:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Yc9twyfo2ofnnZ2ALGcCp/mhrgMLu+tyCCMaRloUOOY=;
        b=i67hY9nF/q6XyI20wWzS8FopSmFCERVkp4vqG5i2yl8Ebeh5YpYc/BVnOJPyGVAdAK
         t4WvIQw/1hY23ZJfMaJuVfLpIRqn0apYoKhR4P66FlCU45lN69oVcTlJGIUgAeh5KHHh
         j20sc1H7XwPOZg6cvsV7VV8RuyMMOJIQYDDNEaD5GtyqFu/0VcUcGa7d3n6XIogC4YeT
         ftzcXBNzuaSvu3Hm9c3C9ZWvZB2t2KQe7VoCW/As3KiF48cB9KNGVsoYLIqezYAtVK7y
         eLHZZ0ifNjypfcq2SKreN9qB4dYPlCLho/a8ca05/yiLv5nOxL6+I65GsnFfGn6mGCqV
         G2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yc9twyfo2ofnnZ2ALGcCp/mhrgMLu+tyCCMaRloUOOY=;
        b=NZQNsCgOqJXrHBwMuuUlSBXVL7mqi1c5NO2U0kPsaZU5BxpoSlX9EgwUzRRV/L7VKV
         99B48uAJh7XSI6BcPLms0dMOvcbnaVuCPEjjM8KRILjUe+lVydI7rSH3DXj8UiZkuLy9
         gIuXgmPgI0TtZmRex+I55MTL7aaCEWT90kiTbOQOl9IZjLd7FosDLU7otzKKFSTQpUNx
         YPFHueNvbJQeUttoUVKp1AXHZ0aLh1zsWGUlcN4SAzWMeRXC5I3o9J72SpRHQLUIJ9/c
         68FmXBoQ77F8gzATYpQeNO7t9pjcoct7wm47fLHjyvy7qEVNGK8yfN2M15yi9TCkxPW0
         ACtw==
X-Gm-Message-State: APjAAAXqdi3y4aqC/Ej2ICbpLgsCrLb55LuC8LaZ7o3ea2tiobuhORa1
        NlUlTVK3XFKWRX8caEECGbppMnQ2EM4=
X-Google-Smtp-Source: APXvYqy2A0SRs9TbxvyKOL7FlB0h9rMraaJnwaNkVlMtYNFHJ2OeMskvICLKbRaCisr2xWc8ACKUCw==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr52671372plf.255.1582616079599;
        Mon, 24 Feb 2020 23:34:39 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id j125sm15642787pfg.160.2020.02.24.23.34.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:34:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 2/5] Bluetooth: L2CAP: Add definitions for Enhanced Credit Based Mode
Date:   Mon, 24 Feb 2020 23:34:34 -0800
Message-Id: <20200225073437.11212-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225073437.11212-1-luiz.dentz@gmail.com>
References: <20200225073437.11212-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces the definitions for the new L2CAP mode called Enhanced
Credit Based Mode.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 093aedebdf0c..3e6544e53516 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -119,6 +119,10 @@ struct l2cap_conninfo {
 #define L2CAP_LE_CONN_REQ	0x14
 #define L2CAP_LE_CONN_RSP	0x15
 #define L2CAP_LE_CREDITS	0x16
+#define L2CAP_ECRED_CONN_REQ	0x17
+#define L2CAP_ECRED_CONN_RSP	0x18
+#define L2CAP_ECRED_RECONF_REQ	0x19
+#define L2CAP_ECRED_RECONF_RSP	0x1a
 
 /* L2CAP extended feature mask */
 #define L2CAP_FEAT_FLOWCTL	0x00000001
@@ -359,6 +363,7 @@ struct l2cap_conf_rfc {
  * ever be used in the BR/EDR configuration phase.
  */
 #define L2CAP_MODE_LE_FLOWCTL	0x80
+#define L2CAP_MODE_EXT_FLOWCTL	0x81
 
 struct l2cap_conf_efs {
 	__u8	id;
@@ -483,6 +488,39 @@ struct l2cap_le_credits {
 	__le16     credits;
 } __packed;
 
+#define L2CAP_ECRED_MIN_MTU		64
+#define L2CAP_ECRED_MIN_MPS		64
+
+struct l2cap_ecred_conn_req {
+	__le16 psm;
+	__le16 mtu;
+	__le16 mps;
+	__le16 credits;
+	__le16 scid[0];
+} __packed;
+
+struct l2cap_ecred_conn_rsp {
+	__le16 mtu;
+	__le16 mps;
+	__le16 credits;
+	__le16 result;
+	__le16 dcid[0];
+};
+
+struct l2cap_ecred_reconf_req {
+	__le16 mtu;
+	__le16 mps;
+	__le16 scid[0];
+} __packed;
+
+#define L2CAP_RECONF_SUCCESS		0x0000
+#define L2CAP_RECONF_INVALID_MTU	0x0001
+#define L2CAP_RECONF_INVALID_MPS	0x0002
+
+struct l2cap_ecred_reconf_rsp {
+	__le16 result;
+} __packed;
+
 /* ----- L2CAP channels and connections ----- */
 struct l2cap_seq_list {
 	__u16	head;
@@ -724,6 +762,7 @@ enum {
 	FLAG_EFS_ENABLE,
 	FLAG_DEFER_SETUP,
 	FLAG_LE_CONN_REQ_SENT,
+	FLAG_ECRED_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
 };
-- 
2.21.1

