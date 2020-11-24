Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013A6C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 01:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FD520729
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 01:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JFVz8HXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgKXBJM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 20:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgKXBJL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 20:09:11 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813B6C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 17:09:10 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id v12so16725423pfm.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 17:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jFsNwOfiI97+tBvNF8sHCE8VoDlrkyHqf0lduU6KQ0Q=;
        b=JFVz8HXePkRCBYz8rHTCcS3o++kPQKD3fJQYZWTJiGExPbMSJypHVWG6Ry995U+Ar7
         Jg6h/CFs1GFVv76uKo+snfpfdR+2WYrhaFuNKhO94CP8P8A6DPgT/bmH4ffTM5C6Hof4
         ANyP9MNP3NnmV+QCaPoDX2SDXUFmEsfs+WBQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jFsNwOfiI97+tBvNF8sHCE8VoDlrkyHqf0lduU6KQ0Q=;
        b=EF2qyhXwoz2veulBiX1gxig5MJI6mdbEsMKF6KyJTx9ILvCg4xr1HLughER9ZWtJIe
         fJ0U9kndU+zAkWXD79dgJ24P+l5isEDJqYI85jvxT3jPZx6RQbT1LcQ3tZ9KD6sbmJk/
         SnJbv8ypvqL2oBTDidlDQxMrfzkzUI2rQcLj4c+qWsY2w/qE8/cyfLp8eOHzbqZdL+AK
         otSyEVVXHMcBVT5+8mv9vRi4KFo3DoEhnByFISB9sxBo4z6mf7hFgI53bm7nlqKGufPn
         692mcioNWOfvyuaX2KZbSrsvSfKCt72rO4VVeKOfKzaAbB60xzOk7WULimmhuh/d5wth
         RexA==
X-Gm-Message-State: AOAM530Us4GnPJdXOS1i4R4OSd+y3ip8GKEHso4D8rS8A+MVSZQGwLg+
        1aCjgsbXQ8SfFonQoLRtXWzTOfeMUE72NQ==
X-Google-Smtp-Source: ABdhPJxgWA6430uU28+5SGh7V/l9UKP+pQjkcsrf3/iiTsHZGRwz1CoS4hS/s8nPGuL3E9zdIJNFxQ==
X-Received: by 2002:a17:90a:d491:: with SMTP id s17mr1988010pju.2.1606180149817;
        Mon, 23 Nov 2020 17:09:09 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id w15sm589214pjy.47.2020.11.23.17.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 17:09:09 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH] Bluetooth: Cancel Inquiry before Create Connection
Date:   Mon, 23 Nov 2020 17:09:06 -0800
Message-Id: <20201124010906.340433-1-sonnysasaka@chromium.org>
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
Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>

---
 net/bluetooth/hci_conn.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4f1cd8063e720..b41ad08f8d411 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -233,6 +233,17 @@ static void hci_acl_create_connection(struct hci_conn *conn)
 	else
 		cp.role_switch = 0x00;
 
+	/* Many controllers disallow HCI Create Connection while it is doing
+	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
+	 * Connection. This may cause the MGMT discovering state to become false
+	 * without user space's request but it is okay since the MGMT Discovery
+	 * APIs do not promise that discovery should be done forever. Instead,
+	 * the user space monitors the status of MGMT discovering and it may
+	 * request for discovery again when this flag becomes false.
+	 */
+	if (test_bit(HCI_INQUIRY, &hdev->flags))
+		hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
+
 	hci_send_cmd(hdev, HCI_OP_CREATE_CONN, sizeof(cp), &cp);
 }
 
-- 
2.26.2

