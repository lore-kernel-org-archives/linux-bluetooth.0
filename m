Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8195C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 19:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E50620768
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 19:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="In8sZKHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHNTEP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgHNTEO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 15:04:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23718C061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 12:04:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i92so5967847pje.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sym/AmXhI2hFDD6PNhYTvYIW04BDHmyuqhnUhFDB198=;
        b=In8sZKHdSEbhLPcwRUfe7iXD7g6GuOB752EKkJMSV9iP16ltG3sgfA9O+Yaof7JYU0
         yIsj305aKFhCEDRAxvT62nvMk3XlW7dr13kW4pGUOmCWjUs1JoeEDpbefG5xA4XNpmlF
         97ez5sKMlF9hA/7UR2rKBmR+zGpcmRmkXBiz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sym/AmXhI2hFDD6PNhYTvYIW04BDHmyuqhnUhFDB198=;
        b=Bzj9Yp6s7EzhKR2tahTb9MOv7++18UlcQQxj8TaT4PO+opwhmGvyfhqxTND6at3g7y
         t5TvNYVgQ5xhojqZXy/kzRXTytBE0oLceXDUk0slEwYsTAOnTPP/lv2L5TRFuSut+WEL
         vfrLYi7ZrhQXB6aCdwNWnGXtMmwzNeOgJYbftIcQb9xRCzE+AFnD63XZv9XlDtI23o4c
         XZ1fWvvYoo69cevjWNJHWse8eXHt0T1QWuS43pIdoWzZ+Hh4zsT0TZDn7UIY+tGkk/yj
         ay/d8Gqprm4BjJXPE7ZjyRJwSkiafnoxg7reS2XjZpVgNHelPUdFjFwktufRHDtBkxxU
         mioQ==
X-Gm-Message-State: AOAM531LRqF2EQojYkBC/i3lHFwOqWBmpc7uqQYpJDTnKu6RXUdPYlO8
        /gXgtbes47GOSvHoOuPjQ4tG9FJa4RKggw==
X-Google-Smtp-Source: ABdhPJwMK/6lUhSpFQ4BPd/LzqydFyN1Vx3qtTOaHsE0hZwfzmqu7dffcBqXlPfC/RZcHSUr/Azigw==
X-Received: by 2002:a17:90a:216a:: with SMTP id a97mr3353255pje.144.1597431853192;
        Fri, 14 Aug 2020 12:04:13 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id z2sm10125840pfq.46.2020.08.14.12.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2020 12:04:12 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH] Bluetooth: Fix auto-creation of hci_conn at Conn Complete event
Date:   Fri, 14 Aug 2020 12:04:06 -0700
Message-Id: <20200814190406.361415-1-sonnysasaka@chromium.org>
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

