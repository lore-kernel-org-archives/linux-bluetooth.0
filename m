Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D929C77B75
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 21:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjEBVZi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 17:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjEBVZh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 17:25:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4613010EF
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 14:25:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64115e652eeso367782b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683062735; x=1685654735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ka/SwIDHwEHrJuqFX1XIh48oMlHgMa3gOezG3it4Bk=;
        b=Zgvi5vPCxzCrmjN49/vGxfjzHtxRrYNcse/MjRqB13tFz1VNH81l4CxErXEKqxzKvX
         nFasVU2+FjAA383J7Ov3e4c5boylFFItnBwq004ejmBsy7427DE7wa+ukKeJROURDRgm
         r59FnXUi13mpmAZ1s3EM2ocvRa39YpXEkH85mU69azxvRXc/ZivnnzcA4RBCSdCWK7Zb
         VqGBT+SfKEC0YvgAYod1JzQq12nhLgdWpH9mCJlhHpJCpUWB3jz+++W1H6Tvm8/IPcdI
         Qd5ohI3FpsKAK0njXYKDinRR16x+BOI0jdvs9HcTIkbOenVE1yY+x0wxpp6WaS9kInCW
         7moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062735; x=1685654735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ka/SwIDHwEHrJuqFX1XIh48oMlHgMa3gOezG3it4Bk=;
        b=A3PV3x6ssk+OB47nngZmGEw/y8DfKFdNitz8zqJcegLrd6HzzJp874DBkG8bujTp2B
         sBt41qSwuJHkOckZXwTrPoWZ81yRSSjARsMKP/ekXOFsF2SngU5opTpRlUi0e9gB0MNi
         0kRUdY6m7XTydnzm+hK6vwJXww2uviBh94wG61mLYmrq/t5FtvqMejPkDMgiwurOzDFU
         I7KDn18VUQKroUldkUWLV2ZsCNCpp+AKEB5eqOVvgKg9G2zQVz7HXG8bHhbL41mRPchu
         x4C2HT2TrNqdNDCynR0hY/k9xSupJVMTumlsxEj8Jku8T+VwZskPATMn6gxGkMPn7WBw
         XSHw==
X-Gm-Message-State: AC+VfDz9FR5h+EIRTupZ+88UwNCx3GfaYv6qamO4m5H9fcUeYLrg1W2F
        Qt1PzHcHAdXYCGG/l21c4gxIc4VgP8s=
X-Google-Smtp-Source: ACHHUZ5rbCWi3v268uIKpLBOMI91xKpYfxl/TjVKmX8X+YNs3wVLaUkgNWUijTVLD2H9lEPBN/wPxg==
X-Received: by 2002:aa7:8b49:0:b0:63f:32ed:92b1 with SMTP id i9-20020aa78b49000000b0063f32ed92b1mr20353403pfd.7.1683062734955;
        Tue, 02 May 2023 14:25:34 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b0063d3d776910sm22232459pfj.138.2023.05.02.14.25.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 14:25:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/4] Bluetooth: Unlink CISes when LE disconnects in hci_conn_del
Date:   Tue,  2 May 2023 14:25:27 -0700
Message-Id: <20230502212527.1662896-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502212527.1662896-1-luiz.dentz@gmail.com>
References: <20230502212527.1662896-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_conn.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ce588359b290..f75ef12f18f7 100644
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
@@ -2485,12 +2482,6 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 						list)) != NULL) {
 		conn->state = BT_CLOSED;
 		hci_disconn_cfm(conn, HCI_ERROR_LOCAL_HOST_TERM);
-
-		/* Unlink before deleting otherwise it is possible that
-		 * hci_conn_del removes the link which may cause the list to
-		 * contain items already freed.
-		 */
-		hci_conn_unlink(conn);
 		hci_conn_del(conn);
 	}
 }
-- 
2.40.0

