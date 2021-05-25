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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8970C2B9F8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DCB610FC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 10:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhEYKd2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 06:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhEYKca (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 06:32:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE50C06135D
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:30:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b66-20020a25cb450000b02905076ea039f1so41221711ybg.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UXo23GwK/luqXob/Py9T0EVZy2iOWx16pZJGz6ZxQDU=;
        b=aKPYkXbNTpTI1/TPsoRXDxDv/cdsJnQM4nvpvoTQ7XymGtPqhysT3wU42ITnSCKjhb
         6E4fWga6oPp0gsi6h3Xq5ncixCDa2W6gdIWy5T48dU78p7+naHvW1dM+CW3lMtEHvn2/
         GU8DuRkb3Jw3P4aeZHpVr5Gdd32h1+9sJIaeaLHA45+8AFnBc0YYEkHVuT659xtmMUlU
         K5d620FNPMlyOar2u+eH3UbyY2VmxgghFFZoPCYxtk5L+wt0ESbZURQPNRddRi43CAFX
         exJvRkxGu8qS6OGN/PPhPqoPIDQ3kA1xDaE6kX4ufWADOvw9TU4TvpMCPxgepAhRlK/y
         pMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UXo23GwK/luqXob/Py9T0EVZy2iOWx16pZJGz6ZxQDU=;
        b=l38ylmXqwKCc9Pi32KgRgU3EUVrqoz5FPtnc7dEcsqYnZWJmaj/RhCCHF3IuZxGt36
         PZ24Vsft+txZNQw/j2bUmnZTZxBviaQiVCKkEeKvpc2vggek12frVR4Vc6ymTW3dAuhS
         dN/8aqpM/wNXPfYEi6rlcytaIfMB+pTJbOTn0oD2B/27aNiyvA0IiTCMhEb6lxkqgfwL
         3sUK9mjXmiWH8CciHmMFOOW0CguWJjfcYgy77MRq9TTVw+VKDgeKtkv2cVWH704hDf/d
         65NcPp/16ZbXu21ba5cAwaFaBdRO5BuHm5VDcWA+i2MMlqctCZTQUFyAZXuB+wW7YD2k
         uI8g==
X-Gm-Message-State: AOAM533FxlwmO7SNMi0GLsd7tTm+o2b++yEo9lnaYOCdKaPd9dxHdbVe
        A0La+bNPt0JCBNEArD1ANVfFa2AW5oHgnDBXhM5FzbTT3vDd4vGxQlQZCOfxCttEr/on+x1jiav
        8VjURBR+Q/mHr3f/k0ZA87Egqyd/mHyjQmY6UDT1BvhnOxGnhug3VJE3O6HxY/zy8Sd8zLZesv8
        qZ
X-Google-Smtp-Source: ABdhPJyoV+Zo7rkBl/WtwI/KW4L1RCHSLbXle/C0FUYdwLdD63gI+j7VoQa/VBE9H4d0V6SjTGr8OFD7rB/k
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:8806:6b98:8ae6:8824])
 (user=apusaka job=sendgmr) by 2002:a25:6911:: with SMTP id
 e17mr4108665ybc.162.1621938618586; Tue, 25 May 2021 03:30:18 -0700 (PDT)
Date:   Tue, 25 May 2021 18:29:36 +0800
In-Reply-To: <20210525102941.3958649-1-apusaka@google.com>
Message-Id: <20210525182900.7.I4401b43eaf53e45e02ccaadef43cdcd3396173be@changeid>
Mime-Version: 1.0
References: <20210525102941.3958649-1-apusaka@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 07/12] Bluetooth: use inclusive language when tracking connections
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
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Use "central" and "peripheral".

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

 include/net/bluetooth/hci_core.h |  6 +++---
 net/bluetooth/hci_event.c        |  4 ++--
 net/bluetooth/hci_request.c      | 17 +++++++++--------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 929768f6ed93..cfe2ada49ca2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -122,7 +122,7 @@ struct hci_conn_hash {
 	unsigned int     amp_num;
 	unsigned int     sco_num;
 	unsigned int     le_num;
-	unsigned int     le_num_slave;
+	unsigned int     le_num_peripheral;
 };
 
 struct bdaddr_list {
@@ -894,7 +894,7 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 	case LE_LINK:
 		h->le_num++;
 		if (c->role == HCI_ROLE_PERIPHERAL)
-			h->le_num_slave++;
+			h->le_num_peripheral++;
 		break;
 	case SCO_LINK:
 	case ESCO_LINK:
@@ -920,7 +920,7 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 	case LE_LINK:
 		h->le_num--;
 		if (c->role == HCI_ROLE_PERIPHERAL)
-			h->le_num_slave--;
+			h->le_num_peripheral--;
 		break;
 	case SCO_LINK:
 	case ESCO_LINK:
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a809e90326d7..c5871c2a16ba 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5384,9 +5384,9 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 		return NULL;
 
 	/* Most controller will fail if we try to create new connections
-	 * while we have an existing one in slave role.
+	 * while we have an existing one in peripheral role.
 	 */
-	if (hdev->conn_hash.le_num_slave > 0 &&
+	if (hdev->conn_hash.le_num_peripheral > 0 &&
 	    (!test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) ||
 	     !(hdev->le_states[3] & 0x10)))
 		return NULL;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index fa9125b782f8..28a477a7d320 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1502,13 +1502,14 @@ static bool is_advertising_allowed(struct hci_dev *hdev, bool connectable)
 	if (hci_conn_num(hdev, LE_LINK) == 0)
 		return true;
 
-	/* Check le_states if there is any connection in slave role. */
-	if (hdev->conn_hash.le_num_slave > 0) {
-		/* Slave connection state and non connectable mode bit 20. */
+	/* Check le_states if there is any connection in peripheral role. */
+	if (hdev->conn_hash.le_num_peripheral > 0) {
+		/* Peripheral connection state and non connectable mode bit 20.
+		 */
 		if (!connectable && !(hdev->le_states[2] & 0x10))
 			return false;
 
-		/* Slave connection state and connectable mode bit 38
+		/* Peripheral connection state and connectable mode bit 38
 		 * and scannable bit 21.
 		 */
 		if (connectable && (!(hdev->le_states[4] & 0x40) ||
@@ -1516,13 +1517,13 @@ static bool is_advertising_allowed(struct hci_dev *hdev, bool connectable)
 			return false;
 	}
 
-	/* Check le_states if there is any connection in master role. */
-	if (hci_conn_num(hdev, LE_LINK) != hdev->conn_hash.le_num_slave) {
-		/* Master connection state and non connectable mode bit 18. */
+	/* Check le_states if there is any connection in central role. */
+	if (hci_conn_num(hdev, LE_LINK) != hdev->conn_hash.le_num_peripheral) {
+		/* Central connection state and non connectable mode bit 18. */
 		if (!connectable && !(hdev->le_states[2] & 0x02))
 			return false;
 
-		/* Master connection state and connectable mode bit 35 and
+		/* Central connection state and connectable mode bit 35 and
 		 * scannable 19.
 		 */
 		if (connectable && (!(hdev->le_states[4] & 0x08) ||
-- 
2.31.1.818.g46aad6cb9e-goog

