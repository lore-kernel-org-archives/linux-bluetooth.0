Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0716AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 19:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F762078D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 19:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cxr1uYhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgHNTJQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHNTJP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 15:09:15 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC54C061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 12:09:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u20so5016648pfn.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPKm4oa2dN1Vf5/ovK5Iqwbq1EaqjYUe9CdiX1HO9dI=;
        b=cxr1uYhkmPFKReP0IqFfPTtHZbZEpvhzHU+z/er4B/I/bSmzdLha1Td+kiyGooZC6q
         EkJX55wRwyRMIvyOC+DgGtgVqZ70BDD69OvHTGX2npQlkn+T0BGUZD1cPoUd++31gN/q
         l/IDLVXuDEQsg9VN4PxqQ/56fCpN+AWGBBQ+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPKm4oa2dN1Vf5/ovK5Iqwbq1EaqjYUe9CdiX1HO9dI=;
        b=H9dWHgJ6KUGo+F5gyEFYcn7ed3lN7AJjTsUZMLhiewCleu2vHpLhqoTQTlHuCLZgF0
         TYplXwIvy2+HAU4W0hI2JrT8gntJOXY0k9PWdNV3VU587gBfb1uQQqi/eO/D4urmn67U
         sKdIQERzXUKpy0+k65YDct8Wh8gJxXUKxkv4ii+pq7ZjrKQsfFTKTZL6wVWYyTOxqaJj
         abp2D7jP7dup9yxia1gcIrYzs7QcyKMIIQHCCR35HvZdWanOpm2/XgRH8TFu7mFo2DPe
         sZ6uh4RAerMn7oJYPVbE9ee6/ubzrbe8B7cSGaMD1n1uhwrAmSgkJKSDoiRVYTMZVlnD
         Ib8w==
X-Gm-Message-State: AOAM530UM6mhEig4EPfPGf66AGxsHoJcf9FPjPgwt0HOFV4SxvRjPblS
        y4R65wlAkYaR8PsqNxYxSmgzJIw4eSJIDA==
X-Google-Smtp-Source: ABdhPJwAx4bCFH/vqzup+Sj+BRBqFZHnwKEeyz5teB1/b5fUS7SSusWqHlqAsbCp3d38f6r1HleOfw==
X-Received: by 2002:a62:ea01:: with SMTP id t1mr2789546pfh.125.1597432154796;
        Fri, 14 Aug 2020 12:09:14 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id f17sm10223112pfq.67.2020.08.14.12.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2020 12:09:14 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH v2] Bluetooth: Fix auto-creation of hci_conn at Conn Complete event
Date:   Fri, 14 Aug 2020 12:09:09 -0700
Message-Id: <20200814190909.361764-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently the code auto-creates hci_conn only if the remote address has
been discovered before. This may not be the case. For example, the
remote device may trigger connection after reboot at already-paired
state so there is no inquiry result found, but it is still correct to
create the hci_conn when Connection Complete event is received.

A better guard is to check against bredr allowlist. Devices in the
allowlist have been given permission to auto-connect.

Fixes: 4f40afc6c764 ("Bluetooth: Handle BR/EDR devices during suspend")
Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

---
 net/bluetooth/hci_event.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 33d8458fdd4a..6b83da1790ee 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2566,7 +2566,6 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_conn_complete *ev = (void *) skb->data;
-	struct inquiry_entry *ie;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
@@ -2575,13 +2574,19 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
 	if (!conn) {
-		/* Connection may not exist if auto-connected. Check the inquiry
-		 * cache to see if we've already discovered this bdaddr before.
-		 * If found and link is an ACL type, create a connection class
+		/* Connection may not exist if auto-connected. Check the bredr
+		 * allowlist to see if this device is allowed to auto connect.
+		 * If link is an ACL type, create a connection class
 		 * automatically.
+		 *
+		 * Auto-connect will only occur if the event filter is
+		 * programmed with a given address. Right now, event filter is
+		 * only used during suspend.
 		 */
-		ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
-		if (ie && ev->link_type == ACL_LINK) {
+		if (ev->link_type == ACL_LINK &&
+		    hci_bdaddr_list_lookup_with_flags(&hdev->whitelist,
+						      &ev->bdaddr,
+						      BDADDR_BREDR)) {
 			conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr,
 					    HCI_ROLE_SLAVE);
 			if (!conn) {
-- 
2.26.2

