Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B3AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 11:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEBF261A4F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 11:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhIILuW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 07:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240107AbhIILqc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 07:46:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F4886124F;
        Thu,  9 Sep 2021 11:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631187781;
        bh=wmAn7NASzO3JH9q1wnZ3WbFIdI3bcHKwprsxehcilEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MArroyZM8JL05CgMkzarvvBO1CBKApYb7yKmWzHSW6/MS2/tYA4otr1ElTgAvxEiA
         d38suipkBTimMzEaiCbW/oTt/hiRpBVAGPkJzmxIXhVAzx/5OQO1VE+/AFwkHLQCZF
         3ZIAaLRLlOasZY0j2FLp0rE8Mp8/3GKCq7svhjlQWSsivCXJmvVPeck4RnLOXRw1+2
         lQ20vajy5ClEox+IKGX08DF1AdnmAP9Q/Pd9ebf0ajJb34euMmQGgcNkeu8MbHc9+9
         Mrj6ryDZjoqr5Q8IGF4oHcR7dPr/V8iHIqkIy1wFSkGlX9T/KPGl/UTPZlv1LYhZpV
         oYCFExKZ6rp/Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        syzbot+66264bf2fd0476be7e6c@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 090/252] Bluetooth: skip invalid hci_sync_conn_complete_evt
Date:   Thu,  9 Sep 2021 07:38:24 -0400
Message-Id: <20210909114106.141462-90-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909114106.141462-1-sashal@kernel.org>
References: <20210909114106.141462-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>

[ Upstream commit 92fe24a7db751b80925214ede43f8d2be792ea7b ]

Syzbot reported a corrupted list in kobject_add_internal [1]. This
happens when multiple HCI_EV_SYNC_CONN_COMPLETE event packets with
status 0 are sent for the same HCI connection. This causes us to
register the device more than once which corrupts the kset list.

As this is forbidden behavior, we add a check for whether we're
trying to process the same HCI_EV_SYNC_CONN_COMPLETE event multiple
times for one connection. If that's the case, the event is invalid, so
we report an error that the device is misbehaving, and ignore the
packet.

Link: https://syzkaller.appspot.com/bug?extid=66264bf2fd0476be7e6c [1]
Reported-by: syzbot+66264bf2fd0476be7e6c@syzkaller.appspotmail.com
Tested-by: syzbot+66264bf2fd0476be7e6c@syzkaller.appspotmail.com
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1c3018202564..ea7fc09478be 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4382,6 +4382,21 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 
 	switch (ev->status) {
 	case 0x00:
+		/* The synchronous connection complete event should only be
+		 * sent once per new connection. Receiving a successful
+		 * complete event when the connection status is already
+		 * BT_CONNECTED means that the device is misbehaving and sent
+		 * multiple complete event packets for the same new connection.
+		 *
+		 * Registering the device more than once can corrupt kernel
+		 * memory, hence upon detecting this invalid event, we report
+		 * an error and ignore the packet.
+		 */
+		if (conn->state == BT_CONNECTED) {
+			bt_dev_err(hdev, "Ignoring connect complete event for existing connection");
+			goto unlock;
+		}
+
 		conn->handle = __le16_to_cpu(ev->handle);
 		conn->state  = BT_CONNECTED;
 		conn->type   = ev->link_type;
-- 
2.30.2

