Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80993C43219
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 00:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359011AbiDFAlf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572983AbiDERkJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Apr 2022 13:40:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B67B8202
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Apr 2022 10:38:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bg10so28264567ejb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Apr 2022 10:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWDLuBMv69l7smkyAs5PVU2OS4u5uUsp7PBl7TVy2v4=;
        b=qON21d56MpM/bjOhhzQEfHJKs0ihdNmcrFgvwIuNLigXVdqEzo6ZoR0Ld23t3chaHH
         XlSq03hl7sOg//P/2hzVg6g6Of/vUeYj7GIQeJ73+YSCg5uSJkPzO1L6tlqWUa7fl74B
         z2QQNvA/+glkjWOXigxdvR+/hwIh5a/L/wokwf0eAlTRxC0NdoDcopb1Hr8iQYCHOtXW
         fFsWaZ4uWAKiq49hQqPn6eao6ceK5wHm8ElJydIe2dfPZN/jIHNi44cHj0YDf9DryL2e
         kqfnEOfKc1Xtfrol0XyxDMHhjWAesoKCe3uUDsp3IEkCtkGN7VH0YyBES76V4OwskLjo
         JeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWDLuBMv69l7smkyAs5PVU2OS4u5uUsp7PBl7TVy2v4=;
        b=fqpAJ5kHfOGckZ5ibvhfoMPBYM/Qv4GAomZVStLxeir/Pke9QbNutcu2++1RyzZnO3
         D0qedbK3IA1J46XRMd9QIQosX/vQoSTS8yh9AthKzPbskpqsVTXMLzUJiJeIcYSAJr8G
         E24ZEt/3td6ZyPt0Wuhqb3FAFG3yvpxh9AgHfttK9Bl56woxSMlxOTBiAoTa49efpjor
         +lqnUmRf99evgj1LYdcFIB5KjToHWkKy1G3nUcnAbAmmukwSX3AVw8y8lXtFeHjKKHjX
         HjPR4n3xWav3gBv8BW2eXHpRddMjxzax0AbIqCfs1Tvseg0120bIuL4YX4ws1C1/rJoC
         5flQ==
X-Gm-Message-State: AOAM531RX/se+Sl8FtxG5Y36qYvRuVNUZfPcWgkSYtmIXWVsjaKQdaYW
        Qrf7cb1BJ0ORCC1PkmbArCfj3ZDcVzQ=
X-Google-Smtp-Source: ABdhPJytWCmUYmgqtfD8xurBG/b7Q+SjIj1NkMNeWw1/+VO7Q2N0dqb7Sg0L3ZPl9/ogsh1GZmXASw==
X-Received: by 2002:a17:906:730c:b0:6e6:c512:49c8 with SMTP id di12-20020a170906730c00b006e6c51249c8mr4686781ejc.405.1649180288841;
        Tue, 05 Apr 2022 10:38:08 -0700 (PDT)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id x3-20020a50d9c3000000b0041c8ce4bcd7sm5646330edj.63.2022.04.05.10.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 10:38:08 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH v2] Bluetooth: use hdev lock for accept_list and reject_list in conn req
Date:   Tue,  5 Apr 2022 19:37:52 +0200
Message-Id: <20220405173751.7269-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

All accesses (both reads and modifications) to
hdev->{accept,reject}_list are protected by hdev lock,
except the ones in hci_conn_request_evt. This can cause a race
condition in the form of a list corruption.
The solution is to protect these lists in hci_conn_request_evt as well.

I was unable to find the exact commit that introduced the issue for the
reject list, I was only able to find it for the accept list.

Fixes: a55bd29d5227 ("Bluetooth: Add white list lookup for incoming connection requests")
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---

Changes in v2:
 - edited commit message to exclude note
 - used an exit goto label instead

Note:
I am currently working on a static analyser to detect missing locks
using type-based static analysis as my master's thesis
in order to obtain my master's degree.
If you would like to have more details, please let me know.
This was a reported case. I manually verified the report by looking
at the code, so that I do not send wrong information or patches.
After concluding that this seems to be a true positive, I created
this patch. I have both compile-tested this patch and runtime-tested
this patch on x86_64. The effect on a running system could be a
potential race condition in exceptional cases.
This issue was found on Linux v5.17.1.

 net/bluetooth/hci_event.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index abaabfae19cc..02a77f676da4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3222,10 +3222,12 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 		return;
 	}
 
+	hci_dev_lock(hdev);
+
 	if (hci_bdaddr_list_lookup(&hdev->reject_list, &ev->bdaddr,
 				   BDADDR_BREDR)) {
 		hci_reject_conn(hdev, &ev->bdaddr);
-		return;
+		goto unlock;
 	}
 
 	/* Require HCI_CONNECTABLE or an accept list entry to accept the
@@ -3237,13 +3239,11 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	    !hci_bdaddr_list_lookup_with_flags(&hdev->accept_list, &ev->bdaddr,
 					       BDADDR_BREDR)) {
 		hci_reject_conn(hdev, &ev->bdaddr);
-		return;
+		goto unlock;
 	}
 
 	/* Connection accepted */
 
-	hci_dev_lock(hdev);
-
 	ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
 	if (ie)
 		memcpy(ie->data.dev_class, ev->dev_class, 3);
@@ -3255,8 +3255,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 				    HCI_ROLE_SLAVE);
 		if (!conn) {
 			bt_dev_err(hdev, "no memory for new connection");
-			hci_dev_unlock(hdev);
-			return;
+			goto unlock;
 		}
 	}
 
@@ -3296,6 +3295,10 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 		conn->state = BT_CONNECT2;
 		hci_connect_cfm(conn, 0);
 	}
+
+	return;
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static u8 hci_to_mgmt_reason(u8 err)
-- 
2.35.1

