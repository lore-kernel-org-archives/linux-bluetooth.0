Return-Path: <SRS0=LYTB=C7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4841C2D0E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Sep 2020 07:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84AED239D2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Sep 2020 07:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AucI3MRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIVH4S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Sep 2020 03:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIVH4S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Sep 2020 03:56:18 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BF4C0613D0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2020 00:56:18 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id b18so15405723qto.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2020 00:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ClKheBsVPCjUi1w0lCfGtWlJh8qfJBEdB5PCy2ar4eQ=;
        b=AucI3MRGxCu1uQ3YwRyhbF9AV90VUSbzOq+E13sGK46lv3zhafkIXVxlaRdbZkMOFp
         uD+RQhz++rvrSt6zSCfX/jNrMzRJDUKglbhV+XnvrPhf8d5vfmHukiMUmnCgNCeVYv0d
         13PDmn7qysJV03qMFOEe+mdUoYRLiowtLKjq44/u9/viZqJFz8tM9/zjxebu5IypWNw1
         as2UZN+TQH0E3iuIDsafThBzdP7AFwsToQprz9uMK1YtM7n35824NKcJnf3OLaAQESqV
         IPhbZNrRqs/Tmj6NLv8mloisoRhBVAzbirZftx6ipmL+J3MELZiMjgu7h51BMWwg6aoq
         8xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ClKheBsVPCjUi1w0lCfGtWlJh8qfJBEdB5PCy2ar4eQ=;
        b=ENkYAGAKLy62snvzdHDwjgZng8GmlD7g3QnIjSgs1qSQZRovPiyGAODCPGrKmDHO57
         dTdt5UGp+2An9RHcJbjq4stEM0hG3tNL6DKHH/TXenzf5L4vbjuh1LZ39EED86iXeUvr
         RFSj0cnM5XvRdr7V6SB0NUcgrPUa2kvhooEGoZNsa99OuBkKjyfqe6VFaAL09aG8LZ7h
         n93MKiMdMPuYhYfpmqlYI3Y0IdDNksk6uQSQIbUP0je4WvlhOxUcrxboBxJWKATFrz/g
         ltgsWgP3YYrN5z/s1TTNYPV/lrkHGaAwsRMnufrMFZpLupMaD4wR7O++bwWEfTQwLCPb
         Re9Q==
X-Gm-Message-State: AOAM533Ql5ap7sGIGUVzPpFJ7IQ3z2kt7EzyXWOQBrJ63NUeaeMfM9gH
        3wXBfYoGxe73WQUIJf8mwrCjfS2dPOXJC4W6XIOJ3ELzckVP+SAVm3E0VUxCLTBAQ8XH2eM7zct
        +I+P5SiWbQzWVW2u4fKSPHsbk4N5OzQHOpMGyCZH+wWR7fyojgIZ6Nx3Qe7b3x3d3ink+TJvArH
        zs
X-Google-Smtp-Source: ABdhPJyR9yLwG5vy6sWNnj6uUqoZ9+AuNeiZPDSyud1VBRfooMC47509/9C+6TBmwN4TjtWXTMXV0zSHSyMT
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:ad4:57cc:: with SMTP id
 y12mr4563202qvx.48.1600761376969; Tue, 22 Sep 2020 00:56:16 -0700 (PDT)
Date:   Tue, 22 Sep 2020 15:56:11 +0800
Message-Id: <20200922155548.v3.1.I67a8b8cd4def8166970ca37109db46d731b62bb6@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3] Bluetooth: Check for encryption key size on connect
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When receiving connection, we only check whether the link has been
encrypted, but not the encryption key size of the link.

This patch adds check for encryption key size, and reject L2CAP
connection which size is below the specified threshold (default 7)
with security block.

Here is some btmon trace.
@ MGMT Event: New Link Key (0x0009) plen 26    {0x0001} [hci0] 5.847722
        Store hint: No (0x00)
        BR/EDR Address: 38:00:25:F7:F1:B0 (OUI 38-00-25)
        Key type: Unauthenticated Combination key from P-192 (0x04)
        Link key: 7bf2f68c81305d63a6b0ee2c5a7a34bc
        PIN length: 0
> HCI Event: Encryption Change (0x08) plen 4        #29 [hci0] 5.871537
        Status: Success (0x00)
        Handle: 256
        Encryption: Enabled with E0 (0x01)
< HCI Command: Read Encryp... (0x05|0x0008) plen 2  #30 [hci0] 5.871609
        Handle: 256
> HCI Event: Command Complete (0x0e) plen 7         #31 [hci0] 5.872524
      Read Encryption Key Size (0x05|0x0008) ncmd 1
        Status: Success (0x00)
        Handle: 256
        Key size: 3

////// WITHOUT PATCH //////
> ACL Data RX: Handle 256 flags 0x02 dlen 12        #42 [hci0] 5.895023
      L2CAP: Connection Request (0x02) ident 3 len 4
        PSM: 4097 (0x1001)
        Source CID: 64
< ACL Data TX: Handle 256 flags 0x00 dlen 16        #43 [hci0] 5.895213
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)

////// WITH PATCH //////
> ACL Data RX: Handle 256 flags 0x02 dlen 12        #42 [hci0] 4.887024
      L2CAP: Connection Request (0x02) ident 3 len 4
        PSM: 4097 (0x1001)
        Source CID: 64
< ACL Data TX: Handle 256 flags 0x00 dlen 16        #43 [hci0] 4.887127
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 0
        Source CID: 64
        Result: Connection refused - security block (0x0003)
        Status: No further information available (0x0000)

Signed-off-by: Archie Pusaka <apusaka@chromium.org>

---

Changes in v3:
* Move the check to hci_conn_check_link_mode()

Changes in v2:
* Add btmon trace to the commit message

 net/bluetooth/hci_conn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9832f8445d43..89085fac797c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1348,6 +1348,10 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 	    !test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 		return 0;
 
+	if (test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
+	    conn->enc_key_size < conn->hdev->min_enc_key_size)
+		return 0;
+
 	return 1;
 }
 
-- 
2.28.0.681.g6f77f65b4e-goog

