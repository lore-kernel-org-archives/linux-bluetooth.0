Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7FAC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Sep 2022 18:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiIMSXH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIMSWt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 14:22:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBA360E2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 10:39:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y17so24190346ejo.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ROR9HKc+i/EG3Ruo2ziztWgnKpNvTt2Fc72iYdNl99Y=;
        b=oUFMgAAumFxK6DUW8wAKwcAc54OmDcpJDpDFlV3mp9JHi6jqH6MX0/ZsflH4WlyUBM
         XbXMIzRihS6HyT23TPa23ATtXNn6XRqiIpt0Lvpecu+4BNO5AmOS4+0C1CPTpH4Aj4pz
         V9OiGhxlB2uSf/ZqsT5OyySQjIFsZXOcPgfiuq5Dyr1u88gcs7isWj1bvL1E/zVE9i2L
         za2MSF8vkm/K2KpDNe4cUBxuI53DgF89GkRT3NwJgCRwQjoAl3xs6etg1zp4jQoM9osq
         2iRmC+436qCM8VFvUtLK6GvCkkGtONA+uNOyJOFpceS14IM+a4gVgePk7Ag9vLqIP3HA
         KnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ROR9HKc+i/EG3Ruo2ziztWgnKpNvTt2Fc72iYdNl99Y=;
        b=59gEaGK08TZKQXhE5nG7TTrvllHKi9cGnkpgZPTrWlAJZPmujJdufywFgBKoIG0Skw
         p+ZMw+pNLrvB+QoP9jtcFuJnKMnLNq8copbLC7+UJnrkKAMJ0KRYVEZWKVkFYHGCihlF
         693pxMCqqPlDf5EQQGVb+th92j9ub+QcPGG05WmD+LOWTihynWI0gAZSFeDzfsEwKfCb
         Rv/sYRwl0Rgm9h4NFPmjNzP/rxZvcPEdiej7xqB1FXZQXUd1kHOmLoPr/aowr7gq0Prt
         QFE5f0/l5pmzaHj6hFw7sB4Edhkpm/dD0eBjonBjAI80YtGn2xRAyzPVXjG4EQhMYB7L
         iphA==
X-Gm-Message-State: ACgBeo3ljb49vJpAF8oB2rN3TYrRYLkv/4LSI46vpeIsZWyaHN9WYaNM
        0Ty/YOV2YGVovzvKFoSjtDWUvG8zERI=
X-Google-Smtp-Source: AA6agR5SgsH+gf+95txupGSVDOcuPRzTLcADLlIU1wfRy6BAUTrwYrjR96uAG9VHkGDfULL9pLxwzQ==
X-Received: by 2002:a17:907:9484:b0:73d:8c67:a945 with SMTP id dm4-20020a170907948400b0073d8c67a945mr22703047ejc.634.1663090757152;
        Tue, 13 Sep 2022 10:39:17 -0700 (PDT)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id j7-20020a170906278700b007324aa2ca77sm6348507ejc.85.2022.09.13.10.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 10:39:16 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH v2] Bluetooth: protect remote oob data in build_pairing_cmd's callsites
Date:   Tue, 13 Sep 2022 19:39:08 +0200
Message-Id: <20220913173907.13792-1-dossche.niels@gmail.com>
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
index 11f853d0500f..6611a789b6c1 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1803,7 +1803,9 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 		return 0;
 	}
 
+	hci_dev_lock(hdev);
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

