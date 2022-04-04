Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFE3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Apr 2022 00:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356108AbiDDAgl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 Apr 2022 20:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354020AbiDDAgk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 Apr 2022 20:36:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17597193C6
        for <linux-bluetooth@vger.kernel.org>; Sun,  3 Apr 2022 17:34:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k23so13267966ejd.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 Apr 2022 17:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMDg7eh35+cgK9V+wCbU7Bj5WyzMtSWA+Ve2bb7rcGo=;
        b=ijR/OXY90Hpv2aVO/T1AWe/deI7xFC7UOxsplMaZ7Te/c42R4rxBfTwOiMGknwyEtI
         9eEFrpyM9fcUVoE0ANAMCVNPMDtnBSUMYkBknPG68r+kWqVsALONkRmHuKsoWQ1/LNHD
         z8f7Xi2AKr+Z003FKTfR2PLj7oM6X7mXO/REMSyWsfyF9RGekAOE4juqFAiF9sEhF2nZ
         hfUlTIZF/iZUSqW77yVE+FH1j74jMYHTPbmuLekO0KQRoxjT7v6nLe3OUSG5mYmR1gAo
         HvqwbDA0Egv6ia+/keJ8445angP6GswuVT98nVReFPT1HWhmaoZ1lPhno8VZduLjXNU5
         c06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMDg7eh35+cgK9V+wCbU7Bj5WyzMtSWA+Ve2bb7rcGo=;
        b=WjU2rm7f81LNOvTf5Yv4UY5156Yv770HZZLq8BQGgosaA9Ef29yoLr5oLr77AH6KU2
         EK07TOp+Eb7PNUR2THmitAhQ/MePpLUiv2WtFtg0NxZqwdB9ndVncP9D9TELskgLz534
         fgij5T887rm1bcGmMcMHIS/PQTuvMXmchDTOBVAPNMiEHvy8syQGTxarxpI98uCYLIXS
         BTcFAFeyDDZqpCYH/hAlA7jZScowOpZRD08yk5jLni9SMGWAwO/jVDPJh8knTFEeBPgT
         Q7Llg4pZ+y2W1iba1f70c7YLKUonl4yUgfuCscVH0hyk/6MsDAynQE/bsjkt5HQdHC1b
         QmOQ==
X-Gm-Message-State: AOAM5306UNcJoXRcORWaOEa1li/oSCU7nsyqCZkzj83+jOFeKGq1PT2d
        SsPm5Ik4J2GN/4le3Mc7n8u2PBg428c=
X-Google-Smtp-Source: ABdhPJyu/OYtdowJivA+ebZxUW9WfM5hA3AyANakQhZP26Y31P9ageoeNzgQg+7++xUldc8ig6QRjw==
X-Received: by 2002:a17:906:7f02:b0:6cf:86d8:c31c with SMTP id d2-20020a1709067f0200b006cf86d8c31cmr9121960ejr.518.1649032483581;
        Sun, 03 Apr 2022 17:34:43 -0700 (PDT)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id qb10-20020a1709077e8a00b006dfedd50ce3sm3724531ejc.143.2022.04.03.17.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 17:34:43 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] Bluetooth: use hdev lock for accept_list and reject_list in conn req
Date:   Mon,  4 Apr 2022 02:34:04 +0200
Message-Id: <20220404003403.35690-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

All accesses (both read and modifications) to
hdev->{accept,reject}_list are protected by hdev lock,
except the ones in hci_conn_request_evt. This can cause a race condition
in the form of a list corruption.
The solution is to protect these lists in hci_conn_request_evt as well.

I was unable to find the exact commit that introduced the issue for the
reject list, I was only able to find it for the accept list.

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

Fixes: a55bd29d5227 ("Bluetooth: Add white list lookup for incoming connection requests")
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 net/bluetooth/hci_event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index abaabfae19cc..b9038f24f46f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3222,8 +3222,11 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 		return;
 	}
 
+	hci_dev_lock(hdev);
+
 	if (hci_bdaddr_list_lookup(&hdev->reject_list, &ev->bdaddr,
 				   BDADDR_BREDR)) {
+		hci_dev_unlock(hdev);
 		hci_reject_conn(hdev, &ev->bdaddr);
 		return;
 	}
@@ -3236,14 +3239,13 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 	    !hci_dev_test_flag(hdev, HCI_CONNECTABLE) &&
 	    !hci_bdaddr_list_lookup_with_flags(&hdev->accept_list, &ev->bdaddr,
 					       BDADDR_BREDR)) {
+		hci_dev_unlock(hdev);
 		hci_reject_conn(hdev, &ev->bdaddr);
 		return;
 	}
 
 	/* Connection accepted */
 
-	hci_dev_lock(hdev);
-
 	ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
 	if (ie)
 		memcpy(ie->data.dev_class, ev->dev_class, 3);
-- 
2.35.1

