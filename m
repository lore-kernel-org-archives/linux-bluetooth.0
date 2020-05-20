Return-Path: <SRS0=JpWv=7C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5669BC433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 21:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA2620823
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 21:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxDRcW58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgETVUV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 17:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgETVUV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 17:20:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A650C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 14:20:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b190so2192260pfg.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iZhuRKbyDTh3g42dSpXvTikCtlww+2CD2oa7D8LCk/Y=;
        b=GxDRcW58WRTaBJ7g/8vHVxBYuvEwEKZSF8ha73Xb1cvmcAbiKl3M0U+LT7Oi49jBg3
         X8xMnYYD1EqVKiMiLZDCG/8NnQErAO22uBL5NttT8n+eH07auVQrAa85UUye4VJybVTN
         DBJMn49xZA1bpOVBMJWQA9mxqzfr7V17batBsej8UX4gndUdkm731SN01undQ32ccj7Y
         wKXhbQ1Cq2s5QX1eox3UuBcZs5gI6HBSrAcI0GMFQqRBD4d0k/OMr+08tD2lY+31g8ph
         puIk5c7aoWmv2TP3VYH9vSvRKNqWo+7/sWL3OoHwtyNN0Glh56PUyfbp9SMXbbiWdiyq
         u6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZhuRKbyDTh3g42dSpXvTikCtlww+2CD2oa7D8LCk/Y=;
        b=oDqiSC8zIZMBxxuPOtHPNTAkqSLRkY6LF+gJV+b7qhjL7W6rUPbIfzkThemB1wIlna
         NL8kY0pN6YvxaO5SWFnb+FLuX16WlFhl0ccb2mwsiz0U8NmDgorYqI3+wR2uNggA55s+
         pkTgq+BYDwh4miLvpSsN7S4ydTaDq6JuAHZ+zxG6xFLAB1v8LgajMQ3XIgwDdyx4kmIe
         +UYD+6q6De6MYGKWNHjQqMYbNW/FY1nvtuMeurkjjdNA8cQlHKl62XSl0s5CVGksI/Ph
         DRoRhynYEFA2d2+95Bt44EXq2T+RGF6CVsj1UrmvINpAUfmJ+H3e3KvGHUiu7OsA27e/
         wiuQ==
X-Gm-Message-State: AOAM5338o+Gj5Lk5+I95LX6Bp+n7zwJ31EsZJaNga9SPPTmkoJ/AOA2F
        /cTFzjbwIJ0n6i/z4xfcupjknWpw
X-Google-Smtp-Source: ABdhPJzCMaVgTV2Z8Lb+n+tlWgykAOIEzco3Yo0Xvcou36oVZ/oW3gWJp+1R5N/KVqMPWoRGoTDENQ==
X-Received: by 2002:aa7:80cf:: with SMTP id a15mr6603196pfn.124.1590009620193;
        Wed, 20 May 2020 14:20:20 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o27sm2424524pgd.18.2020.05.20.14.20.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 14:20:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Fix bogus check for re-auth no supported with non-ssp
Date:   Wed, 20 May 2020 14:20:15 -0700
Message-Id: <20200520212015.626026-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200520212015.626026-1-luiz.dentz@gmail.com>
References: <20200520212015.626026-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reverts 19f8def031bfa50c579149b200bfeeb919727b27
"Bluetooth: Fix auth_complete_evt for legacy units" which seems to be
working around a bug on a broken controller rather then any limitation
imposed by the Bluetooth spec, in fact if there ws not possible to
re-auth the command shall fail not succeed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_conn.c         |  8 +++-----
 net/bluetooth/hci_event.c        | 11 ++---------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c69309ffd40a..13b90b5fdd3b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -732,7 +732,6 @@ void hci_inquiry_cache_flush(struct hci_dev *hdev);
 /* ----- HCI Connections ----- */
 enum {
 	HCI_CONN_AUTH_PEND,
-	HCI_CONN_REAUTH_PEND,
 	HCI_CONN_ENCRYPT_PEND,
 	HCI_CONN_RSWITCH_PEND,
 	HCI_CONN_MODE_CHANGE_PEND,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b99b5c6de55a..f595acf0032b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1372,12 +1372,10 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 		hci_send_cmd(conn->hdev, HCI_OP_AUTH_REQUESTED,
 			     sizeof(cp), &cp);
 
-		/* If we're already encrypted set the REAUTH_PEND flag,
-		 * otherwise set the ENCRYPT_PEND.
+		/* Set the ENCRYPT_PEND to trigger encryption after
+		 * authentication.
 		 */
-		if (test_bit(HCI_CONN_ENCRYPT, &conn->flags))
-			set_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
-		else
+		if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 			set_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d6a1e2450696..cfc7edcce3cd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2884,14 +2884,8 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!ev->status) {
 		clear_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
-
-		if (!hci_conn_ssp_enabled(conn) &&
-		    test_bit(HCI_CONN_REAUTH_PEND, &conn->flags)) {
-			bt_dev_info(hdev, "re-auth of legacy device is not possible.");
-		} else {
-			set_bit(HCI_CONN_AUTH, &conn->flags);
-			conn->sec_level = conn->pending_sec_level;
-		}
+		set_bit(HCI_CONN_AUTH, &conn->flags);
+		conn->sec_level = conn->pending_sec_level;
 	} else {
 		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
 			set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
@@ -2900,7 +2894,6 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	clear_bit(HCI_CONN_AUTH_PEND, &conn->flags);
-	clear_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
 
 	if (conn->state == BT_CONFIG) {
 		if (!ev->status && hci_conn_ssp_enabled(conn)) {
-- 
2.25.3

