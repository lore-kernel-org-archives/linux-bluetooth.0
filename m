Return-Path: <SRS0=BuFd=5C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043D5C10F29
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 05:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0A320663
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 05:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYz7uO05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgCQFkh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Mar 2020 01:40:37 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:36827 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgCQFkf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Mar 2020 01:40:35 -0400
Received: by mail-ua1-f73.google.com with SMTP id m10so2175688uap.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2020 22:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=el82hvu8NsarLBH+1bSM5mOhPUGbPGRaUwoQglxhFZs=;
        b=PYz7uO05mG25NfUmMbpjZKCOZbxuF3u1CeNkjJDeW4SMOhqxfZ8/yJnrMmXdi5VeV9
         jLeEmHj7qIs4osoWmBuCse20pEigoQMUyodNp4LVCkIFfxAmuJGBmppBctcZwXwFJswS
         OvZOFL6C0u/qSaIFvukwFUyXBft83T5SZ5hENFMj2ZDSiVK95DInCXLMfOWVnKSZx5El
         8gf+eV+iBgYPGi0qZWqUk+HDBB8rxlPmuysjBNfDUEerKhf6EvCQqedBOafPX0dlv4lP
         IcCYZvNxs09Abb1wNrlU1kT9ge6uVBZGxxeopIZQYjEiRQECmydKvBsibIEdfkGryNnY
         mPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=el82hvu8NsarLBH+1bSM5mOhPUGbPGRaUwoQglxhFZs=;
        b=kz9XCF0kOSdNWARrAfeN227HgoCkjjOPY96/5ckv1PlheJGUasQpXUinVgF6Ut348g
         yaXMbMEUBcXjzKvK89cWbfMlJw3DvjRP3cF3Wil77fDWfpSwCShSoAKTJRANPoXdnTuS
         OvaX1l2SXejpnky8KFi4KBpiU/PAaZeRnrDemSeUQfKDAc54RBAbYT6M4wC0wx/10VFF
         YvPL8Pasy5BsP6ic6MQE6tTyUjzVfaTj36JpYVhkRoqyVAAxOdCtBMRIKz3jQQjoJqSi
         oPuit7bz3mjoOLI1F4avkmmt9HIhWPQGQPv5u+Jlt+UTgLNw6vXQLvSn5C2T0xD+uy66
         lOuA==
X-Gm-Message-State: ANhLgQ0cEUw1gbXVYp2+OdwNDdeqPxVI/iWAbjPDOnT1ja/6BP962tad
        /wwvPeBetP+0oVPCfZ7qygAnBJGgxddiQQ==
X-Google-Smtp-Source: ADFU+vvobSt7t9RrwR/m04uzP8LCbT1bE28OruemFxbEsN4zMun2S8b74DOmhSvpXfrTSMb4P36QDEyPRn8AGw==
X-Received: by 2002:ab0:614c:: with SMTP id w12mr2373505uan.141.1584423632602;
 Mon, 16 Mar 2020 22:40:32 -0700 (PDT)
Date:   Mon, 16 Mar 2020 22:40:27 -0700
Message-Id: <20200316224023.1.I002569822232363cfbb5af1f33a293ea390c24c7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] Bluetooth: Do not cancel advertising when starting a scan
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org
Cc:     Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        linux-bluetooth@vger.kernel.org,
        Dmitry Grinberg <dmitrygr@google.com>,
        Manish Mandlik <mmandlik@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Dmitry Grinberg <dmitrygr@google.com>

BlueZ cancels adv when starting a scan, but does not cancel a scan when
starting to adv. Neither is required, so this brings both to a
consistent state (of not affecting each other). Some very rare (I've
never seen one) BT 4.0 chips will fail to do both at once. Even this is
ok since the command that will fail will be the second one, and thus the
common sense logic of first-come-first-served is preserved for BLE
requests.

Signed-off-by: Dmitry Grinberg <dmitrygr@google.com>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 net/bluetooth/hci_request.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index bf83179ab9d19..649e1e5ed446a 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2727,23 +2727,6 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 
 	BT_DBG("%s", hdev->name);
 
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
-		hci_dev_lock(hdev);
-
-		/* Don't let discovery abort an outgoing connection attempt
-		 * that's using directed advertising.
-		 */
-		if (hci_lookup_le_connect(hdev)) {
-			hci_dev_unlock(hdev);
-			return -EBUSY;
-		}
-
-		cancel_adv_timeout(hdev);
-		hci_dev_unlock(hdev);
-
-		__hci_req_disable_advertising(req);
-	}
-
 	/* If controller is scanning, it means the background scanning is
 	 * running. Thus, we should temporarily stop it in order to set the
 	 * discovery scanning parameters.
-- 
2.25.1.481.gfbce0eb801-goog

