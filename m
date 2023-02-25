Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A5C64ED8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Feb 2023 00:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBYAVE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 19:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBYAVD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 19:21:03 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678797038F
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 16:20:55 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so926789pjz.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 16:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QS+t43GmTGiabhyga4ShoD477QWkItKNnqQI5YOqHXA=;
        b=oFcQtVuqVpbXtC3tOkcr1BT57OV1LA9tt83ItBcmWxRTzsATlSUlArOvcmPa1LHPrp
         6grqDuo+BQvgVySddfpKc9sISkYcdhXduu0lyoAIYDKomjgW6eB1KJ6kfaegQV87/hAQ
         nOBiAb5bYiQShpaNmNPXPXv490Ovgdpy93rHjUDStbexPqk6ipLfXP8kXHBfwLhe1w8c
         kE7Zgr0prFLZZRSOiGoxtKsh4uGVvecJwcXaSk9riMfi4V4nIW2JFiJKLcJIs9VYytrn
         xo8GWMIhYphZ5PdYeu3fhQxH1o3I4iqVMpqWNFq53wpjLnynW/rFjw0LApHvuP09fECb
         TNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QS+t43GmTGiabhyga4ShoD477QWkItKNnqQI5YOqHXA=;
        b=0aodUbEQRP+ZGFFhyjtPJqLjBY9h1ATSTesvsy/LflJzE5R57ktWKR1tcnl3qnZVYo
         PFlddJfzbtynQ3o0Z1sY3cc51f1sTuyH4dkjwhhQ1LKbL26vOHQRsnRJN4nx7hUK5YNB
         EHsthszBfoa/Dbvia7y3ic6TY0Smp+OdaVVHq4OK8CqmOAsP17IuPTpPMtJVfU6bCV9N
         NO6MFyL/E6qHh6NWqCPZdBItCgr/ndrF1+ufMZqNSLQ5frbPXD3gcSnoa1I9U2yWfj/V
         xN/tLspJqRT0APlSTCUAmZK7YlBusK9ainsXSgVKkft1sKlYrdVjfjZzgo9SFusrAIMj
         Z5Mg==
X-Gm-Message-State: AO0yUKXUifAnoqG6/LpEuGcQw9IcqEHPP/83NxrWWsoGYmZxNMqs+B4f
        Qm9ory5j5xKms1ygpVv5RCExVaau2tY=
X-Google-Smtp-Source: AK7set8YYHcWUWh0aITg/R7yAz+fDWmoPqJY4nJycAnzsWhpYpAjJUi8i3qr0G0qV2weUNv88P0Isw==
X-Received: by 2002:a17:902:d486:b0:19a:c009:8512 with SMTP id c6-20020a170902d48600b0019ac0098512mr1770180plg.6.1677284454195;
        Fri, 24 Feb 2023 16:20:54 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id ja17-20020a170902efd100b00196025a34b9sm75008plb.159.2023.02.24.16.20.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 16:20:53 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: hci_core: Make hci_conn_hash_add append to the list
Date:   Fri, 24 Feb 2023 16:20:50 -0800
Message-Id: <20230225002052.3866357-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes hci_conn_hash_add append to the tail of the conn_hash so it
matches the order they are created, this is required if the controller
attempts to match the order of ACL with CIS which uses append logic
when programming the CIS ids on the CIG.

The result of this change affects Create CIS:

From:

< HCI Command: LE Create Connected Isochronous Stream (0x08|0x0064) plen 9
        Number of CIS: 2
        CIS Handle: 2560
        ACL Handle: 3586
        CIS Handle: 2561
        ACL Handle: 3585

To:

< HCI Command: LE Create Connected Isochronous Stream (0x08|0x0064) plen 9
        Number of CIS: 2
        CIS Handle: 2560
        ACL Handle: 3585
        CIS Handle: 2561
        ACL Handle: 3586

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7254edfba4c9..9488671c1219 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -978,7 +978,7 @@ static inline bool hci_conn_sc_enabled(struct hci_conn *conn)
 static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
-	list_add_rcu(&c->list, &h->list);
+	list_add_tail_rcu(&c->list, &h->list);
 	switch (c->type) {
 	case ACL_LINK:
 		h->acl_num++;
-- 
2.37.3

