Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF37CC7EE43
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 21:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbjFHVG5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jun 2023 17:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbjFHVGy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jun 2023 17:06:54 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046F62D7E
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 14:06:50 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QccGJ2nYGz10LN;
        Fri,  9 Jun 2023 00:06:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1686258408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UAF2j62o62g4jxJcr8tw9/1yrhub+sdCrQ4qdE9Qg6g=;
        b=b0N5+gdnE/AOBwAzrAutUA5HvVI64AlbIXaxeRqcN6bbZQ5m10Z+I/1qGMOHs1Me+H/Jx0
        GhbJ9gJhvJkppSdnFPTnX8JB1r28/Uc+t2nc6+fpWIgjm0xek8ZRNidHAw0D1My14JE28i
        Vg+0Z+dgTTw+pT7+w0f1N64+g0v2RHg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1686258408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UAF2j62o62g4jxJcr8tw9/1yrhub+sdCrQ4qdE9Qg6g=;
        b=S0lEIwkCIE4Y2z0NBqFMr9rJzcjanw04a5pdc0U1gQT5cEDGsgcAXiyVFKmzkim9Pm7+oC
        HclxgDxn2/1uWt8ZVFEGWkqZLQCEWt5gOj7H7Z4RVkhf7iks/NqRVjy4CK2VoNxJDOG2rt
        2086b3zBV6LLkQ1VRJlPrC8q2jd0BPc=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1686258408; a=rsa-sha256; cv=none;
        b=UfKzAKnTA98c6TUYEpczt4/vCnaGc3ZaPCPNJUlxgcHMb/VxsS7pjJ5BrY7ukEmi4QvGuv
        UFXjPZftWmbpmeYVu+SnLVXlaubF5uVQL0Nw+faWxT/RMsNDOz93MGiJkNJHsUznKL/pAK
        oyybWfgz4rDEL/imKyo/cYD37up6q8M=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 2/3] Bluetooth: hci_event: call ISO disconnect callback before deleting conn
Date:   Fri,  9 Jun 2023 00:06:43 +0300
Message-Id: <7dd7bff24c3f6765728aec12b2e96be792d8f6d7.1686252492.git.pav@iki.fi>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686252492.git.pav@iki.fi>
References: <cover.1686252492.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In hci_cs_disconnect, we do hci_conn_del even if disconnection failed.

When this occurs for ISO connections, which refer to the conn without
hci_conn_get, disconn_cfm must be called otherwise use-after-free
occurs.

Currently ISO socket Disconnect often fails because we try disconnect
them after disconnecting ACL when they are already implicitly
disconnected (Core v5.3 Vol 4 Part E Sec 7.1.6).

Trace from logs:
==========================================================
iso_sock_connect:880: sk 00000000eabd6557
iso_connect_cis:356: 70:1a:b8:98:ff:a2 -> 28:3d:c2:4a:7e:da
...
iso_conn_add:140: hcon 000000001696f1fd conn 00000000b6251073
hci_dev_put:1487: hci0 orig refcnt 17
__iso_chan_add:214: conn 00000000b6251073
iso_sock_clear_timer:117: sock 00000000eabd6557 state 3
...
hci_rx_work:4085: hci0 Event packet
hci_event_packet:7601: hci0: event 0x0f
hci_cmd_status_evt:4346: hci0: opcode 0x0406
hci_cs_disconnect:2760: hci0: status 0x0c
hci_sent_cmd_data:3107: hci0 opcode 0x0406
hci_conn_del:1151: hci0 hcon 000000001696f1fd handle 2560
hci_conn_unlink:1102: hci0: hcon 000000001696f1fd
hci_conn_drop:1451: hcon 00000000d8521aaf orig refcnt 2
hci_chan_list_flush:2780: hcon 000000001696f1fd
hci_dev_put:1487: hci0 orig refcnt 21
hci_dev_put:1487: hci0 orig refcnt 20
hci_req_cmd_complete:3978: opcode 0x0406 status 0x0c
... <no iso_* activity on sk/conn> ...
iso_sock_sendmsg:1098: sock 00000000dea5e2e0, sk 00000000eabd6557
BUG: kernel NULL pointer dereference, address: 0000000000000668
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
RIP: 0010:iso_sock_sendmsg (net/bluetooth/iso.c:1112) bluetooth
==========================================================

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    This might be necessary for all socket types, not sure about that yet.

 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7c199f7361f7..fb80923bf965 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2784,6 +2784,12 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 			hci_enable_advertising(hdev);
 		}
 
+		/* Tell ISO sockets the conn went away, before we delete it,
+		 * because they do not hold reference.
+		 */
+		if (conn->type == ISO_LINK)
+			hci_disconn_cfm(conn, HCI_ERROR_LOCAL_HOST_TERM);
+
 		goto done;
 	}
 
-- 
2.40.1

