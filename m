Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D4FC0015E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Aug 2023 20:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjHFUU3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 16:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjHFUU0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 16:20:26 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D261725
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 13:20:24 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RJrRV2jCJz49Q64;
        Sun,  6 Aug 2023 23:20:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691353222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10nB+Wh+NxCOugfbv+kTYq9QX8gX/cCaF72EnwHIaWs=;
        b=fVFMv8/Imgj9FTxS80i1ntn1iIWjJhbOnbl2iJezkdv4kUz8g/Aqr/rk94f1Cf4rBpARf0
        +ZiwEB4AT5NKy1h+/hhwG3UXv7m++fSUkmVhWIzeQjM2Z0UPpv/589Niquncduy2RGTlgL
        aUKMHqqDLy8TqL2F1P9LVa4pzVIwkePGZAcfUyTamrb1rubV5Pvrykgv3jKLX8S719yBUR
        TMRp0lIsnBrMZH6oIFcU9wPlp34BapOvKBByrAlcdjHvT2QqnLa2gHU5/QsEwGqAc/NHyu
        HmoCyfQ9vvn/2hnhq3Nkz59MW8Y2r4IwMh7CskHRd0Opu/rI01GWli2aZ2U5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691353222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10nB+Wh+NxCOugfbv+kTYq9QX8gX/cCaF72EnwHIaWs=;
        b=eiuxaP1pP94HHk4YeJWYIwLGvVbq/MGkSOZqWwCTdorYFS/AU9knTVri2D4ENChOPK4eVl
        oUZlwJXLqy3s5CssME9wgXEiOiv6NMx6rDaVqgY6iwyH7+GvFr7JOneqhe0Jdzy37B8wgG
        B+Y0+Er1c16W6TCsvt1J9c9dtf7KNoJDFclJpsV92zj7VnOPsvOFVVw0HMhNogxQyDhjto
        8nH0tpsKdVCuDNZIWNlRA+Nk8RnqIrIxqy5Fkpeg+QIHy1APr49tACKNS08xfT5wsTPQVQ
        MLtbGQlO/7TuYXuXdybmc2z/21QXnVlQ2B01y1vcZcs0IksQBZcQ0kGpcxukoQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691353222; a=rsa-sha256;
        cv=none;
        b=fGIf3+/UhkaLsk7fHk5CKpy8aiBnR1cw3AdIiXj0qV96ihR5Ww5BPcyjHpxEaffVVHmKlV
        0E3cK1cOxiohDm5JJ4ojXNbMsp+O6TxBdFupc42gzkjoHM/SaemZfSQqB1vTX6LyuZTjhc
        6AXzR3vrgnsnNq8c7ZhkK/OMsvs/Yu7L8yvY8ttsHscVnxZRw8YYqbYgpE1xsOg7oXIaEq
        NO82EFPseTSmFi167z8TDHWeJ8mCrU6D6/du+0ptcLGWFTiJ6ixJDRhZrA4Iuz+l7bAhBh
        MWuRwxPO9X1M4ORTkmUb2aiMKseD/7YMUUmg6stk/YJUeoWCRUNM6J6p3reMHQ==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 3/4] Bluetooth: hci_sync: disconnect linked connections before parents
Date:   Sun,  6 Aug 2023 23:18:39 +0300
Message-ID: <89fd73eb453f951438c594222828aafe8e4640a3.1691352503.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691352503.git.pav@iki.fi>
References: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691352503.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SCO/ISO connections are disconnected implicitly if the ACL connection is
gone.  If we disconnect ACL first, controller may error disconnecting
ISO/SCO, which in hci_disconnect_all_sync fails powering off.  With ISO
connections present, powering off usually fails because of this.

Fix by aborting linked connections first in hci_disconnect_all_sync.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2: new patch

 net/bluetooth/hci_sync.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 228259f44815..a476594ecd2a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5435,10 +5435,26 @@ static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
 	do {
 		conn = NULL;
 		list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
+			struct hci_link *link;
+
 			if (c->abort_reason == reason)
 				continue;
 
 			conn = c;
+
+			/* Abort linked connections first. Disconnecting ACL
+			 * implicitly disconnects SCO/ISO, and controller may
+			 * error commands disconnecting them after ACL.
+			 * (See Core v5.4 Vol 4 Part E Sec 7.1.6)
+			 */
+			if (conn->parent)
+				break;
+			list_for_each_entry_rcu(link, &conn->link_list, list) {
+				if (link->conn->abort_reason != reason) {
+					conn = link->conn;
+					break;
+				}
+			}
 			break;
 		}
 		if (!conn)
-- 
2.41.0

