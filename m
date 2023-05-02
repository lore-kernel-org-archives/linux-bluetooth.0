Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1E3C7EE24
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 20:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjEBUQC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 16:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjEBUQA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 16:16:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00721FC3
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 13:15:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24e24b0193fso1187610a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683058543; x=1685650543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BFwpSW7WSPxSuB/p2o9rzOoGAMdZNpn0wLc1+Av00M=;
        b=d39t6R9wPjIU8LCr3Gdyg4/pBaLAfPpqNZ1OgOeDo20EBn/+GilGk7Y1Fv7QZt7NEF
         LVkparK/lj3qLqL4DflyzCwLBVT6zR87I8Zvt2OyPByD8VDtqxvZeYNNo2ooi01cY0oW
         UwDWfogfJWZnQHtWXPU+dL3X4Y1i25853tjo4oaOy3N/4uOWiFZ9LBhj1NANuVosjIP1
         ZvSZaLr377gnIq5Gs/byNvozh5gA8fht3Tj3LekQ5CHuzz6615dUQjV+nMfM6l28xuSa
         an6pVEzejgzIuALm4jsm2Od70FlVZ3pQGyqSN6Jalpw4ncMlHOvH3uVH65vYLyPq0FA+
         JL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058543; x=1685650543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BFwpSW7WSPxSuB/p2o9rzOoGAMdZNpn0wLc1+Av00M=;
        b=KHbyTfzYQIM6EBeF0h1a50Oq+P5JYbvtuAH0W9xNbZ2V/LyjE+q5QwRVeoBxdrYIJJ
         a3HkUSq/ZAsiMH9zptbA4yg/FFF52LblWhogge/WgaWHBZEN8qCN7b0BcWL9Nl8SNihN
         zqWpeLbxV7wwWz0mxByxnXZchiuhK7+TT4PNtP0Wix4qMC77PsNZWacmCSgJA3i1foij
         2Apfs5qz8bAOgX/x9/AAz//WYb6JMjHdqQ1rFRmMGDqezcWJL6FZvoJj4YQqG+jiQB9h
         gs/Kc8+ayRbZgJYb5Mbe19xXxt6jBiIiUgib6YdjifTqXhSEnAY0mVO875xxbSxaCEbb
         e0Fg==
X-Gm-Message-State: AC+VfDyiS0ZlbyY0YqfKRNTL45TFWyLcNuCGW3ytD7/H+Mm7Vz4DbhL7
        a9BRKNPt4qP7HAW5RHtx+REZEO71+Og=
X-Google-Smtp-Source: ACHHUZ7e0lDJnRbDPkDTMP6DkigE4iGHlJtvsuR7HLlU6V/ITDAAJGFxuFDhST9EwoXflgf//VOjhg==
X-Received: by 2002:a17:90a:858b:b0:24d:f802:9172 with SMTP id m11-20020a17090a858b00b0024df8029172mr9413567pjn.19.1683058543301;
        Tue, 02 May 2023 13:15:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709028a8900b0019cb6222691sm20133364plo.133.2023.05.02.13.15.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 13:15:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] Bluetooth: Unlink CISes when LE disconnects in hci_conn_del
Date:   Tue,  2 May 2023 13:15:34 -0700
Message-Id: <20230502201534.1500462-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502201534.1500462-1-luiz.dentz@gmail.com>
References: <20230502201534.1500462-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Currently, hci_conn_del calls hci_conn_unlink for BR/EDR, (e)SCO, and
CIS connections, i.e., everything except LE connections. However, if
(e)SCO connections are unlinked when BR/EDR disconnects, CIS connections
should also be unlinked when LE disconnects.

In terms of disconnection behavior, CIS and (e)SCO connections are not
too different. One peculiarity of CIS is that when CIS connections are
disconnected, the CIS handle isn't deleted, as per [BLUETOOTH CORE
SPECIFICATION Version 5.4 | Vol 4, Part E] 7.1.6 Disconnect command:

        All SCO, eSCO, and CIS connections on a physical link should be
        disconnected before the ACL connection on the same physical
        connection is disconnected. If it does not, they will be
        implicitly disconnected as part of the ACL disconnection.
        ...
        Note: As specified in Section 7.7.5, on the Central, the handle
        for a CIS remains valid even after disconnection and, therefore,
        the Host can recreate a disconnected CIS at a later point in
        time using the same connection handle.

Since hci_conn_link invokes both hci_conn_get and hci_conn_hold,
hci_conn_unlink should perform both hci_conn_put and hci_conn_drop as
well. However, currently it performs only hci_conn_put.

This patch makes hci_conn_unlink call hci_conn_drop as well, which
simplifies the logic in hci_conn_del a bit and may benefit future users
of hci_conn_unlink. But it is noted that this change additionally
implies that hci_conn_unlink can queue disc_work on conn itself, with
the following call stack:

        hci_conn_unlink(conn)  [conn->parent == NULL]
                -> hci_conn_unlink(child)  [child->parent == conn]
                        -> hci_conn_drop(child->parent)
                                -> queue_delayed_work(&conn->disc_work)

Queued disc_work after hci_conn_del can be spurious, so during the
process of hci_conn_del, it is necessary to make the call to
cancel_delayed_work(&conn->disc_work) after invoking hci_conn_unlink.

Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1e8910c50bef..6414f64334aa 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1100,7 +1100,9 @@ static void hci_conn_unlink(struct hci_conn *conn)
 			 * yet at this point. Delete it now, otherwise it is
 			 * possible for it to be stuck and can't be deleted.
 			 */
-			if (child->handle == HCI_CONN_HANDLE_UNSET)
+			if ((child->type == SCO_LINK ||
+			     child->type == ESCO_LINK) &&
+			    child->handle == HCI_CONN_HANDLE_UNSET)
 				hci_conn_del(child);
 		}
 
@@ -1113,6 +1115,7 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	list_del_rcu(&conn->link->list);
 	synchronize_rcu();
 
+	hci_conn_drop(conn->parent);
 	hci_conn_put(conn->parent);
 	conn->parent = NULL;
 
@@ -1126,12 +1129,13 @@ void hci_conn_del(struct hci_conn *conn)
 
 	BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
 
+	hci_conn_unlink(conn);
+
 	cancel_delayed_work_sync(&conn->disc_work);
 	cancel_delayed_work_sync(&conn->auto_accept_work);
 	cancel_delayed_work_sync(&conn->idle_work);
 
 	if (conn->type == ACL_LINK) {
-		hci_conn_unlink(conn);
 		/* Unacked frames */
 		hdev->acl_cnt += conn->sent;
 	} else if (conn->type == LE_LINK) {
@@ -1142,13 +1146,6 @@ void hci_conn_del(struct hci_conn *conn)
 		else
 			hdev->acl_cnt += conn->sent;
 	} else {
-		struct hci_conn *acl = conn->parent;
-
-		if (acl) {
-			hci_conn_unlink(conn);
-			hci_conn_drop(acl);
-		}
-
 		/* Unacked ISO frames */
 		if (conn->type == ISO_LINK) {
 			if (hdev->iso_pkts)
-- 
2.40.0

