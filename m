Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B9EC001B0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Aug 2023 15:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjHFP1t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 11:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHFP1s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 11:27:48 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F002D3
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 08:27:47 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RJjxr591qz49Q8H;
        Sun,  6 Aug 2023 18:27:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691335664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6GlQTR+ZTtiAWaaFWtKO7MBI16joiTsNFOmWWklszOI=;
        b=m1/eedfefh+20BdnFEKskXX++/lMtn8E18Nsp2BqRoYcV6vZmK4ArTKeiJqgLgE9rwL9gq
        SjcGMK6d6gKgYQXwBq11oGFFbc2FwvlGays3rzQzeoH4jLxF0S270XYlJtNqTcsFrKxMDB
        nHUFLk0tJWt0ALiITFjmxD0JnTDWutF1r/YjSys9Mv45gFuvZLB8ro9yz8/JSYHCP0WYd+
        QLQ5T5RL+lDbqOus8fW9ikiRKJuRdXpjL589bHxKBd9K9y6Ox4YhfY/TfF63w/1pZlALZ5
        Eij2bSFXE8+8oDt1M35pF4Q2/OqNqBuJEfXCLvcmGQ36Qg/g3g4CHTxUDi5akA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691335664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6GlQTR+ZTtiAWaaFWtKO7MBI16joiTsNFOmWWklszOI=;
        b=CSPdwc3KknFv/oGzDO+NBps9GQ7yXP1vkyOCaaywSSJypU3X50OolYnZCOEyULCiU5plqx
        noYQ5D4sUvOWylVsj3mOZSV6k+ev1Vyu9vypANa2HhqfGm7i7y0Tu+nVrGi+gfJgq11dWT
        BrTUu1y2o/ED8bYPop8nxOowJT+RDYlzj+HOBHfNuipwnLyISzRluNuCDTmMi03Zplb+th
        6fDz4eoKN1jbkRPJO2Oqv1M7y90Qn2P3JeCqBXyJORyQ/MkytWsWbW9wNHxt9ujmSgberW
        ohdN08WLDIwp/o9sv9/BBMd+ms6cLwljCDuLn+6O+MWGQtYL4IhUIWyRB6FrRw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691335664; a=rsa-sha256;
        cv=none;
        b=Iw9XLlig/6LAnwCDu8TK3/gYnsSF30TY2+dy13PHqqQWyWpe6CKc6sSS7f9VXwdLRCeSsA
        hePV9lDGOsIx1G0ZlXVpJ0MHBzcC13W8cvry0sjDnF9c2lE42AX3K6mwKTeiZakL63tKTB
        dAW1azMeCZAXXqC2kndSB+NSgts/1ihzj7RO/0dxLha0+/4NO8gLC7lF1tg9Qe4R+JJTXN
        LAv0SePDTrZhP+74NKy8XkF4H37DZGplcnnJbBVETU1sQuqEP4AQi4eVJx1mmvyPu953Hv
        YxdW1YtYsPUEjKBEq8mnuoB0cCeMogYW9yOlbFpYqlRufOlKvBZSugrboBPvjw==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 3/3] Bluetooth: hci_conn: verify connection is to be aborted before doing it
Date:   Sun,  6 Aug 2023 18:27:39 +0300
Message-ID: <b49f9428a680a77613b8452a5664d09593a5966e.1691331800.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691331800.git.pav@iki.fi>
References: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691331800.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When processing connections in abort_conn_sync, also check the
connection handle still refers to a connection that should be aborted.

There is a theoretical race condition where a connection handle is
reused, after hci_abort_conn but before abort_conn_sync is processed in
hci_sync. This change should avoid terminating a wrong connection in
this case.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ae206eb551f7..b65a1e9b178b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2861,7 +2861,7 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
 	u16 handle = PTR_ERR(data);
 
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
+	if (!conn || !conn->abort_reason)
 		return 0;
 
 	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
@@ -2876,6 +2876,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 */
 	if (conn->abort_reason)
 		return 0;
+	if (!reason)
+		return -EINVAL;
 
 	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
 
-- 
2.41.0

