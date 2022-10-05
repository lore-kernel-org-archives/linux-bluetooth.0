Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0ABC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Oct 2022 07:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJEHKC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Oct 2022 03:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJEHJ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Oct 2022 03:09:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC11BCE2D
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 00:09:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h4-20020a5b02c4000000b006bc192d672bso15485067ybp.22
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Oct 2022 00:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=0kv7LZbwVvvTCY0FDOB7BWqbGQ4uCTTTGBzanUoZ/5c=;
        b=FxjCN8MEoO/P7TtrDCci6qecuNe+mYvoZwwIqXh+ZFVTP9pYumPENqeRRVX1V57FGt
         VmIhuBShQ85+xuhfo0OJnvaY6jh6xm1uotVlGCTndMdcs7UCmW1WAr0h4F70uMgWMuHH
         k3Nk+0Q+JLMBV1jELcfeZ78+i74EuDU/xV6DFKsThsGjRsnecnMWhQS44hlzs+JMVg8x
         9C6f7nQYTmLbYrhnzMUnkSV/gp2YYiGbRQULv4uG6DMgfHXzMUFsn/AVzv7c/JJdPDPv
         L818cWJ9KOkXTuoXzFyaVhbpFcknI8CnlKiAI7vw+KTQPs6JtDBYUwqXOMHPg2V1MIwK
         mMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=0kv7LZbwVvvTCY0FDOB7BWqbGQ4uCTTTGBzanUoZ/5c=;
        b=d2bXhtRvrRMNZG97WmiUPMG56aC8cVjhRSFjp236gTVoLczIaUuIVAAHHdlD0v+Het
         5q205UuGAWk7NY5gBFkJ1Q2LCjha7l/4ynt7G1bPeSiK9SBWr7nr69fpVDaCcMyjncLo
         aVHf74ktRuxah11WpsPmsu+QjnoHONJzqm3IF0tIDiQorHhAHDAQF2H5ffCXiZu5S92a
         8HXmp6o1BRftfPfmhmR+W+gZX7E76j+aHxsQXMwLQ6tI5z0+cJTqro/9L41w+eyegsOK
         L7Ht5yNqD698vU6qzWVPN8Azp9iQ5aP+dTeZakf0+09S57uSLo7Hbb7ngL6lOOYVwlx4
         3dlg==
X-Gm-Message-State: ACrzQf0KqNNSzefHb6oMWTrC+K5L9m7MOO5cSh1q2kqEha96Ro2FfObh
        LRzeQFhCdyPWxok+oHhWfVfw1GRp2uAJCssILBv13p85D6OqAWb3Gdm/ioyRq/iOuVX9NqFU6cv
        5CsAn4OxzWdmkxADZGmWVISEsB1LNUo4qMT87PuHopAjob7yoL12NgxgV/u8hVdmD2Aa+HG2pBP
        rW
X-Google-Smtp-Source: AMsMyM5G6SbVAJC0wRlFyL/5sIT96s+VNQjdmgANHz/PRa0/bVmVUatteDEjIeuOfCNl1UZWWA+w/88KYR5e
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:499:ff69:2084:388d])
 (user=apusaka job=sendgmr) by 2002:a05:6902:1083:b0:6b1:4a11:9cf5 with SMTP
 id v3-20020a056902108300b006b14a119cf5mr29727673ybu.537.1664953794404; Wed,
 05 Oct 2022 00:09:54 -0700 (PDT)
Date:   Wed,  5 Oct 2022 15:09:47 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221005150934.1.Ife932473db2eec6f0bc54226c3328e5fa8c5f97b@changeid>
Subject: [PATCH] Bluetooth: hci_sync: cancel cmd_timer if hci_open failed
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

If a command is already sent, we take care of freeing it, but we
also need to cancel the timeout as well.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>

---

 net/bluetooth/hci_sync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 76c3107c9f91..a011065220e4 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4696,6 +4696,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 			hdev->flush(hdev);
 
 		if (hdev->sent_cmd) {
+			cancel_delayed_work_sync(&hdev->cmd_timer);
 			kfree_skb(hdev->sent_cmd);
 			hdev->sent_cmd = NULL;
 		}
-- 
2.38.0.rc1.362.ged0d419d3c-goog

