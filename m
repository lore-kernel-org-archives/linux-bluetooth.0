Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCD1C00140
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 08:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiHJIrq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 04:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiHJIrp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 04:47:45 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCB26C745
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 01:47:44 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id a17-20020a17090abe1100b001f320df2e97so886955pjs.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=IkO2qbmRcFc6UxfvSrEn8JNuo3OleMYGP7m+9m5YUGE=;
        b=GRzr0X8Bvqmio2LDXmGRaknTkzJlz6XYPdUWa3HK+1BbpqjUTnoRv59n9Z8kmIe9eE
         k4B7qwLn6g9b335FI1FmJ+y5nY4jWh0smsFLZmnN85oQd6c0NHziYC2zSVFvisEPcwo9
         hJcKKfKbZk3azdWtI/Hc0FD/u9yIpTUj+6D+8g5WRalUtXpjHa2VYFY1MPlk/a0cX9Pd
         /vB1Q/24aJIeFqn2hDcPipxpph02wVS892JseyWiRtsZO5s/TonCf7vXFjTgKKzyL/VR
         +QqmiB/lJIziPqkT8mV9YpGNDQs4hNggQ10nYi0NdPevOA405NCFybuUCGZhDnH2DiNi
         O7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=IkO2qbmRcFc6UxfvSrEn8JNuo3OleMYGP7m+9m5YUGE=;
        b=Kty9+AEyfGnxW/N5qwZJWqLsan679tTjBEGsTbtbWwnWeryiqUQX9PTUxnWq1GhHc1
         3jcGjRW5PwSgiwQ9KjjKA8VP3sojBUZvmG5Y3jKbMLOvpt4yyT6ItWSj9p0d+8cNYfwR
         IEmOMiETgmc7ZCYEmd4KbpBEjjE7AGwTr7RL+oQfWo+/GfLZdNbkz7ZgBNSSfyG1uAHH
         18dI1JaIRc96gcU0x9Q8T00sIpG4y+B/WNr1O4UXHEiHgCr8YdiNpamaP1osREQlsvLP
         D6/CmN1BRWowD5QpWLYpYWgIfst03yAjNiCYPvbj7AiBmovGeE1ftGKUkj79yHXqluor
         JcpA==
X-Gm-Message-State: ACgBeo16emjUwHjbBtfq8LZAgZNiVxfohzqEMPVT7mbdJV+JecJkgI/m
        PbNBe8lxV9ue3k603AtwvzVfBYUQHfzFd6kYBF5Q+VD3k79IJNcIBJc6q+v7owTc94ZlwWnrsHT
        aZQch/yTr4Gxsm5PwE9sXD20WprJnJ9EICu4y2qEg837XWb1dcS/fVa3Hb4S6x8djwnYkb202+v
        A+
X-Google-Smtp-Source: AA6agR5HfTknbxKKBNTihyGsEeT4IzJR7ci36ymQ75F6+56l8RT3V41NgytngbB2802N/PnwLcTHdOtXFTJP
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:babf:73ba:88f:89e])
 (user=apusaka job=sendgmr) by 2002:a62:38d8:0:b0:52d:1496:6775 with SMTP id
 f207-20020a6238d8000000b0052d14966775mr26377140pfa.15.1660121263438; Wed, 10
 Aug 2022 01:47:43 -0700 (PDT)
Date:   Wed, 10 Aug 2022 16:47:36 +0800
Message-Id: <20220810164627.1.Id730b98f188a504d9835b96ddcbc83d49a70bb36@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] Bluetooth: Honor name resolve evt regardless of discov state
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Ying Hsu <yinghsu@chromium.org>,
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

Currently, we don't update the name resolving cache when receiving
a name resolve event if the discovery phase is not in the resolving
stage.

However, if the user connect to a device while we are still resolving
remote name for another device, discovery will be stopped, and because
we are no longer in the discovery resolving phase, the corresponding
remote name event will be ignored, and thus the device being resolved
will stuck in NAME_PENDING state.

If discovery is then restarted and then stopped, this will cause us to
try cancelling the name resolve of the same device again, which is
incorrect and might upset the controller.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Ying Hsu <yinghsu@chromium.org>

---
The following steps are performed:
    (1) Prepare 2 classic peer devices that needs RNR. Put device A
        closer to DUT and device B (much) farther from DUT.
    (2) Remove all cache and previous connection from DUT
    (3) Put both peers into pairing mode, then start scanning on DUT
    (4) After ~8 sec, turn off peer B.
    *This is done so DUT can discover peer B (discovery time is 10s),
    but it hasn't started RNR. Peer is turned off to buy us the max
    time in the RNR phase (5s).
    (5) Immediately as device A is shown on UI, click to connect.
    *We thus know that the DUT is in the RNR phase and trying to
    resolve the name of peer B when we initiate connection to peer A.
    (6) Forget peer A.
    (7) Restart scan and stop scan.
    *Before the CL, stop scan is broken because we will try to cancel
    a nonexistent RNR
    (8) Restart scan again. Observe DUT can scan normally.


 net/bluetooth/hci_event.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 395c6479456f..95e145e278c9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2453,6 +2453,16 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
 		mgmt_device_connected(hdev, conn, name, name_len);
 
+	e = hci_inquiry_cache_lookup_resolve(hdev, bdaddr, NAME_PENDING);
+
+	if (e) {
+		list_del(&e->list);
+
+		e->name_state = name ? NAME_KNOWN : NAME_NOT_KNOWN;
+		mgmt_remote_name(hdev, bdaddr, ACL_LINK, 0x00, e->data.rssi,
+				 name, name_len);
+	}
+
 	if (discov->state == DISCOVERY_STOPPED)
 		return;
 
@@ -2462,7 +2472,6 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 	if (discov->state != DISCOVERY_RESOLVING)
 		return;
 
-	e = hci_inquiry_cache_lookup_resolve(hdev, bdaddr, NAME_PENDING);
 	/* If the device was not found in a list of found devices names of which
 	 * are pending. there is no need to continue resolving a next name as it
 	 * will be done upon receiving another Remote Name Request Complete
@@ -2470,12 +2479,6 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 	if (!e)
 		return;
 
-	list_del(&e->list);
-
-	e->name_state = name ? NAME_KNOWN : NAME_NOT_KNOWN;
-	mgmt_remote_name(hdev, bdaddr, ACL_LINK, 0x00, e->data.rssi,
-			 name, name_len);
-
 	if (hci_resolve_next_name(hdev))
 		return;
 
-- 
2.37.1.595.g718a3a8f04-goog

