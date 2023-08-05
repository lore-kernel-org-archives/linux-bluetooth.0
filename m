Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAC5C001DB
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Aug 2023 16:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjHEQIx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Aug 2023 12:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHEQIw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Aug 2023 12:08:52 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507313C3D
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Aug 2023 09:08:50 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RJ6vj1crZz49QBg;
        Sat,  5 Aug 2023 19:08:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691251729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUPrpgRQeHR3l+t/8DZur6vLwuHe3l3cb3bKNUeiSt4=;
        b=g0dPYK0yvC8bI4Lb3Kj5q5eQbFCUD7ZpMMJ4IuOefdtZUXheEbZqBxkMsAczNbOdrFyIYw
        +iR3VKel3aLiGTDwsxl8eqBJHcKCnsldOdq+gBiUb/ElTk0grNXFwf6rL15UV+Ii6AbbQM
        9DdQ7dWoWpkE0DL0DDR506xlbwR4gN219OllIM+chOQcLrhDgiQlexpxsWVQh5QwLO9nmB
        9cTG+mDWtHmB1DWoZAiPB0EgfiJN249T9BaIx4FQ0W5njCRMtnLUaqpmjSX3ahG4bLJVfO
        gYbe4irgNdbpglLhzEs29kBhlZ1qZ+TTmf0u64gXboXRjtQ2YpcPsH00Lds24A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691251729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUPrpgRQeHR3l+t/8DZur6vLwuHe3l3cb3bKNUeiSt4=;
        b=TcZO1mzQeV+z7Saz4Ap+36WPRA9419Qyp0fnVKm930vi/fvmwsERgbc9xhl8x8ZQQuekvC
        FvONJycZX7cpPHf2mdB1LSsOa/lqW/0RnUQO77MJbS0NaZJk3bFpixdHKoiK+rMRrUc8E9
        fVrMFRBkuvAF8uWOu4RV4HfZ9re3UgEnPIMknA8GrGsUiSTK+1fDfsl8w0KuzSm0zUqKTC
        9ZBPUBnLTZ7O2/aIZxq2H/dXNLOeQgJqH1NQ/TBFtxvCwvaBLTl518Cgv+VAAH0CcbpwKi
        zAa8MUiNNAuMjqK6THfpjNOd7nbDjRV42oTX/NlNthWM+3P+r2jaMqLQROPXVw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691251729; a=rsa-sha256;
        cv=none;
        b=PMKqS2GFZFAL9WWxi3mtIFmLywjz6rTsofFFFPRjeJ9It81vHRsquEJkBp39cHoWp+j6qq
        DS1vVPpU1CRGd8IUYsEFuVWelVHiv6YXbVheEdRdIuVTW+lXNVKtpCNdAdd9dMP9hAStsA
        uxHKbN9xgu8E18FdyjJPgpO5sQGBc6Ic+sbipZbbiHENoTGkrquFykHzxqWH4Z73CRFQt2
        Xo1CJVTVlgXXFho9BpZM8JvziZwtAleZ8kPHXFMdcmzgT/18nU+yRSYiFvtEoC2h18wndQ
        80YTIZf+Huh90wASFdqP8CUWcZP7MaQyFnFySWN3GefoYsGAMgkzQQWnzqab3w==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 2/2] Bluetooth: hci_conn: avoid checking uninitialized CIG/CIS ids
Date:   Sat,  5 Aug 2023 19:08:42 +0300
Message-ID: <704a2ba34a67780a1f5992eff0bd03a6a6c011a0.1691251325.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <5af5d6830d65173124aa525dd01b2718548ffb65.1691251325.git.pav@iki.fi>
References: <5af5d6830d65173124aa525dd01b2718548ffb65.1691251325.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The CIS/CIG ids of ISO connections are defined only when the connection
is unicast.

Fix the lookup functions to check for unicast first. Ensure CIG/CIS
IDs have valid value also in state BT_OPEN.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci_core.h | 4 ++--
 net/bluetooth/hci_conn.c         | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f4462c325e2a..c53d74236e3a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1219,7 +1219,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != ISO_LINK)
+		if (c->type != ISO_LINK || !bacmp(&c->dst, BDADDR_ANY))
 			continue;
 
 		/* Match CIG ID if set */
@@ -1251,7 +1251,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_cig(struct hci_dev *hdev,
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != ISO_LINK)
+		if (c->type != ISO_LINK || !bacmp(&c->dst, BDADDR_ANY))
 			continue;
 
 		if (handle == c->iso_qos.ucast.cig) {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ae206eb551f7..106be8882066 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1865,6 +1865,8 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 			return ERR_PTR(-ENOMEM);
 		cis->cleanup = cis_cleanup;
 		cis->dst_type = dst_type;
+		cis->iso_qos.ucast.cig = BT_ISO_QOS_CIG_UNSET;
+		cis->iso_qos.ucast.cis = BT_ISO_QOS_CIS_UNSET;
 	}
 
 	if (cis->state == BT_CONNECTED)
-- 
2.41.0

