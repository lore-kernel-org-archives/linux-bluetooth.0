Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817E0C4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 21:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3276323B6B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 21:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgLIVgD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 16:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbgLIVgD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 16:36:03 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FFDC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Dec 2020 13:35:23 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w4so2114400pgg.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Dec 2020 13:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uDAWdOWWyKeGk4mWjM6HOfEfDXxHr/N17SbEvzpH/ZY=;
        b=Bfu3Q0nmcaPvORlVmD+gWHnnmpH5jHmeHwOgsnFXOf1xzmtm1jVwEo1kRsL9+1sjHU
         /xcIkdMODPADj1/oPGLRhAFdnmzi/bQnFUgcHQTWw6RaPe1akRSSChZSYBqFNSbOAb7X
         Kyqv8BQkH6kdZXol3X7QyXVJ4aWszggSFfgBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uDAWdOWWyKeGk4mWjM6HOfEfDXxHr/N17SbEvzpH/ZY=;
        b=ajArtLtNNMpN7fdHM8+0leXwaF37axinBUdR83FDeNfvXjnytgeT+LjiOnJIJAfLnq
         UfJjgFeG2NKOi5EMBIhmRYUYrfbaa6GWPkcV6e8gfIan7knLQzcZdFgvYXOH/obO4yto
         dsN68Om0O5Z8g+ElCUJor+/gmz9XbTlLBmPupZswz1HoWcBcSRFOo/4y8Ad4RhWhebfI
         NlRhdPXRtT/b6QPasZ1iOq975zu+zY5zQCu4xz2LUqdpy2hfbr9ZuUa38U0pGq/ztYE9
         PESWuQ4p9I1s+mZo+5ilhrUzWS27C+va6uHaZ568J2lgTXKZdmKPaluGF/41KQKdCi0z
         21YQ==
X-Gm-Message-State: AOAM5311IdjR6ZhkRj0befD1Kic/vouYvh1epNDiRHxj8FUjHQwghNFX
        0u8j3/2x0SP0ue+1rAF/A2nWYiIuODTgDQ==
X-Google-Smtp-Source: ABdhPJxqKYn8TJnWrlfdzPVS8iM+l5XsJnvWzU/AaAiQqOFxMWTTyiiYPbox40fEAy/LYumaphtD+Q==
X-Received: by 2002:a17:90b:1882:: with SMTP id mn2mr3998311pjb.236.1607549722542;
        Wed, 09 Dec 2020 13:35:22 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id y21sm3869639pfr.90.2020.12.09.13.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 13:35:21 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH v2] Bluetooth: Cancel Inquiry before Create Connection
Date:   Wed,  9 Dec 2020 13:35:14 -0800
Message-Id: <20201209213514.99326-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Many controllers do not allow HCI Create Connection while it is doing
Inquiry. This patch adds Inquiry Cancel before Create Connection in this
case to allow the controller to do Create Connection. User space will be
aware of this Inquiry cancellation and they may issue another discovery
request afterwards.

Sample Command Disallowed response of HCI Create Connection:
< HCI Command: Inquiry (0x01|0x0001) plen 5
        Access code: 0x9e8b33 (General Inquiry)
        Length: 10.24s (0x08)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4
      Inquiry (0x01|0x0001) ncmd 2
        Status: Success (0x00)
< HCI Command: Create Connection (0x01|0x0005) plen 13
        Address: XX:XX:XX:XX:XX:XX
        Packet type: 0xcc18
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11
        Status: Command Disallowed (0x0c)
        Handle: 65535
        Address: XX:XX:XX:XX:XX:XX
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>

---
 net/bluetooth/hci_conn.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4f1cd8063e720..23c0d77ea7370 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -203,6 +203,23 @@ static void hci_acl_create_connection(struct hci_conn *conn)
 
 	BT_DBG("hcon %p", conn);
 
+	/* Many controllers disallow HCI Create Connection while it is doing
+	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
+	 * Connection. This may cause the MGMT discovering state to become false
+	 * without user space's request but it is okay since the MGMT Discovery
+	 * APIs do not promise that discovery should be done forever. Instead,
+	 * the user space monitors the status of MGMT discovering and it may
+	 * request for discovery again when this flag becomes false.
+	 */
+	if (test_bit(HCI_INQUIRY, &hdev->flags)) {
+		/* Put this connection to "pending" state so that it will be
+		 * executed after the inquiry cancel command complete event.
+		 */
+		conn->state = BT_CONNECT2;
+		hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+		return;
+	}
+
 	conn->state = BT_CONNECT;
 	conn->out = true;
 	conn->role = HCI_ROLE_MASTER;
-- 
2.26.2

