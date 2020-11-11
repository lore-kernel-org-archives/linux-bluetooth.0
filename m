Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07724C4742C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 06:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B023E20795
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 06:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHZGjZAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgKKGch (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 01:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgKKGcg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 01:32:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE8DC0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 22:32:33 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v12so1381586ybi.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 22:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=l22P/UvfY4A1BIn9cXpcSgB6BknzP+YPhXI72uNPenc=;
        b=DHZGjZAaMsVUnO/mfnpAcDccAoAeDm1EZIlCJ0x9aqwZehcgdKEZglS8Vwzi9lpRey
         gf8aUk/h+Hz02UhKOeBA/bUy/XWPVIeYUocK0uy5waMxolvP1nm9y6KbY2Z3lZ0Ex8DC
         oC6yjC60x4avCB6z4FKvPdYJOwjtPyDftqqRQx6L5724ViNldz2aIgtN0rl7aJEyvfFN
         GTPbq7PitQ/u0tR7D8t6qdQzA6hb5jAU98YfQy8Bzphc64qQmosS/zhLMRy8EXUTxGZD
         JjE2q9YnjhlTMriRcxn8SmBlpW2/4bK8Do/zOfnnfmiTuTC8vOJbn3cgQzIf6kbhtOLi
         HmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=l22P/UvfY4A1BIn9cXpcSgB6BknzP+YPhXI72uNPenc=;
        b=QhqcawVjVaq7Y86pZj8IcG1Gk7IymEp06C3WZ6rSEeCz9SfcNVXR3Vyvo9teobpE2s
         nxsuP0FUMvmBtOb2/S+162/IlxDDxJiG4z+FhR/sbrxxEackmCrkZpOqQJM011IWmUK+
         1DV9LeqB6wVLy87GpB4TaJ4BIiRUlzDDcryyIP206T8Hr3jj126+YmLK+j37W8HmAbi2
         Hc7XbaB33YxdRrLZh9LBjW37bUgc2qtr6p4ZVyE8LCDk35zWJL9l5LFg5XSvO/LSEELM
         qude85sWlN+YKcte9OO3IWBj4XsWSicXlQZqICOB1s10rIYCeHYv/HB+GBFZFT8saZfk
         yJwA==
X-Gm-Message-State: AOAM5322n//FNLR8Q4KCT5toPDUDDXxmINh/sZKrh4WsARMd8nuY+mgf
        2JdNuenkvQYHW/GGwYVm95FwyzgZZEuvb3OFiv22pFNlC4RTt2kd6o0VQFUkX2ZK15Kuk8La0+t
        mXWL4AVFypm+vhf6jWgSk/rHLAIPrm1wyHHY37CyjQ7iAGigALbx/WF/EUCjRriYBnjm6fDVxdv
        KS
X-Google-Smtp-Source: ABdhPJwPhJArrjhEfiRnP1zUgcGVe3QSt/bkTpwLuTs0BM+ic72W5kM4JBUTqqNl2uek/nifOlskl8CoUX9s
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:6744:: with SMTP id
 b65mr29744843ybc.321.1605076353047; Tue, 10 Nov 2020 22:32:33 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:32:20 +0800
Message-Id: <20201111142947.v2.1.Id3160295d33d44a59fa3f2a444d74f40d132ea5c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2] Bluetooth: Enforce key size of 16 bytes on FIPS level
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to the spec Ver 5.2, Vol 3, Part C, Sec 5.2.2.8:
Device in security mode 4 level 4 shall enforce:
128-bit equivalent strength for link and encryption keys required
using FIPS approved algorithms (E0 not allowed, SAFER+ not allowed,
and P-192 not allowed; encryption key not shortened)

This patch rejects connection with key size below 16 for FIPS
level services.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>

---

Sorry for the long delay. This patch fell out of my radar.

Changes in v2:
* Add comment on enforcing 16 bytes key size

 net/bluetooth/l2cap_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1ab27b90ddcb..5817f5c2ec18 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1515,8 +1515,14 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon)
 	 * that have no key size requirements. Ensure that the link is
 	 * actually encrypted before enforcing a key size.
 	 */
+	int min_key_size = hcon->hdev->min_enc_key_size;
+
+	/* On FIPS security level, key size must be 16 bytes */
+	if (hcon->sec_level == BT_SECURITY_FIPS)
+		min_key_size = 16;
+
 	return (!test_bit(HCI_CONN_ENCRYPT, &hcon->flags) ||
-		hcon->enc_key_size >= hcon->hdev->min_enc_key_size);
+		hcon->enc_key_size >= min_key_size);
 }
 
 static void l2cap_do_start(struct l2cap_chan *chan)
-- 
2.29.2.299.gdc1121823c-goog

