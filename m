Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC31BC10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 18:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C191621D7E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 18:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOTPbncC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgCJSie (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:38:34 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:55560 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJSid (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 14:38:33 -0400
Received: by mail-qt1-f202.google.com with SMTP id o10so9700084qtk.22
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DVW9btlrE9WxdPGCCpJUK2ALvJluBH0kWl1F121tkv8=;
        b=IOTPbncCEhJ6Tlz1Iw6Gu+n2Ojfh6tB5pWO5AS2+hXov1EUWbLSoF7wSBUH20ovyt7
         zxQlcZcCR/aX7jbuBwKpop15IyvI5jXWDoBQ2bMeD5UarniqqgyoP6g8a2UCA3SFd7l4
         gs8EqISUW8RauHWE3mWMnRQFsk3kB4EQwyss7hkvcD7jGfOyr0mD4ZNXbVPzmQRKa4XG
         3tMuVRUC351yCD4XC9LcUIumBkpJFggMJpk22rPpdmmjpx6mHT5dKqudgULcsj8HzLh5
         5KFvUzlCPS1HyTGUrmGKaEuGzu9Xo/yq+rY1aul7UuhME44YuhNJueGBdclGJrLKxXPt
         W5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DVW9btlrE9WxdPGCCpJUK2ALvJluBH0kWl1F121tkv8=;
        b=kGB8Dn43KBJlTJESA9H81PqcooUYdiOfJyQEkooOlYBGL5mUq0VQ0OWNrEz4RXHGbm
         Fn8LAy1quRW91l2dkcr2UTqnkKPZQdSeis1zr5ah2RLFZPP9WDv8+aHv9YiApvjTZ6N8
         zfwo7avEBMO6Wxb1TdoFqBodFOVAOedA3iiJZfFVTbmWiFaP3hadgYNfIAmNJ35xDz9d
         eQ8gbZ3bixfMBTBq3/dW3XMRNMmcKp/vKdQm5ZLgsmU5/XRZIkiGN7ZphBsurmgRqmRA
         u4rrlxgZfyK5z4xoohmYU3hWFx4iQJDTvnzuwT0KRB30PIFsf9hCElXcvx1CniC4c1xJ
         1igQ==
X-Gm-Message-State: ANhLgQ00p3V1RScTiMxm5bGktszv5g6+QmbjVLvCvO9kwRiOiypzxKCO
        tHDYQJg1oNAj1MYTQ/R0U+CU8zAXCXXEfQ==
X-Google-Smtp-Source: ADFU+vt3hko+Smop5fTqoBl8hrviV1maP8B16CI24CvOJMBylSgDWKjoTPwri0v8rrhRtvBjU7JPuD+4NG8I7Q==
X-Received: by 2002:a0c:90a2:: with SMTP id p31mr11609515qvp.2.1583865512672;
 Tue, 10 Mar 2020 11:38:32 -0700 (PDT)
Date:   Tue, 10 Mar 2020 11:38:27 -0700
Message-Id: <20200310113816.1.I12c0712e93f74506385b67c6df287658c8fdad04@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] Bluetooth: clean up connection in hci_cs_disconnect
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org
Cc:     Alain Michaud <alainm@chromium.org>,
        linux-bluetooth@vger.kernel.org,
        Miao-chen Chou <mcchou@chromium.org>,
        Joseph Hwang <josephsih@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Joseph Hwang <josephsih@chromium.org>

In bluetooth core specification 4.2,
Vol 2, Part E, 7.8.9 LE Set Advertise Enable Command, it says

    The Controller shall continue advertising until ...
    or until a connection is created or ...
    In these cases, advertising is then disabled.

Hence, advertising would be disabled before a connection is
established. In current kernel implementation, advertising would
be re-enabled when all connections are terminated.

The correct disconnection flow looks like

  < HCI Command: Disconnect

  > HCI Event: Command Status
      Status: Success

  > HCI Event: Disconnect Complete
      Status: Success

Specifically, the last Disconnect Complete Event would trigger a
callback function hci_event.c:hci_disconn_complete_evt() to
cleanup the connection and re-enable advertising when proper.

However, sometimes, there might occur an exception in the controller
when disconnection is being executed. The disconnection flow might
then look like

  < HCI Command: Disconnect

  > HCI Event: Command Status
      Status: Unknown Connection Identifier

  Note that "> HCI Event: Disconnect Complete" is missing when such an
exception occurs. This would result in advertising staying disabled
forever since the connection in question is not cleaned up correctly.

To fix the controller exception issue, we need to do some connection
cleanup when the disconnect command status indicates an error.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 net/bluetooth/hci_event.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a40ed31f6eb8f..7f7e5ba3974a8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2191,6 +2191,7 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_disconnect *cp;
 	struct hci_conn *conn;
+	u8 type;
 
 	if (!status)
 		return;
@@ -2202,10 +2203,21 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
-	if (conn)
+	if (conn) {
 		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
 				       conn->dst_type, status);
 
+		/* If the disconnection failed for any reason, the upper layer
+		 * does not retry to disconnect in current implementation.
+		 * Hence, we need to do some basic cleanup here and re-enable
+		 * advertising if necessary.
+		 */
+		type = conn->type;
+		hci_conn_del(conn);
+		if (type == LE_LINK)
+			hci_req_reenable_advertising(hdev);
+	}
+
 	hci_dev_unlock(hdev);
 }
 
-- 
2.25.1.481.gfbce0eb801-goog

