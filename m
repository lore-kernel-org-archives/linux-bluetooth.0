Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B87CC433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 09:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E765D239EE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 09:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbhAVIkA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jan 2021 03:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbhAVIio (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jan 2021 03:38:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901D7C061220
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 00:36:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c9so4789354ybs.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 00:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GoHtCD9i/HlVEXFt8+h29d4MxhFf0tqQCKDbQQUvONI=;
        b=KscSHaebmBoTdf9LwsLcKwhJu7p25PKadVGRGPcdgMhNa9uYGj7f/lLucOa+aWC3fl
         vY/l29jJ2pyHn+IKkRioQHrLpmAt6Ea7xkTDEZK9Clys1KSCa3zmr7Z46lY5JOzQjS0W
         G+hy/sOMiPKuu2orYQ/nD43LyI6ISciPMmbT480i/NB5wDM4TmHir8yzP2G1CByCZuW4
         xrBKBGDtiX9OG8Q2DXXXbXInZh3ASShQXvuzGAZb0xsU1SCnhxn3I7/P5vfpdjINWoMx
         l7kK4DflvVo+jHoRNcw4vtUx6veHPPqt4QKZ2CyxDLIXtwD3DPIaa0FuMBh5YX+EZLVb
         zUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GoHtCD9i/HlVEXFt8+h29d4MxhFf0tqQCKDbQQUvONI=;
        b=X4GXFGCkZd5I75PTfdgwKyKZjSLK9E+rtl/S+C/27djS8Xu8CK5rFx0BIsKcEFrJFH
         poojC8KRKmXYeHznwxCaJM+3/nLLNT++nNyImTo7IiEviFXq/ayM9fzmINsDdL/vPSZL
         AsrYvUL2+8a3bqEaQTWrq6Dni+lMJ7v49tCowbwqOVGHuZlC/VRrKWEZsOFw38rVPKGU
         PKTaYQTzEX88YUFMmOZWu7fKARacXXNNXO4O8V6e4/IajwpOWl4pgoBG9lk8kOCI/SRl
         sWyDusklVRZs/BXaQSsFvQwTPQn+H4yEcHf5m4+M1iy9AI7g0KczZEE1eQcH0/rUs8WD
         yr7A==
X-Gm-Message-State: AOAM530IgUiGO2LzyLF26oCJjCwcYKNp09nOOsQMvA2OVYSznfmhnihf
        sQngl8Ed3pL/Zfdmw0Qoeau0brHXwmsNjFgz/De5GA1/x5S/oCw04jeLuTziHcZhwvDN9NmlWcb
        jj3Nb/e4DWiahgQ71CkD2sFRnGTBtH1hOVRBhUHNQbWEOL2F2l3mCdqLd6LZJisNHcLi3UQ5hZs
        3W
X-Google-Smtp-Source: ABdhPJzP0Z89akTyWApS8norA15HXkqT/+ByEX6DtZyJArvEPRt0i/XUcHRgwH9a05Z+gb46wHGl2o9KZvdp
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:41c9:: with SMTP id
 o192mr5005552yba.100.1611304609718; Fri, 22 Jan 2021 00:36:49 -0800 (PST)
Date:   Fri, 22 Jan 2021 16:36:16 +0800
In-Reply-To: <20210122083617.3163489-1-apusaka@google.com>
Message-Id: <20210122163457.v6.6.If655289cea81baf9226583a39f703ddc53817a51@changeid>
Mime-Version: 1.0
References: <20210122083617.3163489-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v6 6/7] Bluetooth: advmon offload MSFT interleave scanning integration
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When MSFT extension is supported, we don't have to interleave the scan
as we could just do allowlist scan.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

Changes in v6:
* New patch "advmon offload MSFT interleave scanning integration"

 net/bluetooth/hci_request.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 5aa7bd5030a2..d29a44d77b4e 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -404,13 +404,18 @@ static void cancel_interleave_scan(struct hci_dev *hdev)
  */
 static bool __hci_update_interleaved_scan(struct hci_dev *hdev)
 {
-	/* If there is at least one ADV monitors and one pending LE connection
-	 * or one device to be scanned for, we should alternate between
-	 * allowlist scan and one without any filters to save power.
+	/* Do interleaved scan only if all of the following are true:
+	 * - There is at least one ADV monitor
+	 * - At least one pending LE connection or one device to be scanned for
+	 * - Monitor offloading is not supported
+	 * If so, we should alternate between allowlist scan and one without
+	 * any filters to save power.
 	 */
 	bool use_interleaving = hci_is_adv_monitoring(hdev) &&
 				!(list_empty(&hdev->pend_le_conns) &&
-				  list_empty(&hdev->pend_le_reports));
+				  list_empty(&hdev->pend_le_reports)) &&
+				hci_get_adv_monitor_offload_ext(hdev) ==
+				    HCI_ADV_MONITOR_EXT_NONE;
 	bool is_interleaving = is_interleave_scanning(hdev);
 
 	if (use_interleaving && !is_interleaving) {
@@ -899,14 +904,11 @@ static u8 update_white_list(struct hci_request *req)
 
 	/* Use the allowlist unless the following conditions are all true:
 	 * - We are not currently suspending
-	 * - There are 1 or more ADV monitors registered
+	 * - There are 1 or more ADV monitors registered and it's not offloaded
 	 * - Interleaved scanning is not currently using the allowlist
-	 *
-	 * Once the controller offloading of advertisement monitor is in place,
-	 * the above condition should include the support of MSFT extension
-	 * support.
 	 */
 	if (!idr_is_empty(&hdev->adv_monitors_idr) && !hdev->suspended &&
+	    hci_get_adv_monitor_offload_ext(hdev) == HCI_ADV_MONITOR_EXT_NONE &&
 	    hdev->interleave_scan_state != INTERLEAVE_SCAN_ALLOWLIST)
 		return 0x00;
 
-- 
2.30.0.280.ga3ce27912f-goog

