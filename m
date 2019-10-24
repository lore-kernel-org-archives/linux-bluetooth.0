Return-Path: <SRS0=pV4/=YR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23222CA9EAF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Oct 2019 10:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED12F2084C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Oct 2019 10:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDssyzRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438876AbfJXKfn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:35:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35716 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438874AbfJXKfn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Oct 2019 06:35:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id c3so11665990plo.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2019 03:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+6h95oeKOuPu2vzoPEnhNGHvlYgVDwc1p862g10QGFI=;
        b=aDssyzRI1O3/WDumH/I/HCjSXWTOfqe01oJBkTTE/wMHgXDw4358dUKlknF1DWPPFR
         7EeEb3wKNVvZ0rRVrmpUe3NuhVtaSb8AYCU0ezg1ij4vesOeVEUfBperdDFWZ5C3/Wa5
         noQlwQJGVjrIfJIPHxvdtOuHMtHkTgJWzGc/F1tLQNNg51oNU79FoxxGEDu/hQpYGYrV
         gyq0yQGckvpK7Aa+GB7CY3Ow0rNryfzyCEhIksqv50GpowkVK9zuE7eHCN/2+GGgv4h4
         Lt9zZcDAo1aVlryFZ/O7Fe3pfs0zTSwxu7w8o9WAFoxnx1j/v1sh5PcHXGDLEL+bqbJm
         AwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+6h95oeKOuPu2vzoPEnhNGHvlYgVDwc1p862g10QGFI=;
        b=oVHqdp42QvrOeEkDySKvLm/I3SnrmoZOGI+ylL0Ex5sOj6zrygrWUXJzi97DKjpaTR
         E4O9RrAt92I9gOtARMytI5LnCZIG8AL8aCVz69K5V5WGpPNJG6OW8xLmpdUrqnBmKWja
         Me9m6eAcznn8dSoS8iV/kHLNW1/lRTnaZK0bh8nzUcd17KWNP+xqleLuggGoPSFHkIjv
         q0kjnnB0D0cPdx0g67SjoDtdDGBBvblWpvp3LVOKL+uNXZwNKIS9UhPmk08I15cAqBwS
         Blmu81svJBAIqVScmIYa/AkFFOF/hbEXd01TMjmFNGXQ9jSccaxm668ihhhWDm17rS9i
         KCBA==
X-Gm-Message-State: APjAAAXsVrF1qYRJgiHiFLmtedVKtolRudukh2kKkqH+6QHzCz4OJ5JP
        ogWRg/T/Uqc0g3ZOHJcFP3kvLVOD3mA=
X-Google-Smtp-Source: APXvYqwS3bxh0nC+sqNZtrPIRiDWVja5GYb4pA8ITqgXG+SqLwdzMsJMIgAFdhSk/1yprZ8A5PxmLQ==
X-Received: by 2002:a17:902:b08b:: with SMTP id p11mr15483737plr.57.1571913342259;
        Thu, 24 Oct 2019 03:35:42 -0700 (PDT)
Received: from wcs0336-Latitude-E5440.iind.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id m12sm1672292pjk.13.2019.10.24.03.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Oct 2019 03:35:41 -0700 (PDT)
From:   Jaganath Kanakkassery <jaganath.k.os@gmail.com>
X-Google-Original-From: Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Subject: [PATCH] Bluetooth: Always set scannable for Adv instance 0
Date:   Thu, 24 Oct 2019 16:02:19 +0530
Message-Id: <1571913139-6477-1-git-send-email-jaganath.kanakkassery@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

By default for instance 0, local name will be added for scan rsp
data, but currently the property is set as non scannable and hence
Set Adv parameter fails with Invalid parameter.

< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
        Handle: 0x00
        Properties: 0x0010
          Use legacy advertising PDUs: ADV_NONCONN_IND
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Random (0x01)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
        TX power: 127 dbm (0x7f)
        Primary PHY: LE 1M (0x01)
        Secondary max skip: 0x00
        Secondary PHY: LE 1M (0x01)
        SID: 0x00
        Scan request notifications: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 5
      LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
        Status: Success (0x00)
        TX power (selected): 7 dbm (0x07)

< HCI Command: LE Set Extended Scan Response Data (0x08|0x0038) plen 35
        Handle: 0x00
        Operation: Complete scan response data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x0d
        Name (short): localhost.
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Response Data (0x08|0x0038) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)

This patch makes the instance 0 scannable by default.

< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036) plen 25
        Handle: 0x00
        Properties: 0x0012
          Scannable
          Use legacy advertising PDUs: ADV_SCAN_IND
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Random (0x01)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
        TX power: 127 dbm (0x7f)
        Primary PHY: LE 1M (0x01)
        Secondary max skip: 0x00
        Secondary PHY: LE 1M (0x01)
        SID: 0x00
        Scan request notifications: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 5
      LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
        Status: Success (0x00)
        TX power (selected): 7 dbm (0x07)

< HCI Command: LE Set Extended Scan Response Data (0x08|0x0038) plen 35
        Handle: 0x00
        Operation: Complete scan response data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x0d
        Name (short): localhost.
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Response Data (0x08|0x0038) ncmd 1
        Status: Success (0x00)

Signed-off-by: Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
---
 net/bluetooth/hci_request.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 7f6a581..362b1ca 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1601,7 +1601,12 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_CONN_IND);
 		else
 			cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_IND);
-	} else if (get_adv_instance_scan_rsp_len(hdev, instance)) {
+	} else if (!instance || get_adv_instance_scan_rsp_len(hdev, instance)) {
+		/* Always set scannable for instance 0, as scan rsp data will
+		 * be set by default with local name. For other instances set
+		 * scannable based on whether scan rsp data is there for the
+		 * respective instance
+		 */
 		if (secondary_adv)
 			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_SCAN_IND);
 		else
-- 
2.7.4

