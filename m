Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDAEC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Sep 2022 16:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiIMQ1c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiIMQ1R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 12:27:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179B3AC272
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 08:22:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y17so23276143ejo.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=xVJTuw3QuQuOeoFl+heMsboXqywN3ahaS8uuijHe0dI=;
        b=pP2N9Tx570/xZ5sQDB7YbgtO+zKmGpeeEEKojeDT+4EECmVsWLXPivOE5X9w9jJase
         /249QKoyQKiAJhm9Jo78mWINt8Jf/js61StwBFkqy/NBnOyYalz9rSx1p6ODnES7cwCI
         sFp6PeO1cPlsT40Kqm+lC3xv2Zkbmag0ooBfOlA7WqfbEGch40FSXDkbd3Lh4o+80V1b
         n68ffMXuI5uEIHYPzSY5c79kG1PkC5AmiJ+e2gcGC78E4sy0+lOxwR5GRGQt2BWef9dE
         umLrkOmSAPk011FWBOxDiTJTDAlxXYb1mok7nQnT6jB3vSK1x6NnE0m6X+Qx/Vs21/e/
         Q9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=xVJTuw3QuQuOeoFl+heMsboXqywN3ahaS8uuijHe0dI=;
        b=kmrit5shCKB3OCgGT25r5Pb/tN7RFX9EDRK672vxWehmnJSHkN1cQciwgjVMa2LUif
         SPCoUPK5f52xBDB485Tx6A+yquAjTeEoJnyPOHA+wHydppG5nU9NJ/z6OMQKdRUd6R8i
         Pbp7g1ZbDgsE/9QyPkNHbtOYCPDc0dh4P1QyQ7bVdflQtMOfV8aroG9FaL40fTjGjMuu
         f19f94olb6Ul5ujFuhlzlY6jEJfBhObjm8G5TSLCCfPF9E4ZTrk90kCyqdq7q/TWmWrM
         crANtUpPQsx1+KQUS0SIYaMjPP81yl7PXpI4VMcQpe6sWn7ORIcDz1YhgjWCyLfAP6y4
         GLPA==
X-Gm-Message-State: ACgBeo3ZAuF0zZ2wpGttAKfwmbnwWinYmkK8DxfPy6baC4RbY4W8BnC0
        C+VioSiQtaxukPd/KOUN8JKjwh+Xbsc=
X-Google-Smtp-Source: AA6agR51OoWkSbHfVU5A1jNL1SArCN82J+XBTz4LoMq8SGLuc6LaCbMk8nvClqcCcpP8PIuS31Terg==
X-Received: by 2002:a17:907:3dab:b0:741:9a23:eb01 with SMTP id he43-20020a1709073dab00b007419a23eb01mr23204556ejc.26.1663082422146;
        Tue, 13 Sep 2022 08:20:22 -0700 (PDT)
Received: from nlaptop.wireless.UGent.be (nata195.ugent.be. [157.193.240.195])
        by smtp.gmail.com with ESMTPSA id gc33-20020a1709072b2100b00731803d4d04sm6134933ejc.82.2022.09.13.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:20:21 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] Bluetooth: protect remote oob data in build_pairing_cmd's callsites
Date:   Tue, 13 Sep 2022 17:20:16 +0200
Message-Id: <20220913152016.38691-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Accesses to hci_dev->remote_oob_data are protected by the hdev lock,
except for the access in build_pairing_cmd via hci_find_remote_oob_data.
Adding the lock around the access in build_pairing_cmd would cause a
lock ordering problem: the l2cap_chan_lock is taken in the caller
smp_conn_security, while the hdev lock should be taken before the chan
lock.
The solution is to add the hdev lock to the callsites of
build_pairing_cmd.

Fixes: 02b05bd8b0a6 ("Bluetooth: Set SMP OOB flag if OOB data is available")
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---

Note:
I am currently working on a static analyser to detect missing locks
using type-based static analysis, which reported the missing lock on
v6.0-rc5. I manually verified the report by looking at the code,
so that I do not send wrong information or patches.
After concluding that this seems to be a true positive, I created
this patch. I have only managed to compile-test this patch on x86_64.
After applying the patch, my analyser no longer reports the potential
bug.

 net/bluetooth/smp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 11f853d0500f..3efa99fa5062 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1803,7 +1803,9 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 		return 0;
 	}
 
+	hci_dev_lock(dev);
 	build_pairing_cmd(conn, req, &rsp, auth);
+	hci_dev_unlock(hdev);
 
 	if (rsp.auth_req & SMP_AUTH_SC) {
 		set_bit(SMP_FLAG_SC, &smp->flags);
@@ -2335,7 +2337,9 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	skb_pull(skb, sizeof(*rp));
 
 	memset(&cp, 0, sizeof(cp));
+	hci_dev_lock(hdev);
 	build_pairing_cmd(conn, &cp, NULL, auth);
+	hci_dev_unlock(hdev);
 
 	smp->preq[0] = SMP_CMD_PAIRING_REQ;
 	memcpy(&smp->preq[1], &cp, sizeof(cp));
@@ -2380,6 +2384,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 		return 1;
 	}
 
+	hci_dev_lock(hcon->hdev);
 	l2cap_chan_lock(chan);
 
 	/* If SMP is already in progress ignore this request */
@@ -2435,6 +2440,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 
 unlock:
 	l2cap_chan_unlock(chan);
+	hci_dev_unlock(hcon->hdev);
 	return ret;
 }
 
-- 
2.37.3

