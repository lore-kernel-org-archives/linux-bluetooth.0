Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780C1C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 15:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiFBPPK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 11:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbiFBPPJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 11:15:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71131C2D63
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 08:15:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 84-20020a250557000000b0065bb92955a2so4409586ybf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jun 2022 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Wr2n5iI7XttDispKB41EO8G79l4qta1A1VBwdKgaGQg=;
        b=K57/WdHT4u8VdENtYRT2HFl5kLPTLI0FcXt1D8IExcQ6jqRfEB78EOmbDeXhnMLAvx
         ShM+ROjLF8dh1S+MActgGL3MfFOJKHMiqUACX0uAFFTahYnUUPNZH0ivKYqGh46n9Qvv
         JIl1EH6b3KoMsm4FozPq3FZZ3qd1TbDzgBpA0TESnZwYKtoSt3FoG+zvJsUgDUuhG7Gq
         eywRkDVmJ+53j+cYerjmufgUCW6r4D/HTR543Pqm51dozKw/gfhXZY9wwekLD183o7C+
         cxKKbP3EbNMGPVgSw88747UrRcyWeVckl8bkm/yMVsPAzekVnAjDzx4gQqY95FW0GKVn
         ZxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Wr2n5iI7XttDispKB41EO8G79l4qta1A1VBwdKgaGQg=;
        b=KfheSKTlkTl22SMXE0l4HGjyIDGo+o4tlMJKQ2dWCstsqZVi/JqmrVpXXUmOYBYfpZ
         MSEe814PZ0xwDVzKSnaK+xPrF3aSUDRbB5ijt1MvSSqGofiILjE0qIyJGnrlNKVBxJJR
         TctX1LWwY92GUIPFX+bnM7sOfCGB8KoopLeqoEWOK6go3nGrQgQMbFdmVgHRqmFqFSs2
         2xAVgrHvMps+PyEmA6apvBu5iG1IZX8s9I4fv2rlCapZ7mVLWE5UcwCmVDp6/ziFkWtq
         aDetnq0E3x51r8ibjwEvulM6J/0qd4FczMzM66Re5xKCSiLgtkcvIH7iB9DEgeY6uSBi
         0c/g==
X-Gm-Message-State: AOAM531peYXqyJK6vSdFfFhsbsW92wv3uj/It+ZNzHnqv0y76wWyiT89
        LHK0mgRbTNCwnABKXBOEMBN/4jwWHYshRCrktyHdUfLhWt07GNaeBQbMEPwpNvbmx6Bg1YOEiEu
        FFVtL7KdpB3+YXkH2aL/4Aa3X9ty4vCkew9Br38CGYjGh1GX0u3gwQk/il3ScxDijNAddxXPZ48
        0mj4miMYVyzhYqDQ==
X-Google-Smtp-Source: ABdhPJwgzfjBkuwAIlhVJU3K64/lVauaaNGCor4kJpVmZz5B9OzfxnNDf589Fln0AbrJ3JiMHsVhssHw5pKQEGTTYVM=
X-Received: from alainmic.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2890])
 (user=alainmichaud job=sendgmr) by 2002:a25:8046:0:b0:65b:9fd2:53b0 with SMTP
 id a6-20020a258046000000b0065b9fd253b0mr5804468ybn.100.1654182907005; Thu, 02
 Jun 2022 08:15:07 -0700 (PDT)
Date:   Thu,  2 Jun 2022 15:15:03 +0000
Message-Id: <20220602151456.v2.1.I9f2f4ef058af96a5ad610a90c6938ed17a7d103f@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2] Bluetooth: clear the temporary linkkey in hci_conn_cleanup
From:   Alain Michaud <alainmichaud@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Alain Michaud <alainm@chromium.org>

If a hardware error occurs and the connections are flushed without a
disconnection_complete event being signaled, the temporary linkkeys are
not flushed.

This change ensures that any outstanding flushable linkkeys are flushed
when the connection are flushed from the hash table.

Signed-off-by: Alain Michaud <alainm@chromium.org>

---

Changes in v2:
-Address Feedback from Luiz

 net/bluetooth/hci_conn.c  | 3 +++
 net/bluetooth/hci_event.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 352d7d612128..5911ca0c5239 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -118,6 +118,9 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 	if (test_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
 		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
 
+	if (test_and_clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
+		hci_remove_link_key(hdev, &conn->dst);
+
 	hci_chan_list_flush(conn);
 
 	hci_conn_hash_del(hdev, conn);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6b83f9b0082c..b67fdd1ad8da 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2729,7 +2729,7 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	mgmt_conn = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
 
 	if (conn->type == ACL_LINK) {
-		if (test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
+		if (test_and_clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
 			hci_remove_link_key(hdev, &conn->dst);
 	}
 
@@ -3372,7 +3372,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
 				reason, mgmt_connected);
 
 	if (conn->type == ACL_LINK) {
-		if (test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
+		if (test_and_clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
 			hci_remove_link_key(hdev, &conn->dst);
 
 		hci_req_update_scan(hdev);
-- 
2.36.1.255.ge46751e96f-goog

