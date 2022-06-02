Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAFCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 15:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiFBPaK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 11:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbiFBPaI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 11:30:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A38D13C351
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 08:30:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-30026cf9af8so45581047b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jun 2022 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2nAGCZ2HRmIXfv8rT8uSoEGsDABE/p5lJinXX/zQGnA=;
        b=IfIrft4dh0L+HPBnonus5+t8id1FCITlCEYwqDadPZIb9negqKU7CN3IGx3i8hTnhR
         kB6ouvKEZZZP0zF0B8cw1UOa/f8y3XVDhpPK7cRzGLWUcglbKxAbMtNc0hniyy5/hL7F
         Osuhj77CqUU9jyA7mlllRNA736rv4LPVJjfzC0DsNurQR5dVgRYPdP8tdusDwF0hE3ZR
         qyCRo4MI1G6T2kSnla0yA76He3F+Fquw4jlhF3DudC+aK0Md+LME2aC1Bi/fTYB2sq+0
         HQb17wBXpRy+YvXh3tfiB/Nk1Ba3q4rmQZEtl92xvisIC2C60EziP4l54dD3Um39VU9G
         pPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2nAGCZ2HRmIXfv8rT8uSoEGsDABE/p5lJinXX/zQGnA=;
        b=07HC6nzHVwfu7kp4A5PoDL40I73RsTBd2w65iLECnMrpPiRRPd8iEUgnyMZCRnsleq
         ovr0RSwLHhEGU0290JmQrGpyB+z7GFzkeOHJaXrrtrBFC8dEtmYMKASefK79G8B/40X0
         bHqJ4ToXAgOCGo9QijYKNvm2965Ipkx01bA8WHcrek+ocud7CwcqRjVV3ibQhKIJlibH
         EnoOBIPKxe3Mu5JQ7x2vEuHhyQPSKyvNxQWkIeu0isHCFQ7sUPHBoFtESi0129BNAMh4
         KQ2dE5eVzLPXXVo0GKN16r87G16U+8IIjgb19JLvbfd3wR44HvkiiNQNDddRRL49iLYR
         AsPg==
X-Gm-Message-State: AOAM531E8akIMxqJZ02SkgTpT62DEJI84X8NQS3tpjrVnPxDYCsTacKW
        bzCwf6JtRBDFZuytMTRE2b858JEXO7d+d8gh44fgrhg88h7QmOHUCVpJoLhA6UAK+J83Ra6uqMu
        PrYL/aAcK5DiTHkwQQN0JoRym7DW8oLo9T0o8iQ9MIpK4QNGXsP2CVozHE6IDEQzSl5seIdq+um
        U6lyUFn5okSvux9A==
X-Google-Smtp-Source: ABdhPJx9WENoVblAMpg4ET+k1EH0awq1ra4yhT0qlJy920LyMKD8OOajT85XeuhNvx8xInBSN3eh9VZql+trNKSgB1w=
X-Received: from alainmic.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2890])
 (user=alainmichaud job=sendgmr) by 2002:a25:2c4c:0:b0:65d:3767:2ef2 with SMTP
 id s73-20020a252c4c000000b0065d37672ef2mr5957046ybs.570.1654183806234; Thu,
 02 Jun 2022 08:30:06 -0700 (PDT)
Date:   Thu,  2 Jun 2022 15:30:03 +0000
Message-Id: <20220602152952.v3.1.I9f2f4ef058af96a5ad610a90c6938ed17a7d103f@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3] Bluetooth: clear the temporary linkkey in hci_conn_cleanup
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

Additionally, this also makes use of test_and_clear_bit to avoid
multiple attempts to delete the link key that's already been flushed.

Signed-off-by: Alain Michaud <alainm@chromium.org>

---

Changes in v3:
-Adding test_and_clear_bit to the commit description based on Marcel's
feedback

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

