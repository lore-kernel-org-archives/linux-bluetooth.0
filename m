Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2E5EE49A5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Aug 2023 13:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjHSNgP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Aug 2023 09:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjHSNgO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Aug 2023 09:36:14 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D200F27D13
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Aug 2023 06:33:46 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RSfpH4mWcz49Q1g;
        Sat, 19 Aug 2023 16:33:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1692452024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vIPZQH20bOMqt/XW1gOs+RZ1NsCf75lmXm2Dfjnu0cg=;
        b=EiaW5rL0QCk57qZQo91t9cjZojwJlZ1RUsyVVQ5x6aHkqwrt7lcPOvb7p3Xq8w03/P/oFP
        zqN6cEgrBXCohMlknSXNvHYncAqtSB9jUUtDLg8CNKSdZXkuXhmjgSGS+VIRlb2xVSRuG9
        BSJ5B7G6SOcHYZEJgDwHdG/S2D20V0TutGzDdhUXso7f0n2za83iytm1MCJjegCEnTkT6c
        T09/Dkc7F35dNQiWvjISJb6fMXM2WyLESpOJC55hP4GkNkP0AfSooa7Am/KfGAClDMPIZX
        14JrRcIX0ITY4BNj6+SfWj5QE3r6UClIrdvlsOIuM8msqNTRTMCWkMnreWzCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1692452023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vIPZQH20bOMqt/XW1gOs+RZ1NsCf75lmXm2Dfjnu0cg=;
        b=TBS8e/OqWOOUEu4NuG6J7TsYhlq5onnZOIvCoM40aLKz7Fb0+BgTulx3OMQ4NJP2V+1/IG
        /WGtzJbPJyj5cZYWXQFR4KQbC/LnpvKyxY3OkH+qBm5hbUZyIFTzNlRoX7hD2O7n9ioZmw
        Nls7/eR+EWc2xDf/bzD63rgvAHDnBvi+sMv44qgzuwbFLgoh5WnMl/e19SQSuI4ODL9mKU
        QfuVsSE3+Yu8DDG4VBXWb5rCuDVRnnCNcbnZ/XfMKIqIj+qis+2KGl3j7c57KAV1NUB5k9
        VzQW0tpFgPXTSdhY1epmlVHrwwrhc6lkw/LjcsrkVQWyzZx29x6pWWYITHdcNg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1692452024; a=rsa-sha256;
        cv=none;
        b=ANzojFdVzbzsgsgJwpUoEc7y70rUmIje/OT2c3Y0NEIyPqgdX1snxlayBxWFIbKfU/ClRu
        wHzNs+A/TpXdRRdKYp9hnr4949RUDeuA1+ivaX+wCf6dIoBY10C2E8ySh8uix5WT3bw1Ay
        8ztDPHXErfB4ERdagKQJMG3Qn0R0FfLt+OznXcf0VcPRlQr7k9k8fr/t3AJKV4Cu/vFVFt
        AwfOfOkSDPhp5+gzqdb+joBxvwFLs7VPXv1PRwdO9y1ZG2J0swTR5NJJUJuVOAkSHnj6P5
        HIZWCZ/YRKOBTeythjuP6aiwbvdHSPr/O9M9S6LjXlWgCUcYv6XcPxZW4NcZHA==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>, syzkaller-bugs@googlegroups.com,
        syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci_conn: fail SCO/ISO via hci_conn_failed if ACL gone early
Date:   Sat, 19 Aug 2023 16:33:36 +0300
Message-ID: <d5aebbd4337291708c970380fa947a0fe1767cd5.1692451565.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Not calling hci_(dis)connect_cfm before deleting conn referred to by a
socket generally results to use-after-free.

When cleaning up SCO connections when the parent ACL is deleted too
early, use hci_conn_failed to do the connection cleanup properly.

We also need to clean up ISO connections in a similar situation when
connecting has started but LE Create CIS is not yet sent, so do it too
here.

Fixes: ca1fd42e7dbf ("Bluetooth: Fix potential double free caused by hci_conn_unlink")
Reported-by: syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/00000000000013b93805fbbadc50@google.com/
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    This makes BlueZ test cases pass (and should fix syzbot crash):

    ISO Connect ACL Disconnect - Failure                 Passed       1.004 seconds
    eSCO ACL Disconnect - Failure                        Passed       0.987 seconds

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git f0835e7404b7f6fd825fc1ad7a174253a54234cf

 net/bluetooth/hci_conn.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8b0c8e631324..9d5057cef30a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1044,6 +1044,29 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return conn;
 }
 
+static void hci_conn_cleanup_child(struct hci_conn *conn, u8 reason)
+{
+	if (!reason)
+		reason = HCI_ERROR_REMOTE_USER_TERM;
+
+	/* Due to race, SCO/ISO conn might be not established yet at this point,
+	 * and nothing else will clean it up. In other cases it is done via HCI
+	 * events.
+	 */
+	switch (conn->type) {
+	case SCO_LINK:
+	case ESCO_LINK:
+		if (HCI_CONN_HANDLE_UNSET(conn->handle))
+			hci_conn_failed(conn, reason);
+		break;
+	case ISO_LINK:
+		if (conn->state != BT_CONNECTED &&
+		    !test_bit(HCI_CONN_CREATE_CIS, &conn->flags))
+			hci_conn_failed(conn, reason);
+		break;
+	}
+}
+
 static void hci_conn_unlink(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -1066,14 +1089,7 @@ static void hci_conn_unlink(struct hci_conn *conn)
 			if (!test_bit(HCI_UP, &hdev->flags))
 				continue;
 
-			/* Due to race, SCO connection might be not established
-			 * yet at this point. Delete it now, otherwise it is
-			 * possible for it to be stuck and can't be deleted.
-			 */
-			if ((child->type == SCO_LINK ||
-			     child->type == ESCO_LINK) &&
-			    HCI_CONN_HANDLE_UNSET(child->handle))
-				hci_conn_del(child);
+			hci_conn_cleanup_child(child, conn->abort_reason);
 		}
 
 		return;
-- 
2.41.0

