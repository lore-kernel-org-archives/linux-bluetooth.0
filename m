Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47F5C001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGZV0K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjGZV0I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:26:08 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD552691
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:26:03 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RB6Q20W7xz1097;
        Thu, 27 Jul 2023 00:25:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1690406746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wY79wLmp/mbU+avRSt0aj3qMsw6uaa1fo1QqQOAfhG4=;
        b=pY1mp0fjF1Xcol9Py+W3bVDl+MCGXwWJUAzINIZKSCDamX/fqOifGJaoicozA7MDuHrgRF
        lSCvBvIR/tJy1fNpvrfhFQxGp5tlISVWFfcYMPsDwmq49Z0MVZgUydxbkTR/2RDMB3iRR3
        adPugtQdiK85MA3FuWV+xtj6ya2nDw0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1690406746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wY79wLmp/mbU+avRSt0aj3qMsw6uaa1fo1QqQOAfhG4=;
        b=KNooRWsdtR23rd36tJ9Di8qTFIC6Bd4Jm0ouZnGYh/VY1MLlZ04+UEnIvhyoziWV7Hmck4
        78lPN55vWpjwklI51aZbTZlAZgX4C20/NiCY7TBwQnFNCiMxI1+L/Z5E7SWgn0OGzeFOtb
        i9fOf20TtFTQcdlLwFzJ/yIV+9t9JaY=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1690406746; a=rsa-sha256; cv=none;
        b=W/V7dIXFraEOTGx86/Ff0TkybY5VcDo4vvnoP79MN35NZUneg9okazKh+aQB+Sk3HytwJD
        nTXbBYEwRsNiMm+bPFjuIKbKjUZjOqvl5kIJfAC7vAZkX0omTwmGm3T/ZAaCn3tePAsE/T
        IzLnIce9NypSxAnMIzMSwjjkuq8296Y=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RFC 5/6] Bluetooth: hci_sync: delete CIS in BT_OPEN/CONNECT/BOUND when aborting
Date:   Thu, 27 Jul 2023 00:25:25 +0300
Message-ID: <6d9672c9a1e97b87e823e05ff07576013683979d.1690399379.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690399379.git.pav@iki.fi>
References: <cover.1690399379.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dropped CIS that are in state BT_OPEN/BT_BOUND, and in state BT_CONNECT
with HCI_CONN_CREATE_CIS unset, should be cleaned up immediately.
Closing CIS ISO sockets should result to the hci_conn be deleted, so
that potentially pending CIG removal can run.

hci_abort_conn cannot refer to them by handle, since their handle is
still unset if Set CIG Parameters has not yet completed.

This fixes CIS not being terminated if the socket is shut down
immediately after connection, so that the hci_abort_conn runs before Set
CIG Parameters completes. See new BlueZ test "ISO Connect Close - Success"

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 101548fe81da..3926213c29e6 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5339,6 +5339,10 @@ static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
 		if (test_bit(HCI_CONN_CREATE_CIS, &conn->flags))
 			return hci_disconnect_sync(hdev, conn, reason);
 
+		/* CIS with no Create CIS sent have nothing to cancel */
+		if (bacmp(&conn->dst, BDADDR_ANY))
+			return HCI_ERROR_LOCAL_HOST_TERM;
+
 		/* There is no way to cancel a BIS without terminating the BIG
 		 * which is done later on connection cleanup.
 		 */
@@ -5426,9 +5430,17 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	case BT_CONNECT2:
 		return hci_reject_conn_sync(hdev, conn, reason);
 	case BT_OPEN:
-		/* Cleanup bises that failed to be established */
-		if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags))
+		/* Cleanup failed CIS, and BIS that failed to be established */
+		if (bacmp(&conn->dst, BDADDR_ANY) ||
+		    test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags))
+			hci_conn_failed(conn, reason);
+		break;
+	case BT_BOUND:
+		/* Bound CIS should be cleaned up */
+		if (conn->type == ISO_LINK && bacmp(&conn->dst, BDADDR_ANY))
 			hci_conn_failed(conn, reason);
+		else
+			conn->state = BT_CLOSED;
 		break;
 	default:
 		conn->state = BT_CLOSED;
-- 
2.41.0

