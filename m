Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CE4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1669520674
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqIZdmER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgFCRON (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgFCRON (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:14:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8B0C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 10:14:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s10so2220814pgm.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 10:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CuTW1YSo6SbIPQ+NugG8xNnabM9kKD5flh82Xdj9G2g=;
        b=AqIZdmERFi5Y3RTNmnlfaTFzw+mHC3sV9IZZQmeVtkfc7JAOWEyqTcnvfqTZskloHH
         ZFQ2B9p9hBZMQpah5RhFoOhMVv5JuWjsM//UUoYfEpW6SrOfMZgddyAtauSctTiAxK9W
         y5zT3y7hi97tMiS04YCJNXhAREml1hsWx0euIi7jAG2HWO33i30d/Ouy1TtSctrHHjkn
         ZwasvGy8ubqD+KFNusBjQPdTQxjBidoQWJzHL57ZuJmY1N6jdVW9YjGpy1jbtk8EsrjS
         RH3L47w9b56NjOlTY5bTUioQfBETcFjX6GFHlwlio1215m+Y2KJ1JL4dzc4TTvVvmclC
         2gmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CuTW1YSo6SbIPQ+NugG8xNnabM9kKD5flh82Xdj9G2g=;
        b=eRAdYvJEbcixQGIgxHP40UvBd9JFxAeAUQBJRVaSC2pHGtzdpiZZWNiZV7+j1hSiCx
         dncgqmVdNxPoR8mR4/YdU6MIJbLwmly9t00urWZ8q2a88U9t7PhYn66PbGB+J72pMA52
         3eE893cVBWGuyeoQaKNWGNWBgkiNwMd74ga/e7dVUTXf0kl8eh55eCqKCXlc5h5Q/bJ9
         L8YDBAtz/boPLHGtNPGcsRFHFpoAHdQnXbzGv7uwCMFpCwQvY1YEPoy3Y2xMia08iQMM
         nWLIYgPbKqOL9frxyFparxExg+MW0nNWLA+++4SAjzL6h6cfFbJ2qhjf/qqlw7CE086+
         HPtg==
X-Gm-Message-State: AOAM533Oz7W8zOX8lIDXgmU9ssLAPkmQODwZEFN69y/4x7acVdcXt6Wj
        OZvzE7BqF/iEFlZlEIKbJy3b0RsbzoQ=
X-Google-Smtp-Source: ABdhPJwjJ10+cQMD+6dnq0Dknw1/gJZYKR1on9zzSONDk5w34DQFAdpbYlxP4k6fMHiIgh2WhbFP4g==
X-Received: by 2002:a17:90b:252:: with SMTP id fz18mr866840pjb.96.1591204452769;
        Wed, 03 Jun 2020 10:14:12 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id x190sm2016770pgb.79.2020.06.03.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 10:14:12 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v2 1/7] Bluetooth: Translate additional address type correctly
Date:   Wed,  3 Jun 2020 22:47:07 +0530
Message-Id: <20200603171713.9882-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603171713.9882-1-sathish.narasimman@intel.com>
References: <20200603171713.9882-1-sathish.narasimman@intel.com>
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
index 16ab6ce87883..1165dfea56a9 100644
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
index dbe2d79f233f..f4ceda1f1454 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3145,6 +3145,15 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
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

