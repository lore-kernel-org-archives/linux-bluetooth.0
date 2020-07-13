Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7883BC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573882065F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYtuEI24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgGMGSa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMGSa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:18:30 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA8CC061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j20so5563790pfe.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xSub10RztAkAVkR7dQ1tuib+ohmh4r9LyvxXZPcSzms=;
        b=PYtuEI24SUiceyjMGvP8DZ9fcw4kzUoqVdCJIl22dOi89C/ex/cniSYZpVA7KQixZG
         fY7OKc2Gr67Ho/vjnGI1+z3O+Vbsu/H8Etl81ziYf4MTFSqNCeml4SM20StY0T0vUO7h
         63Bk5qiYquUOi69iuqbI/CChpvpXDscIFmOQCHX2EjJVq1e0eUfJbjcXLVs6T6EHAhiB
         Io2LtaNgBGF3ZuEjo9QbSeyuxJoR2txATJbgzZt+smMZ03DR+Y2emcwP/pt6ctl8gA62
         nt02/TdUg3XDcSSpa/hsDJYOtVvbguU8AuLW3b8xBWF1eyWAmAAKgLqTFjIUjwhIuj6u
         JlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xSub10RztAkAVkR7dQ1tuib+ohmh4r9LyvxXZPcSzms=;
        b=iBVQ24+U2kgNLnWcCwx+XrYyHhkNbGwuWSIBB+MqGHLgue0og36s6qqtOvExzUqkrN
         /65Dio2T/5ATHEDCHsxzg1FAckBLdtjSc+lLmIj8G06PFDIwkFOH+5sGgh9W+NzzNxzp
         alQ62XQRmUVrYNUgOcrbbjwjuwyAGHdL5UTqgRzlcGkWyus/9JrxrsyfOnYm+EtWDHzB
         WLufa4xz7DVLTZa4gvKWRd7hcN3iGxM6VlAL4eo3rz3Ts67BtgYuXcCZZ1p2ECc0uiQk
         wdh6aGIccCJmRStvVB6AxCQK6JMLc3WmirW3SuvaVxK5+AR6wsVQ22gx6wn5/rHa7ULG
         hMWw==
X-Gm-Message-State: AOAM532GeoWXNtAI+hMp8mpH72z7jmtYnG44yVUb/avNtvj2Mo9tUb2S
        5D/nKEPKpoGfJGgZ5Bpm94iv8Je6r693TQ==
X-Google-Smtp-Source: ABdhPJxGd+UgMH68xXk6MSqy1axeE3LMMVxel5LtDzJ8mfBZs3SCMKaLVq4ysnZ8zH3kNagDdKxggQ==
X-Received: by 2002:a63:6744:: with SMTP id b65mr48189679pgc.42.1594621109882;
        Sun, 12 Jul 2020 23:18:29 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 204sm13096371pfx.3.2020.07.12.23.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:18:29 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v4 1/8] Bluetooth: Translate additional address type correctly
Date:   Mon, 13 Jul 2020 11:52:06 +0530
Message-Id: <20200713062213.3692-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713062213.3692-1-sathish.narasimman@intel.com>
References: <20200713062213.3692-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

When using controller based address resolution, then the new address
types 0x02 and 0x03 are used. These types need to be converted back into
either public address or random address types.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h | 6 ++++--
 net/bluetooth/hci_core.c    | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1f18f71363e9..abab8b5981a7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2268,8 +2268,10 @@ struct hci_ev_le_conn_complete {
 #define LE_EXT_ADV_SCAN_RSP		0x0008
 #define LE_EXT_ADV_LEGACY_PDU		0x0010
 
-#define ADDR_LE_DEV_PUBLIC	0x00
-#define ADDR_LE_DEV_RANDOM	0x01
+#define ADDR_LE_DEV_PUBLIC		0x00
+#define ADDR_LE_DEV_RANDOM		0x01
+#define ADDR_LE_DEV_PUBLIC_RESOLVED	0x02
+#define ADDR_LE_DEV_RANDOM_RESOLVED	0x03
 
 #define HCI_EV_LE_ADVERTISING_REPORT	0x02
 struct hci_ev_le_advertising_info {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6509f785dd14..4af208b82138 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3290,6 +3290,15 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 {
 	struct hci_conn_params *param;
 
+	switch (addr_type) {
+	case ADDR_LE_DEV_PUBLIC_RESOLVED:
+		addr_type = ADDR_LE_DEV_PUBLIC;
+		break;
+	case ADDR_LE_DEV_RANDOM_RESOLVED:
+		addr_type = ADDR_LE_DEV_RANDOM;
+		break;
+	}
+
 	list_for_each_entry(param, list, action) {
 		if (bacmp(&param->addr, addr) == 0 &&
 		    param->addr_type == addr_type)
-- 
2.17.1

