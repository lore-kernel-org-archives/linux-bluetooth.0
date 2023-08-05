Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9534FC04A94
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Aug 2023 16:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjHEQIy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Aug 2023 12:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHEQIw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Aug 2023 12:08:52 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506EB10F8
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Aug 2023 09:08:50 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RJ6vg3vpQz49Q4L;
        Sat,  5 Aug 2023 19:08:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691251728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NsYmtSVvMuwoELtsIr6DmZyU3wxOLuL2Y2AFWYp/KoA=;
        b=NwH/bZt99vTmh9QgDg1HkVSOYE7aT530eAOBTXwt8blHupyHIwVeH0v+40Y/jXVM6Be5JV
        65BodadrMJxVmD0WLYdEVBKtY+IEO2unkRGdorFSYd3z2EDk45WR02CRVrhfScymROUaHE
        CHYC7kRk71cJx5LN7Z4WM+NkA4HXXmHqAH53wrSJNIA8YeDmNODAjbbiM9V7O8zMdXYnQV
        2KgPy9FrRuYl5o8tlw6Ul0Erz9O6cqhPH3PaprY4NW8GCQ5baKHDjLB1obpN93xz904Yy9
        sverXgeEpx01Lw4Xh3QPLlE4G+rKnSAJjdwRC+eN3BVkYMmXKlyQZ7pCyW8juQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691251728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NsYmtSVvMuwoELtsIr6DmZyU3wxOLuL2Y2AFWYp/KoA=;
        b=pqC2eyDq2PpNISZ4zro1xkDHTw8dRk+yurGEenjyR03HAxkzI6k8obbUmrgo3T62aSF8Xe
        FFEj0fEXQdOi/84E+BYJGlgiXM/JKTUwFEczGOfrsiaSUl1SBNtaph1UkqpGRIxHgw4GHZ
        Za0/1zm88kZraWKv1sF8tCTejgWYeL0YI/7tCaZdwPz//aym/L9gDhXAkTBcFxymj+0GGO
        /MwkLdoNn0vlVbRKra9YAK5sFSqqvZ2ATB5LSWrJQ39GnRDj7Ilxj+l/Z4Fsb+rX2Ab/Uz
        SSsjCH50VXphoMer7jELK/FDtTdhnsjR7jVHnq1pK4lbz3xJlUPowXDE5x+mwA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691251728; a=rsa-sha256;
        cv=none;
        b=KSefgtb3naKw8luojvK5f3yVU95TkE+ouKlUu2cIbIj5HEdsrxxxt7nwo/HOuJv/mKQIaa
        jtYnBq7KZAQ6cApCrKUYwKSuQrDws6erTsAoORfyCqIc4fZRprHvAkn2xu8g2gcFDENQPS
        WEdHpQ1I0soVXOknlcQyrTV6SYm6AhmqyOStF5qYrgjidJL+fuVqnbj4YzBQwtIcBO4cyl
        /bFjVtv13fYFxZ5ysP5RuRpjiE8dP7WwojhFX5W1izto2dnLySGKQvJn0mrjIs///C5L9I
        2pt5V1jUJlQH87M6aaGFkwkJSWWBvABLJwfgFkyVIGDp4sGl+rtf6QBHf7Vwpw==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 1/2] Bluetooth: hci_event: drop only unbound CIS if Set CIG Parameters fails
Date:   Sat,  5 Aug 2023 19:08:41 +0300
Message-ID: <5af5d6830d65173124aa525dd01b2718548ffb65.1691251325.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When user tries to connect a new CIS when its CIG is not configurable,
that connection shall fail, but pre-existing connections shall not be
affected.  However, currently hci_cc_le_set_cig_params deletes all CIS
of the CIG on error so it doesn't work, even though controller shall not
change CIG/CIS configuration if the command fails.

Fix by failing on command error only the connections that are not yet
bound, so that we keep the previous CIS configuration like the
controller does.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_event.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 218da9b0fe8f..559b6080706c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3799,6 +3799,22 @@ static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+static void hci_unbound_cis_failed(struct hci_dev *hdev, u8 cig, u8 status)
+{
+	struct hci_conn *conn, *tmp;
+
+	lockdep_assert_held(&hdev->lock);
+
+	list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) {
+		if (conn->type != ISO_LINK || !bacmp(&conn->dst, BDADDR_ANY) ||
+		    conn->state == BT_OPEN || conn->iso_qos.ucast.cig != cig)
+			continue;
+
+		if (HCI_CONN_HANDLE_UNSET(conn->handle))
+			hci_conn_failed(conn, status);
+	}
+}
+
 static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 				   struct sk_buff *skb)
 {
@@ -3820,12 +3836,15 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	/* BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E page 2554
+	 *
+	 * If the Status return parameter is non-zero, then the state of the CIG
+	 * and its CIS configurations shall not be changed by the command. If
+	 * the CIG did not already exist, it shall not be created.
+	 */
 	if (status) {
-		while ((conn = hci_conn_hash_lookup_cig(hdev, rp->cig_id))) {
-			conn->state = BT_CLOSED;
-			hci_connect_cfm(conn, status);
-			hci_conn_del(conn);
-		}
+		/* Keep current configuration, fail only the unbound CIS */
+		hci_unbound_cis_failed(hdev, rp->cig_id, status);
 		goto unlock;
 	}
 
-- 
2.41.0

