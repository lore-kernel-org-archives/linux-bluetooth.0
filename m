Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F50EC2B9F8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C3C613F4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhEYKeB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 06:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhEYKct (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 06:32:49 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B2AC06137C
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:30:37 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w15-20020ac857cf0000b02901e11cd2e82fso26073621qta.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HjaAVyjqWLnSC3FFXoJAmpMacfJ4D7tkLOeJEd/lVVY=;
        b=qZdJsQKmwaRh/S8yLEHNhohKTur3L8Wo6btuJkgZbFhw6mLXc3uFvkyynYP1ZW25sQ
         8A+t2ygyCl57P03POYdkVV7LgP9aXVJkunH6oxJT5jasFFdJ+6SkmzDieN+K7mFTMz3J
         0954A7mmnajLatFz5t0phcn517URZQtjrSNr92KsWQm3Nc8fTwFsP45ULlH2PC9rkMU9
         aHgkt+xSiFbZFxOiwio65HPy/okDvg9xZ402B0nvW1LuyL4YC2Ib11fLGJtS1hoEGvFp
         5leI9boxSg856kF6NroS/fhjHEcsg3EXW2zJZxcLIBO+mOpTAzfoFZ/GHwpwunoF6+RM
         BScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HjaAVyjqWLnSC3FFXoJAmpMacfJ4D7tkLOeJEd/lVVY=;
        b=VcMrJrB5XnR/1WMxryDNtodUtz7691HYddpHe7oi0+cANWdt+hi+VDvo2CAFXAkeIO
         iXfxAlP84PCXAjnnXaRMgLef3z9ru3dtOb3m22z16VYwQK0l9iAClkK/3L2XLai6tSLq
         fWJ1eR7prKm3aLUPCV4AYGLgnP/Q1kGMKj8UETjV/z33nm0ln26QK5o663bHrDDMw/Go
         cei1BXwo9Pz7siFdXwmZK/0Bb+KvzwIdLvg1U3oF3BrEly6jeU5XGzjXrjcVOcNOyLAH
         M+D9I54j5w0dhgZWIYICEDSuNCrRuQYPiIh4Wvzh7g0S/xeK4tPZD1+VgOMYBuD9b8fk
         sWsg==
X-Gm-Message-State: AOAM533bIYtY+iqh36eI4ap90rOMFKvC3EEcJ2eG8FaKOjsswme/h/Zr
        A5dTBiVkC3YJjr5tIVC/iqp19FPGRWT8ZZGm+lrfr9YCEqhZyPlickttPJq60+Ofnlgl1Bt35NL
        eyf9L0FTbeyCEW7wVN55xvSjCI/GYSbTtFr5igd9l8YeruaXYUZ97OCzi+k0yhOeOkB2/BkpHow
        Sc
X-Google-Smtp-Source: ABdhPJx3y3NV3+IgaLvjYGrwoSuEMZ4sv0qOlrPCZ3EWKqb59wYJD6XdsM9PFHw08/ZZjU653qgd9ZvOnX4M
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:8806:6b98:8ae6:8824])
 (user=apusaka job=sendgmr) by 2002:ad4:4583:: with SMTP id
 x3mr35782858qvu.39.1621938636956; Tue, 25 May 2021 03:30:36 -0700 (PDT)
Date:   Tue, 25 May 2021 18:29:41 +0800
In-Reply-To: <20210525102941.3958649-1-apusaka@google.com>
Message-Id: <20210525182900.12.I361d8bede7e78ecb42a83a42994f191b13e60279@changeid>
Mime-Version: 1.0
References: <20210525102941.3958649-1-apusaka@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 12/12] Bluetooth: use inclusive language in comments
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "=?UTF-8?q?Ole=20Bj=C3=B8rn=20Midtb=C3=B8?=" <omidtbo@cisco.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Use "peripheral" and "blocked".

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

 net/bluetooth/hci_event.c | 6 +++---
 net/bluetooth/hidp/core.c | 2 +-
 net/bluetooth/mgmt.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 760e8e14e0f2..df5e17019e00 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5404,7 +5404,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 		case HCI_AUTO_CONN_DIRECT:
 			/* Only devices advertising with ADV_DIRECT_IND are
 			 * triggering a connection attempt. This is allowing
-			 * incoming connections from slave devices.
+			 * incoming connections from peripheral devices.
 			 */
 			if (adv_type != LE_ADV_DIRECT_IND)
 				return NULL;
@@ -5412,8 +5412,8 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 		case HCI_AUTO_CONN_ALWAYS:
 			/* Devices advertising with ADV_IND or ADV_DIRECT_IND
 			 * are triggering a connection attempt. This means
-			 * that incoming connections from slave device are
-			 * accepted and also outgoing connections to slave
+			 * that incoming connections from peripheral device are
+			 * accepted and also outgoing connections to peripheral
 			 * devices are established when found.
 			 */
 			break;
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 0db48c812662..96fedef14723 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -794,7 +794,7 @@ static int hidp_setup_hid(struct hidp_session *session,
 	hid->dev.parent = &session->conn->hcon->dev;
 	hid->ll_driver = &hidp_hid_driver;
 
-	/* True if device is blacklisted in drivers/hid/hid-quirks.c */
+	/* True if device is blocked in drivers/hid/hid-quirks.c */
 	if (hid_ignore(hid)) {
 		hid_destroy_device(session->hid);
 		session->hid = NULL;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b6fa0333ca8c..9d316518bbe2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2959,7 +2959,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		/* When pairing a new device, it is expected to remember
 		 * this device for future connections. Adding the connection
 		 * parameter information ahead of time allows tracking
-		 * of the slave preferred values and will speed up any
+		 * of the peripheral preferred values and will speed up any
 		 * further connection establishment.
 		 *
 		 * If connection parameters already exist, then they
-- 
2.31.1.818.g46aad6cb9e-goog

